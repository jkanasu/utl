#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define NUM_CHILD_THREADS 7
#define NUM_OF_PRINTS 9

// Note the pointer * to function name as well as argument
void *printContinuously(void *arg)
{
	long tid;
	tid = (long)arg;

	int sleepValue;
	for(int m=1; m<=NUM_OF_PRINTS; m++)
	{
		sleepValue = 3 + rand() % 10;// value between 3 and 13 seconds
		printf("Thread id %3ld message num %2d sleep for %2d\n",tid, m, sleepValue);
		sleep(sleepValue);
	}
}

void createChildThreads()
{
	pthread_t childThreads[NUM_CHILD_THREADS];

	int rc;
	for(int t=0; t<NUM_CHILD_THREADS; t++)
	{
		rc = pthread_create(&childThreads[t], NULL, printContinuously, (void *)t+1);
		if(rc)
		{
			printf("Error creating thread %d : return code %d\n", t, rc);
			return;
		}
	}
}

int main(int argc, char *argv[])
{
	printf("Main program starting %s\n", "jaggi");
	createChildThreads();
	printf("Main program entering infinite printing %s\n", "jaggi");
	printContinuously((void *)999);
	return 0;
}

