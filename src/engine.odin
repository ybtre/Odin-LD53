package LD_53 

import rl "vendor:raylib"

game_atlas : rl.Texture2D

initialize_engine :: proc(){
    // game_atlas = rl.LoadTexture("../assets/game_atlas_8x8.png")

    startup_game_overlord()
    setup_game()

    setup_background()

    setup_cathedral()
    set_cathedral_pos(rl.Vector2{1050, 550})

    setup_liver()
    set_liver_pos(rl.Vector2{250, 150})

    setup_ants()

    setup_buttons()
    set_btn_pos(&buttons[0], rl.Vector2{ 400, 700})
    set_btn_pos(&buttons[1], rl.Vector2{ 600, 700})
    set_btn_pos(&buttons[2], rl.Vector2{ 800, 700})
}

update_engine :: proc(){
    switch current_screen {
        case .MAIN_MENU:
            update_main_menu()
            break
        case .GAMEPLAY:
            update_gameplay()
            break
        case .GAME_OVER:
            break
    }
}

render_engine :: proc(){
    rl.BeginDrawing()
    rl.ClearBackground(rl.BLACK)

    {// RENDER
        switch current_screen {
            case .MAIN_MENU:
                render_main_menu()
                break
            case .GAMEPLAY:
                render_gameplay()
                break
            case .GAME_OVER:
                break
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