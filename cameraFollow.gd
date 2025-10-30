extends Camera3D

var speed : float = 3
var offset = Vector3(0, 10, 10)
@export var playerNode : Node3D

func _ready() -> void:
	var dir = offset.normalized()
	look_at(global_position - dir, Vector3.UP)

func _process(delta: float) -> void:
	if playerNode == null:
		return

	# Smoothly move toward target + offset
	var desired_pos = playerNode.global_position + offset
	global_position = global_position.lerp(desired_pos, delta * speed)
