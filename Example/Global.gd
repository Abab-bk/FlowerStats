extends Node

func await_timer(_time:float) -> void:
    await get_tree().create_timer(_time).timeout