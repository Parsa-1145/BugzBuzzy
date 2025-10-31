class_name HogRider
extends EnemyBase

func _ready() -> void:
	super._ready()
	move_speed = 5.5
	score = 30
	health = 10
	enemyName = "Hog Rider"
	current_target = GameManager.castle
