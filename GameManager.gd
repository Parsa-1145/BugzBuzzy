extends Node

@onready var player_scene = preload("res://PlayerBase.tscn")
@onready var camera_scene = preload("res://CameraBase.tscn")

var playerNode: Node3D

#func _ready() -> void:
	#playerNode = player_scene.instantiate()
	#add_child(playerNode)
	#playerNode.global_position = Vector3(0, 2, 0)
	#
	#var cameraNode = camera_scene.instantiate()
	#add_child(cameraNode)
#
	#cameraNode.setPlayer(playerNode)
	#var test : CameraFo
	#print("camera set")
