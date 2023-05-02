package LD_53

import rl "vendor:raylib"

MAX_ANTS :: 30
ants : [MAX_ANTS]Ant
gatherer_ant_tex : rl.Texture2D
gatherer_ants_count : i32

GATHERER_SCALE_MULTI :: 3
GATHERER_PIVOT :: GATHERER_SCALE_MULTI * 2

MAX_ANTS_BUILDER :: 5
builder_ant_tex : rl.Texture2D
builder_ants_count : i32

BUILDER_SCALE_MULTI :: 3
BUILDER_PIVOT :: BUILDER_SCALE_MULTI * 2

MAX_ANTS_SOLDIER :: 5
soldier_ant_tex : rl.Texture2D
soldier_ants_count : i32

SOLDIER_SCALE_MULTI :: 2
SOLDIER_PIVOT :: SOLDIER_SCALE_MULTI * 2

setup_ants :: proc() {
    gatherer_ant_tex = rl.LoadTexture("../raw_photos/gatherer_ant_scaled.png")
    builder_ant_tex = rl.LoadTexture("../raw_photos/builder_ant_scaled.png")
    soldier_ant_tex = rl.LoadTexture("../raw_photos/soldier_ant_scaled.png")

    for i in 0..<MAX_ANTS {
        ants[i].ent.spr.src = {0,0, 160, 160}
        ants[i].ent.spr.dest = { 0, 0, ants[i].ent.spr.src.width/GATHERER_SCALE_MULTI * 1.5, ants[i].ent.spr.src.height/GATHERER_SCALE_MULTI }
        ants[i].ent.spr.center = { ants[i].ent.spr.src.width / GATHERER_PIVOT, ants[i].ent.spr.src.height / GATHERER_PIVOT }

        ants[i].ent.alive = false
        ants[i].ent.rec = {0, 0, ants[i].ent.spr.src.width, ants[i].ent.spr.src.height}
        ants[i].ent.color = rl.WHITE
        ants[i].ent.speed = 2

        ants[i].rot = 0
        ants[i].type = ANT_TYPES.GATHERER
        ants[i].has_resources = false
        ants[i].spawn_point = rl.Vector2{ cathedral.ent.rec.x, cathedral.ent.rec.y }
        ants[i].target = rl.Vector2{liver.ent.rec.x + liver.ent.rec.width, liver.ent.rec.y + liver.ent.rec.height}
        ants[i].detection_radius = 300
        ants[i].hp = 1
        ants[i].dmg = 1
    }
   
}

spawn_ant :: proc(ant: ^Ant, TYPE: ANT_TYPES){
    ant.type = TYPE
    ant.ent.rec = { ant.spawn_point.x, ant.spawn_point.y, ant.ent.spr.src.width/GATHERER_SCALE_MULTI, ant.ent.spr.src.height/GATHERER_SCALE_MULTI} 
    ant.ent.spr.dest = { ant.spawn_point.x + ant.ent.spr.src.width/GATHERER_PIVOT, ant.spawn_point.y  + ant.ent.spr.src.height/GATHERER_PIVOT, ant.ent.spr.src.width/GATHERER_SCALE_MULTI, ant.ent.spr.src.height/GATHERER_SCALE_MULTI }

    if ant.type == .GATHERER
    {
        
    }
    else if ant.type == .BUILDER
    {
        
    }
    else if ant.type == .SOLDIER
    {
        ant.target = rl.Vector2{SCREEN.x /2 - 70, SCREEN.y /2}
    }
}

set_ant_pos :: proc(ant : ^Ant, new_pos : rl.Vector2) {
    ant.ent.rec = { new_pos.x, new_pos.y, ant.ent.spr.src.width/GATHERER_SCALE_MULTI, ant.ent.spr.src.height/GATHERER_SCALE_MULTI} 
    ant.ent.spr.dest = {new_pos.x + ant.ent.spr.src.width/GATHERER_PIVOT, new_pos.y + ant.ent.spr.src.height/GATHERER_PIVOT, ant.ent.spr.src.width/GATHERER_SCALE_MULTI, ant.ent.spr.src.height/GATHERER_SCALE_MULTI }
}

update_ants :: proc() {
    for i in 0..<MAX_ANTS 
    {
        if ants[i].ent.alive
        {
            switch ants[i].type
            {
                case .GATHERER:
                    update_gatherer_ants(i)
                    break
                case .BUILDER:
                    update_builder_ants(i) 
                    break
                case .SOLDIER:
                    update_soldier_ants(i)
                    break
            }
        }
    }
}

