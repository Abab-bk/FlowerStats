class_name Unit extends Resource

signal tags_changed

@export var name:String
@export var attrs:Array[Attribute]
@export var stats:Array[Stat]
@export var tags:Array[StringName]:
    set(value):
        tags = value
        tags_changed.emit()


func _init(_name:StringName = &"") -> void:
    name = _name


func has_tag(_tag:StringName) -> bool:
    return tags.has(_tag)


func add_tag(_tag:StringName) -> void:
    tags.append(_tag)
    tags_changed.emit()


func remove_tag(_tag:StringName) -> void:
    tags.erase(_tag)
    tags_changed.emit()


func clear_all_tags() -> void:
    tags = []


func add_attr(_attr:Attribute) -> void:
    attrs.append(_attr)

func add_stat(_stat:Stat) -> void:
    stats.append(_stat)

func remove_attr(_attr:Attribute) -> void:
    attrs.erase(_attr)

func remove_stat(_stat:Stat) -> void:
    stats.erase(_stat)

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