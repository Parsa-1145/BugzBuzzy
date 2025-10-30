# Game MAnager
extends Node

@onready var player_scene = preload("res://PlayerBase.tscn")
@onready var camera_scene = preload("res://CameraBase.tscn")

var enemies : Array[EnemyBase]= []
var towers = []
var castle: Node3D

var enemy_types: Array[PackedScene] = [
	preload("res://Skeleton.tscn")
]

var playerNode: Player

func _ready() -> void:
	playerNode = player_scene.instantiate()
	add_child(playerNode)
	playerNode.global_position = Vector3(0, 2, 0)
	
	var cameraNode = camera_scene.instantiate()
	add_child(cameraNode)
	if cameraNode is CameraFollow:
		cameraNode.playerNode = playerNode
		playerNode.camera = cameraNode
