class_name Unit extends Resource

@export var name:String
@export var attrs:Array[Attribute]
@export var stats:Array[Stat]


func get_attr_by_id(_id:StringName) -> Attribute:
    for _attr:Attribute in attrs:
        if _attr.id == _id:
            return _attr
    return null


func get_stat_by_id(_id:StringName) -> Stat:
    for _stat:Stat in stats:
        if _stat.id == _id:
            return _stat
    return null