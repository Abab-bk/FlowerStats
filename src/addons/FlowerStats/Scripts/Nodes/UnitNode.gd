@icon("../../Icons/UnitNode.svg")
class_name UnitNode extends Node

@export var unit:Unit


func _ready() -> void:
    recompute_all_stats()


func add_tag(_tag:StringName) -> void:
    unit.add_tag(_tag)


func remove_tag(_tag:StringName) -> void:
    unit.remove_tag(_tag)


func has_tag(_tag:StringName) -> bool:
    return unit.has_tag(_tag)


func recompute_all_stats() -> void:
    for _attr:Attribute in unit.attrs:
        _attr.recompute_stats()
    
    for _stat:Stat in unit.stats:
        _stat.recompute_final_value()


func get_attr_by_id(_id:StringName) -> Attribute:
    return unit.get_attr_by_id(_id)


func get_stat_by_id(_id:StringName) -> Stat:
    return unit.get_stat_by_id(_id)


func get_attrs() -> Array[Attribute]:
    return unit.attrs


func get_stats() -> Array[Stat]:
    return unit.stats