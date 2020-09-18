import generate_proc_in_module

type Three* = object
type Three_export* = Three #to export a different name than module...

#typedesc fails here...
proc Three_new_struct_inner*() : Three =
    return Three()

#just used to have a sym to run .owner on for comparison
proc check_module() =
    discard

proc hello*() =
    echo "hello - Three"

expandMacros:
    generate_proc_in_module(hello, check_module)