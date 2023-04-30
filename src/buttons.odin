package LD_53

import rl "vendor:raylib"

MAX_BTNS :: 3
buttons : [MAX_BTNS]Button
btn_tex : rl.Texture2D

setup_buttons :: proc() {
    for i in 0..<MAX_BTNS {
        btn_tex = rl.LoadTexture("../assets/ant_temp.png")

        buttons[i].spr.src = {0,0, 160, 160}
        buttons[i].spr.dest = { 0, 0, buttons[i].spr.src.width/4, buttons[i].spr.src.height/4 }
        buttons[i].spr.center = { buttons[i].spr.src.width / 2.0, buttons[i].spr.src.height / 2.0 }

        buttons[i].rec = {0, 0, buttons[i].spr.src.width, buttons[i].spr.src.height}

        buttons[i].is_highlighted = false
        buttons[i].is_pressed = false
    }
}


set_btn_pos :: proc(btn : ^Button, new_pos : rl.Vector2) {
    btn.rec = { new_pos.x - btn.spr.src.width /2, new_pos.y- btn.spr.src.width /2, btn.spr.src.width/2, btn.spr.src.height/2} 
    btn.spr.dest = {new_pos.x, new_pos.y, btn.spr.src.width/2, btn.spr.src.height/2 }
}

update_buttons :: proc() {
    using rl

    for i in 0..<MAX_BTNS
    {
        if CheckCollisionPointRec(GetMousePosition(), buttons[i].rec)
        {
            buttons[i].is_highlighted = true

            if IsMouseButtonReleased(MouseButton.LEFT)
            {
                buttons[i].is_pressed = true
            } 
            else {
                buttons[i].is_pressed = false
            }
        } else {
            buttons[i].is_highlighted = false
        }
    }
}

render_buttons :: proc() {
    using rl

    for i in 0..<MAX_BTNS
        {
            DrawRectangleLinesEx(buttons[i].rec, 4, RED)
            if buttons[i].is_highlighted {
                if buttons[i].is_pressed
                {
                    DrawTexturePro(ant_tex, buttons[i].spr.src, buttons[i].spr.dest, buttons[i].spr.center, 0, GREEN)
                } 
                else {
                    DrawTexturePro(ant_tex, buttons[i].spr.src, buttons[i].spr.dest, buttons[i].spr.center, 0, BLUE)
                }
            } else {
                DrawTexturePro(ant_tex, buttons[i].spr.src, buttons[i].spr.dest, buttons[i].spr.center, 0, MAGENTA)
            }
        }
}
