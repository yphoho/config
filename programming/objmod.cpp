#include<iostream>

class A {
public:
    void Hello(const std::string& name) {
        std::cout << "hello " << name << std::endl;
    }
};


int main(int argc, char** argv)
{
    A* pa = NULL; //!!
    pa->Hello("world");

    return 0;
}

