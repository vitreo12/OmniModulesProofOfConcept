import macros

macro use_inner(statement : typed) =
    #Multiple functions with same name!
    if statement.kind == nnkClosedSymChoice:
        for individual_proc in statement:
            echo astGenRepr individual_proc.getImpl()
            echo astGenRepr individual_proc.owner()
    else:
        echo astGenRepr statement.getImpl()
        echo astGenRepr statement.owner()

macro use(file : untyped, code_block : untyped) =
    let file_module = newIdentNode(file.strVal() & "_module")

    let one = code_block[0][1]

    let something_one = nnkDotExpr.newTree(
        file,
        one
    )

    echo astGenRepr something_one

    return quote do:
        import `file`
        #import `file` as `file_module`
        
        #Generate typed
        use_inner(`something_one`)

use Something:
    One as One1
    
use SomethingElse:
    something as something2

#use Something:
    #One as One1
    #hello as hello1
    #[ 
import Something as Something_module

type One1 = Something_module.One

template hello1() : untyped =
    Something_module.hello()

#use SomethingElse:
    #One as One2
    #hello as hello2
import SomethingElse as SomethingElse_module

type One2 = SomethingElse_module.One

template hello2() : untyped =
    SomethingElse_module.hello()

let a = One1()
let b = One2()

a.something()
b.something()

hello1()
hello2() ]#