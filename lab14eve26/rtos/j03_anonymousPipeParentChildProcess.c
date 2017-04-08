// This code is from the man page
// Added some more printf statements to show the fork mechanism
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

int
main(int argc, char *argv[])
{
   int pipefd[2];
   pid_t cpid;
   char buf;

   if (argc != 2) {
	   fprintf(stderr, "Usage: %s <string>\n", argv[0]);
	   exit(EXIT_FAILURE);
   }

   pid_t ppid = getpid(); // get the parent's pid
   printf("\n01 Main starting Parent pid %d", ppid);
   printf("\n"); // to flush the stdout

   if (pipe(pipefd) == -1) {
	   perror("pipe");
	   exit(EXIT_FAILURE);
   }

   cpid = fork();
   pid_t currentpid = getpid(); // get the current process's pid
   printf("\nParent pid %d, child pid %d, current pid %d", ppid, cpid, currentpid);
   printf("\n"); // to flush the stdout

   if (cpid == -1) {
	   perror("fork");
	   exit(EXIT_FAILURE);
   }

   if (cpid == 0) {    /* Child reads from pipe */
           printf("\nInside child %d, %d", cpid, currentpid);
           printf("\n"); // to flush the stdout
	   close(pipefd[1]);          /* Close unused write end */

	   while (read(pipefd[0], &buf, 1) > 0)
		   write(STDOUT_FILENO, &buf, 1);

	   write(STDOUT_FILENO, "\n", 1);
           printf("\n"); // to flush the stdout
	   close(pipefd[0]);
	   _exit(EXIT_SUCCESS);

   } else {            /* Parent writes argv[1] to pipe */
           printf("\nInside parent %d, %d, %d", ppid, cpid, currentpid);
           printf("\n"); // to flush the stdout
	   close(pipefd[0]);          /* Close unused read end */
	   write(pipefd[1], argv[1], strlen(argv[1]));
	   close(pipefd[1]);          /* Reader will see EOF */
	   wait(NULL);                /* Wait for child */
	   exit(EXIT_SUCCESS);
   }
}

