class_name StatusEffect extends Resource

signal finished

@export var id:StringName
@export var tags:Array[StringName]
@export var max_stack:int = 1
@export var duration:float = 0.0
@export var allow_while_ticked:bool = false
@export var remove_tags_on_finished:bool = true

@export_group("Effects")
@export var scene:PackedScene
@export var action:PackedScene:
    set(v):
        action = v

var _instance_scene:Node
var _instance_action:EffectAction

var _timer:Timer
var _unit_node:UnitNode
var _applier_node:StatusEffectApplier


func _start(_target_node:Node, _target_unit:Unit) -> void:
    if _target_node:
        _instance_action.target_node = _target_node
    if _target_unit:
        _instance_action.target_unit = _target_unit
    
    _instance_action._allow_while_ticked = allow_while_ticked
    
    _instance_action.on_start()


func _finish() -> void:
    if _timer:
        _timer.stop()
        _timer.queue_free()

    if remove_tags_on_finished:
        for _tag:StringName in tags:
            _unit_node.remove_tag(_tag)

    _instance_action.on_end()
    _instance_action = null

    if _instance_scene:
        _instance_scene.queue_free()

    _applier_node.effect_list.erase(self)
    finished.emit()
