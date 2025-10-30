#projeectile
class_name Projectile
extends RigidBody3D

@export var speed: float = 20.0
@export var life_time: float = 3.0
@export var damage: float = 4.0

var direction: Vector3 = Vector3.ZERO
