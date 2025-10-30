#Camera Follow
class_name CameraFollow
extends Camera3D

var speed : float = 3
var offset = Vector3(0, 10, 10)
@export var playerNode : Node3D


func get_cursor_position_on_ground() -> Vector3:
	var mouse_pos = get_viewport().get_mouse_position()
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * 1000.0
	var plane = Plane(Vector3.UP, 0)
	var res = plane.intersects_ray(from, to)
	if res == null:
		return Vector3.ZERO;
	return res
	
func _ready() -> void:
	var dir = offset.normalized()
	look_at(global_position - dir, Vector3.UP)

func _process(delta: float) -> void:
	if playerNode == null:
		return

	var desired_pos = playerNode.global_position + offset
	global_position = global_position.lerp(desired_pos, delta * speed)
