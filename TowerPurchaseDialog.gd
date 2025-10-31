class_name TowerPurchaseDialoge
extends MarginContainer

var placeHolder: Node3D

func _ready() -> void:
	$VBoxContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ColorRect.placeHolder = placeHolder
	$VBoxContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ColorRect2.placeHolder = placeHolder
	$VBoxContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ColorRect.towerPurchaseDialog = self
	$VBoxContainer/MarginContainer/ColorRect/MarginContainer/VBoxContainer/HBoxContainer/ColorRect2.towerPurchaseDialog = self
func close():
	queue_free()
