package LD_53 

import rl "vendor:raylib"

startup_game_overlord :: proc(){
    current_screen = SCREENS.MAIN_MENU
    score = 0
    is_paused = false
}

setup_game :: proc() {
    score = 0

    live_src = { 32, 0, SPRITE_SIZE, SPRITE_SIZE }
    live_dest = { 10, 40, live_src.width * SPRITE_SCALE_MULTI, live_src.height * SPRITE_SCALE_MULTI }

    score_src = { SPRITE_SIZE_SCALED, 0, SPRITE_SIZE, SPRITE_SIZE }
    score_dest = { 10, 100, score_src.width * SPRITE_SCALE_MULTI, score_src.height * SPRITE_SCALE_MULTI }
}

reset_game :: proc(){
    score = 0

    is_paused = false;
}

get_current_wave_data :: proc() -> Wave {
    return waves[current_wave]
}

set_current_wave_dur :: proc(){
    wave_duration = waves[current_wave].duration
}

get_current_screen :: proc() -> SCREENS {
    return current_screen
}

set_current_screen :: proc(new_screen : SCREENS) {
    current_screen = new_screen
}

is_game_over :: proc() -> bool {
    return false
}
