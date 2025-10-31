extends Projectile

@export var explosion_radius: float = 7.0
var gravity = 1

func _ready() -> void:
	speed = 10
	damage = 6
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
			var dx = global_position.x - enemy.global_position.x;
			var dz = global_position.z - enemy.global_position.z;
			var dist = sqrt(dx*dx + dz*dz);
			if dist <= explosion_radius:
				enemy.take_damage(damage)
	
	queue_free()
