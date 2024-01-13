class_name UnitNode extends Node

@export var unit:Unit


func _ready() -> void:
    recompute_all_stats()



func recompute_all_stats() -> void:
    for _attr:Attribute in unit.attrs:
        _attr.recompute_stats()
    
    for _stat:Stat in unit.stats:
        _stat.recompute_final_value()


func get_attr_by_id(_id:StringName) -> Attribute:
    for _attr:Attribute in unit.attrs:
        if _attr.id == _id:
            return _attr
    return null


func get_attrs() -> Array[Attribute]:
    return unit.attrs


func get_stats() -> Array[Stat]:
    return unit.stats