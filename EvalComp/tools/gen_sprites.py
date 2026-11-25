# Generate pixel-art character sprites (Double Dragon style, 3x quality) using PIL
import os, random
from PIL import Image, ImageDraw

random.seed(123)
OUT = r"C:\Users\rapha\OneDrive - Institution Saint Jean\Documents\Projet par défaut\EvalCompetences\assets\sprites"
os.makedirs(OUT, exist_ok=True)

W, H = 144, 192
SCALE = 3

SKIN = (230, 190, 150)
SKIN_DARK = (190, 150, 115)
HAIR_COLORS = [
    (40, 28, 20), (90, 55, 30), (170, 130, 60), (25, 20, 16),
]
SHIRT_COLORS = [
    (200, 50, 50), (50, 90, 200), (50, 170, 80), (200, 170, 40), (160, 60, 190),
]
OUTLINE = (20, 16, 14)

def make():
    im = Image.new("RGBA", (W, H), (0,0,0,0))
    return im, ImageDraw.Draw(im)

def R(d, x, y, w, h, color, alpha=255):
    if w <= 0 or h <= 0:
        return
    x, y, w, h = x*SCALE, y*SCALE, w*SCALE, h*SCALE
    fill = color + (alpha,) if len(color) == 3 else color
    d.rectangle([x, y, x+w-1, y+h-1], fill=fill)

def O(d, x, y, w, h):
    x, y, w, h = x*SCALE, y*SCALE, w*SCALE, h*SCALE
    d.rectangle([x-SCALE, y-SCALE, x+w, y-SCALE], fill=OUTLINE)
    d.rectangle([x-SCALE, y+h, x+w, y+h], fill=OUTLINE)
    d.rectangle([x-SCALE, y, x-SCALE, y+h-1], fill=OUTLINE)
    d.rectangle([x+w, y, x+w, y+h-1], fill=OUTLINE)

def shade(c, k):
    return tuple(max(0, min(255, int(v*k))) for v in c)

