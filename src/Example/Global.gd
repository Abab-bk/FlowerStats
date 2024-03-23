extends Node

const STATS:Dictionary = {
    "MaxHealth": &"MaxHealth",
    "Health": &"Health",
    "Strength": &"Strength",
}

func await_timer(_time:float) -> void:
    await get_tree().create_timer(_time).timeout