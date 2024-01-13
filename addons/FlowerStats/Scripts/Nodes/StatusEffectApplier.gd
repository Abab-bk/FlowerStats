class_name StatusEffectApplier extends Node

@export_category("Status Effect")
@export var target:UnitNode
@export var target_node:Node

var effect_list:Array[StatusEffect] = []


func apply(_effect:StatusEffect) -> void:
    effect_list.append(_effect)
    # 添加timer
    var _timer:Timer = create_timer(_effect.duration)
    add_child(_timer)
    _timer.timeout.connect(_effect.finish)
    
    # 添加场景
    if _effect.scene:
        var _scene = _effect.scene.instantiate()
        target_node.add_child(_scene)
        _effect._instance_scene = _scene
    
    _effect.finished.connect(func():
        effect_list.erase(_effect)
        _timer.queue_free()
        )

    _effect.start(target_node, target.unit)
    _timer.start()



func create_timer(_time:float) -> Timer:
    var _timer:Timer = Timer.new()
    _timer.one_shot = true
    _timer.wait_time = _time
    return _timer