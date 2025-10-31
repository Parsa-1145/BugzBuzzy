extends ColorRect

var defaultColor : Color
@export var towerType : String
var placeHolder: Node3D

func _ready():
	mouse_filter = Control.MouseFilter.MOUSE_FILTER_STOP
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	defaultColor = color
	
	$MarginContainer/VBoxContainer/TowerNameLabel.text = towerType
	$MarginContainer/VBoxContainer/TowerPriceLabel.text = str(GameManager.TowerType[towerType]["price"])

func _on_mouse_entered():
	color = defaultColor.darkened(0.4)
func _on_mouse_exited():
	color = defaultColor
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_instantiate_tower()
		
func _instantiate_tower():
	var tower_instance = GameManager.TowerType[towerType]["sceneDest"].instantiate()
	# Optionally set tower type if needed
	# tower_instance.towerType = towerType
	# Add tower to the game world (replace GameManager.gameWorld with your actual node)
	get_tree().current_scene.add_child(tower_instance)
	tower_instance.global_position = placeHolder.global_position  # or wherever you want to spawn it
	placeHolder.isBuilt = true
	tower_instance.placeHolder = placeHolder
	print("Tower instantiated:", towerType)
