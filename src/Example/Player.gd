extends CharacterBody2D

@onready var modifier_node:ModifierNode = %ModifierNode
@onready var unit_node:UnitNode = %UnitNode
@onready var status_effect_applier:StatusEffectApplier = %StatusEffectApplier


func add_status_effect(_effect:StatusEffect) -> void:
    status_effect_applier.apply(_effect)


func add_modifier(_modifier:Modifier) -> void:
    modifier_node.add_modifier(_modifier)


func remove_modifier(_modifier:Modifier) -> void:
    modifier_node.remove_modifier(_modifier)


func get_attr_by_id(_id:StringName) -> Attribute:
    return unit_node.unit.get_attr_by_id(_id)


func get_stat_by_id(_id:StringName) -> Stat:
    for _stat:Stat in unit_node.unit.stats:
        if _stat.id == _id:
            return _stat
    return null