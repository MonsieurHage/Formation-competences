extends Node

# Données du joueur / avatar
var avatar_gender: String = "male"
var walk_speed: float = 60.0
var run_speed: float = 100.0

func set_gender(g: String) -> void:
	if g in ["male", "female"]:
		avatar_gender = g
		GameState.gender = g