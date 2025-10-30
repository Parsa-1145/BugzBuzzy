class_name Tower
extends StaticBody3D

@onready var head : Node3D = $Head
var health: float


func _process(delta: float) -> void:
	var minDist: float = INF
	var closestEnemy: EnemyBase
	for enemy: EnemyBase in GameManager.enemies:
		var dist: float = (enemy.global_position - global_position).length()
		if  dist < minDist:
			minDist = dist
			closestEnemy = enemy
	
	if closestEnemy == null:
		return
	
	#var headDiff = closestEnemy.position - head.position
	head.look_at(closestEnemy.global_position)
	head.rotation.x = 0
	head.rotation.z = 0
