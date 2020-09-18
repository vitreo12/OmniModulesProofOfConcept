import generate_proc_in_module

#use Two:
    #Two as TwoSomething
import Two as Two_module except Two, Two_export #Whenever doing an "as", except the names
export Two_module except Two, Two_export #Whenever doing an "as", except the names

type TwoSomething* = Two_module.Two_export
type TwoSomething_export* = TwoSomething

proc TwoSomething_new_struct_inner*() : TwoSomething {.inline.} =
    return Two_module.Two_new_struct_inner()

type One* = object
type One_export* = One

#The one used in exports (typedesc doesn't work...)
proc One_new_struct_inner*() : One =
    return One()

#The one used internally
proc new_struct_inner*(obj_type : typedesc[One]) : One =
    return One()

#just used to have a sym to run .owner on for comparison
proc check_module() =
    discard

proc something*(a : One) =
    echo "One - SomethingElse"

proc something*(a : TwoSomething) =
    echo "Two - SomethingElse"

proc hello*() =
    echo "hello - SomethingElse"

expandMacros:
    generate_proc_in_module(something, check_module)
    generate_proc_in_module(hello, check_module)