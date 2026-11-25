extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var camera: Camera3D = $Camera3D
@onready var progress_label: Label = $HUD/Progress
@onready var bilan_btn: Button = $HUD/BilanBtn
@onready var quit_btn: Button = $HUD/QuitBtn

func _ready() -> void:
	bilan_btn.pressed.connect(_on_bilan)
	quit_btn.pressed.connect(_on_quit)
	for h in get_tree().get_nodes_in_group("hotspots"):
		if h.has_method("mark_done"):
			h.mark_done()
	_update_progress()
	GameState.in_scenario = false
	player.position = GameState.classroom_position
	_add_decoration()
	_fit_camera()
	get_viewport().size_changed.connect(_fit_camera)

func _fit_camera() -> void:
	camera.position = Vector3(0, 13, 16)
	camera.look_at(Vector3(0, 0, 0), Vector3.UP)
	var viewport_size := get_viewport().get_visible_rect().size
	var aspect := viewport_size.x / maxf(viewport_size.y, 1.0)
	camera.size = maxf(12.8, 21.0 / aspect)

func _update_progress() -> void:
	progress_label.text = "Situations : %d / %d   Score : %d / %d" % [GameState.scenarios_completed.size(), ScenariosDB.count(), GameState.score, GameState.max_score()]

func _on_bilan() -> void:
	get_tree().change_scene_to_file("res://scenes/Result.tscn")

func _on_quit() -> void:
	get_tree().quit()

func _box(parent: Node3D, label: String, at: Vector3, dimensions: Vector3, tint: Color) -> void:
	var item := MeshInstance3D.new()
	item.name = label
	var mesh := BoxMesh.new()
	mesh.size = dimensions
	item.mesh = mesh
	var material := StandardMaterial3D.new()
	material.albedo_color = tint
	material.roughness = 0.9
	item.material_override = material
	item.position = at
	parent.add_child(item)

func _add_decoration() -> void:
	for i in range(20):
		var desk := get_node("Poste%d" % i)
		_box(desk, "Cahier", Vector3(-0.28, 0.79, -0.3), Vector3(0.35, 0.025, 0.25), Color("52766f") if i % 2 == 0 else Color("d88c70"))
		_box(desk, "Feuille", Vector3(-0.28, 0.805, -0.3), Vector3(0.3, 0.008, 0.22), Color("f2eee5"))
		_box(desk, "Trousse", Vector3(0.35, 0.81, -0.48), Vector3(0.23, 0.065, 0.10), Color("35546d"))
	for x in [-7.0, 7.0]:
		_box(self, "CadreFenetre", Vector3(x, 1.85, -7.33), Vector3(3.2, 1.8, 0.10), Color("aa9279"))
		_box(self, "Vitre", Vector3(x, 1.85, -7.25), Vector3(2.95, 1.55, 0.04), Color("9bb8c4"))
		_box(self, "Montant", Vector3(x, 1.85, -7.20), Vector3(0.07, 1.55, 0.04), Color("e7e3da"))
	for i in range(3):
		_box(self, "Affiche", Vector3(-9.85, 1.7, -3.0 + i * 2.1), Vector3(0.04, 1.1, 0.8), [Color("d88c70"), Color("52766f"), Color("9bb8c4")][i])
	_box(self, "Plinthe", Vector3(0, 0.12, -7.32), Vector3(20, 0.18, 0.06), Color("aa9279"))
