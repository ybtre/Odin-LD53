package LD_53

import "core:fmt"

import rl "vendor:raylib"

update_main_menu :: proc() {
    update_cursor()

    if rl.IsKeyPressed(rl.KeyboardKey.SPACE)
    {
        set_current_screen(SCREENS.GAMEPLAY)
    }
}

render_main_menu :: proc(){
    using rl

    render_background()

    DrawText("ASTEOIDS", i32(SCREEN.x / 2 - 175), i32(SCREEN.y / 2 - 60), 60, C_TEXT)
    DrawText("PRESS SPACE TO PLAY", i32(SCREEN.x / 2 - 250), i32(SCREEN.y / 2), 40, C_TEXT)

    render_cursor()
}