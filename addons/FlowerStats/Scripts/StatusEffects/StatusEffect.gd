class_name StatusEffect extends Resource

@export_group("Info")
@export var id:StringName
@export var tags:Array[String]
@export var max_stack:int = 1
@export var has_duration:bool
@export var duration:float

@export_group("Effects")
@export var modifiers:Array[Modifier]


