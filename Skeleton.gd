class_name Skeleton
extends EnemyBase

func _process(delta: float) -> void:
	current_target = null
	current_target = nearest_tower

	if not (current_target == null || global_position.distance_to(current_target.global_position) > global_position.distance_to(GameManager.playerNode.global_position)):
		current_target = GameManager.playerNode
