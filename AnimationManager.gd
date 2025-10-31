extends Node

enum CharacterAction {Walking, Idle, Attack}

var animation_map: Dictionary = {}

func _ready() -> void:
	for enemy_name in GameManager.EnemyType.keys():
			animation_map[enemy_name] = {}
			loadAnim("Walking", enemy_name, GameManager.EnemyType[enemy_name]["animFolder"], 8)
			loadAnim("Idle", enemy_name, GameManager.EnemyType[enemy_name]["animFolder"], 1, 8 * 9)
			loadAnim("Attack", enemy_name, GameManager.EnemyType[enemy_name]["animFolder"], GameManager.EnemyType[enemy_name]["attackFrames"], 8 * 9 + 9)

func loadAnim(action: String, enemyType: String, animFolder: String, framesPerDir: int, offset: int = 0):
	animation_map[enemyType][action] = {}
	var i : int = offset
	for dir in range(0, 9):
		animation_map[enemyType][action][dir] = []
		if dir != 0 and dir != 8 :
			animation_map[enemyType][action][16 - dir] = []
		for frame_index in range(framesPerDir):
			var path = "%s%04d.png" % [animFolder, i]
			print(path)
			i += 1
			if FileAccess.file_exists(path):
				var tex = load(path)
				if dir != 0 and dir != 8 :
					var img = tex.get_image().duplicate()
					img.flip_x()
					var mirrored_tex := ImageTexture.create_from_image(img)
					animation_map[enemyType][action][16 - dir].append(mirrored_tex)
				animation_map[enemyType][action][dir].append(load(path))
			else:
				print("animNotFound")
