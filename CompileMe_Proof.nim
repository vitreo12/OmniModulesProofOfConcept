#use Something:
    #One as One1
    #TwoSomething as TwoSomething1
    #ThreeYay as Three1
    #hello as hello1
    #Three.hello as helloThree1
    #something as something1
    #Two.something as somethingThree1

import Something as Something_module except One, One_export, TwoSomething, TwoSomething_export, ThreeYay, ThreeYay_export

type One1 = Something_module.One_export

#Use proc for name mangling in typedToUntyped
proc One1_new_struct_inner() : One1 {.inline.} =
    return Something_module.One_new_struct_inner()

type TwoSomething1 = Something_module.TwoSomething_export

#Use proc for name mangling in typedToUntyped
proc TwoSomething1_new_struct_inner() : TwoSomething1 {.inline.} =
    return Something_module.TwoSomething_new_struct_inner()

#type Three1 = Something_module.Two_module.Three_export 
type Three1 = Something_module.ThreeYay_export

#Use proc for name mangling in typedToUntyped
proc Three1_new_struct_inner() : Three1 {.inline.} =
    #return Something_module.Two_module.Three_new_struct_inner()
    return Something_module.Three_new_struct_inner()

template hello1() : untyped =
    Something_module.OmniDef_Something_hello()

template helloThree1() : untyped =
    Something_module.Three_module.OmniDef_Three_hello()

template something1(a : Something_module.One_export) : untyped =
    Something_module.OmniDef_Something_something(a)

template something1(a : Something_module.TwoSomething_export) : untyped =
    Something_module.OmniDef_Something_something(a)

template somethingThree1(a : Something_module.ThreeYay_export) : untyped =
    Something_module.OmniDef_Two_something(a)

#use SomethingElse:
    #One as One2
    #TwoSomething as TwoSomething2
    #ThreeYay as Three2
    #hello as hello2
    #Three.hello as helloThree2
    #something as something2
    #Two.something as somethingThree2

import SomethingElse as SomethingElse_module except One, One_export, TwoSomething, TwoSomething_export, ThreeYay, ThreeYay_export

type One2 = SomethingElse_module.One_export

#Use proc for name mangling in typedToUntyped
proc One2_new_struct_inner() : One2 {.inline.} =
    return SomethingElse_module.One_new_struct_inner()

type TwoSomething2 = SomethingElse_module.TwoSomething_export

#Use proc for name mangling in typedToUntyped
proc TwoSomething2_new_struct_inner() : TwoSomething2 {.inline.} =
    return SomethingElse_module.TwoSomething_new_struct_inner()

#type Three2 = Something_module.Two_module.Three_export 
type Three2 = Something_module.ThreeYay_export

#Use proc for name mangling in typedToUntyped
proc Three2_new_struct_inner() : Three2 {.inline.} =
    #return Something_module.Two_module.Three_new_struct_inner()
    return Something_module.Three_new_struct_inner()

template hello2() : untyped =
    SomethingElse_module.OmniDef_SomethingElse_hello()

template helloThree2() : untyped =
    Something_module.Three_module.OmniDef_Three_hello()

template something2(a : SomethingElse_module.One_export) : untyped =
    SomethingElse_module.OmniDef_SomethingElse_something(a)

template something2(a : SomethingElse_module.TwoSomething_export) : untyped =
    SomethingElse_module.OmniDef_SomethingElse_something(a)

template somethingThree2(a : SomethingElse_module.ThreeYay_export) : untyped =
    SomethingElse_module.OmniDef_Two_something(a)


type Three* = object
type Three_export* = object

proc Three_new_struct_inner*() : Three {.inline.} =
    return Three()

proc hello*() =
    echo "hello - CompileMe_Proof"

proc hello*(one1 : One1) =
    echo "hello One1"

proc hello*(one2 : One2) =
    echo "hello One2"

#Can't do Two1 and Two2, they are the same object!
proc hello*(two : TwoSomething1) =
    echo "hello Two1 or Two2"

#Can't do Three1 and Three2, they are the same object!
proc hello*(three : Three2) =
    echo "hello Three1 or Three2"

#This applies to Three defined in this module!
proc hello*(three : Three) =
    echo "hello Three CompileMe_Proof"


import macros

macro typedToUntyped(code_block : typed) : untyped =
    result = nnkBlockStmt.newTree(
        newEmptyNode(),
        parseStmt(code_block.repr())
    )

    echo repr result
    
typedToUntyped:
    #One1()
    let a = One1_new_struct_inner()

    #One2()
    let b = One2_new_struct_inner()

    #Two1()
    let c = TwoSomething1_new_struct_inner()

    #TwoSomething2()
    var d = TwoSomething2_new_struct_inner()

    #Three1()
    let e = Three1_new_struct_inner()

    #Three2()
    let f = Three2_new_struct_inner()

    #Three()
    let g = Three_new_struct_inner()

    #a and b are two different types, can use something directly
    #Or something1 and something2 to be more precise
    a.something()
    b.something()
    a.something1()
    b.something2()

    #c and d are the same type, but two different something are defined for them
    c.something1()
    d.something2()

    #e and f are same type, and only one something is defined for that type
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
    g.hello()

    hello1()
    helloThree1()
    hello2()
    helloThree2()

    #Will use the one in current module, no probs here
    hello()