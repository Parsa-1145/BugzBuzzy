class_name Barbarian
extends EnemyBase

func _process(delta: float) -> void:
	current_target = null
	current_target = nearest_tower
