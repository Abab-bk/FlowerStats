extends Node2D

@onready var add_max_hp_btn:Button = %AddMaxHp
@onready var remove_max_hp_btn:Button = %RemoveMaxHp
@onready var add_max_hp_percentage_btn:Button = %AddMaxHpPercentage
@onready var remove_max_hp_percentage_btn:Button = %RemoveMaxHpPercentage
@onready var add_burning_status_effect_btn:Button = %AddBurningStatusEffect


@onready var player:CharacterBody2D = %Player
@onready var label:Label = %Label


var _constant_modifiers:Array[FlowerModifier] = []
var _percentage_modifiers:Array[FlowerModifier] = []


func _ready() -> void:
    add_max_hp_btn.pressed.connect(func():
        player.add_modifier(get_new_modifier(Global.STATS.MaxHealth, FlowerModifier.TYPE.CONSTANT, 10))
        )
    remove_max_hp_btn.pressed.connect(func():
        if _constant_modifiers.is_empty():
            return
        player.remove_modifier(_constant_modifiers[0])
        _constant_modifiers.erase(_constant_modifiers[0])
        )
    
    add_max_hp_percentage_btn.pressed.connect(func():
        player.add_modifier(get_new_modifier(Global.STATS.MaxHealth, FlowerModifier.TYPE.PERCENTAGE, 0.1))
        )
    remove_max_hp_percentage_btn.pressed.connect(func():
        if _percentage_modifiers.is_empty():
            return

        player.remove_modifier(_percentage_modifiers[0])
        _percentage_modifiers.erase(_percentage_modifiers[0])
        )

    add_burning_status_effect_btn.pressed.connect(func():
        player.add_status_effect(load("res://Example/Classes/Effects/Burning.tres"))
        )
    

func get_new_modifier(_id:StringName, _operation:FlowerModifier.TYPE, _value:float) -> FlowerModifier:
    var _modifier:FlowerModifier = FlowerModifier.new()\
            .set_target(player.get_stat_by_id(_id))\
            .set_type(_operation)\
            .set_value(_value)
    
    if _operation == FlowerModifier.TYPE.CONSTANT:
        _constant_modifiers.append(_modifier)
    if _operation == FlowerModifier.TYPE.PERCENTAGE:
        _percentage_modifiers.append(_modifier)

    return _modifier


func _physics_process(_delta:float) -> void:
    if not player.get_attr_by_id(Global.STATS.Health):
        return
    update_ui()

func update_ui() -> void:
    label.text = """
    Health: %s
    MaxHealth: %s
    Modifiers: %s
    """ % [
        str(player.get_attr_by_id(Global.STATS.Health).get_value()),
        str(player.get_attr_by_id(Global.STATS.Health).get_max_value().get_value()),
        str(player.get_modifiers().size())]
