import generate_proc_in_module

#use Three:
    #Three as ThreeYay
import Three as Three_module except Three, Three_export
export Three_module except Three, Three_export

type ThreeYay* = Three_module.Three_export
type ThreeYay_export* = ThreeYay

proc ThreeYay_new_struct_inner*() : ThreeYay {.inline.} =
    return Three_module.Three_new_struct_inner()

#struct Two
type Two* = object
type Two_export* = Two #to export a different name than module...

proc Two_new_struct_inner*() : Two =
    return Two()

#def something(a ThreeYay)
when not declared(check_module):
    proc check_module() =
        discard

proc something_def_inner*(a : ThreeYay) =
    echo "Two - Three"

template something*(a : ThreeYay) =
    something_def_inner(a)

expandMacros:
    generate_proc_in_module(something_def_inner, check_module)
    generate_proc_in_module(hello, check_module) #Nothing gets generated for hello, not defined in current module!