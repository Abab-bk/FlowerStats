class_name ModifierNode extends Node

@export var source:UnitNode
@export var target:UnitNode
@export var modifiers:Array[Modifier]


func add_modifier(_modifier:Modifier) -> void:
    modifiers.append(_modifier)
    compute()


func remove_modifier(_modifier:Modifier) -> void:
    _modifier.uninstall(false)
    modifiers.erase(_modifier)
    compute()


func compute() -> void:
    var _percentage_modifiers:Array[Modifier] = []
    var _constant_modifiers:Array[Modifier] = []

    for _modifier:Modifier in modifiers:
        match _modifier.type:
            Modifier.TYPE.PERCENTAGE:
                _percentage_modifiers.append(_modifier)
            Modifier.TYPE.CONSTANT:
                _constant_modifiers.append(_modifier)
    
    for _modifier:Modifier in _percentage_modifiers:
        _modifier.compute()
    for _modifier:Modifier in _constant_modifiers:
        _modifier.compute()
