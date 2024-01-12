class_name Stat extends Resource

@export var id:StringName
@export var base_value:float:
    set(v):
        if final_value < base_value:
            final_value = base_value

var final_value:float = 0