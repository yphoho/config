#include <stdio.h>
#include <stdlib.h>

#include <sys/time.h>
#include <time.h>


int main()
{
    struct timeval tv;
    time_t curtime;

    char buffer[32];


    gettimeofday(&tv, NULL); 
    curtime=tv.tv_sec;

    strftime(buffer, sizeof(buffer), "%m-%d-%Y %T.", localtime(&curtime));
    printf("%s%ld\n", buffer, tv.tv_usec);

    return 0;
}

