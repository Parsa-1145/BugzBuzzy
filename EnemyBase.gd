class_name EnemyBase
extends CharacterBody3D

func _physics_process(delta: float) -> void:
	if(!is_on_floor()):
		velocity.y += 9.8 * delta
func _process(delta: float) -> void:
	var targetPos = GameManager.playerNode.position
	var diff = targetPos - position
	
	position += diff.normalized() * delta * 2
