class_name TowerPurchaseDialoge
extends MarginContainer

var placeHolder: Node3D

func _ready() -> void:
	$VBoxContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ColorRect.placeHolder = placeHolder
	$VBoxContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ColorRect2.placeHolder = placeHolder
func close():
	queue_free()
