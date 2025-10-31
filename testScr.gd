extends Area3D


func _ready():
	# Connect signals

	connect("body_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	connect("input_event", _on_input_event)

func _on_mouse_entered(body: Node):
	print("asd")


func _on_mouse_exited():
	print("asd")

func _on_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_MASK_RIGHT:
			print("Area clicked!")
