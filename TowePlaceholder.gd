extends Area3D

@onready var label: Label3D = $Label

func _ready():
	# Connect signals
	self.connect("mouse_entered", self._on_mouse_entered)
	self.connect("mouse_exited", self._on_mouse_exited)
	self.connect("input_event", self._on_input_event)
	
	label.visible = false
	label.text = "Build a tower"

func _on_mouse_entered():
	label.visible = true


func _on_mouse_exited():
	label.visible = false

func _on_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Area clicked!")

func _process(delta: float) -> void:
	label.look_at(-GameManager.cameraNode.position)
	label.rotation.x = 0
	label.rotation.z = 0
