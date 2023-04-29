package LD_53 

import rl "vendor:raylib"

bg : Background
bg_tex : rl.Texture2D

setup_background :: proc(){
    bg_tex = rl.LoadTexture("../assets/background.png")

    bg.spr.src = { 0, 0, 420, 315}
    bg.spr.dest =  { -35, -35, bg.spr.src.width * 2.64, bg.spr.src.height * 2.64 }
    bg.spr.center = { 0, 0 }
}

render_background :: proc(){
    rl.DrawTexturePro(bg_tex, bg.spr.src, bg.spr.dest, bg.spr.center, 0, rl.WHITE)
}

unload_background :: proc() {
    rl.UnloadTexture(bg_tex)
}