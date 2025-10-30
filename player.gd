#projectile
class_name Player
extends CharacterBody3D


@export var speed: float = 5.0
@export var crouch_speed: float = 2.5
@export var jump_force: float = 10.0
@export var gravity: float = -24.8
@export var y_offset: float =-0.50;
@export var mouse_sensitivity: float = 0.3
@export var camera: CameraFollow

@export var health: float = 10 
@export var money : int = 0

var yaw: float = 0.0
var pitch: float = 0.0
var is_crouching: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	
func _physics_process(delta: float) -> void:
	handle_movement(delta)
	rotate_toward_mouse()
	
func handle_movement(delta: float) -> void:
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("move_up"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_down"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_just_pressed("shoot"):
		shoot_projectile()


	input_dir = input_dir.normalized()
	var move_dir = (input_dir).normalized()

	# Choose correct speed
	var current_speed: float
	if is_crouching:
		current_speed = crouch_speed
	else:
		current_speed = speed

	velocity.x = move_dir.x * current_speed
	velocity.z = move_dir.z * current_speed

	# Apply gravity and jump
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func rotate_toward_mouse() -> void:
	if camera == null:
		return
		
	var target = camera.get_cursor_position_on_ground()
	if target == null:
		return
		
	var player_pos = global_position
	target.y = player_pos.y

	var direction = -(target - player_pos).normalized()

	var target_rotation = atan2(direction.x, direction.z)
	rotation.y = lerp_angle(rotation.y, target_rotation, 0.2)

func shoot_projectile() -> void:
	var projectile_scene = GameManager.projectile_scene

	if projectile_scene == null:
		return
	
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)
	
	# Position at player's head or slightly in front
	var spawn_pos = global_position + Vector3(0, y_offset, 0) + -transform.basis.z
	projectile.global_position = spawn_pos
	
	# Direction is where the player is facing
	var forward = -transform.basis.z
	projectile.direction = forward
