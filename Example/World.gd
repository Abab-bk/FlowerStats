extends Node2D

@onready var add_max_hp_btn:Button = %AddMaxHp
@onready var remove_max_hp_btn:Button = %RemoveMaxHp

@onready var player:CharacterBody2D = %Player
@onready var label:Label = %Label


class modifier_container:
    var modifier:Modifier = load("res://Example/Classes/Modifiers/AddMapHp.tres").duplicate()


var modifier_containers:Array[modifier_container] = [
    modifier_container.new(),
    modifier_container.new(),
    modifier_container.new(),
]

var _modifier_count:int = 0:
    set(v):
        _modifier_count = min(2, v)

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


func _physics_process(_delta:float) -> void:
    label.text = """
    Health: %s
    MaxHealth: %s
    Strength: %s
    """ % ["11", str(player.get_attr_by_id("Health").max_value.final_value), "11"]
