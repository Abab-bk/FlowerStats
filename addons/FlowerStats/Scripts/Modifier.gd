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

    if type == TYPE.CONSTANT:
        target.constant_value += value
        computed = true
        return
    
    if type == TYPE.PERCENTAGE:
        target.percentage_value += value
        computed = true
        return


func uninstall(_recompute:bool = true) -> void:
    if not computed:
        return
    
    match type:
        TYPE.CONSTANT:
            target.constant_value -= value
            computed = false
        TYPE.PERCENTAGE:
            target.percentage_value -= value
            computed = false
    
    if _recompute:
        compute()


func push_self_in_target() -> void:
    target.push_modifier(self)

func pop_self_in_target() -> void:
    target.pop_modifier_in_stack(self)