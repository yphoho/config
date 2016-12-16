// gcc -std=c99 singletailqueue.c
#include<stdio.h>
#include<stdlib.h>
#include<sys/queue.h>



struct entry
{
    int i;
    STAILQ_ENTRY(entry) field;
};



int main()
{
    STAILQ_HEAD(xx, entry) head;
    STAILQ_INIT(&head);

    for(int i=0; i<10; i++)
    {
        struct entry *tmp=malloc(sizeof(struct entry));
        tmp->i=i;
        STAILQ_INSERT_HEAD(&head, tmp, field);
    }

    struct entry *tmp=malloc(sizeof(struct entry));
    tmp->i=100;
    STAILQ_INSERT_TAIL(&head, tmp, field);

    struct entry *var;
    STAILQ_FOREACH(var, &head, field)
    {
        printf("%d\n", var->i);
    }
    printf("\n");

    STAILQ_REMOVE_HEAD(&head, field);
    STAILQ_FOREACH(var, &head, field)
    {
        printf("%d\n", var->i);
    }
    printf("\n");

    printf("%d\n", STAILQ_FIRST(&head)->i);

    return 0;
}