def draw_player_profile(shirt_color, hair_color):
    im, d = make()
    cx = 28
    # head
    O(d, cx-2, 4, 14, 16)
    R(d, cx-2, 4, 14, 16, SKIN)
    # hair
    O(d, cx-3, 2, 16, 8)
    R(d, cx-3, 2, 16, 8, hair_color)
    R(d, cx-3, 2, 16, 3, shade(hair_color, 1.3))
    R(d, cx+10, 6, 3, 10, hair_color)
    R(d, cx-8, 1, 2, 3, shade(hair_color, 0.6))
    R(d, cx-6, 1, 2, 3, shade(hair_color, 0.7))
    R(d, cx-4, 0, 2, 4, shade(hair_color, 0.8))
    R(d, cx-2, 0, 2, 4, shade(hair_color, 0.9))
    R(d, cx, 0, 2, 4, shade(hair_color, 1.0))
    R(d, cx+2, 1, 2, 3, shade(hair_color, 1.1))
    # ear
    R(d, cx-3, 10, 2, 4, SKIN_DARK)
    R(d, cx-3, 11, 1, 2, shade(SKIN_DARK, 0.8))
    # eye
    O(d, cx+6, 8, 3, 3)
    R(d, cx+6, 8, 3, 3, (250,250,250))
    R(d, cx+7, 9, 1, 1, (30, 40, 90))
    R(d, cx+7, 9, 1, 1, (10,10,10))
    R(d, cx+6, 8, 1, 1, (255,255,255))
    # brow
    R(d, cx+5, 7, 4, 1, shade(hair_color, 0.5))
    R(d, cx+5, 6, 4, 1, shade(hair_color, 0.4))
    # nose
    O(d, cx+11, 12, 4, 3)
    R(d, cx+11, 12, 4, 3, SKIN)
    R(d, cx+12, 13, 2, 1, SKIN_DARK)
    R(d, cx+11, 12, 2, 1, shade(SKIN, 1.1))
    # mouth
    R(d, cx+4, 16, 5, 1, (180, 80, 80))
    R(d, cx+4, 17, 4, 1, (160, 70, 70))
    R(d, cx+5, 16, 2, 1, (200, 100, 100))
    # cheek shadow
    R(d, cx-1, 14, 3, 2, shade(SKIN, 0.88))
    R(d, cx+8, 14, 3, 2, shade(SKIN, 0.88))
    # neck
    R(d, cx+2, 19, 5, 3, SKIN)
    R(d, cx+2, 19, 5, 1, shade(SKIN, 0.85))
    # shirt
    O(d, cx-2, 22, 16, 18)
    R(d, cx-2, 22, 16, 18, shirt_color)
    R(d, cx-2, 22, 16, 3, shade(shirt_color, 1.2))
    R(d, cx-2, 22, 4, 18, shade(shirt_color, 0.8))
    for i in range(4):
        R(d, cx-2, 24+i*4, 16, 1, shade(shirt_color, 0.75))
    # collar
    R(d, cx-2, 22, 6, 2, (240,240,245))
    R(d, cx-1, 22, 4, 1, (255,255,255))
    # pocket
    R(d, cx+3, 28, 5, 4, shade(shirt_color, 0.85))
    R(d, cx+4, 29, 3, 1, shade(shirt_color, 0.7))
    R(d, cx+3, 28, 5, 1, shade(shirt_color, 0.95))
    # button
    R(d, cx-1, 26, 2, 2, (240,240,240))
    R(d, cx-1, 31, 2, 2, (240,240,240))
    R(d, cx-1, 36, 2, 2, (240,240,240))
    # arm (front)
    O(d, cx+12, 22, 5, 14)
    R(d, cx+12, 22, 5, 14, shirt_color)
    R(d, cx+12, 22, 5, 2, shade(shirt_color, 1.15))
    R(d, cx+12, 28, 5, 2, shade(shirt_color, 0.9))
    R(d, cx+12, 36, 5, 4, SKIN)
    R(d, cx+12, 39, 5, 2, SKIN_DARK)
    for i in range(3):
        R(d, cx+12+i, 39, 1, 2, shade(SKIN, 0.9-i*0.05))
    # back arm
    R(d, cx-6, 24, 4, 12, shade(shirt_color, 0.7))
    R(d, cx-6, 36, 4, 3, shade(SKIN, 0.8))
    # belt
    O(d, cx-2, 39, 16, 3)
    R(d, cx-2, 39, 16, 3, (40, 30, 20))
    R(d, cx-2, 39, 16, 1, shade((40,30,20), 1.3))
    R(d, cx+4, 39, 4, 3, (180, 150, 60))
    R(d, cx+5, 39, 2, 3, (220, 190, 90))
    # pants
    O(d, cx-2, 42, 16, 14)
    R(d, cx-2, 42, 16, 14, (50, 60, 100))
    R(d, cx-2, 42, 16, 2, (70, 80, 130))
    R(d, cx-2, 42, 5, 14, (40, 50, 90))
    R(d, cx+6, 42, 1, 14, (35, 45, 80))
    # knee
    R(d, cx+2, 48, 4, 1, (35, 45, 80))
    R(d, cx+2, 49, 4, 1, (30, 40, 75))
    # shoes
    O(d, cx+4, 56, 10, 6)
    R(d, cx+4, 56, 10, 6, (30, 30, 35))
    R(d, cx+4, 60, 10, 2, (20, 20, 25))
    R(d, cx+6, 56, 5, 1, (200,200,200))
    R(d, cx+4, 56, 10, 1, (50,50,55))
    R(d, cx+4, 59, 10, 1, (15,15,20))
    # laces
    R(d, cx+5, 57, 3, 1, (220,220,220))
    R(d, cx+8, 57, 3, 1, (220,220,220))
    return im

