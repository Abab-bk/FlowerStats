class_name Stat extends Resource

signal value_changed(value:float)

@export var id:StringName
@export var base_value:float:
    set(v):
        base_value = max(0, v)
        if final_value < base_value:
            final_value = base_value
        recompute_final_value()

var final_value:float = 0.0:
    set(v):
        final_value = v
        value_changed.emit(final_value)
var stack:Array[FlowerModifier] = []

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

    final_value = (final_value + constant_value) * (1.0 + percentage_value)


func set_id(_id:StringName) -> Stat:
    id = _id
    return self


func push_modifier(_modifier:FlowerModifier) -> void:
    if _modifier not in stack:
        stack.append(_modifier)
    for _temp_modifier:FlowerModifier in stack:
        _temp_modifier.compute()


func pop_modifier_in_stack(_modifier:FlowerModifier) -> void:
    var _modifier_index:int = stack.find(_modifier)
    if _modifier_index == -1:
        print("modifier not exist in stack.")
        return
    
    var _temp_list:Array[FlowerModifier] = stack.slice(0, _modifier_index)
    _temp_list.reverse()
    for _temp_modifier:FlowerModifier in _temp_list:
        _temp_modifier.uninstall()

    _modifier.uninstall(false)
    stack.erase(_modifier)

    for _temp_modifier:FlowerModifier in _temp_list:
        _temp_modifier.compute()


func get_value() -> float:
    return final_value


func set_value(_value:float) -> Stat:
    base_value = _value
    recompute_final_value()
    return self


func decrease(_value:float) -> float:
    if _value > base_value:
        base_value -= _value
        return base_value

    base_value -= _value

    return _value


func increase(_value:float) -> float:
    base_value += _value
    return base_value