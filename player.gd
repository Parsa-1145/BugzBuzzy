extends CharacterBody3D

@export var speed: float = 5.0
@export var crouch_speed: float = 2.5
@export var jump_force: float = 10.0
@export var gravity: float = -24.8
@export var mouse_sensitivity: float = 0.3

@export var health: float = 10
@export var money : int = 0

var yaw: float = 0.0
var pitch: float = 0.0
var is_crouching: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#yaw -= event.relative.x * mouse_sensitivity
		#pitch -= event.relative.y * mouse_sensitivity
		#pitch = clamp(pitch, -90, 90)
#
		#rotation_degrees.y = yaw
		#head.rotation_degrees.x = pitch

func _physics_process(delta: float) -> void:
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("move_up"):
		input_dir.z -= 1
	if Input.is_action_pressed("move_down"):
		input_dir.z += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1

	input_dir = input_dir.normalized()
	var move_dir = (transform.basis * input_dir).normalized()

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
