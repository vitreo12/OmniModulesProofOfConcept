import generate_proc_in_module

#use Two:
    #Two as TwoSomething
import Two as Two_module except Two, Two_export #Whenever doing an "as", except the names
export Two_module except Two, Two_export #Whenever doing an "as", except the names

type TwoSomething* = Two_module.Two_export
type TwoSomething_export* = TwoSomething

proc TwoSomething_new_struct_inner*() : TwoSomething {.inline.} =
    return Two_module.Two_new_struct_inner()

#struct One
type One* = object
type One_export* = One

proc One_new_struct_inner*(a : typedesc[One_export]) : One =
    return One()

proc checkValidity*(obj : One) =
    echo "checkValidity - One - SomethingElse"

#def something(a : One)
when not declared(check_module):
    proc check_module() =
        discard

proc something_def_inner*(a : One) =
    echo "One - SomethingElse"

template something*(a : One) =
    something_def_inner(a)

#def something(a : TwoSomething)
when not declared(check_module):
    proc check_module() =
        discard

proc something_def_inner*(a : TwoSomething) =
    echo "Two - SomethingElse"

template something*(a : TwoSomething) =
    something_def_inner(a)

#def hello()
when not declared(check_module):
    proc check_module() =
        discard

proc hello_def_inner*() =
    echo "hello - SomethingElse"

template hello*() =
    hello_def_inner()

expandMacros:
    generate_proc_in_module(something_def_inner, check_module)
    generate_proc_in_module(hello_def_inner, check_module)