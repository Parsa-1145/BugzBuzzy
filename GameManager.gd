# Game MAnager
extends Node

@onready var player_scene = preload("res://PlayerBase.tscn")
@onready var camera_scene = preload("res://CameraBase.tscn")
@onready var projectile_scene = preload("res://Projectile.tscn")
@onready var bomb_scene = preload("res://Bomb.tscn")
@onready var castle_scene = preload("res://castle.tscn")
@onready var towerPurchaseDialoge = preload("res://TowerPurchaseDialoge.tscn")

var done = false
var EnemyType = {
	"Hog Rider" : {"sceneDest" : preload("res://HogRider.tscn"), "animFolder" : "res://Assets/Animations/HogRider/", "attackFrames" : 9},
	"Skeleton"  : {"sceneDest" : preload("res://Skeleton.tscn"), "animFolder" : "res://Assets/Animations/Skeleton/", "attackFrames" : 4},
	"Barbarian" : {"sceneDest" : preload("res://Barbarian.tscn"), "animFolder" : "res://Assets/Animations/Barbarian/", "attackFrames" : 9}
}
var ProjectileType = {
	"Arrow" : {"sceneDest" : preload("res://Projectile.tscn")},
	"Bomb" : {"sceneDest" : preload("res://Bomb.tscn")},
}
var TowerType = {
	"X-Bow" : {"sceneDest" : preload("res://xBow.tscn"), "price" : 60},
	"Bomb Tower" : {"sceneDest" : preload("res://BombTower.tscn"), "price": 90},
	"Castle" : {"sceneDest" : preload("res://castle.tscn")}
}
var enemies : Array[EnemyBase]= []
var towers : Array[Tower] = []
var castle: Castle

var playerNode: Player
var cameraNode: CameraFollow

var timeLeft: float = 150


var skeletonTimer: Timer
var hogTimer: Timer
var BarTimer: Timer

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
	
	skeletonTimer = Timer.new()
	skeletonTimer.wait_time = 3  # seconds
	skeletonTimer.autostart = true
	skeletonTimer.one_shot = false
	add_child(skeletonTimer)
	skeletonTimer.timeout.connect(spawnSkel)
	
	BarTimer = Timer.new()
	BarTimer.wait_time = INF  # seconds
	BarTimer.autostart = true
	BarTimer.one_shot = false
	add_child(BarTimer)
	BarTimer.timeout.connect(spawnBar)

	hogTimer = Timer.new()
	hogTimer.wait_time = INF  # seconds
	hogTimer.autostart = true
	hogTimer.one_shot = false
	add_child(hogTimer)
	hogTimer.timeout.connect(pawnHog)
	
func spawnSkel():
	#for i in range(0, 2):
	spawnEnemy(EnemyType["Skeleton"]["sceneDest"])

func spawnBar():
	#for i in range(0, 2):
	spawnEnemy(EnemyType["Barbarian"]["sceneDest"])

func pawnHog():
	#for i in range(0, 2):
	spawnEnemy(EnemyType["Hog Rider"]["sceneDest"])


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

func lose():
	var dialoge : EndGameDialog = preload("res://EndGameDialoge.tscn").instantiate()
	if dialoge is EndGameDialog:
		dialoge.setState("You Lost")
	get_tree().current_scene.get_node("HUD").add_child(dialoge)
	done = true
func win():
	var dialoge : EndGameDialog = preload("res://EndGameDialoge.tscn").instantiate()
	if dialoge is EndGameDialog:
		dialoge.setState("You Survived")
	get_tree().current_scene.get_node("HUD").add_child(dialoge)
	done = true
func _process(delta: float) -> void:
	timeLeft -= delta
	if timeLeft <= 0:
		win()
		
		
	if(timeLeft<=120 && timeLeft + delta > 120):
		BarTimer.wait_time = 3.5 * (2 / 3.0)
		BarTimer.start()
	elif(timeLeft<=45 && timeLeft + delta > 45):
		BarTimer.wait_time = 2 * (2 / 3.0)
		BarTimer.start()
	
	if(timeLeft<=60 && timeLeft + delta > 60):
		skeletonTimer.wait_time = 1.5 * (2 / 3.0)
		skeletonTimer.start()
		
	if(timeLeft<=90 && timeLeft + delta > 90):
		hogTimer.wait_time = 5 * (2 / 3.0)
		hogTimer.start()
	
	if(timeLeft<=30 && timeLeft + delta > 30):
		hogTimer.wait_time = 2.5 * (2 / 3.0)
		hogTimer.start()
