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

#The one used in exports (typedesc doesn't work...)
proc One_new_struct_inner*() : One =
    return One()

#The one used internally
proc new_struct_inner*(obj_type : typedesc[One]) : One =
    return One()

#just used to have a sym to run .owner on for comparison
proc check_module() =
    discard

#def something(a One)
proc something_def_inner*(a : One) =
    echo "One - Something"

template something*(a : One) =
    something_def_inner(a)

#def something(a TwoSomething)
proc something_def_inner*(a : TwoSomething) =
    echo "Two - Something"

template something*(a : TwoSomething) =
    something_def_inner(a)

#def hello()
proc hello_def_inner*() =
    echo "hello - Something"

template hello*() =
    hello_def_inner()

expandMacros:
    generate_proc_in_module(something_def_inner, check_module)
    generate_proc_in_module(hello_def_inner, check_module)