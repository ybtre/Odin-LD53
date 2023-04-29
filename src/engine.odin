package LD_53 

import rl "vendor:raylib"

game_atlas : rl.Texture2D

initialize_engine :: proc(){
    game_atlas = rl.LoadTexture("../assets/game_atlas_8x8.png")

    startup_game_overlord()
    setup_game()

    setup_game_map()
    setup_background()
    setup_cursor()
}

update_engine :: proc(){
    switch get_current_screen() {
        case SCREENS.MAIN_MENU:
            update_main_menu()
            break;
        case SCREENS.GAMEPLAY:
            update_gameplay()
            break;
        case SCREENS.GAME_OVER:
            break;
        case SCREENS.UPGRADE:
            break;
    }
    update_cursor()
}

render_engine :: proc(){
    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    {// RENDER
        switch get_current_screen() {
            case SCREENS.MAIN_MENU:
                render_main_menu()
                break;
            case SCREENS.GAMEPLAY:
                render_gameplay()
                break;
            case SCREENS.GAME_OVER:
                break;
            case SCREENS.UPGRADE:
                break;
        }
        // background.render()
        // game_map.render(game_atlas)
        // cursor.render()
    }
    rl.DrawFPS(0, 0)

    rl.EndDrawing()
}

shutdown_engine :: proc(){
    rl.UnloadTexture(game_atlas)
}