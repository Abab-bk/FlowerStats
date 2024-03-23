extends EffectAction


func on_start() -> void:
    super()
    target_unit.get_attr_by_id(Global.STATS.Health).decrease(5)


func tick() -> void:
    print("Burn!, Health - 5")
    target_unit.get_attr_by_id(Global.STATS.Health).decrease(5)
    await Global.await_timer(0.5)
    super()


func on_end() -> void:
    super()