extends Node

const SAVE_PATH := "user://evalcomp_save.cfg"

func save() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("player", "gender", GameState.gender)
	cfg.set_value("player", "score", GameState.score)
	cfg.set_value("player", "xp", GameState.xp)
	cfg.set_value("player", "level", GameState.level)
	cfg.set_value("player", "completed", GameState.scenarios_completed)
	cfg.set_value("player", "answers", GameState.scenario_answers)
	cfg.set_value("player", "points", GameState.scenario_points)
	cfg.set_value("player", "reduce_animations", GameState.reduce_animations)
	cfg.save(SAVE_PATH)

func load_save() -> bool:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) != OK:
		return false
	GameState.gender = cfg.get_value("player", "gender", "male")
	GameState.score = cfg.get_value("player", "score", 0)
	GameState.xp = cfg.get_value("player", "xp", 0)
	GameState.level = cfg.get_value("player", "level", 1)
	GameState.scenarios_completed = cfg.get_value("player", "completed", [])
	GameState.scenario_answers = cfg.get_value("player", "answers", {})
	GameState.scenario_points = cfg.get_value("player", "points", {})
	GameState.reduce_animations = cfg.get_value("player", "reduce_animations", false)
	PlayerData.avatar_gender = GameState.gender
	return true