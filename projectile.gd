#projectile
extends RigidBody3D

@export var speed: float = 20.0
@export var life_time: float = 3.0

var direction: Vector3 = Vector3.ZERO

func _ready() -> void:
	# Destroy after lifetime expires

	await get_tree().create_timer(life_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if direction != Vector3.ZERO:
		linear_velocity = direction * speed
