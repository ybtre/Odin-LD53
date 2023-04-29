package LD_53 

import rl "vendor:raylib"
import m "core:math/linalg/hlsl"

C_PLAYER     :: rl.Color{ 72, 107, 127, 255 }
C_ASTEROID   :: rl.Color{ 187, 71, 79, 255 }
C_BULLET     :: rl.Color{ 122, 156, 150, 255 }
C_GAME_MAP   :: rl.Color{ 255, 255, 255, 220 }
C_CURSOR     :: rl.Color{ 209, 191, 176, 255 }
C_TEXT       :: rl.Color{ 188, 33, 106, 255 }
C_BG         :: rl.Color{ 13, 32, 27, 255 }
C_BTN_HOVER  :: rl.Color{ 200, 200, 200, 255 }

SCREEN : rl.Vector2 : { 1024.0, 768.0 }
project_name :: "Ludum Dare 53 - De-liver"

NUM_ASTEROIDS       :: 100

SPRITE_OFFSET :: ((8 * 6) / 2)
SPRITE_SCALE_MULTI :: 6
SPRITE_SIZE :: 8
SPRITE_SIZE_SCALED :: 48
BUTTON_SPRITE_SIZE :: 32
BUTTON_SPRITE_OFFSET :: ((32 * 6) / 2)