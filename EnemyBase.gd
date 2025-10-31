#EnemyBase
class_name EnemyBase
extends CharacterBody3D

@export var move_speed: float = 2.0
@export var gravity: float = 9.8
@export var health: float = 20.0
@export var score: float = 20.0
var nearest_tower: Node3D = null
var current_target: Node3D = null
var timeSinceLastAttack: float = 0

var enemyName: String
var currentAction : String = "Idle"
var animTimeState : float = 0
var prevDirection : int = 0

@onready var sprite3D: Sprite3D = $Sprite3D
@onready var hitArea : Area3D = $hitArea

var target_in_range: bool = false

func _ready() -> void:
	hitArea.connect("body_entered", _on_body_entered)
	hitArea.connect("body_exited", _on_body_exited)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0
	if current_target != null:
		var target_pos = current_target.global_position
		var diff = target_pos - global_position
		diff.y = 0 
	  
		var dir = diff.normalized()
		velocity.x = dir.x * move_speed
		velocity.z = dir.z * move_speed
		
	move_and_slide()
	
	if(currentAction != "Attack" and velocity.length() <= 0.3):
		currentAction = "Idle"
	else:
		currentAction = "Walking"
		
		var angle = atan2(velocity.x, velocity.z)  # note: x,z order!
		
		# Convert to degrees and normalize to [0, 360)
		var deg = fposmod(rad_to_deg(angle), 360.0)
		
		# Map 360° into 16 equal slices (each = 22.5°)
		prevDirection = int(round(deg / 22.5)) % 16

func _update_nearest_target():
	var targets = GameManager.towers
	if GameManager.towers.is_empty():
		current_target = null
		nearest_tower = null
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
	GameManager.playerNode.money += score
	
func _process(delta: float) -> void:
	animTimeState += delta
	timeSinceLastAttack += delta
	
	#if(currentAction == "Attack"):
		#if(animTimeState >= AnimationManager.animation_map[enemyName][currentAction].size() * 5):
			#currentAction = "Idle"
			#animTimeState = 0
	
	if (current_target) == null:
		pass
	elif(target_in_range):
		currentAction = "Attack"
		if not (timeSinceLastAttack < 1.8) :
			timeSinceLastAttack = 0
			animTimeState = 0
			
			var diff : Vector3 = current_target.global_position - global_position
			var angle = atan2(diff.x, diff.z)  # note: x,z order!
		
		# Convert to degrees and normalize to [0, 360)
			var deg = fposmod(rad_to_deg(angle), 360.0)
			
			# Map 360° into 16 equal slices (each = 22.5°)
			prevDirection = int(round(deg / 22.5)) % 16
				
			if current_target is Tower:
				current_target.take_damage()
			elif current_target is Player:
				current_target.take_damage()

	var anim : Array = AnimationManager.animation_map[enemyName][currentAction][prevDirection]
	sprite3D.texture = anim[int(floor(animTimeState * 12)) % anim.size()]

func _on_body_entered(body):
	if body == current_target:
		target_in_range = true

func _on_body_exited(body):
	if body == current_target:
		target_in_range = false
