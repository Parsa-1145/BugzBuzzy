class_name HogRider
extends EnemyBase

func _ready() -> void:
	move_speed = 5.5
	score = 30
	health = 16
	enemyName = "Hog Rider"
	current_target = GameManager.castle
