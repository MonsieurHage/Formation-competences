extends Control

@onready var title_label: Label = $Panel/VBox/Title
@onready var score_label: Label = $Panel/VBox/Score
@onready var level_label: Label = $Panel/VBox/Level
@onready var completed_label: Label = $Panel/VBox/Completed
@onready var message_label: Label = $Panel/VBox/Message
@onready var restart_btn: Button = $Panel/VBox/Buttons/Restart
@onready var menu_btn: Button = $Panel/VBox/Buttons/Menu

func _ready() -> void:
	restart_btn.pressed.connect(_on_restart)
	menu_btn.pressed.connect(_on_menu)
	score_label.text = "Score de jeu : %d / %d" % [GameState.score, GameState.max_score()]
	level_label.text = "Situations terminées : %d / %d" % [GameState.scenarios_completed.size(), ScenariosDB.count()]
	var ok := 0
	for i in GameState.scenarios_completed:
		if GameState.scenario_points.get(i, 0) >= 100:
			ok += 1
	completed_label.text = "Décisions réussies : %d / %d" % [ok, GameState.scenarios_completed.size()]
	if GameState.scenarios_completed.size() >= ScenariosDB.count():
		title_label.text = "Bravo !"
		message_label.text = "Vous avez parcouru toutes les situations. Le score décrit vos décisions dans ce jeu, pas un niveau de maîtrise professionnelle."
	else:
		title_label.text = "Parcours en cours"
		message_label.text = "Revenez en classe pour résoudre les situations restantes."
	Progress.save()

func _on_restart() -> void:
	GameState.reset_run()
	get_tree().change_scene_to_file("res://scenes/GenderSelect.tscn")

func _on_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")