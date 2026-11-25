extends Control

@onready var male_btn: Button = $VBox/Male
@onready var female_btn: Button = $VBox/Female
@onready var back_btn: Button = $VBox/Back

func _ready() -> void:
	male_btn.pressed.connect(func(): _choose("male"))
	female_btn.pressed.connect(func(): _choose("female"))
	back_btn.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))

func _choose(g: String) -> void:
	PlayerData.set_gender(g)
	GameState.gender = g
	GameState.reset_run()
	GameState.gender = g
	get_tree().change_scene_to_file("res://scenes/Classroom.tscn")