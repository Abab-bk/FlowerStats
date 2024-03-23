class_name EffectAction extends Node2D

signal ticked

var target_node:Node
var target_unit:Unit
var scene:Node

var _allow_while_ticked:bool = false

func on_start() -> void:
    if _allow_while_ticked:
        ticked.connect(tick)
    tick()


func tick() -> void:
    ticked.emit()


func on_end() -> void:
    queue_free()