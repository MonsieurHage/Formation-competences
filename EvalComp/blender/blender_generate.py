# blender_generate.py
# Script Blender pour generer les sprites pixel art d'EvalComp.
# Usage : blender --background --python blender/blender_generate.py
# Genere des sprites 2D (rendu orthographique basse resolution) dans assets/sprites/

import bpy
import os
import math

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT_DIR = os.path.join(ROOT, "assets", "sprites")
os.makedirs(OUT_DIR, exist_ok=True)

SPRITE_SIZE = 96

def clear_scene():
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for block in bpy.data.meshes:
        bpy.data.meshes.remove(block)
    for block in bpy.data.materials:
        bpy.data.materials.remove(block)
    for block in bpy.data.cameras:
        bpy.data.cameras.remove(block)
    for block in bpy.data.lights:
        bpy.data.lights.remove(block)

def setup_render(name):
    scene = bpy.context.scene
    scene.render.engine = 'BLENDER_EEVEE'
    scene.render.resolution_x = SPRITE_SIZE
    scene.render.resolution_y = SPRITE_SIZE
    scene.render.resolution_percentage = 100
    scene.render.film_transparent = True
    scene.render.image_settings.file_format = 'PNG'
    scene.render.filepath = os.path.join(OUT_DIR, name + ".png")

def setup_camera(location=(0, -4, 1.2), ortho_scale=2.2):
    bpy.ops.object.camera_add(location=location)
    cam = bpy.context.active_object
    cam.data.type = 'ORTHO'
    cam.data.ortho_scale = ortho_scale
    bpy.context.scene.camera = cam
    # look at origin
    import mathutils
    direction = mathutils.Vector((0,0,0)) - cam.location
    cam.rotation_euler = direction.to_track_quat('-Z', 'Y').to_euler()
    return cam

def mat(name, color):
    m = bpy.data.materials.new(name=name)
    m.use_nodes = True
    bsdf = m.node_tree.nodes.get("Principled BSDF")
    bsdf.inputs["Base Color"].default_value = color
    bsdf.inputs["Roughness"].default_value = 0.8
    return m

def make_teacher(gender="male"):
    clear_scene()
    body_color = (0.2, 0.45, 0.95, 1.0) if gender == "male" else (0.9, 0.4, 0.6, 1.0)
    # body
    bpy.ops.mesh.primitive_cube_add(size=1, location=(0, 0, 0.6))
    body = bpy.context.active_object
    body.scale = (0.35, 0.25, 0.7)
    body.data.materials.append(mat("Body", body_color))
    # head
    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.28, location=(0, 0, 1.45))
    head = bpy.context.active_object
    head.data.materials.append(mat("Head", (1.0, 0.85, 0.7, 1.0)))
    # eyes
    for x in (-0.1, 0.1):
        bpy.ops.mesh.primitive_uv_sphere_add(radius=0.05, location=(x, 0.22, 1.5))
        e = bpy.context.active_object
        e.data.materials.append(mat("Eye", (0.1, 0.1, 0.1, 1.0)))
    setup_camera(location=(0, -3.5, 1.2), ortho_scale=2.0)
    setup_render("teacher_" + gender)
    bpy.ops.render.render(write_still=True)
    print("Rendered teacher_" + gender)

def make_student():
    clear_scene()
    bpy.ops.mesh.primitive_cube_add(size=1, location=(0, 0, 0.5))
    body = bpy.context.active_object
    body.scale = (0.3, 0.22, 0.6)
    body.data.materials.append(mat("Body", (0.9, 0.75, 0.3, 1.0)))
    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.24, location=(0, 0, 1.25))
    head = bpy.context.active_object
    head.data.materials.append(mat("Head", (1.0, 0.85, 0.7, 1.0)))
    setup_camera(location=(0, -3.0, 1.0), ortho_scale=1.8)
    setup_render("student")
    bpy.ops.render.render(write_still=True)
    print("Rendered student")

if __name__ == "__main__":
    make_teacher("male")
    make_teacher("female")
    make_student()
    print("All sprites generated in", OUT_DIR)