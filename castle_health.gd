extends Area3D

@onready var label: Label3D = $Label3D


func _process(delta: float) -> void:
	label.look_at(-GameManager.cameraNode.position)
	label.rotation.x = 0
	label.rotation.z = 0
