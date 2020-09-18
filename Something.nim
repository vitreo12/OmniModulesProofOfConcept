import generate_proc_in_module

#use Two
import Two as Two_module
export Two_module

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
proc something*(a : One) =
    echo "One - Something"

#def something(a Two)
proc something*(a : Two) =
    echo "Two - Something"

proc hello*() =
    echo "hello - Something"

expandMacros:
    generate_proc_in_module(something, check_module)
    generate_proc_in_module(hello, check_module)