update_gatherer_ants :: proc(i: int)
{
    if ants[i].ent.rec.x == ants[i].target.x &&
        ants[i].ent.rec.y == ants[i].target.y
    {
        ants[i].has_resources = true
        ants[i].liver_piece = spawn_liver_piece(&ants[i])
    }   
    
    if ants[i].ent.rec.x == ants[i].spawn_point.x && ants[i].ent.rec.y == ants[i].spawn_point.y
    {
        ants[i].has_resources = false
        if ants[i].liver_piece != nil
        {
            handle_liver_piece_dropoff(liver_pieces_dropoff_point, ants[i].liver_piece)
            ants[i].liver_piece = nil
        }
    }   

    if !ants[i].has_resources
    {
        pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
        pos = vec2_move_towards(pos, ants[i].target, ants[i].ent.speed)

        set_ant_pos(&ants[i], pos)
    }
    else 
    {
        pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
        pos = vec2_move_towards(pos, ants[i].spawn_point, ants[i].ent.speed)

        set_ant_pos(&ants[i], pos)

        set_liver_piece_pos_to_ant(&ants[i], ants[i].liver_piece)
    }
}

update_builder_ants :: proc(i: int)
{
    if !ants[i].has_resources
    { 
        if ants[i].liver_piece != nil
        {
            pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
            pos = vec2_move_towards(pos, rl.Vector2{ants[i].liver_piece.rec.x, ants[i].liver_piece.rec.y}, ants[i].ent.speed)

            set_ant_pos(&ants[i], pos)
        } else 
        {
            // fmt.println(len(liver_pieces_for_building))
            if len(liver_pieces_for_building) > 0 && liver_pieces_count > 0
            {

                last_piece := pop(&liver_pieces_for_building)
                liver_pieces_count -= 1
                ants[i].liver_piece = last_piece
            }

            pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
            pos = vec2_move_towards(pos, rl.Vector2{1000, 650}, ants[i].ent.speed)

            set_ant_pos(&ants[i], pos)
        }
    } else 
    {
        pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
        pos = vec2_move_towards(pos, rl.Vector2{1200, 650}, ants[i].ent.speed)

        set_ant_pos(&ants[i], pos)
        set_liver_piece_pos_to_ant(&ants[i], ants[i].liver_piece)
    }

    if ants[i].liver_piece != nil &&
    ants[i].ent.rec.x == ants[i].liver_piece.rec.x &&
    ants[i].ent.rec.y == ants[i].liver_piece.rec.y  
    {
        ants[i].has_resources = true
    }   
    if ants[i].ent.rec.x == 1200 &&
    ants[i].ent.rec.y == 650
    {
        ants[i].has_resources = false
        ants[i].liver_piece.alive = false
        ants[i].liver_piece = nil
        cathedral.build_progress += 1
    } 
}

update_soldier_ants :: proc(i: int)
{
    if ants[i].ent.rec.x != ants[i].target.x && ants[i].ent.rec.y != ants[i].target.y
    {
        pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
        pos = vec2_move_towards(pos, ants[i].target, ants[i].ent.speed)

        set_ant_pos(&ants[i], pos)
    }
}

render_ants :: proc() {
    using rl

    for i in 0..<MAX_ANTS
    {
        if ants[i].ent.alive
        {
            switch ants[i].type
            {
                case .GATHERER:
                    DrawRectangleLinesEx(ants[i].ent.rec, 4, GREEN)
                    DrawTexturePro(
                        gatherer_ant_tex, 
                        ants[i].ent.spr.src, 
                        ants[i].ent.spr.dest, 
                        ants[i].ent.spr.center,
                        // ants[i].rot,
                        f32(GetTime()) * 90,
                        ants[i].ent.color)
                    break
                case .BUILDER:
                    DrawRectangleLinesEx(ants[i].ent.rec, 4, GREEN)
                    DrawTexturePro(
                        builder_ant_tex, 
                        ants[i].ent.spr.src, 
                        ants[i].ent.spr.dest, 
                        ants[i].ent.spr.center,
                        // ants[i].rot,
                        f32(GetTime()) * 45,
                        ants[i].ent.color)
                    break
                case .SOLDIER:
                    DrawCircleV(Vector2{ants[i].ent.rec.x + ants[i].ent.spr.src.width/SOLDIER_PIVOT, ants[i].ent.rec.y + ants[i].ent.spr.src.width/SOLDIER_PIVOT}, f32(ants[i].detection_radius), RED)
                    DrawRectangleLinesEx(ants[i].ent.rec, 4, GREEN)
                    DrawTexturePro(
                        soldier_ant_tex, 
                        ants[i].ent.spr.src, 
                        ants[i].ent.spr.dest, 
                        ants[i].ent.spr.center,
                        // ants[i].rot,
                        f32(GetTime()) * 135,
                        ants[i].ent.color)
                    break
            }
        }

    }
}
