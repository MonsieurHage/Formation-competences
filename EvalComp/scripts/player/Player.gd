extends CharacterBody3D

@export var speed: float = 6.0

var facing: int = 1
var model: Node3D
var anim: AnimationPlayer
var idle_anim: String = "HumanArmature|Man_Idle"
var walk_anim: String = "HumanArmature|Man_Walk"

func _ready() -> void:
	var path := "res://assets/models/characters/man.glb"
	if PlayerData.avatar_gender == "female":
		path = "res://assets/models/characters/woman.glb"
		idle_anim = "Armature|Idle"
		walk_anim = "Armature|Walking"
	var scene = load(path)
	if scene:
		model = scene.instantiate()
		model.scale = Vector3(0.3, 0.3, 0.3)
		add_child(model)
		anim = _find_anim(model)
		if anim:
			anim.play(idle_anim)
	var cs := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.3
	shape.height = 1.2
	cs.shape = shape
	cs.position = Vector3(0, 0.6, 0)
	add_child(cs)

func _find_anim(n) -> AnimationPlayer:
	var best: AnimationPlayer = null
	var best_count := 0
	if n is AnimationPlayer:
		best = n
		best_count = n.get_animation_list().size()
	for c in n.get_children():
		var r := _find_anim(c)
		if r != null and r.get_animation_list().size() > best_count:
			best = r
			best_count = r.get_animation_list().size()
	return best

func _physics_process(delta: float) -> void:
	var input_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var dir := Vector3(input_vec.x, 0, input_vec.y)
	if dir.length() > 0:
		dir = dir.normalized()
	velocity = dir * speed
	if input_vec.x != 0:
		facing = sign(input_vec.x)
		if model:
			model.rotation.y = 0 if facing > 0 else PI
	# animation (respect reduce_animations)
	if anim and not GameState.reduce_animations:
		if input_vec.length() > 0:
			if anim.current_animation != walk_anim:
				anim.play(walk_anim)
		else:
			if anim.current_animation != idle_anim:
				anim.play(idle_anim)
	move_and_slide()
	global_position.x = clamp(global_position.x, -9.0, 9.0)
	global_position.z = clamp(global_position.z, -6.0, 6.0)