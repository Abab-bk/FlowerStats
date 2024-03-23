extends CharacterBody2D

@onready var modifier_node:ModifierNode = %ModifierNode
@onready var unit_node:UnitNode = %UnitNode
@onready var status_effect_applier:StatusEffectApplier = %StatusEffectApplier


func _ready() -> void:
    unit_node.add_stat(
        Stat.new()\
        .set_id(Global.STATS.MaxHealth)\
        .set_value(100.0)
        )

    unit_node.add_attr(
        Attribute.new()\
        .set_id(Global.STATS.Health)\
        .set_value(100)\
        .set_max_value(get_stat_by_id(Global.STATS.MaxHealth))
        )
    
    print(unit_node.get_attrs()[0].id)


func add_status_effect(_effect:StatusEffect) -> void:
    status_effect_applier.apply(_effect)


func add_modifier(_modifier:FlowerModifier) -> void:
    modifier_node.add_modifier(_modifier)


func remove_modifier(_modifier:FlowerModifier) -> void:
    modifier_node.remove_modifier(_modifier)


func get_modifiers() -> Array[FlowerModifier]:
    return modifier_node.get_modifiers()


func get_attr_by_id(_id:StringName) -> Attribute:
    return unit_node.unit.get_attr_by_id(_id)


func get_stat_by_id(_id:StringName) -> Stat:
    for _stat:Stat in unit_node.unit.stats:
        if _stat.id == _id:
            return _stat
    return null