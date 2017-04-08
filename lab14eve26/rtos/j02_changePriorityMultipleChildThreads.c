// NOTE : we need root permissions to run this program
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <errno.h>

#define NUM_CHILD_THREADS 4
#define NUM_OF_PRINTS 25

pthread_t childThreadA;
pthread_t childThreadB;

void checkPthreadSupport()
{
	printf("Support %d\n", _POSIX_THREAD_PRIORITY_SCHEDULING);
	printf("FIFO %d\n", SCHED_FIFO);
	printf("RR %d\n", SCHED_RR);
	printf("OTHER %d\n", SCHED_OTHER);
}
// Below code courtesy
// http://man7.org/linux/man-pages/man3/pthread_getschedparam.3.html
#define handle_error_en(en, msg) \
	   do { errno = en; perror(msg); exit(EXIT_FAILURE); } while (0)

static void
display_sched_attr(int policy, struct sched_param *param)
{
   printf("policy=%s, priority=%d,",
		   (policy == SCHED_FIFO)  ? "SCHED_FIFO" :
		   (policy == SCHED_RR)    ? "SCHED_RR" :
		   (policy == SCHED_OTHER) ? "SCHED_OTHER" :
		   "???",
		   param->sched_priority);
}

static void
display_thread_sched_attr(char *msg)
{
   int policy, s;
   struct sched_param param;

   s = pthread_getschedparam(pthread_self(), &policy, &param);
   if (s != 0)
	   handle_error_en(s, "pthread_getschedparam");

   printf("\n%s ", msg);
   display_sched_attr(policy, &param);
}

// Note the pointer * to function name as well as argument
void *printMessages(void *arg)
{
	long tid;
	tid = (long)arg;
	char name[12];
	sprintf(name, "jagi_%ld", tid);

	int sleepValue;
	//display_thread_sched_attr(name);//"jagi");
	//usleep(100 * 1000 * 1000);
	for(int m=1; m<=NUM_OF_PRINTS; m++)
	{
		display_thread_sched_attr(name);//"jagi");
		printf(" thread number %3ld - multiplication iter num %2d\n", tid, m);
		//sleepValue = 3 + rand() % 10;// value between 3 and 13 seconds
		//display_thread_sched_attr(name);//"jagi");
		// below function takes microseconds
		//usleep(sleepValue * 1000 * 1000);
		long i = 1234567890;
		long j = 1234567890;
		for (int mult=0; mult<=123; mult++)
		{
			for (int inmult=0; inmult<=1234567; inmult++)
			{
				i*j; // simply multiply to engage the cpu
			}
		}
	}
	// We can simply return or explicitly call the below function
	// pthread_exit((void *)arg);
}

// This function creates the child threads and also joins them to the main thread
void createChildThreads()
{
	int sleepValue=0;
	int rc;
	int t=0;

	// Start creating the child threads
	// childThread A
	// NOTE : we need root permissions to run this program
	// Initialize the thread to be joinable
	pthread_attr_t custom_attributeA;
	pthread_attr_init(&custom_attributeA);
	pthread_attr_setdetachstate(&custom_attributeA, PTHREAD_CREATE_JOINABLE);
	pthread_attr_setdetachstate(&custom_attributeA, PTHREAD_CREATE_JOINABLE);
	pthread_attr_setinheritsched(&custom_attributeA, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&custom_attributeA, SCHED_FIFO);
	struct sched_param fifo_paramA;
	// choose 10 as the arbitrary priority for the thread
	fifo_paramA.sched_priority = 10;//sched_get_priority_max(SCHED_FIFO);
	pthread_attr_setschedparam(&custom_attributeA, &fifo_paramA);
	t = t + 1;
	rc = pthread_create(&childThreadA, &custom_attributeA, printMessages, (void *)t);
	if(rc)
	{
		printf("Error creating thread %2d : return code %2d\n", t, rc);
		return;
	}
	printf("*** Finished creating child threads A *** \n");
	// Free up the attribute
	pthread_attr_destroy(&custom_attributeA);

	//int prio = pthread_getschedparam();
	sleepValue = 2;
	printf("Before creating child thread B - Wait for %2d \n", sleepValue);
	// below function takes microseconds
	usleep(sleepValue * 1000 * 1000);

	// childThread B
	// Initialize the thread to be joinable & schedulable & prioritizable
	pthread_attr_t custom_attributeB;
	pthread_attr_init(&custom_attributeB);
	pthread_attr_setdetachstate(&custom_attributeB, PTHREAD_CREATE_JOINABLE);
	pthread_attr_setinheritsched(&custom_attributeB, PTHREAD_EXPLICIT_SCHED);
	pthread_attr_setschedpolicy(&custom_attributeB, SCHED_FIFO);
	struct sched_param fifo_param;
	// choose the same 11 as the arbitrary priority for the thread
	fifo_param.sched_priority = 11;//sched_get_priority_max(SCHED_FIFO);
	pthread_attr_setschedparam(&custom_attributeB, &fifo_param);
	t = t + 1;
	rc = pthread_create(&childThreadB, &custom_attributeB, printMessages, (void *)t);
	if(rc)
	{
                if (rc != 0)  handle_error_en(rc, "pthread_create");
		printf("Error creating thread %2d : return code %2d\n", t, rc);
		return;
	}
	printf("*** Finished creating child threads B *** \n");
	// Free up the attribute
	pthread_attr_destroy(&custom_attributeB);

	printf("*** Finished creating child threads A & B*** \n");

	sleepValue = 3 + rand() % 5;// value between 3 and 3+5 seconds

	//int prio = pthread_getschedparam();
	printf("Before changing priority - Wait for %2d \n", sleepValue);
	// below function takes microseconds
	usleep(sleepValue * 1000 * 1000);
	printf("Changing priority of child thread A");
	struct sched_param dynamic_fifo_param;
	// choose the same 15 a higher as the arbitrary priority for the thread
	dynamic_fifo_param.sched_priority = 15;//sched_get_priority_max(SCHED_FIFO);
	pthread_setschedparam(childThreadA, SCHED_FIFO, &dynamic_fifo_param);


	// Start joining the threads
	// NOTE only one thread can be joined at a time
	void *status;
	printf("*** Joining thread *** A\n");
	rc = pthread_join(childThreadA, &status);
	if(rc)
	{
		printf("Error joining thread A : return code %2d\n", rc);
	}
	printf("Completed Join thread A : return status %2ld\n", (long)status);

	printf("*** Joining thread *** B\n");
	rc = pthread_join(childThreadB, &status);
	if(rc)
	{
		printf("Error joining thread B : return code %2d\n", rc);
	}
	printf("Completed Join thread B : return status %2ld\n", (long)status);

}

// the main function to this process
int main(int argc, char *argv[])
{
	printf("Main program starting %s\n", "jaggi");
	checkPthreadSupport();
	createChildThreads();
	printf("Main program exiting %s\n", "jaggi");
	return 0;
}

