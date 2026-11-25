extends Control

@onready var name_label: Label = $Panel/VBox/Header/NameCol/Name
@onready var role_label: Label = $Panel/VBox/Header/NameCol/Role
@onready var bloom_label: Label = $Panel/VBox/Header/Bloom
@onready var context_label: Label = $Panel/VBox/Scroll/Content/Context
@onready var question_label: Label = $Panel/VBox/Scroll/Content/Question
@onready var options_box: VBoxContainer = $Panel/VBox/Scroll/Content/Options
@onready var feedback_label: Label = $Panel/VBox/Scroll/Content/Feedback
@onready var continue_btn: Button = $Panel/VBox/Buttons/Continue
@onready var back_btn: Button = $Panel/VBox/Buttons/Back
@onready var score_label: Label = $Panel/VBox/Buttons/Score
@onready var portrait: ColorRect = $Panel/VBox/Header/Portrait

var scenario: Dictionary = {}
var answered: bool = false

func _ready() -> void:
	continue_btn.visible = false
	continue_btn.pressed.connect(_on_continue)
	back_btn.pressed.connect(_on_back)
	_load_scenario()

func _load_scenario() -> void:
	var idx := GameState.current_scenario_index
	scenario = ScenariosDB.get_scenario(idx)
	if scenario.is_empty():
		get_tree().change_scene_to_file("res://scenes/Classroom.tscn")
		return
	name_label.text = GameState.interlocutor_name
	role_label.text = scenario.get("title", "")
	var bloom_id: String = scenario.get("bloom", "")
	bloom_label.text = "Bloom : " + Bloom.level_label(bloom_id)
	bloom_label.modulate = Bloom.level_color(bloom_id)
	context_label.text = "Principe : " + scenario.get("principle", "")
	question_label.text = scenario.get("situation", "")
	for c in options_box.get_children():
		c.queue_free()
	for i in range(scenario.get("options", []).size()):
		var opt = scenario["options"][i]
		var btn := Button.new()
		btn.text = opt.get("text", "")
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		btn.custom_minimum_size = Vector2(0, 64)
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.pressed.connect(_answer.bind(i))
		options_box.add_child(btn)
	feedback_label.text = ""
	score_label.text = "Score : %d / %d" % [GameState.score, GameState.max_score()]

func _answer(i: int) -> void:
	if answered:
		return
	answered = true
	for button in options_box.get_children():
		button.disabled = true
	var opt = scenario["options"][i]
	var idx := GameState.current_scenario_index
	var already := GameState.is_completed(idx)
	var points := 0
	if opt.get("correct", false):
		points = 100
		feedback_label.modulate = Color(0.3, 0.9, 0.4)
	else:
		points = 0
		feedback_label.modulate = Color(0.95, 0.4, 0.4)
	if already:
		points = 0
	GameState.award_scenario(idx, i, points)
	var pts_text := "+%d point%s" % [points, "s" if points != 1 else ""]
	feedback_label.text = "%s\n%s" % [pts_text, opt.get("feedback", "")]
	continue_btn.visible = true
	Progress.save()
	continue_btn.grab_focus()
	$Panel/VBox/Scroll.ensure_control_visible.call_deferred(feedback_label)
	score_label.text = "Score : %d / %d" % [GameState.score, GameState.max_score()]

func _on_continue() -> void:
	GameState.in_scenario = false
	if GameState.scenarios_completed.size() >= ScenariosDB.count():
		get_tree().change_scene_to_file("res://scenes/Result.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/Classroom.tscn")

func _on_back() -> void:
	GameState.in_scenario = false
	get_tree().change_scene_to_file("res://scenes/Classroom.tscn")