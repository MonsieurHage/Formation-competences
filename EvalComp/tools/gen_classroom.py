import os, random
random.seed(123)

proj = r"C:\Users\rapha\OneDrive - Institution Saint Jean\Documents\Projet par défaut\EvalCompetences"
out = os.path.join(proj, "scenes", "Classroom.tscn")

W, D, Hwall = 20.0, 15.0, 3.0
cols = 5
rows = 4
xs = [-8.0 + c*4.0 for c in range(cols)]
zs = [-4.0 + r*3.0 for r in range(rows)]

names = ["Lina","Tom","Nina","Léo","Sara","Hugo","Emma","Lucas","Chloé","Noah","Jade","Adam","Léa","Louis","Manon","Nathan","Camille","Gabriel","Inès","Arthur"]

lines = []
lines.append('[gd_scene load_steps=4 format=3]')
lines.append('')
lines.append('[ext_resource type="Script" path="res://scripts/classroom/Classroom.gd" id="1_cls"]')
lines.append('[ext_resource type="Script" path="res://scripts/player/Player.gd" id="2_ply"]')
lines.append('[ext_resource type="PackedScene" path="res://scenes/PosteEleve.tscn" id="3_poste"]')
lines.append('[ext_resource type="ArrayMesh" path="res://assets/models/kenney/bookcaseOpen.obj" id="m_bookcase"]')
lines.append('[ext_resource type="ArrayMesh" path="res://assets/models/kenney/plantSmall1.obj" id="m_plant"]')
lines.append('[ext_resource type="ArrayMesh" path="res://assets/models/kenney/lampSquareTable.obj" id="m_lamp"]')
lines.append('[ext_resource type="ArrayMesh" path="res://assets/models/kenney/table.obj" id="m_table"]')
lines.append('')

lines.append('[sub_resource type="Environment" id="Env"]')
lines.append('background_mode = 1')
lines.append('background_color = Color(0.125, 0.161, 0.22, 1)')
lines.append('ambient_light_color = Color(0.7, 0.7, 0.75, 1)')
lines.append('ambient_light_energy = 0.4')
lines.append('')

lines.append('[sub_resource type="StandardMaterial3D" id="MatFloor"]')
lines.append('albedo_color = Color(0.667, 0.573, 0.475, 1)')
lines.append('roughness = 0.85')
lines.append('')
lines.append('[sub_resource type="StandardMaterial3D" id="MatWall"]')
lines.append('albedo_color = Color(0.906, 0.890, 0.855, 1)')
lines.append('roughness = 0.9')
lines.append('')
lines.append('[sub_resource type="StandardMaterial3D" id="MatBoard"]')
lines.append('albedo_color = Color(0.161, 0.294, 0.263, 1)')
lines.append('roughness = 0.3')
lines.append('metallic = 0.1')
lines.append('')

lines.append('[sub_resource type="BoxMesh" id="FloorBox"]')
lines.append('size = Vector3(1, 1, 1)')
lines.append('')
lines.append('[sub_resource type="BoxMesh" id="WallBox"]')
lines.append('size = Vector3(1, 1, 1)')
lines.append('')
lines.append('[sub_resource type="BoxMesh" id="BoardBox"]')
lines.append('size = Vector3(1, 1, 1)')
lines.append('')

lines.append('[node name="Classroom" type="Node3D"]')
lines.append('script = ExtResource("1_cls")')
lines.append('')
lines.append('[node name="WorldEnvironment" type="WorldEnvironment" parent="."]')
lines.append('environment = SubResource("Env")')
lines.append('')
lines.append('[node name="Sun" type="DirectionalLight3D" parent="."]')
lines.append('rotation_degrees = Vector3(-45, 30, 0)')
lines.append('light_energy = 0.7')
lines.append('shadow_enabled = true')
lines.append('')
lines.append('[node name="Fill" type="DirectionalLight3D" parent="."]')
lines.append('rotation_degrees = Vector3(-30, 200, 0)')
lines.append('light_energy = 0.25')
lines.append('light_color = Color(0.9, 0.95, 1.0, 1)')
lines.append('')
lines.append('[node name="Rim" type="DirectionalLight3D" parent="."]')
lines.append('rotation_degrees = Vector3(20, 90, 0)')
lines.append('light_energy = 0.15')
lines.append('light_color = Color(1.0, 0.95, 0.85, 1)')
lines.append('')

# Floor
lines.append('[node name="Floor" type="MeshInstance3D" parent="."]')
lines.append('mesh = SubResource("FloorBox")')
lines.append('surface_material_override/0 = SubResource("MatFloor")')
lines.append('position = Vector3(0, -0.05, 0)')
lines.append('scale = Vector3(20, 0.1, 15)')
lines.append('')

# Walls
walls = [
    ("WallBack", (0, 1.5, 7.5), (0, 0, 0), (20, 3, 0.2)),
    ("WallFront", (0, 1.5, -7.5), (0, 0, 0), (20, 3, 0.2)),
    ("WallLeft", (-10, 1.5, 0), (0, 90, 0), (15, 3, 0.2)),
    ("WallRight", (10, 1.5, 0), (0, 90, 0), (15, 3, 0.2)),
]
for name, pos, rot, sz in walls:
    lines.append(f'[node name="{name}" type="MeshInstance3D" parent="."]')
    lines.append('mesh = SubResource("WallBox")')
    lines.append('surface_material_override/0 = SubResource("MatWall")')
    lines.append(f'position = Vector3({pos[0]}, {pos[1]}, {pos[2]})')
    if rot != (0, 0, 0):
        lines.append(f'rotation_degrees = Vector3({rot[0]}, {rot[1]}, {rot[2]})')
    lines.append(f'scale = Vector3({sz[0]}, {sz[1]}, {sz[2]})')
    lines.append('')

