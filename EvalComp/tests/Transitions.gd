extends Node
func _ready():
	get_parent().remove_child.call_deferred(self)
	get_tree().root.add_child.call_deferred(self)
	call_deferred("run")
func run():
	GameState.reset_run()
	for idx in range(3):
		GameState.current_scenario_index = idx
		get_tree().change_scene_to_file("res://scenes/Scenario.tscn")
		for f in range(5): await get_tree().process_frame
		var scene = get_tree().current_scene
		scene.options_box.get_child(0).pressed.emit()
		for f in range(3): await get_tree().process_frame
		scene.continue_btn.pressed.emit()
		for f in range(5): await get_tree().process_frame
		assert(get_tree().current_scene.name == "Classroom")
		var player = get_tree().current_scene.player
		var before = player.position
		Input.action_press("move_right")
		for f in range(5): await get_tree().physics_frame
		Input.action_release("move_right")
		assert(player.position.x > before.x)
	print("TRANSITIONS: 3 answers -> return to classroom -> movement: PASS")
	get_tree().quit()
