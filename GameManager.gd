# Game MAnager
extends Node

@onready var player_scene = preload("res://PlayerBase.tscn")
@onready var camera_scene = preload("res://CameraBase.tscn")
@onready var castle_scene = preload("res://castle.tscn")

var enemies : Array[EnemyBase]= []
var towers = []
var castle: Castle

var enemy_types: Array[PackedScene] = [
	preload("res://Skeleton.tscn")
]

var playerNode: Player
var cameraNode: CameraFollow

func _ready() -> void:
	playerNode = player_scene.instantiate()
	add_child(playerNode)
	playerNode.global_position = Vector3(0, 2, 0)
	
	cameraNode = camera_scene.instantiate()
	add_child(cameraNode)
	if cameraNode is CameraFollow:
		cameraNode.playerNode = playerNode
		playerNode.camera = cameraNode
		
	castle = castle_scene.instantiate()
	add_child(castle)
	castle.position = Vector3(3, 0, 3)
	
	var timer = Timer.new()
	timer.wait_time = 2.0  # seconds
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	spawnEnemy(enemy_types[0])

func spawnEnemy(type: PackedScene):
	var instance: EnemyBase = type.instantiate()
	add_child(instance)
	instance.position = Vector3(5, 5, 5)
	enemies.append(instance)