# Whiteboard
lines.append('[node name="Whiteboard" type="MeshInstance3D" parent="."]')
lines.append('mesh = SubResource("BoardBox")')
lines.append('surface_material_override/0 = SubResource("MatBoard")')
lines.append('position = Vector3(0, 1.5, 7.4)')
lines.append('scale = Vector3(8, 2.5, 0.1)')
lines.append('')
lines.append('[node name="WhiteboardFrame" type="MeshInstance3D" parent="."]')
lines.append('mesh = SubResource("BoardBox")')
lines.append('surface_material_override/0 = SubResource("MatWall")')
lines.append('position = Vector3(0, 1.5, 7.45)')
lines.append('scale = Vector3(8.4, 2.9, 0.05)')
lines.append('')

# Rug
lines.append('[node name="Rug" type="MeshInstance3D" parent="."]')
lines.append('mesh = ExtResource("m_rug")') if False else ''
# Use kenney rug via ext_resource? We didn't include it. Let's skip rug to avoid missing ext.
# Actually include it:
lines = [l for l in lines if l != 'mesh = ExtResource("m_rug")' or True]
# remove the last appended rug lines if any placeholder
# We'll add rug via PosteEleve? No. Skip rug for now.

# Bookcase
lines.append('[node name="Bookcase" type="MeshInstance3D" parent="."]')
lines.append('mesh = ExtResource("m_bookcase")')
lines.append('position = Vector3(8.5, 0, 6)')
lines.append('rotation_degrees = Vector3(0, -90, 0)')
lines.append('scale = Vector3(0.2, 0.2, 0.2)')
lines.append('')

# Plant
lines.append('[node name="Plant" type="MeshInstance3D" parent="."]')
lines.append('mesh = ExtResource("m_plant")')
lines.append('position = Vector3(-8.5, 0, 6)')
lines.append('scale = Vector3(0.3, 0.3, 0.3)')
lines.append('')

# Teacher desk (table model)
lines.append('[node name="TeacherDesk" type="MeshInstance3D" parent="."]')
lines.append('mesh = ExtResource("m_table")')
lines.append('position = Vector3(6, 0, 6.5)')
lines.append('scale = Vector3(0.2, 0.2, 0.2)')
lines.append('')

# Lamp
lines.append('[node name="Lamp" type="MeshInstance3D" parent="."]')
lines.append('mesh = ExtResource("m_lamp")')
lines.append('position = Vector3(6, 0.8, 6.5)')
lines.append('scale = Vector3(0.3, 0.3, 0.3)')
lines.append('')

# Player
lines.append('[node name="Player" type="CharacterBody3D" parent="."]')
lines.append('position = Vector3(0, 0, 0)')
lines.append('script = ExtResource("2_ply")')
lines.append('')

# Camera (fixed, independent)
lines.append('[node name="Camera3D" type="Camera3D" parent="."]')
lines.append('projection = 1')
lines.append('size = 16.0')
lines.append('position = Vector3(0, 8, 12)')
lines.append('')

# PosteEleve instances (20)
for idx in range(20):
    r = idx // cols
    c = idx % cols
    x = xs[c]
    z = zs[r]
    lines.append(f'[node name="Poste{idx}" parent="." instance=ExtResource("3_poste")]')
    lines.append(f'position = Vector3({x}, 0, {z})')
    lines.append(f'label_text = "{names[idx]}"')
    lines.append(f'student_index = {idx}')
    lines.append('')

# HUD
lines.append('[node name="HUD" type="CanvasLayer" parent="."]')
lines.append('')
lines.append('[node name="Progress" type="Label" parent="HUD"]')
lines.append('offset_left = 8.0')
lines.append('offset_top = 8.0')
lines.append('offset_right = 712.0')
lines.append('offset_bottom = 24.0')
lines.append('text = "Situations : 0 / 0"')
lines.append('theme = ExtResource("4_theme")')
lines.append('theme_override_font_sizes/font_size = 12')
lines.append('')
lines.append('[node name="BilanBtn" type="Button" parent="HUD"]')
lines.append('offset_left = 8.0')
lines.append('offset_top = 240.0')
lines.append('offset_right = 90.0')
lines.append('offset_bottom = 264.0')
lines.append('text = "Bilan"')
lines.append('theme = ExtResource("4_theme")')
lines.append('')
lines.append('[node name="QuitBtn" type="Button" parent="HUD"]')
lines.append('offset_left = 630.0')
lines.append('offset_top = 240.0')
lines.append('offset_right = 712.0')
lines.append('offset_bottom = 264.0')
lines.append('text = "Quitter"')
lines.append('theme = ExtResource("4_theme")')
lines.append('')

# Need ext_resource for theme
# insert theme ext_resource
lines.insert(3, '[ext_resource type="Theme" path="res://themes/main.tres" id="4_theme"]')

with open(out, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))

print("written", out)
print("postes:", 20)
