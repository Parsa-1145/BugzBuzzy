extends Tower

@onready var head : Node3D = $Head
@onready var nuzzle : Node3D = $Head/nuzzle

@export var projectileSpeed: float = 1
@export var fireRate: float = 2
var timeSinceLastShoot: float = 0
var v_y = 4
var g = 1
var closestEnemy: EnemyBase


func _process(delta: float) -> void:
	var minDist: float = INF
	closestEnemy = null
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
		
	head.look_at(closestEnemy.global_position)
	
	var projectile_scene = GameManager.bomb_scene


	if projectile_scene == null:
		return
	
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	# Position at player's head or slightly in front
	var spawn_pos = nuzzle.global_position
	projectile.global_position = spawn_pos
	
	var forward = -head.transform.basis.z
	var h = spawn_pos.y
	var t = v_y/g + (v_y**2 + g*h)**0.5 / g
	t/=2
	forward /= forward.length()
	forward.y = 0
	var d = closestEnemy.global_position - spawn_pos
	d.y = 0
	forward *= d.length()/t 
	var launch_dir = (forward + Vector3(0, v_y, 0)).normalized()

	projectile.direction = launch_dir
