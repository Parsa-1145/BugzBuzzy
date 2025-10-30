extends Tower

@onready var head : Node3D = $Head
@onready var nuzzle : Node3D = $Head/nuzzle

@export var projectileSpeed: float = 20
@export var fireRate: float = 0.5
var timeSinceLastShoot: float = 0

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
	
	if(timeSinceLastShoot < fireRate):
		timeSinceLastShoot += delta
		return
	timeSinceLastShoot = 0
		
	head.look_at(closestEnemy.global_position + closestEnemy.velocity*(minDist / projectileSpeed))
	
	var projectile_scene = GameManager.projectile_scene

	if projectile_scene == null:
		return
	
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	# Position at player's head or slightly in front
	var spawn_pos = nuzzle.global_position
	projectile.global_position = spawn_pos
	
	# Direction is where the player is facing
	var forward = -head.transform.basis.z
	projectile.direction = forward
