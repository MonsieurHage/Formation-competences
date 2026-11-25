extends Node3D
func _ready() -> void:
	var scene = load("res://assets/models/characters/man.glb")
	var inst = scene.instantiate()
	add_child(inst)
	var aps = []
	_find_anim(inst, aps)
	for ap in aps:
		print("anims:", ap.get_animation_list())
	get_tree().quit()

func _find_anim(n, out):
	if n is AnimationPlayer:
		out.append(n)
	for c in n.get_children():
		_find_anim(c, out)