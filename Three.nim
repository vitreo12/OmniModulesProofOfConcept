import generate_proc_in_module

#struct Three
type Three* = object
type Three_export* = Three #to export a different name than module...

proc Three_new_struct_inner*() : Three =
    return Three()

proc checkValidity*(obj : Three) =
    echo "checkValidity - Three - Three"

#just used to have a sym to run .owner on for comparison
when not declared(check_module):
    proc check_module() =
        discard

#def hello()
proc hello_def_inner*() =
    echo "hello - Three"

template hello*() =
    hello_def_inner()

expandMacros:
    generate_proc_in_module(hello_def_inner, check_module)