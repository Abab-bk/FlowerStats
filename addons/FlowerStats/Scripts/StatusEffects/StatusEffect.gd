class_name StatusEffect extends Resource

signal finished

@export var id:StringName
@export var tags:Array[String]
@export var max_stack:int = 1
@export var has_duration:bool
@export var duration:float

@export_group("Effects")
@export var scene:PackedScene
@export var action:EffectAction

var _instance_scene:Node


func start(_target_node:Node, _target_unit:Unit) -> void:
    action.target_node = _target_node
    action.target_unit = _target_unit
    action.allow_while_ticked = has_duration
    action.on_start()


func finish() -> void:
    action.on_end()
    action = null
    
    if _instance_scene:
        _instance_scene.queue_free()

    finished.emit()
