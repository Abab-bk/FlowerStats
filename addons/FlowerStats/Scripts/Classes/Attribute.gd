class_name Attribute extends Resource

signal value_changed(value:float)

@export var id:StringName
@export var min_value:float = 0
@export var max_value:Stat:
    set(v):
        max_value = v
        _value = max_value.get_value()

var _value:float = 0:
    set(v):
        if v <= min_value:
            _value = min_value
            value_changed.emit(_value)
            return
        _value = min(max_value.get_value(), v)
        value_changed.emit(_value)


func make_unique() -> void:
    max_value = max_value.duplicate(true)


func get_value() -> float:
    return _value


func recompute_stats() -> void:
    max_value.recompute_final_value()


func increase(_com_value:float) -> void:
    _value += _com_value


func decrease(_com_value:float) -> void:
    _value -= _com_value

