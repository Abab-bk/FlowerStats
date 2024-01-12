class_name Modifier extends Resource


enum TYPE {
    CONSTANT, # +、-
    PERCENTAGE, # *、/
    FORMULA,
}


@export var target:Stat
@export var type:TYPE
@export var value:float
@export var formula:Formula

var computed:bool = false


func compute() -> void:
    if computed:
        uninstall()
        return
    
    print("modifier 计算")

    if type == TYPE.CONSTANT:
        target.final_value += value
        computed = true
        return
    
    if type == TYPE.PERCENTAGE:
        target.final_value *= (1.0 + value)
        computed = true
        return


func uninstall(_recompute:bool = true) -> void:
    if not computed:
        return

    print("modifier 卸载")
    
    match type:
        TYPE.CONSTANT:
            target.final_value -= value
            computed = false
        TYPE.PERCENTAGE:
            target.final_value /= (1.0 + value)
            computed = false
    
    if _recompute:
        compute()
