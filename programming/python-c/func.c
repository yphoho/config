typedef struct _AA
{
    int a;
    int b;
}AA, *PAA;


typedef struct _BB
{
    int a;
    char *pB;
    int c;
}BB, *PBB;







int test(int a)
{
    return a;
}

int testA(int a, int b)
{
    return a * b;
}

char *testB(char *p)
{
    return p;
}

int testC(AA *p)
{
    return p->a * p->b;
}

int testD(AA *p)
{
    int tmp = p->a;
    p->a = p->b;
    p->b = tmp;
    return 0;
}

char *testE(BB *p)
{
    int tmp = p->a;
    p->a = p->c;
    p->c = tmp;
    return p->pB;
}

int testF(BB *p)
{
    int tmp = p->a;
    p->a = p->c;
    p->c = tmp;
    p->pB = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF";
    return 0;
}
