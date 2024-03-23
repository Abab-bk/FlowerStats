@icon("../../Icons/ModifierNode.svg")
class_name ModifierNode extends Node

@export var source:UnitNode
@export var target:UnitNode
@export var modifiers:Array[FlowerModifier]


func get_modifiers() -> Array[FlowerModifier]:
    return modifiers


func add_modifier(_modifier:FlowerModifier) -> void:
    modifiers.append(_modifier)
    _compute()


func remove_modifier(_modifier:FlowerModifier) -> void:
    _modifier.pop_self_in_target()
    modifiers.erase(_modifier)
    _compute()


func _compute() -> void:
    var _percentage_modifiers:Array[FlowerModifier] = []
    var _constant_modifiers:Array[FlowerModifier] = []

    for _modifier:FlowerModifier in modifiers:
        match _modifier.type:
            FlowerModifier.TYPE.PERCENTAGE:
                _percentage_modifiers.append(_modifier)
            FlowerModifier.TYPE.CONSTANT:
                _constant_modifiers.append(_modifier)
    
    for _modifier:FlowerModifier in _percentage_modifiers:
        _modifier.push_self_in_target()
    for _modifier:FlowerModifier in _constant_modifiers:
        _modifier.push_self_in_target()
    

func _remove_compute() -> void:
    var _percentage_modifiers:Array[FlowerModifier] = []
    var _constant_modifiers:Array[FlowerModifier] = []

    for _modifier:FlowerModifier in modifiers:
        match _modifier.type:
            FlowerModifier.TYPE.PERCENTAGE:
                _percentage_modifiers.append(_modifier)
            FlowerModifier.TYPE.CONSTANT:
                _constant_modifiers.append(_modifier)
    
    for _modifier:FlowerModifier in _percentage_modifiers:
        _modifier.uninstall(false)
    for _modifier:FlowerModifier in _constant_modifiers:
        _modifier.uninstall(false)