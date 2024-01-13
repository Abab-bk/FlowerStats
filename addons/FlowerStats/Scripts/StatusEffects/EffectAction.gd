class_name EffectAction extends Resource

signal ticked

var target_node:Node
var target_unit:Unit
var scene:Node

var allow_while_ticked:bool = false


func on_start() -> void:
    if allow_while_ticked:
        ticked.connect(while_active)
    while_active()


func while_active() -> void:
    ticked.emit()


func on_end() -> void:
    pass