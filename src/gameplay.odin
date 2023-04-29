package LD_53 

import rl "vendor:raylib"

update_gameplay :: proc() {
    if rl.IsKeyPressed(rl.KeyboardKey.P){
        is_paused = !is_paused
    }
    if !is_paused
    {
        gameplay_time_total += rl.GetFrameTime()

    }
    else 
    {
        pause_blink_counter += 1
    }
}

render_gameplay :: proc(){
    using rl
    
    // if !player.p.ent.is_alive
    // {
    //     set_current_screen(SCREENS.GAME_OVER)
    // }
    // else { //------Objects Render------//
            render_background()
    // }
    
}