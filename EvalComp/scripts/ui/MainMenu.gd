extends Control

@onready var new_game_btn: Button = $Center/VBox/NewGame
@onready var continue_btn: Button = $Center/VBox/Continue
@onready var settings_btn: Button = $Center/VBox/Settings
@onready var quit_btn: Button = $Center/VBox/Quit

var settings_panel: PanelContainer

func _ready() -> void:
	new_game_btn.pressed.connect(_on_new_game)
	continue_btn.pressed.connect(_on_continue)
	settings_btn.pressed.connect(_on_settings)
	quit_btn.pressed.connect(_on_quit)
	var cfg := ConfigFile.new()
	continue_btn.disabled = (cfg.load("user://evalcomp_save.cfg") != OK)
	_build_settings_panel()

func _build_settings_panel() -> void:
	settings_panel = PanelContainer.new()
	settings_panel.visible = false
	settings_panel.custom_minimum_size = Vector2(520, 220)
	settings_panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	settings_panel.offset_left = -260
	settings_panel.offset_right = 260
	settings_panel.offset_top = -110
	settings_panel.offset_bottom = 110
	add_child(settings_panel)
	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	settings_panel.add_child(vbox)
	var title := Label.new()
	title.text = "Paramètres"
	title.add_theme_font_size_override("font_size", 18)
	vbox.add_child(title)
	var cb := CheckBox.new()
	cb.text = "Réduire les animations"
	cb.button_pressed = GameState.reduce_animations
	cb.toggled.connect(func(v): GameState.reduce_animations = v; Progress.save())
	vbox.add_child(cb)
	var close := Button.new()
	close.text = "Fermer"
	close.pressed.connect(func(): settings_panel.visible = false; $Center.visible = true)
	vbox.add_child(close)

func _on_new_game() -> void:
	GameState.reset_run()
	get_tree().change_scene_to_file("res://scenes/GenderSelect.tscn")

func _on_continue() -> void:
	Progress.load_save()
	PlayerData.avatar_gender = GameState.gender
	get_tree().change_scene_to_file("res://scenes/Classroom.tscn")

func _on_settings() -> void:
	settings_panel.visible = not settings_panel.visible
	$Center.visible = not settings_panel.visible

func _on_quit() -> void:
	get_tree().quit()
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and settings_panel.visible:
		settings_panel.hide()
		$Center.show()
