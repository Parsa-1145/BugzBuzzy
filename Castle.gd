class_name Castle
extends Tower

func _ready() -> void:
	health = 15
	
func die():
	GameManager.lose()
