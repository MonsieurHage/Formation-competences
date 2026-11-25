extends Node

func _ready() -> void:
	print("Smoke: scenarios =", ScenariosDB.count())
	print("Smoke: bloom levels =", Bloom.LEVELS.size())
	print("Smoke OK")
	get_tree().quit()
