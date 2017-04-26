// Reference 
// http://man7.org/training/download/posix_shm_slides.pdf
// https://www.ibm.com/developerworks/aix/library/au-spunix_sharedmemory/
// https://users.cs.cf.ac.uk/Dave.Marshall/C/node27.html
// http://man7.org/linux/man-pages/man7/shm_overview.7.html
// 
// Compile with gcc -lrt
//
/*
 * Problem statement:
 * 
 * Test the program application for 
 * creating an anonymous pipe with 512 bytes of size and 
 * pass the ‘Read Handle’ of the pipe to a second process using memory mapped object.
 * The first process writes a message ‘ Hi from Pipe Server’.
 * The 2nd process reads the data written by the pipe 
 * server to the pipe and displays it on the console.
 * Use event object for indicating the availability of data on the pipe
 * and mutex objects for synchronizing the access in the pipe.
 *
 * The important IPC mechanisms used in this program are
 * signals, pipes, shared memory (+ memory mapping), mutex
 *
 * pipe - mechanism to pass data e.g. "Hi from process xyz"
 * shared memory - to pass "Read Handle" of pipe e.g. (123,789) are pipe fds
 * signals - indicate data availability on pipe
 * mutex - synchronize access to the pipe
 *
 * Main method should first have basic constants initialized
 * It should fork, and only the constants should be passed on.
 * Alternatively we could use header file to share constants
 * But this would force to launch server/parent and client/child independently
 * Also server would not know the client/child process details and cannot
 * communicate with the client/child
 * fork is necessary so that the server/parent gets details of client/child
 * 
 * All below steps are after fork, i.e. server and client running
 *
 * In Server
 * Create a known memory mapped object using a predefined id
 * Create the pipe anonymous, i.e. we get back read / write fds
 * Fill the memory mapped object (shared memory) with the read end of pipe
 * Send a event (signal) using to the client using kill system call
 * Start writing messages to the pipe
 * Do for 10 times
 *        Access a mutex
 *        Write message
 * After 10 messages close everything and exit
 *
 * In Client
 * Wait for the event (signal) using a signal handler system call
 * Access the known memory mapped object, read the contents to find read end of pipe
 * Start reading the messages on the pipe
 * Do for 10 times
 *        Access a mutex
 *        Read message
 * After 10 messages close everything and exit
 * 
 * 
*/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

#define SHM_NAME "JAGI789"     // to be known both by server and client
#define MUTEX_ID 545   // to be known both by server and client

char * processName = "UNKNOWN";
char * serverName = "SERVER";
char * clientName = "CLIENT";

/*
 * Below are the server side functions
 *
*/
void enterServerMode(pid_t childPid);
void createPipeInServer();
void createTheMutexInServer();
void createSharedMemoryAndMmapInServer();
void sendEvent(pid_t childPid);
void sendMessages();
void closePipeInServer();

/*
 * Below are the client side functions
 *
*/
void enterClientMode();
void registerForEvent();
void receiveEvent();
void accessSharedMemoryAndMmapInClient();
void receiveMessages();

/*
 * Main method for the program
*/
int main ()
{
	printf("\nStarting Main");
	pid_t childPid = fork();
	if (childPid == -1){
		printf("\nSome error");
		perror("Main method");
	} else if (childPid > 0){
		printf("\n\nIn Parent, the child is %3d", childPid);
		processName = serverName;
		enterServerMode(childPid);
	} else {
		printf("\nIn Child");
		processName = clientName;
		enterClientMode();
	}
	printf("\n%s Main is Exiting", processName);
}

/*
 * Server side code starts below
*/
int shmid;
int pipefdInServer[2];

void enterServerMode(pid_t childPid){
	printf("\nEntering %s Mode", processName);
	createPipeInServer();
	createTheMutexInServer();
	createSharedMemoryAndMmapInServer();
	sendEvent(childPid);
	sendMessages();
	closePipeInServer();
}

void createPipeInServer(){
	if(pipe(pipefdInServer) == -1) {
		perror("pipe");
		printf("%s error is creating pipe", processName);
		exit(EXIT_FAILURE);
	}
	// later the read end of this pipe i.e. pipefdInServer[0] will be passed to server
	printf("%s created the pipe read-end:%d write-end:%d", processName, pipefdInServer[0], pipefdInServer[1]);
}

void createTheMutexInServer(){
	
}

void createSharedMemoryAndMmapInServer(){
	//shmid = shm_open()
}

void sendEvent(pid_t childPid){
	printf("\n%s sending event to %d",processName, childPid);
	int sleepValue = 5;
	usleep(sleepValue * 1000 * 1000);
	kill(childPid, SIGUSR1);
}

void sendMessages(){
	for(int i =1; i<=10; i++){
		printf("\n%s accessing mutex object %d", processName,i);
		int sleepValue = 1;
		usleep(sleepValue * 1000 * 1000);
		printf("\n%s sending Message number %d", processName, i);
	}
}

void closePipeInServer(){
	close(pipefdInServer[0]);
	close(pipefdInServer[1]);
	printf("\n%s closed pipes in server", processName);
}

/*
 * Client side code starts below
*/
int isEventReceived = -1;

void enterClientMode(){
	printf("\nEntering %s Mode", processName);
	registerForEvent();
	// Wait for the event to be received
	while(isEventReceived < 0){
		printf("\n%s waiting for event", processName);
		int sleepValue = 2;
		usleep(sleepValue * 1000 * 1000);
	}
	accessSharedMemoryAndMmapInClient();
	receiveMessages();
}

void registerForEvent(){
	printf("\n%s Registering for events", processName);
	if(signal(SIGUSR1,receiveEvent)==SIG_ERR){
		//printf("Error in registering for events %d", errno);
		perror("CLIENT");
	}
}

void receiveEvent(){
	isEventReceived = 1;
}

void accessSharedMemoryAndMmapInClient(){
	printf("\n%s Accessing the Shared Memory", processName);
}
void receiveMessages(){
	for(int i =1; i<=10; i++){
		printf("\n%s accessing mutex object %d", processName, i);
		int sleepValue = 1;
		usleep(sleepValue * 1000 * 1000);
		printf("\n%s received Message number %d", processName, i);
	}
}

