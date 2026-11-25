extends Node
var failures := 0
func check(ok: bool, message: String):
	if not ok:
		failures += 1
		push_error(message)
func _ready():
	GameState.reset_run()
	for resolution in [Vector2i(1280,720),Vector2i(1440,810),Vector2i(1920,1080)]:
		get_window().size = resolution
		for idx in range(ScenariosDB.count()):
			GameState.current_scenario_index = idx
			var scene = load("res://scenes/Scenario.tscn").instantiate()
			add_child(scene)
			for frame in range(4): await get_tree().process_frame
			var panel = scene.get_node("Panel")
			check(get_viewport().get_visible_rect().encloses(panel.get_global_rect()), "Panel outside viewport")
			var best := 0
			for i in range(scene.scenario.options.size()):
				if scene.scenario.options[i].get("correct",false): best = i
			scene.options_box.get_child(best).pressed.emit()
			for frame in range(4): await get_tree().process_frame
			check(scene.continue_btn.visible, "Return button missing")
			check(get_viewport().get_visible_rect().encloses(scene.continue_btn.get_global_rect()), "Return button clipped")
			check(not scene.feedback_label.text.is_empty(), "Missing feedback")
			var score = GameState.score
			scene._answer(best)
			check(GameState.score == score, "Double award")
			scene.queue_free()
			await get_tree().process_frame
	check(GameState.score == GameState.max_score(), "Incorrect final score")
	Progress.save()
	GameState.reset_run()
	check(Progress.load_save(), "Load failed")
	check(GameState.score == GameState.max_score(), "Save score mismatch")
	var menu = load("res://scenes/MainMenu.tscn").instantiate()
	add_child(menu)
	for frame in range(4): await get_tree().process_frame
	menu._on_settings()
	for frame in range(4): await get_tree().process_frame
	check(get_viewport().get_visible_rect().encloses(menu.settings_panel.get_global_rect()), "Settings clipped")
	menu.queue_free()
	await get_tree().process_frame
	var room = load("res://scenes/Classroom.tscn").instantiate()
	add_child(room)
	for frame in range(4): await get_tree().process_frame
	check(get_tree().get_nodes_in_group("hotspots").size() == 20, "Missing students")
	var camera_transform = room.camera.transform
	room.player.position.x += 1
	await get_tree().process_frame
	check(room.camera.transform == camera_transform, "Camera followed player")
	for i in range(20):
		var desk = room.get_node("Poste%d/Desk" % i)
		var chair = room.get_node("Poste%d/Chair" % i)
		var dc = desk.transform * desk.get_aabb().get_center()
		var cc = chair.transform * chair.get_aabb().get_center()
		check(absf(dc.x - cc.x) < 0.001, "Seat not centered")
	print("REGRESSION: 45 dialogues, 3 resolutions, duplicate clicks, persistence, settings, 20 seats, camera; failures=", failures)
	get_tree().quit(failures)
