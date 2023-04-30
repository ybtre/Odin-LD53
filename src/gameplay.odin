package LD_53 

import rl "vendor:raylib"

spawn_timer : f32 = 0

update_gameplay :: proc() {
    using rl

    spawn_timer += rl.GetFrameTime()

    if rl.IsKeyPressed(rl.KeyboardKey.P){
        is_paused = !is_paused
    }

    if !is_paused
    {
        gameplay_time_total += rl.GetFrameTime()

        update_buttons()

        
        if buttons[0].is_pressed 
        {
            for i in 0..<MAX_ANTS 
            {
                if !ants[i].ent.alive
                {
                    ants[i].ent.alive = true
                    spawn_ant(&ants[i], ANT_TYPES.GATHERER)
                    break
                }
            }
        }
        if buttons[1].is_pressed 
        {
            for i in 0..<MAX_ANTS 
            {
                if !ants[i].ent.alive
                {
                    ants[i].ent.alive = true
                    spawn_ant(&ants[i], ANT_TYPES.BUILDER)
                    break
                }
            }
        }
       
    
        update_ants()
    }
    else 
    {
        pause_blink_counter += 1
    }
}

render_gameplay :: proc(){
    using rl
    
    render_cathedral()
    render_liver()
    render_ants()
    render_liver_pieces()
   
    if is_paused && ((pause_blink_counter / 30) % 2 == 0)
    {
		rl.DrawText("GAME PAUSED", i32(SCREEN.x / 2 - 290), i32(SCREEN.y / 2 - 50), 80, rl.RED)
	} 

    {// UI
       render_buttons()

    //    DrawText(TextFormat("Liver Pieces: %d", liver_pieces_count), 690, 770, 20, BLUE)
    }
}