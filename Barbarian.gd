class_name Barbarian
extends EnemyBase

func _ready() -> void:
	move_speed = 2.5
	score = 15
	health = 12
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_update_nearest_target)
	enemyName = "Barbarian"
	current_target = GameManager.castle

	
	
func _process(delta: float) -> void:
	super._process(delta)
	current_target = nearest_tower
