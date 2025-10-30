#arrow
extends Projectile

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	await get_tree().create_timer(life_time).timeout
	queue_free()


func _physics_process(delta: float) -> void:
	if direction != Vector3.ZERO:
		linear_velocity = direction * speed

func _on_body_entered(body: Node) -> void:
	if body is EnemyBase:
		body.take_damage(damage)
	queue_free()
