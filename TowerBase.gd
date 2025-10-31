class_name Tower
extends StaticBody3D

@export var health: float
@export var price: int
var placeHolder: Node3D

func _ready() -> void:
	GameManager.towers.append(self)
