#use Something:
    #One as One1
    #Two as Two1
    #Three as Three1
    #hello as hello1
    #Three.hello as helloThree1
    #something as something1
    #Two.something as somethingThree1

import Something as Something_module

type One1 = Something_module.One_export

template One1_new_struct_inner() : One1 =
    Something_module.One_new_struct_inner()

type Two1 = Something_module.Two_export

template Two1_new_struct_inner() : Two1 =
    Something_module.Two_new_struct_inner()

#type Three1 = Something_module.Two_module.Three_export 
type Three1 = Something_module.Three_export

template Three1_new_struct_inner() : Three1 =
    #Something_module.Two_module.Three_new_struct_inner()
    Something_module.Three_new_struct_inner()

template hello1() : untyped =
    Something_module.Something_hello()

template helloThree1() : untyped =
    Something_module.Three_module.Three_hello()

template something1(a : Something_module.One_export) : untyped =
    Something_module.Something_something(a)

template something1(a : Something_module.Two_export) : untyped =
    Something_module.Something_something(a)

template somethingThree1(a : Something_module.Three_export) : untyped =
    Something_module.Two_something(a)

#use SomethingElse:
    #One as One2
    #Two as Two2
    #Three as Three2
    #hello as hello2
    #Three.hello as helloThree2
    #something as something2
    #Two.something as somethingThree2

import SomethingElse as SomethingElse_module

type One2 = SomethingElse_module.One_export

template One2_new_struct_inner() : One2 =
    SomethingElse_module.One_new_struct_inner()

type Two2 = SomethingElse_module.Two_export

template Two2_new_struct_inner() : Two2 =
    SomethingElse_module.Two_new_struct_inner()

#type Three2 = Something_module.Two_module.Three_export 
type Three2 = Something_module.Three_export

template Three2_new_struct_inner() : Three2 =
    #Something_module.Two_module.Three_new_struct_inner()
    Something_module.Three_new_struct_inner()

template hello2() : untyped =
    SomethingElse_module.SomethingElse_hello()

template helloThree2() : untyped =
    Something_module.Three_module.Three_hello()

template something2(a : SomethingElse_module.One_export) : untyped =
    SomethingElse_module.SomethingElse_something(a)

template something2(a : SomethingElse_module.Two_export) : untyped =
    SomethingElse_module.SomethingElse_something(a)

template somethingThree2(a : SomethingElse_module.Three_export) : untyped =
    SomethingElse_module.Two_something(a)

#One1()
let a = when declared(One1_new_struct_inner):
        One1_new_struct_inner()
    else:
        new_struct_inner(One1)

#One2()
let b = when declared(One2_new_struct_inner):
        One2_new_struct_inner()
    else:
        new_struct_inner(One2)

#Two1()
let c = when declared(Two1_new_struct_inner):
        Two1_new_struct_inner()
    else:
        new_struct_inner(Two1)

#Two2()
let d = when declared(Two2_new_struct_inner):
        Two2_new_struct_inner()
    else:
        new_struct_inner(Two2)

#Three1()
let e = when declared(Three1_new_struct_inner):
        Three1_new_struct_inner()
    else:
        new_struct_inner(Three1)

#Three2()
let f = when declared(Three2_new_struct_inner):
        Three2_new_struct_inner()
    else:
        new_struct_inner(Three2)

proc hello*() =
    echo "hello - CompileMe_Proof"

proc hello*(one1 : One1) =
    echo "hello One1"

proc hello*(one2 : One2) =
    echo "hello One2"

#Can't do Two1 and Two2, they are the same object!
proc hello*(two : Two) =
    echo "hello Two"

#Can't do Three1 and Three2, they are the same object!
proc hello*(three : Three) =
    echo "hello Three"

#a and b are two different types, can use something directly
a.something()
b.something()

#Or something1 and something2 to be more precise
a.something1()
b.something2()

#c and d are the same type, but two different something are defined for them
c.something1()
d.something2()

e.something()
f.something()

e.somethingThree1()
f.somethingThree2()

a.hello()
b.hello()
c.hello()
d.hello()
e.hello()
f.hello()

hello1()
helloThree1()
hello2()
helloThree2()

#Will use the one in current module, no probs here
hello()