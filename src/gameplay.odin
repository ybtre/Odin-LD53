package LD_53 

import "core:fmt"

import rl "vendor:raylib"

update_gameplay :: proc() {
    update_cursor()

    if rl.IsKeyPressed(rl.KeyboardKey.P){
        is_paused = !is_paused
    }
    if !is_paused
    {
        gameplay_time_total += rl.GetFrameTime()

        if is_wave_starting{
            if current_wave >= NUM_WAVES
            {
                set_current_screen(SCREENS.MAIN_MENU)
                return
            }
            set_current_wave_dur()
            is_wave_starting = false;
        }

        // if player.p.stats.curr_xp >= i32(player.p.stats.req_xp)
        // {
        //     player.p.stats.curr_xp = 0
        //     //increase req xp player

        //     // randomize upgrade buttons
        //     set_current_screen(SCREENS.UPGRADE)
        // }

        wave_duration -= rl.GetFrameTime()
        if wave_duration < 0 
        {
            current_wave += 1
            is_wave_starting = true
        }

        asteroid_wave_spawner()
        //screen shake

        // player wrap in screen limits?

        //update player

        update_asteroids()

        //player shooting

        // update explosions

        // update bullets

        //update xporbvs

        //collision detection
    }
    else 
    {
        pause_blink_counter += 1
    }
    fmt.println("UPDATEEEE")

}

render_gameplay :: proc(){
    using rl
    
    fmt.println("SPACEEEEEEEEE")

    //add raylib cam2d
    // if !player.p.ent.is_alive
    // {
    //     set_current_screen(SCREENS.GAME_OVER)
    // }
    // else { //------Objects Render------//
            render_background()

			// RenderGameMap(map_grid, game_atlas);
            render_game_map()

			// RenderXPOrbs(xp_orbs, game_atlas);

            render_asteroids()

			// RenderBullets(bullets, ARR_BULLETS, game_atlas);

			// RenderExplosions(explosions, ARR_EXPLOSIONS, game_atlas);

			// RenderPlayer(player, game_atlas);

            render_cursor()
    // }
    
}