class_name Tower
extends StaticBody3D

@export var health: float
@export var range: float
@export var price: int

func _ready() -> void:
	GameManager.towers.append(self)

func take_damage():
	health -= 1;
	if (health <= 0):
		die()
		
func die():
	pass
