extends Projectile

@export var explosion_radius: float = 5.0
var gravity = 1

func _ready() -> void:
	speed = 10
	damage = 15
	contact_monitor = true
	max_contacts_reported = 1
	await get_tree().create_timer(life_time).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if direction != Vector3.ZERO:
		linear_velocity = direction * speed
	direction.y -= gravity * delta

func _on_body_entered(body: Node) -> void:
	explode()

func explode() -> void:
	if not is_inside_tree():
		return
	
	for enemy in GameManager.enemies:
		if is_instance_valid(enemy):
			var dist = global_position.distance_to(enemy.global_position)
			if dist <= explosion_radius:
				enemy.take_damage(damage)
	
	queue_free()
