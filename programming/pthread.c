#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<pthread.h>


// use "ps -eL" to see the lwp(light weighted process)


void thread(void)
{
    while(1)
    {
        printf("This is a pthread.\n");
        sleep(2);
    }
}


int main(void)
{
    pthread_t tid;

    if(pthread_create(&tid, NULL, (void *) thread, NULL))
    {
        printf("Create pthread error!\n");
        exit(-1);
    }

    while(1)
    {
        printf("This is the main process.\n");
        sleep(2);
    }
    pthread_join(tid, NULL);

    return (0);
}
