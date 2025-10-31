class_name Barbarian
extends EnemyBase

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_update_nearest_target)
	enemyName = "Barbarian"
