class_name Castle
extends Tower

@onready var label: Label3D = $Area3D/Label3D


func _ready() -> void:
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	label.visible = true
	label.text = "Health: 15/15"
	health = 15
	
	
func take_damage():
	health -= 1
	label.text = "Health: " + str(int(health)) + "/15"
	if (health <= 0):
		die()
func die():
	GameManager.lose()
	queue_free()

func _on_mouse_entered():
	label.visible = true


func _on_mouse_exited():
	label.visible = false
