// Reference https://linux.die.net/man/7/mq_overview
// Refer http://man7.org/linux/man-pages/man7/mq_overview.7.html
// See cat /proc/sys/fs/mqueue/msg_*
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>
#include <errno.h>
#include <fcntl.h>	/* For O_* constants */
#include <sys/stat.h>	/* For mode constants */
#include <mqueue.h>

// Below code courtesy
// http://man7.org/linux/man-pages/man3/pthread_getschedparam.3.html
#define handle_error_en(en, msg) \
	   do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)

#define MIN_NUM_OF_MESSAGES 2
#define SENDMESSAGE_MAX_SIZE 512 // Message length is governed by system 
#define RECEIVEMESSAGE_BUFFER_SIZE 100000 //SENDMESSAGE_MAX_SIZE + 1 // greater than SEND size
#define WM_QUIT_MESSAGE_STRING "WM_QUIT" // represents the end of messaging
#define MESSAGE_QUEUE_NAME "/JAGI_MQ1" // important to add / in beginnning :-(

pthread_t childThread;
mqd_t mesQueue;
int isChildFinished;
long supportedMaxMsgSize;

// declare all the functions, we'll implement later
void createMessageQueue();
void createChildThread();
void *receiveMessages();
void sendMessages();

// Main method of this program
int
main(int argc, char *argv[])
{
	printf("\nMain starting");
	isChildFinished = -1;
	createMessageQueue();
	printf("\nMessage queue created");
	createChildThread(); // will start receiving messages
	printf("\nChild thread created");
	usleep(3 * 1000 * 1000);
	sendMessages();
	printf("\nMain ending\n");
}

void createMessageQueue()
{
	char msqName[] = MESSAGE_QUEUE_NAME;
	int oflags = O_RDWR | O_CREAT | O_CLOEXEC;// |0666;//  
	int modeflags = S_IRWXU | S_IRWXG | S_IRWXO; //0666;//O_CLOEXEC; //O_CREAT | 
	struct mq_attr attr;
	attr.mq_flags = 0;
	attr.mq_maxmsg = 3;
	attr.mq_msgsize = SENDMESSAGE_MAX_SIZE;
	attr.mq_curmsgs = 0;
	// https://linux.die.net/man/3/mq_open
	//mesQueue = mq_open(&msqName, oflags);
	mesQueue = mq_open(&msqName, oflags, modeflags, &attr);//NULL);
	if(mesQueue < 0 )
	{
		printf("Error in creating message queue %d %d", mesQueue, errno);
		handle_error_en(errno, "mq_open");
	}
	struct mq_attr verifyattr;
	int rc;
	rc = mq_getattr(mesQueue, &verifyattr);
	if(rc < 0 )
	{
		printf("Error in creating message queue %d %d", rc, errno);
		handle_error_en(errno, "mq_open");
	}
	printf("\nmq_attr verify %ld %ld %ld %ld",verifyattr.mq_flags, verifyattr.mq_maxmsg, verifyattr.mq_msgsize, verifyattr.mq_curmsgs);
	printf("\nSuccesfully created message queue");
}

void createChildThread()
{
	pthread_attr_t attr;
	pthread_attr_init(&attr);
	int rc;
	rc = pthread_create(&childThread, &attr, (void *)receiveMessages, NULL);
	if (rc)
	{
		printf("\n Error in creating thread");
	}
	printf("\nSuccesfully created child thread");
}

/*
Parent will send "n" messages continuously.
Following the "n" message the string WM_QUIT will be sent.
Before sending a message the Parent thread checks 
a boolean flag to see whether the child thread has finished.
If child thread has finished then Parent thread
*/
void sendMessages()
{
	printf("\nMain thread start sending messages\n");
	long QUIT_MESSAGE_NUM = MIN_NUM_OF_MESSAGES + rand() % 10;
	// twice randomize, seems the once is not enough
	QUIT_MESSAGE_NUM = MIN_NUM_OF_MESSAGES + rand() % 10; 
	char messageInParent[SENDMESSAGE_MAX_SIZE]; 
	size_t msq_len = 0;
	long messageCountInParent=0;
	int msqSentStatus = 0;//-1;
	do{
		if(messageCountInParent == QUIT_MESSAGE_NUM){
			//snprintf(messageInParent, sizeof("WM_QUIT"), "WM_QUIT");
			sprintf(messageInParent, "WM_QUIT");
			QUIT_MESSAGE_NUM = QUIT_MESSAGE_NUM + rand() % 10;
		}else {
			//snprintf(messageInParent, SENDMESSAGE_MAX_SIZE-1, "message_%3d_", messageCountInParent);
			sprintf(messageInParent, "messagesend_%d_", messageCountInParent);
		}
		messageCountInParent++;
		msq_len = strlen(messageInParent);
		printf("\nParent sending ... %d %s", msq_len, messageInParent);
		// https://linux.die.net/man/3/mq_send
		// TODO send message
		// sleep for a second before sending each message
		usleep(1 * 1000 * 1000);
		if(!isChildFinished < 0){
			printf("\nChild is not running\n");
			break;
		}
		msqSentStatus = mq_send(mesQueue, &messageInParent, msq_len, 0);
		if(msqSentStatus != 0 ) 
			handle_error_en(msqSentStatus, "Error is sending message");
	}while (isChildFinished <0); // child is still running
	printf("\n\nChild is not running");
	mq_close(mesQueue);
	mq_unlink(&MESSAGE_QUEUE_NAME);
	return;
}

void *receiveMessages()
{
	printf("\nChild Thread start receiving messages");
	char messageInChild[RECEIVEMESSAGE_BUFFER_SIZE] = ""; // Message length of max 512 characters
	ssize_t msq_len = 0;
	long messageCountInChild=0;
	int msqRecvBytes = -1;
	int msgSize = 0;
	while(1){
		// https://linux.die.net/man/3/mq_receive
		msqRecvBytes = mq_receive(mesQueue, messageInChild, RECEIVEMESSAGE_BUFFER_SIZE, 0);
		//if(msqRecvBytes < 0 ) printf("\nError receiving message %d %d", msqRecvBytes, errno);
		if(msqRecvBytes < 0 ) 
			handle_error_en(errno, "Error receiving message");
		messageCountInChild++;
		// terminate the buffer at the size, else old contents will be there
		messageInChild[msqRecvBytes] = '\0';
		printf("\nChild received ... %d %d %s", messageCountInChild, msqRecvBytes, messageInChild);
		if(strcmp(WM_QUIT_MESSAGE_STRING, messageInChild) == 0 )
		{
			//usleep(3 * 1000 * 1000);
			printf("\nChild Ending");
			isChildFinished = 1;
			return;
		}
		// sleep for a second before sending next message
		//usleep(1 * 1000 * 1000);
	}
}



