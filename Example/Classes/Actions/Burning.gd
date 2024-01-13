class_name Burning extends EffectAction


func on_start() -> void:
    super()
    target_unit.get_attr_by_id("Health").decrease(5)


func while_active() -> void:
    print("Burn!")
    target_unit.get_attr_by_id("Health").decrease(5)
    await Global.await_timer(0.5)
    super()


func on_end() -> void:
    super()