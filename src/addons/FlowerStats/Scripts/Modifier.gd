class_name FlowerModifier extends Resource


enum TYPE {
    CONSTANT, # +、-
    PERCENTAGE, # *、/
    # FORMULA,
}


@export var target:Stat
@export var type:TYPE
@export var value:float
@export var mark_tags:Array[StringName]
# @export var formula:Formula

var computed:bool = false


func set_target(_target:Stat) -> FlowerModifier:
    target = _target
    return self


func set_type(_type:TYPE) -> FlowerModifier:
    type = _type
    return self


func set_value(_value:float) -> FlowerModifier:
    value = _value
    return self


func add_mark_tag(_tag:StringName) -> FlowerModifier:
    mark_tags.append(_tag)
    return self


func remove_mark_tag(_tag:StringName) -> FlowerModifier:
    mark_tags.erase(_tag)
    return self


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


func get_value() -> float:
    return value


func push_self_in_target() -> void:
    if not target:
        push_error("target is null.")
        return

    target.push_modifier(self)


func pop_self_in_target() -> void:
    target.pop_modifier_in_stack(self)



func has_mark_tag(_tag:StringName) -> bool:
    return mark_tags.has(_tag)