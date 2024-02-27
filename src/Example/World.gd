extends Node2D

@onready var add_max_hp_btn:Button = %AddMaxHp
@onready var remove_max_hp_btn:Button = %RemoveMaxHp
@onready var add_max_hp_percentage_btn:Button = %AddMaxHpPercentage
@onready var remove_max_hp_percentage_btn:Button = %RemoveMaxHpPercentage
@onready var add_burning_status_effect_btn:Button = %AddBurningStatusEffect


@onready var player:CharacterBody2D = %Player
@onready var label:Label = %Label


class modifier_container:
    var modifier:Modifier = load("res://Example/Classes/Modifiers/AddMapHp.tres").duplicate()

class percentage_modifier_container:
    var modifier:Modifier = load("res://Example/Classes/Modifiers/AddMaxHpPercentage.tres").duplicate()


var modifier_containers:Array[modifier_container] = [
    modifier_container.new(),
    modifier_container.new(),
    modifier_container.new(),
]
var percentage_modifier_containers:Array[percentage_modifier_container] = [
    percentage_modifier_container.new(),
    percentage_modifier_container.new(),
    percentage_modifier_container.new(),
]

var _modifier_count:int = 0:
    set(v):
        _modifier_count = min(2, v)

var _percentage_modifier_count:int = 0:
    set(v):
        _percentage_modifier_count = min(2, v)

func _ready() -> void:
    add_max_hp_btn.pressed.connect(func():
        if _modifier_count >= 2:
            return
        player.add_modifier(modifier_containers[_modifier_count].modifier)
        _modifier_count += 1
        )
    remove_max_hp_btn.pressed.connect(func():
        if _modifier_count == 0:
            return
        _modifier_count -= 1
        player.remove_modifier(modifier_containers[_modifier_count].modifier)
        )
    
    add_max_hp_percentage_btn.pressed.connect(func():
        if _percentage_modifier_count >= 2:
            return
        player.add_modifier(percentage_modifier_containers[_percentage_modifier_count].modifier)
        _percentage_modifier_count += 1
        )
    remove_max_hp_percentage_btn.pressed.connect(func():
        if _percentage_modifier_count == 0:
            return
        _percentage_modifier_count -= 1
        player.remove_modifier(percentage_modifier_containers[_percentage_modifier_count].modifier)
        )
    add_burning_status_effect_btn.pressed.connect(func():
        player.add_status_effect(load("res://Example/Classes/Effects/Burning.tres"))
        )
    


func _physics_process(_delta:float) -> void:
    label.text = """
    Health: %s
    MaxHealth: %s
    Strength: %s
    """ % [str(player.get_attr_by_id("Health").get_value()), str(player.get_attr_by_id("Health").max_value.final_value), "test"]
