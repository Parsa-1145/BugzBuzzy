extends ColorRect

var defaultColor : Color
@export var towerType : String
var placeHolder: Node3D
var towerPurchaseDialog: TowerPurchaseDialoge
var canBuy: bool = true
func _ready():
	mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	defaultColor = color
	
	$MarginContainer/VBoxContainer/TowerNameLabel.text = towerType
	$MarginContainer/VBoxContainer/TowerPriceLabel.text = str(GameManager.TowerType[towerType]["price"])

func _on_mouse_entered():
	if canBuy:
		color = defaultColor.darkened(0.4)
func _on_mouse_exited():
	if canBuy:
		color = defaultColor
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_instantiate_tower()
func _process(delta: float) -> void:
	if GameManager.TowerType[towerType]["price"] > GameManager.playerNode.money:
		if canBuy:	
			color = Color.DARK_RED
			canBuy = false
	elif !canBuy:
		color = defaultColor
		canBuy = true
func _instantiate_tower():
	if(!canBuy):
		return
	var tower_instance = GameManager.TowerType[towerType]["sceneDest"].instantiate()
	get_tree().current_scene.add_child(tower_instance)
	tower_instance.global_position = placeHolder.global_position
	placeHolder.isBuilt = true
	tower_instance.placeHolder = placeHolder
	towerPurchaseDialog.close()
