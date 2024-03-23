class_name Attribute extends Resource

signal value_changed(value:float)

@export var id:StringName
@export var min_value:float = 0
@export var max_value:Stat:
    set(v):
        max_value = v
        _value = max_value.get_value()
@export var current_value:Stat = Stat.new():
    set(v):
        current_value = v
        
        if not current_value:
            return
            
        if current_value.is_connected("value_changed", _set_internal_stat):
            return
        
        current_value.value_changed.connect(_set_internal_stat)


var _force_changed:bool = false

var _value:float = 0:
    set(v):
        if v <= min_value:
            if _force_changed:
                _value = min_value
                value_changed.emit(_value)
                return

            _value = min_value
            current_value.set_value(_value)
            value_changed.emit(_value)
            return

        if _force_changed:
            _value = min(max_value.get_value(), v)
            value_changed.emit(_value)
            return

        _value = min(max_value.get_value(), v)
        current_value.set_value(_value)
        value_changed.emit(_value)


func _init(_id:StringName = &"") -> void:
    id = _id


func _set_internal_stat(__value:float) -> void:
    _force_changed = true
    _value = __value


func get_max_value() -> Stat:
    return max_value


func get_value() -> float:
    return _value


func get_value_stat() -> Stat:
    return current_value


func set_value(_value:float) -> Attribute:
    _value = _value
    return self


func set_id(_id:StringName) -> Attribute:
    id = _id
    return self


func set_max_value(_max_value:Stat) -> Attribute:
    max_value = _max_value
    return self


func recompute_stats() -> void:
    max_value.recompute_final_value()


func increase(_com_value:float) -> void:
    _value += _com_value


func decrease(_com_value:float) -> void:
    _value -= _com_value


func replenish() -> void:
    _value = max_value.get_value()


func deplete() -> void:
    _value = min_value