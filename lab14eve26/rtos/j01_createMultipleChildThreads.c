#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define NUM_CHILD_THREADS 4
#define NUM_OF_PRINTS 5

pthread_t childThreads[NUM_CHILD_THREADS];

// Note the pointer * to function name as well as argument
void *printContinuously(void *arg)
{
	long tid;
	tid = (long)arg;

	int sleepValue;
	for(int m=1; m<=NUM_OF_PRINTS; m++)
	{
		sleepValue = 3 + rand() % 10;// value between 3 and 13 seconds
		printf("I'm in thread number %3ld - message num %2d - sleep for %2d\n",tid, m, sleepValue);
		sleep(sleepValue);
	}
}

void createChildThreads()
{
	int rc;
	int t;

	// Initialize the thread to be joinable
	pthread_attr_t attribute;
	pthread_attr_init(&attribute);
	pthread_attr_setdetachstate(&attribute, PTHREAD_CREATE_JOINABLE);
	// Start creating the child threads
	for(t=0; t<NUM_CHILD_THREADS; t++)
	{
		rc = pthread_create(&childThreads[t], &attribute, printContinuously, (void *)t+1);
		if(rc)
		{
			printf("Error creating thread %2d : return code %2d\n", t, rc);
			return;
		}
	}
	// Free up the attribute
	pthread_attr_destroy(&attribute);

	// Start joining the threads
	// NOTE only one thread can be joined at a time
	void *status;
	for(t=0; t<NUM_CHILD_THREADS; t++)
	{
		printf("*** Joining thread %d ***\n", t+1);
		rc = pthread_join(childThreads[t], &status);
		if(rc)
		{
			printf("Error joining thread %2d : return code %2d\n", t+1, rc);
		}
		printf("Completed Join thread %2d : return status %2ld\n", t+1, (long)status);
	}

}

int main(int argc, char *argv[])
{
	printf("Main program starting %s\n", "jaggi");
	createChildThreads();
	//printf("Main program entering infinite printing %s\n", "jaggi");
	//printContinuously((void *)999);
	printf("Main program exiting %s\n", "jaggi");
	return 0;
}

