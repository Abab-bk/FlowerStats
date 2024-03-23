@icon("../../Icons/EffectNode.svg")
class_name StatusEffectApplier extends Node

@export_category("Status Effect")
@export var target:UnitNode
@export var target_node:Node

var effect_list:Array[StatusEffect] = []


func apply(_effect:StatusEffect) -> void:
    # 检查 max_stack
    if _check_same_element_count(effect_list, _effect) >= _effect.max_stack:
        return

    effect_list.append(_effect)

    # 添加场景
    if _effect.scene:
        var _scene = _effect.scene.instantiate()
        
        if target_node:
            target_node.add_child(_scene)
        
        _effect._instance_scene = _scene
    
    if _effect.action:
        var _action_scene:EffectAction = _effect.action.instantiate()
        
        if target_node:
            target_node.add_child(_action_scene)
        
        _effect._instance_action = _action_scene
    
    # 添加标签
    for _tag:String in _effect.tags:
        target.add_tag(_tag)

    _effect._unit_node = target
    _effect._applier_node = self

    _effect._start(target_node, target.unit)

    # 添加timer
    if _effect.duration > 0:
        var _timer:Timer = _create_timer(_effect.duration)
        add_child(_timer)
        _timer.timeout.connect(_effect._finish)
        _effect._timer = _timer
        _timer.start()


func _check_same_element_count(_array:Array[StatusEffect], _effect:StatusEffect) -> int:
    var _count:int = 0

    for _element:StatusEffect in _array:
        if _element.id == _effect.id:
            _count += 1
    
    return _count


func _create_timer(_time:float) -> Timer:
    var _timer:Timer = Timer.new()
    _timer.one_shot = true
    _timer.wait_time = _time
    return _timer
