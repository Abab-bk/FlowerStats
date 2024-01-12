class_name Formula extends Resource

# Source Target | source.stats[attack] - target.stats[defense] -> source, target = unit
@export var formula:String


func execute(_source:Unit, _target:Unit) -> float:
    if formula == "":
        push_error("Formula is empty")
        return 0.0

    var _expression:Expression = Expression.new()
    if _expression.parse(formula) != OK:
        push_error("Formula parse error: %s" % _expression.get_error_text())
        return 0.0

    var _result:float = _expression.execute([_source, _target])
    if _expression.has_execute_failed():
        push_error("Formula execute error: %s" % _expression.get_error_text())
        return 0.0
    
    return _result