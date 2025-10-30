class_name Skeleton
extends EnemyBase

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_update_nearest_target)

func _process(delta: float) -> void:
	current_target = null
	current_target = nearest_tower

	if not (current_target == null || global_position.distance_to(current_target.global_position) > global_position.distance_to(GameManager.playerNode.global_position)):
		current_target = GameManager.playerNode
