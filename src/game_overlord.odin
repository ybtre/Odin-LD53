package LD_53 


startup_game_overlord :: proc(){
    current_screen = SCREENS.MAIN_MENU
    is_paused = false
}

setup_game :: proc() {
}

reset_game :: proc(){

    is_paused = false
}