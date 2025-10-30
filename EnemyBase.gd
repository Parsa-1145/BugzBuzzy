#EnemyBase
class_name EnemyBase
extends CharacterBody3D

@export var move_speed: float = 2.0
@export var gravity: float = 9.8
@export var health: float = 20.0
@export var score: float = 20.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0

	var target_pos = GameManager.playerNode.global_position
	var diff = target_pos - global_position
	diff.y = 0 

	var dir = diff.normalized()
	velocity.x = dir.x * move_speed
	velocity.z = dir.z * move_speed

	move_and_slide()
	
func take_damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	queue_free()
	GameManager.enemies.erase(self)
