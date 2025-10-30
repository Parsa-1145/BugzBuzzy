class_name Tower
extends StaticBody3D

@export var health: float
@export var price: int

func _ready() -> void:
	GameManager.towers.append(self)
