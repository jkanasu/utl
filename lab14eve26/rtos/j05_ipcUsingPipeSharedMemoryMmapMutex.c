// Reference 
// https://www.softprayog.in/programming/interprocess-communication-using-posix-shared-memory-in-linux
//
// http://man7.org/training/download/posix_shm_slides.pdf
// https://www.ibm.com/developerworks/aix/library/au-spunix_sharedmemory/
// https://users.cs.cf.ac.uk/Dave.Marshall/C/node27.html
// http://man7.org/linux/man-pages/man7/shm_overview.7.html
// 
// Compile with gcc -pthread
// Link with -lrt
//
/*
* Problem statement:
* 
*	// TODO how do we get pipe Read Handle to pass to the client
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

//#include <sys/syslimits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <semaphore.h>
#include <sys/mman.h>
//#include <pthread.h>

#define SHARED_MEM_NAME "/JAGI-789"     // to be known both by server and client
#define SEM_MUTEX_NAME "/jagi-sem-mutex" // to be known both by server and client

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
void cleanUp();

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
sem_t *mutex_sem_server;
int fd_shm_server ;
int *shared_memory_ptr_server = NULL; // need a shared memory which can hold integer i.e. pipe fd
int pipefdInServer[2];

void enterServerMode(pid_t childPid){
	printf("\nEntering %s Mode", processName);
	createPipeInServer();
	createTheMutexInServer();
	createSharedMemoryAndMmapInServer();
	sendEvent(childPid);
	sendMessages();
	closePipeInServer();
	cleanUp();
}

void createPipeInServer(){
	if(pipe(pipefdInServer) == -1) {
		perror("pipe");
		printf("\n%s error in creating pipe", processName);
		exit(EXIT_FAILURE);
	}
	// later the read end of this pipe i.e. pipefdInServer[0] will be passed to server
	printf("\n%s created the pipe read-end:%d write-end:%d", processName, pipefdInServer[0], pipefdInServer[1]);
	char readEndPipe[1024];//PATH_MAX];
	char writeEndPipe[1024];//PATH_MAX];
	int retVal;
	if ( (retVal = fcntl(pipefdInServer[0], F_GETFD, readEndPipe)) != -1){
		printf("\n%s pipe details read end %d name %s",processName, retVal, readEndPipe);
	}	else printf("\n%s error in printing pipe details", processName);
	if ( (retVal = fcntl(pipefdInServer[1], F_GETFD, writeEndPipe)) != -1){
		printf("\n%s pipe details write end %d name %s",processName, retVal, writeEndPipe);
	}	else printf("\n%s error in printing pipe details", processName);
	// TODO how do we get pipe Read Handle to pass to the client
}

// Reference https://computing.llnl.gov/tutorials/pthreads/#Mutexes
void createTheMutexInServer(){
	// what is the use of mutex?
	// mutual exclusion semaphore, mutex_sem_server with an initial value 0.
	if( (mutex_sem_server = sem_open(SEM_MUTEX_NAME, O_CREAT, 0660, 0)) == SEM_FAILED) {
		perror("mutex");
		printf("\n%s error in creating mutex", processName);
	}
}

void createSharedMemoryAndMmapInServer(){
	if( (fd_shm_server = shm_open(SHARED_MEM_NAME, O_RDWR | O_CREAT, 0660)) == -1){
		perror("sharedMemory");
		printf("\n%s error in creating shared memory", processName);
		exit(EXIT_FAILURE);
	}
	if( ftruncate(fd_shm_server , sizeof(int)) == -1){
		perror("sharedMemoryTruncate");
		printf("\n%s error in truncating shared memory", processName);
		exit(EXIT_FAILURE);
	}
	if( (shared_memory_ptr_server = mmap(NULL, sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, fd_shm_server , 0)) == MAP_FAILED){
		perror("mmap");
		printf("\n%s error in mapping memory", processName);
		exit(EXIT_FAILURE);
	}
	printf("\n%s createSharedMemoryAndMmapInServer success", processName);
	
	// Store the Read Handle of the pipe into the shared memory for client to access.
	*shared_memory_ptr_server = pipefdInServer[0];
	// Initialization complete; now we can set mutex semaphore as 1 to 
	// indicate shared memory segment is available}
	if(sem_post(mutex_sem_server) == -1){
		perror("mutexPost");
		printf("\n%s error in releasing mutex", processName);
	}
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
		char messageInServer[255];
		sprintf(messageInServer, "Message %2d", i);
		printf("\n%s sending %s", processName, messageInServer);
		write(pipefdInServer[1], messageInServer, strlen(messageInServer));
	}
}

void closePipeInServer(){
	close(pipefdInServer[0]);
	close(pipefdInServer[1]);
	printf("\n%s closed pipes in server", processName);
}

void cleanUp(){
	// TODO unlink the sharedmemory
}

/*
* Client side code starts below
*/
int isEventReceived = -1;
sem_t *mutex_sem_client;
int fd_shm_client;
int *shared_memory_ptr_client = NULL;
int pipeReadHandleInClient;

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
	// mutual exclusion semaphore, mutex_sem_server with an initial value 0.
	if( (mutex_sem_client = sem_open(SEM_MUTEX_NAME,0,0,0)) == SEM_FAILED ){
		perror("mutexAcquireClient");
		printf("\n%s mutex acquiring failed",processName);
	}
	// Get shared memory
	if( (fd_shm_client = shm_open(SHARED_MEM_NAME, O_RDWR, 0)) == -1){
		perror("sharedMemClient");
		printf("\n%s shared memory access failed",processName);
	}
	// map the shared to local
	if((shared_memory_ptr_client = mmap(NULL,sizeof(pipeReadHandleInClient),
					PROT_READ, MAP_SHARED, fd_shm_client, 0)) == MAP_FAILED){
		perror("mapInClient");
		printf("\n%s memory map failed",processName);
	}
	pipeReadHandleInClient = *shared_memory_ptr_client;
	printf("\n%s Accessing the Shared Memory and pipe fd is %d", processName, pipeReadHandleInClient);
}

void receiveMessages(){
	for(int i =1; i<=10; i++){
		printf("\n%s accessing mutex object %d", processName, i);
		int sleepValue = 1;
		usleep(sleepValue * 1000 * 1000);
		printf("\n%s received Message number %d", processName, i);
	}
}

