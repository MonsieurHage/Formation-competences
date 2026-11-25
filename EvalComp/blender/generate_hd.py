# generate_hd.py
# Blender script pour generer des personnages et decors 3D haute qualite.
# Usage : blender --background --python blender/generate_hd.py
# Les fichiers .glb sont exportes dans assets/models/hd/

import bpy
import os
import math
import random

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT_DIR = os.path.join(ROOT, "assets", "models", "hd")
os.makedirs(OUT_DIR, exist_ok=True)

random.seed(42)

def clear_scene():
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for block in bpy.data.meshes:
        bpy.data.meshes.remove(block)
    for block in bpy.data.materials:
        bpy.data.materials.remove(block)

def mat(name, color, roughness=0.5, metallic=0.0, emission=None):
    m = bpy.data.materials.new(name=name)
    m.use_nodes = True
    bsdf = m.node_tree.nodes.get("Principled BSDF")
    bsdf.inputs["Base Color"].default_value = (*color, 1.0)
    bsdf.inputs["Roughness"].default_value = roughness
    bsdf.inputs["Metallic"].default_value = metallic
    if emission:
        bsdf.inputs["Emission Color"].default_value = (*emission, 1.0)
        bsdf.inputs["Emission Strength"].default_value = 0.5
    return m

def export_glb(name):
    path = os.path.join(OUT_DIR, name + ".glb")
    bpy.ops.export_scene.gltf(filepath=path, export_format='GLB', use_selection=False,
        export_materials='EXPORT', export_cameras=False, export_lights=False)
    print("Exported", path)

def make_teacher(gender="male"):
    clear_scene()
    skin = (0.95, 0.78, 0.62)
    shirt = (0.25, 0.45, 0.85) if gender == "male" else (0.85, 0.35, 0.55)
    pants = (0.2, 0.25, 0.4)
    hair = (0.25, 0.18, 0.12) if gender == "male" else (0.6, 0.4, 0.2)
    # body (torso)
    bpy.ops.mesh.primitive_cylinder_add(radius=0.25, depth=0.7, location=(0, 0.85, 0))
    body = bpy.context.active_object
    body.scale = (1.0, 1.0, 0.7)
    body.data.materials.append(mat("Shirt", shirt, 0.6))
    # head
    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.22, location=(0, 1.45, 0))
    head = bpy.context.active_object
    head.data.materials.append(mat("Skin", skin, 0.4))
    # hair
    bpy.ops.mesh.primitive_uv_sphere_add(radius=0.24, location=(0, 1.5, -0.05))
    hair_obj = bpy.context.active_object
    hair_obj.scale = (1.0, 0.6, 1.0)
    hair_obj.data.materials.append(mat("Hair", hair, 0.7))
    # eyes
    for x in (-0.08, 0.08):
        bpy.ops.mesh.primitive_uv_sphere_add(radius=0.04, location=(x, 1.48, 0.18))
        e = bpy.context.active_object
        e.data.materials.append(mat("Eye", (0.15, 0.2, 0.4), 0.2))
    # arms
    for x in (-0.32, 0.32):
        bpy.ops.mesh.primitive_cylinder_add(radius=0.06, depth=0.6, location=(x, 0.85, 0))
        arm = bpy.context.active_object
        arm.rotation_euler = (0, 0, math.radians(10 if x>0 else -10))
        arm.data.materials.append(mat("Arm", shirt, 0.6))
    # legs
    for x in (-0.1, 0.1):
        bpy.ops.mesh.primitive_cylinder_add(radius=0.07, depth=0.7, location=(x, 0.15, 0))
        leg = bpy.context.active_object
        leg.data.materials.append(mat("Pants", pants, 0.7))
    # shoes
    for x in (-0.1, 0.1):
        bpy.ops.mesh.primitive_cube_add(size=0.12, location=(x, -0.25, 0.05))
        sh = bpy.context.active_object
        sh.scale = (1, 0.6, 1.4)
        sh.data.materials.append(mat("Shoe", (0.15, 0.15, 0.18), 0.4))
    bpy.ops.object.select_all(action='SELECT')
    export_glb("teacher_" + gender)

def make_desk():
    clear_scene()
    bpy.ops.mesh.primitive_cube_add(size=1, location=(0, 0.4, 0))
    top = bpy.context.active_object
    top.scale = (1.2, 0.05, 0.7)
    top.data.materials.append(mat("DeskTop", (0.7, 0.55, 0.35), 0.6))
    # legs
    for x,z in [(-0.5,-0.3),(0.5,-0.3),(-0.5,0.3),(0.5,0.3)]:
        bpy.ops.mesh.primitive_cylinder_add(radius=0.03, depth=0.4, location=(x, 0.2, z))
        leg = bpy.context.active_object
        leg.data.materials.append(mat("DeskLeg", (0.3, 0.3, 0.35), 0.4, 0.6))
    bpy.ops.object.select_all(action='SELECT')
    export_glb("desk_hd")

def make_chair():
    clear_scene()
    bpy.ops.mesh.primitive_cube_add(size=1, location=(0, 0.25, 0))
    seat = bpy.context.active_object
    seat.scale = (0.5, 0.05, 0.5)
    seat.data.materials.append(mat("Seat", (0.3, 0.35, 0.5), 0.6))
    bpy.ops.mesh.primitive_cube_add(size=1, location=(0, 0.5, -0.2))
    back = bpy.context.active_object
    back.scale = (0.5, 0.5, 0.05)
    back.data.materials.append(mat("Back", (0.3, 0.35, 0.5), 0.6))
    for x,z in [(-0.2,0.2),(0.2,0.2)]:
        bpy.ops.mesh.primitive_cylinder_add(radius=0.02, depth=0.25, location=(x, 0.125, z))
        leg = bpy.context.active_object
        leg.data.materials.append(mat("Leg", (0.25, 0.25, 0.3), 0.4, 0.7))
    bpy.ops.object.select_all(action='SELECT')
    export_glb("chair_hd")

if __name__ == "__main__":
    make_teacher("male")
    make_teacher("female")
    make_desk()
    make_chair()
    print("HD models generated in", OUT_DIR)
