package LD_53

import rl "vendor:raylib"

score := 0

current_screen : SCREENS

is_paused := false
pause_blink_counter := 0

gameplay_time_total : f32 = 0.0
gameplay_time_current := 0.0

score_src : rl.Rectangle
score_dest : rl.Rectangle

Wave :: struct {
    level: i32,
    duration: f32,
    enemy_spawn_interval: f32,
}

SCREENS :: enum {
    MAIN_MENU,
    GAMEPLAY,
    GAME_OVER,
}
