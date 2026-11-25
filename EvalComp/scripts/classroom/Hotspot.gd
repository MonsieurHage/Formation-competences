extends Area3D

@export var label_text: String = "Élève"
@export var student_index: int = 0

var player_in_range: bool = false
var prompt: Label3D
var model: Node3D
var anim: AnimationPlayer
var idle_anim: String = "HumanArmature|Man_Idle"

func _ready() -> void:
	add_to_group("hotspots")
	var model_path := "res://assets/models/characters/man.glb"
	if student_index % 2 == 1:
		model_path = "res://assets/models/characters/woman.glb"
		idle_anim = "Armature|SitIdle"
	else:
		idle_anim = "HumanArmature|Man_Sitting"
	var scene = load(model_path)
	if scene:
		model = scene.instantiate()
		model.scale = Vector3(0.3, 0.3, 0.3)
		model.position = Vector3(0, 0, 0.3)
		add_child(model)
		anim = _find_anim(model)
		if anim:
			if anim.has_animation(idle_anim):
				anim.play(idle_anim)
				anim.seek(anim.get_animation(idle_anim).length, true)
				anim.pause()
				_align_to_seat(model)
	prompt = Label3D.new()
	prompt.text = "E : " + label_text
	prompt.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	prompt.font_size = 24
	prompt.position = Vector3(0, 1.6, 0)
	prompt.visible = false
	add_child(prompt)
	var cs := CollisionShape3D.new()
	var shape := SphereShape3D.new()
	shape.radius = 1.0
	cs.shape = shape
	cs.position = Vector3(0, 0.6, 0)
	add_child(cs)
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)
	_refresh()

func _find_anim(n) -> AnimationPlayer:
	var best: AnimationPlayer = null
	var best_count := 0
	if n is AnimationPlayer:
		var cnt: int = n.get_animation_list().size()
		if cnt > best_count:
			best = n
			best_count = cnt
	for c in n.get_children():
		var r := _find_anim(c)
		if r and r.get_animation_list().size() > best_count:
			best = r
			best_count = r.get_animation_list().size()
	return best

func _on_enter(body: Node) -> void:
	if body is CharacterBody3D:
		player_in_range = true
		_refresh()

func _on_exit(body: Node) -> void:
	if body is CharacterBody3D:
		player_in_range = false
		_refresh()

func _refresh() -> void:
	var remaining := _remaining_count()
	if player_in_range and remaining > 0:
		prompt.visible = true
		prompt.text = "E — Échanger avec " + label_text
	else:
		prompt.visible = false
	if remaining == 0 and model:
		prompt.text = "Parcours terminé"

func _process(_delta: float) -> void:
	if player_in_range and not GameState.in_scenario and Input.is_action_just_pressed("interact"):
		_start()

func _start() -> void:
	var idx := _next_uncompleted()
	if idx < 0:
		GameState.in_scenario = false
		get_tree().change_scene_to_file("res://scenes/Result.tscn")
		return
	GameState.current_scenario_index = idx
	GameState.in_scenario = true
	GameState.interlocutor_name = label_text
	GameState.classroom_position = get_parent().get_node("Player").position
	get_tree().change_scene_to_file.call_deferred("res://scenes/Scenario.tscn")

func _next_uncompleted() -> int:
	for i in GameState.scenario_order:
		if not GameState.is_completed(i):
			return i
	return -1

func _remaining_count() -> int:
	var n := 0
	for i in range(ScenariosDB.count()):
		if not GameState.is_completed(i):
			n += 1
	return n

func mark_done() -> void:
	_refresh()
func _align_to_seat(node: Node) -> void:
	if node is Skeleton3D:
		var hip: int = node.find_bone("Hips")
		if hip >= 0:
			var hip_position := to_local(node.to_global(node.get_bone_global_pose(hip).origin))
			model.position += Vector3(0, 0.58, 0.55) - hip_position
	for child in node.get_children():
		_align_to_seat(child)
