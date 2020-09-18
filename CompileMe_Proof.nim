#use Something:
    #One as One1
    #Two as Two1
    #Two.Three as Three1   #equivalent to Three as Three1
    #hello as hello1
    #Three.hello as helloThree
    #something as something1

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

template something1(a : One1) : untyped =
    Something_module.Something_something(a)

template something1(a : Two1) : untyped =
    Something_module.Something_something(a)

template hello1() : untyped =
    Something_module.Something_hello()

template helloThree() : untyped =
    Something_module.Three_module.Three_hello()

#use SomethingElse:
    #One as One2
    #Two as Two2
    #something as something2
    #hello as hello2

import SomethingElse as SomethingElse_module

type One2 = SomethingElse_module.One_export

template One2_new_struct_inner() : One2 =
    SomethingElse_module.One_new_struct_inner()

type Two2 = SomethingElse_module.Two_export

template Two2_new_struct_inner() : Two2 =
    SomethingElse_module.Two_new_struct_inner()

template something2(a : One2) : untyped =
    SomethingElse_module.SomethingElse_something(a)

template something2(a : Two2) : untyped =
    SomethingElse_module.SomethingElse_something(a)

template hello2() : untyped =
    SomethingElse_module.SomethingElse_hello()

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

#a and b are two different types, can use something directly
a.something()
b.something()

#Or something1 and something2 to be more precise
a.something1()
b.something2()

#c and d are the same type, need to import different def too!
c.something1()
d.something2()

e.something()

hello1()
helloThree()
hello2()