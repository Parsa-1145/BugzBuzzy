# Game MAnager
extends Node

@onready var player_scene = preload("res://PlayerBase.tscn")
@onready var camera_scene = preload("res://CameraBase.tscn")
@onready var projectile_scene = preload("res://Projectile.tscn")
@onready var bomb_scene = preload("res://Bomb.tscn")
@onready var castle_scene = preload("res://castle.tscn")

var EnemyType = {
	"Hog Rider" : {"sceneDest" : preload("res://HogRider.tscn"), "animFolder" : "res://Assets/Animations/HogRider/"},
	"Skeleton"  : {"sceneDest" : preload("res://Skeleton.tscn"), "animFolder" : "res://Assets/Animations/Skeleton/"},
	"Barbarian" : {"sceneDest" : preload("res://Barbarian.tscn"), "animFolder" : "res://Assets/Animations/Barbarian/"}
}
var ProjectileType = {
	"Arrow" : {"sceneDest" : preload("res://Projectile.tscn")},
	"Bomb" : {"sceneDest" : preload("res://Bomb.tscn")},
}
var TowerType = {
	"X-Bow" : {"sceneDest" : preload("res://xBow.tscn")},
	"Castle" : {"sceneDest" : preload("res://castle.tscn")}
}
var enemies : Array[EnemyBase]= []
var towers : Array[Tower] = []
var castle: Castle

var playerNode: Player
var cameraNode: CameraFollow

func _ready() -> void:
	playerNode = player_scene.instantiate()
	add_child(playerNode)
	playerNode.global_position = Vector3(0, 2, 0)
	
	cameraNode = camera_scene.instantiate()
	cameraNode.projection = Camera3D.PROJECTION_ORTHOGONAL
	cameraNode.size = 20.0  # increase this number to zoom out
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
	var enemy_keys = ["Hog Rider", "Skeleton", "Barbarian"]
	var index = randi_range(0, enemy_keys.size() - 1)
	var key = enemy_keys[index]
	spawnEnemy(EnemyType[key]["sceneDest"])

func spawnEnemy(type: PackedScene):
	var instance: EnemyBase = type.instantiate()
	add_child(instance)
	var x = randf() * 20 - 10
	var y = randf() * 20 - 10
	
	if x > 0:
		x += 65
	else:
		x -= 65
	if y > 0:
		y += 65
	else:
		y -= 65
	instance.position = Vector3(x, 2, y)
	enemies.append(instance)
