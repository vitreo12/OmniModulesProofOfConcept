import generate_proc_in_module

import Three as Three_module
export Three_module

type Two* = object
type Two_export* = Two #to export a different name than module...

#typedesc fails here...
proc Two_new_struct_inner*() : Two =
    return Two()

#just used to have a sym to run .owner on for comparison
proc check_module() =
    discard

proc something*(a : Three) =
    echo "Two - Three"

expandMacros:
    generate_proc_in_module(something, check_module)
    generate_proc_in_module(hello, check_module) #Nothing gets generated for hello, not defined in current module!