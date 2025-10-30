#EnemyBase
class_name EnemyBase
extends CharacterBody3D

@export var move_speed: float = 2.0
@export var gravity: float = 9.8
@export var health: float = 20.0
@export var score: float = 20.0
var nearest_tower: Node3D = null
var current_target: Node3D = null

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(_update_nearest_target)

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

func _update_nearest_target():
	var targets = GameManager.towers
	if GameManager.towers.is_empty():
		current_target = null
		return
	
	var min_dist = INF
	var nearest = null
	for t in targets:
		if not is_instance_valid(t):
			continue
		var d = global_position.distance_to(t.global_position)
		if d < min_dist:
			min_dist = d
			nearest = t
	current_target = nearest
	
func take_damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	queue_free()
	GameManager.enemies.erase(self)
