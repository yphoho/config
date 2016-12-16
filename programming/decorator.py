#!/usr/bin/env python

# http://www.artima.com/weblogs/viewpost.jsp?thread=240808
# http://www.artima.com/weblogs/viewpost.jsp?thread=240845


import os, sys

class myDecorator(object):
    def __init__(self, f):
        print "inside myDecorator.__init__()"
        f() # Prove that function definition has completed

    def __call__(self):
        print "inside myDecorator.__call__()"

@myDecorator
def aFunction():
    print "inside aFunction()"

print "Finished decorating aFunction()"

aFunction()



# When you run this code, you see:
# inside myDecorator.__init__()
# inside aFunction()
# Finished decorating aFunction()
# inside myDecorator.__call__()

# Notice that the constructor for myDecorator is executed at the point of decoration of the function. Since we can call f() inside __init__(), it shows that the creation of f() is complete before the decorator is called. Note also that the decorator constructor receives the function object being decorated. Typically, you'll capture the function object in the constructor and later use it in the __call__() method (the fact that decoration and calling are two clear phases when using classes is why I argue that it's easier and more powerful this way).
# When aFunction() is called after it has been decorated, we get completely different behavior; the myDecorator.__call__() method is called instead of the original code. That's because the act of decoration replaces the original function object with the result of the decoration -- in our case, the myDecorator object replaces aFunction. Indeed, before decorators were added you had to do something much less elegant to achieve the same thing:
# def foo(): pass
# foo = staticmethod(foo)

# With the addition of the @ decoration operator, you now get the same result by saying:
# @staticmethod
# def foo(): pass

# This is the reason why people argued against decorators, because the @ is just a little syntax sugar meaning "pass a function object through another function and assign the result to the original function."
# The reason I think decorators will have such a big impact is because this little bit of syntax sugar changes the way you think about programming. Indeed, it brings the idea of "applying code to other code" (i.e.: macros) into mainstream thinking by formalizing it as a language construct.


print "\n\n"



class entryExit(object):
    def __init__(self, f):
        self.f = f

    def __call__(self):
        print "Entering", self.f.__name__
        self.f()
        print "Exited", self.f.__name__

@entryExit
def func1():
    print "inside func1()"

@entryExit
def func2():
    print "inside func2()"

func1()
func2()




# The output is:
# Entering func1
# inside func1()
# Exited func1
# Entering func2
# inside func2()
# Exited func2

# You can see that the decorated functions now have the "Entering" and "Exited" trace statements around the call.
# The constructor stores the argument, which is the function object. In the call, we use the __name__ attribute of the function to display that function's name, then call the function itself.



print "\n\n"



def entryExit(f):
    def new_f():
        print "Entering", f.__name__
        f()
        print "Exited", f.__name__
    return new_f

@entryExit
def func1():
    print "inside func1()"

@entryExit
def func2():
    print "inside func2()"

func1()
func2()
print func1.__name__

# new_f() is defined within the body of entryExit(), so it is created and returned when entryExit() is called. Note that new_f() is a closure, because it captures the actual value of f.
# Once new_f() has been defined, it is returned from entryExit() so that the decorator mechanism can assign the result as the decorated function.
# The output of the line print func1.__name__ is new_f, because the new_f function has been substituted for the original function during decoration. If this is a problem you can change the name of the decorator function before you return it:
# def entryExit(f):
#     def new_f():
#         print "Entering", f.__name__
#         f()
#         print "Exited", f.__name__
#     new_f.__name__ = f.__name__
#     return new_f

# The information you can dynamically get about functions, and the modifications you can make to those functions, are quite powerful in Python.





print "\n\n"



def decoratorFunctionWithArguments(arg1, arg2, arg3):
    def wrap(f):
        print "Inside wrap()"
        def wrapped_f(*args):
            print "Inside wrapped_f()"
            print "Decorator arguments:", arg1, arg2, arg3
            f(*args)
            print "After f(*args)"
        return wrapped_f
    return wrap

@decoratorFunctionWithArguments("hello", "world", 42)
def sayHello(a1, a2, a3, a4):
    print 'sayHello arguments:', a1, a2, a3, a4

print "After decoration"

print "Preparing to call sayHello()"
sayHello("say", "hello", "argument", "list")
print "after first sayHello() call"
sayHello("a", "different", "set of", "arguments")
print "after second sayHello() call"




# Here's the output:
# Inside wrap()
# After decoration
# Preparing to call sayHello()
# Inside wrapped_f()
# Decorator arguments: hello world 42
# sayHello arguments: say hello argument list
# After f(*args)
# after first sayHello() call
# Inside wrapped_f()
# Decorator arguments: hello world 42
# sayHello arguments: a different set of arguments
# After f(*args)
# after second sayHello() call

# The return value of the decorator function must be a function used to wrap the function to be decorated. That is, Python will take the returned function and call it at decoration time, passing the function to be decorated. That's why we have three levels of functions; the inner one is the actual replacement function.
# Because of closures, wrapped_f() has access to the decorator arguments arg1, arg2 and arg3, without having to explicitly store them as in the class version. However, this is a case where I find "explicit is better than implicit," so even though the function version is more succinct I find the class version easier to understand and thus to modify and maintain.
