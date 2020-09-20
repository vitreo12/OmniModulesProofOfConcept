import macros
export macros

import strutils

proc generate_proc_in_module_inner(proc_in : NimNode, current_module : NimNode) : NimNode {.compileTime.} =
    var proc_in_name = proc_in.strVal()
    if proc_in_name.endsWith("_def_inner"):
        proc_in_name = proc_in_name[0..^11] #remove _def_inner

    var proc_def = proc_in.getImpl()
    proc_def[0] = nnkPostfix.newTree(
        newIdentNode("*"),
        newIdentNode("OmniDef_" & current_module.strVal() & "_" & proc_in_name)
    )

    return proc_def

macro generate_proc_in_module*(proc_in : typed, check_module : typed) =
    result = nnkStmtList.newTree()
    let current_module = check_module.owner

    #Multiple functions same name
    if proc_in.kind == nnkClosedSymChoice:
        for proc_in_inner in proc_in:
            let proc_module = proc_in_inner.owner
            if current_module == proc_module:
                let proc_def = generate_proc_in_module_inner(proc_in_inner, current_module)
                result.add(proc_def)

    #One function
    elif proc_in.kind == nnkSym:
        let proc_module = proc_in.owner
        if current_module == proc_module:
            let proc_def = generate_proc_in_module_inner(proc_in, current_module)
            result.add(proc_def)
    