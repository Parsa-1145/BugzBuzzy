class_name HogRider
extends EnemyBase

func _ready() -> void:
	super._ready()
	current_target = GameManager.castle
