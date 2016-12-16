/*
  compile:
  gcc -lpthread -std=c99 -o upd-prefork udp-prefork.c
  test:
  nc -u 127.0.0.1 1053
*/


#include    <stdio.h>
#include    <stdlib.h>
#include    <string.h>
#include    <strings.h>

#include    <sys/types.h>   /* basic system data types */
#include    <sys/socket.h>  /* basic socket definitions */
#include    <sys/time.h>    /* timeval{} for select() */
#include    <time.h>    /* timespec{} for pselect() */
#include    <netinet/in.h>  /* sockaddr_in{} and other Internet defns */
#include    <arpa/inet.h>   /* inet(3) functions */
#include    <errno.h>
#include    <fcntl.h>   /* for nonblocking */
#include    <netdb.h>
#include    <signal.h>
#include    <sys/stat.h>    /* for S_xxx file mode constants */
#include    <sys/uio.h> /* for iovec{} and readv/writev */
#include    <unistd.h>
#include    <sys/wait.h>

#include   <sys/sysctl.h>


#include<sys/epoll.h>
#include<pthread.h>


#define SERV_PORT 1053
#define LISTENQ 10
#define THREADN 3
#define EVENTN 10

void *thread_main(void *arg)
{
    int epollfd=*(int *)arg;
    struct epoll_event events[EVENTN];

    struct sockaddr_in cliaddr;
    int addrlen=sizeof(cliaddr);

    int gameover=0;
    while(!gameover)
    {
        int nfds = epoll_wait(epollfd, events, EVENTN, -1);
        printf("%x:epoll_wait retrun\n", (unsigned int)pthread_self());
        if (nfds == -1)
        {
            perror("epoll_wait");
            break;
        }
        for (int n = 0; n < nfds; ++n)
        {
            int udpfd=events[n].data.fd;
            char buffer[1024];

            int n=recvfrom(udpfd, buffer, 1024, 0,
                           (struct sockaddr *)&cliaddr, &addrlen);
            buffer[n-1]='\t';
            buffer[n]=0;
            printf("recved: %s\n", buffer);

            if(!strcmp(buffer, "exit\n"))
                gameover=1;

            sprintf(buffer+strlen(buffer), "tid: %x\n",
                    (unsigned int)pthread_self());
            sendto(udpfd, buffer, strlen(buffer), 0,
                   (struct sockaddr *)&cliaddr, addrlen);

            sleep(3);
        }

    }

    return 0;
}

void run_server(int tcpfd, int udpfd)
{
    struct epoll_event ev;
    pthread_t tid[THREADN];

    int epollfd = epoll_create(100);

    /* ev.events = EPOLLIN | EPOLLET; */
    ev.events = EPOLLIN;        /* level-triggered is the default */
    ev.data.fd = tcpfd;
    if (epoll_ctl(epollfd, EPOLL_CTL_ADD, tcpfd, &ev) < 0)
    {
        fprintf(stderr, "epoll set insertion error: fd=%d\n", tcpfd);
        exit(-1);
    }

    ev.data.fd = udpfd;
    if (epoll_ctl(epollfd, EPOLL_CTL_ADD, udpfd, &ev) < 0)
    {
        fprintf(stderr, "epoll set insertion error: fd=%d\n", udpfd);
        exit(-1);
    }

    for(int i=0; i<THREADN; i++)
    {
        if(pthread_create(&tid[i], NULL, thread_main, &epollfd))
        {
            perror("pthread_create error");
            exit(-1);
        }
    }

    int prv;
    for(int i=0; i<THREADN; i++)
        pthread_join(tid[i], &prv);

    close(epollfd);

}



int sockfd_open(int istcp)
{
    int sockfd;
    struct sockaddr_in servaddr;

    sockfd = socket(AF_INET,
                    istcp ? SOCK_STREAM : SOCK_DGRAM,
                    0);
    if(!sockfd)
    {
        perror("socket error.\n");
        exit(-1);
    }

    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(SERV_PORT);

    if(bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr))==-1)
    {
        perror("bind error.\n");
        exit(-1);
    }

    if(istcp)
    {
        if(listen(sockfd, LISTENQ)==-1)
        {
            perror("listen error.\n");
            exit(-1);
        }
    }

    return sockfd;
}



int main(int argc, char **argv)
{
    int tcpfd=sockfd_open(1);
    int udpfd=sockfd_open(0);

    run_server(tcpfd, udpfd);

    close(udpfd);
    close(tcpfd);

    return 0;
}

