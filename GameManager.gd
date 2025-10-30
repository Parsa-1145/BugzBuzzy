# Game MAnager
extends Node

@onready var player_scene = preload("res://PlayerBase.tscn")
@onready var camera_scene = preload("res://CameraBase.tscn")
@onready var projectile_scene = preload("res://Projectile.tscn")
@onready var bomb_scene = preload("res://Bomb.tscn")
@onready var castle_scene = preload("res://castle.tscn")

var EnemyType = {
	"Hog Rider" : {"sceneDest" : preload("res://HogRider.tscn")},
	"Skeleton"  : {"sceneDest" : preload("res://Skeleton.tscn")},
	"Barbarian" : {"sceneDest" : preload("res://Barbarian.tscn")}
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
	spawnEnemy(EnemyType["Skeleton"]["sceneDest"])

func spawnEnemy(type: PackedScene):
	var instance: EnemyBase = type.instantiate()
	add_child(instance)
	instance.position = Vector3(randf() * 10, 10, randf() * 10)
	enemies.append(instance)