def draw_student_back_profile(skin_idx, hair_idx, shirt_idx):
    skins = [(230,190,150), (180,135,100)]
    skin = skins[skin_idx % len(skins)]
    skin_dark = (190,150,115) if skin_idx % 2 == 0 else (145, 105, 75)
    hair = HAIR_COLORS[hair_idx % len(HAIR_COLORS)]
    shirt = SHIRT_COLORS[shirt_idx % len(SHIRT_COLORS)]
    im, d = make()
    cx = 28
    # hair
    O(d, cx-8, 2, 18, 12)
    R(d, cx-8, 2, 18, 12, hair)
    R(d, cx-8, 2, 18, 4, shade(hair, 1.3))
    R(d, cx+6, 4, 5, 10, shade(hair, 0.8))
    R(d, cx-9, 4, 3, 10, hair)
    for i in range(5):
        R(d, cx-8+i*3, 1, 2, 3, shade(hair, 0.6+i*0.08))
    R(d, cx+7, 3, 2, 2, shade(hair, 0.5))
    R(d, cx+4, 0, 3, 3, shade(hair, 1.2))
    # head back
    O(d, cx-7, 14, 14, 12)
    R(d, cx-7, 14, 14, 12, skin)
    # profile face
    R(d, cx+5, 14, 4, 12, shade(skin, 0.92))
    R(d, cx+5, 14, 1, 12, shade(skin, 0.85))
    # ear
    R(d, cx+5, 17, 3, 5, shade(skin, 0.82))
    R(d, cx+6, 18, 1, 3, shade(skin, 0.72))
    R(d, cx+5, 17, 1, 1, shade(skin, 1.0))
    # eye
    R(d, cx+5, 17, 2, 2, (250,250,250))
    R(d, cx+6, 17, 1, 1, (40, 60, 120))
    R(d, cx+6, 17, 1, 1, (10,10,10))
    R(d, cx+5, 16, 1, 1, (255,255,255))
    # brow
    R(d, cx+4, 15, 3, 1, shade(hair, 0.5))
    R(d, cx+4, 14, 3, 1, shade(hair, 0.4))
    # nose
    R(d, cx+7, 20, 3, 2, shade(skin, 0.9))
    R(d, cx+8, 21, 1, 1, shade(skin, 0.8))
    R(d, cx+7, 20, 1, 1, shade(skin, 1.05))
    # mouth
    R(d, cx+6, 23, 2, 1, (180, 80, 80))
    R(d, cx+6, 24, 1, 1, (160, 70, 70))
    # blush
    R(d, cx+4, 21, 2, 1, (255, 150, 150), 100)
    # cheek shadow
    R(d, cx-6, 20, 3, 2, shade(skin, 0.88))
    # neck
    R(d, cx-3, 26, 6, 3, skin)
    R(d, cx-3, 26, 6, 1, shade(skin, 0.85))
    # shirt (back)
    O(d, cx-8, 29, 16, 14)
    R(d, cx-8, 29, 16, 14, shirt)
    R(d, cx-8, 29, 16, 3, shade(shirt, 1.15))
    R(d, cx-8, 29, 16, 14, shade(shirt, 0.92))
    for i in range(3):
        R(d, cx-8, 31+i*4, 16, 1, shade(shirt, 0.75))
    # back seam
    R(d, cx-1, 29, 2, 14, shade(shirt, 0.6))
    R(d, cx-1, 29, 1, 14, shade(shirt, 0.5))
    # collar
    R(d, cx-4, 29, 8, 2, (240,240,245))
    R(d, cx-3, 29, 6, 1, (255,255,255))
    # arms on desk
    O(d, cx-11, 30, 3, 10)
    R(d, cx-11, 30, 3, 10, shirt)
    O(d, cx+8, 30, 3, 10)
    R(d, cx+8, 30, 3, 10, shirt)
    R(d, cx-11, 30, 3, 2, shade(shirt, 1.15))
    R(d, cx+8, 30, 3, 2, shade(shirt, 1.15))
    R(d, cx-11, 40, 3, 3, skin)
    R(d, cx+8, 40, 3, 3, skin)
    R(d, cx-11, 42, 3, 1, shade(skin, 0.85))
    R(d, cx+8, 42, 3, 1, shade(skin, 0.85))
    for i in range(2):
        R(d, cx-11+i, 41, 1, 1, shade(skin, 0.9-i*0.05))
        R(d, cx+8+i, 41, 1, 1, shade(skin, 0.9-i*0.05))
    # pants
    R(d, cx-7, 43, 14, 6, (50, 60, 100))
    R(d, cx-7, 43, 14, 2, (70, 80, 130))
    R(d, cx, 43, 1, 6, (35, 45, 85))
    # shoes
    R(d, cx-7, 49, 6, 4, (30, 30, 35))
    R(d, cx+1, 49, 6, 4, (30, 30, 35))
    R(d, cx-7, 52, 6, 1, (20, 20, 25))
    R(d, cx+1, 52, 6, 1, (20, 20, 25))
    R(d, cx-6, 49, 4, 1, (50,50,55))
    R(d, cx+2, 49, 4, 1, (50,50,55))
    # notebook
    R(d, cx-3, 40, 6, 3, (245, 240, 200))
    R(d, cx-2, 41, 4, 1, (80, 80, 120))
    R(d, cx-2, 42, 2, 1, (80, 80, 120))
    R(d, cx-3, 40, 6, 1, (230, 225, 185))
    return im

# Generate
draw_player_profile((200, 50, 50), (40, 28, 20)).save(os.path.join(OUT, "player_male.png"))
draw_player_profile((200, 80, 150), (170, 120, 70)).save(os.path.join(OUT, "player_female.png"))

for i in range(20):
    si = 0 if random.random() < 0.8 else 1
    hi = random.randrange(len(HAIR_COLORS))
    shi = random.randrange(len(SHIRT_COLORS))
    draw_student_back_profile(si, hi, shi).save(os.path.join(OUT, f"student_{i:02d}.png"))

print("done, files:", len(os.listdir(OUT)))
