extends Node2D

# Source Target | source.stats[attack] - target.stats[defense] -> source, target = unit
@export var formula:String

class test_unit:
    var stats:Dictionary = {}

    func _init(_stats) -> void:
        stats = _stats


var source:test_unit = test_unit.new({"attack": 50.0})
var target:test_unit = test_unit.new({"hp": 100.0})

const FORMULA_RULE:String = "(source|target)\\.(stats|attr)\\[(.*?)\\]"

func _ready() -> void:
    print(execute(12.0))


func execute(_value:float) -> float:
    if formula == "":
        push_error("Formula is empty")
        return 0.0


    var _expression:Expression = Expression.new()
    if _expression.parse(formula, ["source", "target"]) != OK:
        push_error("Formula parse error: %s" % _expression.get_error_text())
        return 0.0

    # 解析表达式
    

    var _result:float = _expression.execute([source, target])
    if _expression.has_execute_failed():
        push_error("Formula execute error: %s" % _expression.get_error_text())
        return 0.0
    
    return _result
