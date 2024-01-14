class_name Stat extends Resource

@export var id:StringName
@export var base_value:float:
    set(v):
        base_value = v
        if final_value < base_value:
            final_value = base_value

            recompute_final_value()
# @export var formula:Formula

var final_value:float = 0.0
var stack:Array[Modifier] = []

var percentage_value:float = 0.0:
    set(v):
        percentage_value = v
        recompute_final_value()
        
var constant_value:float = 0.0:
    set(v):
        constant_value = v
        recompute_final_value()


func recompute_final_value() -> void:
    final_value = base_value

    # if formula:
    #     final_value = formula.execute(final_value)

    final_value = (final_value + constant_value) * (1.0 + percentage_value)


func push_modifier(_modifier:Modifier) -> void:
    if _modifier not in stack:
        stack.append(_modifier)
    for _temp_modifier:Modifier in stack:
        _temp_modifier.compute()


func pop_modifier_in_stack(_modifier:Modifier) -> void:
    var _modifier_index:int = stack.find(_modifier)
    if _modifier_index == -1:
        print("modifier not exist in stack.")
        return
    
    var _temp_list:Array[Modifier] = stack.slice(0, _modifier_index)
    _temp_list.reverse()
    for _temp_modifier:Modifier in _temp_list:
        _temp_modifier.uninstall()

    _modifier.uninstall(false)
    stack.erase(_modifier)

    for _temp_modifier:Modifier in _temp_list:
        _temp_modifier.compute()


func get_value() -> float:
    return final_value