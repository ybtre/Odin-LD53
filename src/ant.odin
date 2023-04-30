package LD_53

import rl "vendor:raylib"

MAX_ANTS :: 10
ants : [MAX_ANTS]Ant
ant_tex : rl.Texture2D

ANT_SCALE_MULTI :: 2
ANT_SCALE_PIVOT :: 8

setup_ants :: proc() {
    for i in 0..<MAX_ANTS {
        ant_tex = rl.LoadTexture("../raw_photos/ant_small.png")

        ants[i].ent.spr.src = {0,0, 160, 160}
        ants[i].ent.spr.dest = { 0, 0, ants[i].ent.spr.src.width/ANT_SCALE_MULTI * 1.5, ants[i].ent.spr.src.height/ANT_SCALE_MULTI }
        ants[i].ent.spr.center = { ants[i].ent.spr.src.width / ANT_SCALE_PIVOT, ants[i].ent.spr.src.height / ANT_SCALE_PIVOT }

        ants[i].ent.alive = false
        ants[i].ent.rec = {0, 0, ants[i].ent.spr.src.width, ants[i].ent.spr.src.height}
        ants[i].ent.color = rl.WHITE
        ants[i].ent.speed = 2

        ants[i].rot = 0
        ants[i].type = ANT_TYPES.GATHERER
        ants[i].has_resources = false
        ants[i].spawn_point = rl.Vector2{ cathedral.ent.rec.x, cathedral.ent.rec.y }
        ants[i].target = rl.Vector2{liver.ent.rec.x + liver.ent.rec.width, liver.ent.rec.y + liver.ent.rec.height}
        ants[i].detection_radius = 15
        ants[i].hp = 1
        ants[i].dmg = 1
    }
}

spawn_ant :: proc(ant: ^Ant){
    ant.ent.rec = { ant.spawn_point.x, ant.spawn_point.y, ant.ent.spr.src.width/ANT_SCALE_MULTI, ant.ent.spr.src.height/ANT_SCALE_MULTI} 
    ant.ent.spr.dest = { ant.spawn_point.x, ant.spawn_point.y, ant.ent.spr.src.width/ANT_SCALE_MULTI, ant.ent.spr.src.height/ANT_SCALE_MULTI }
}

set_ant_pos :: proc(ant : ^Ant, new_pos : rl.Vector2) {
    ant.ent.rec = { new_pos.x, new_pos.y, ant.ent.spr.src.width/ANT_SCALE_MULTI, ant.ent.spr.src.height/ANT_SCALE_MULTI} 
    ant.ent.spr.dest = {new_pos.x + ant.ent.spr.src.width/ANT_SCALE_PIVOT, new_pos.y + ant.ent.spr.src.height/ANT_SCALE_PIVOT, ant.ent.spr.src.width/ANT_SCALE_MULTI, ant.ent.spr.src.height/ANT_SCALE_MULTI }
}

update_ants :: proc() {
    for i in 0..<MAX_ANTS 
    {
        if ants[i].ent.alive
        {
            switch ants[i].type
            {
                case .GATHERER:
                    if ants[i].ent.rec.x == ants[i].target.x &&
                        ants[i].ent.rec.y == ants[i].target.y
                    {
                        ants[i].has_resources = true
                    }   
                    if ants[i].ent.rec.x == ants[i].spawn_point.x &&
                        ants[i].ent.rec.y == ants[i].spawn_point.y
                    {
                        ants[i].has_resources = false
                    }   
                    if !ants[i].has_resources
                    {
                        pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
                        pos = vec2_move_towards(pos, ants[i].target, ants[i].ent.speed)
                    
                        set_ant_pos(&ants[i], pos)
                    } else 
                    {
                        pos := rl.Vector2{ants[i].ent.rec.x, ants[i].ent.rec.y}
                        pos = vec2_move_towards(pos, ants[i].spawn_point, ants[i].ent.speed)
                    
                        set_ant_pos(&ants[i], pos)
                    }
                    break
                case .BUILDER:
                    break
                case .SOLDIER:
                    break
            }
            
        }
    }
}

render_ants :: proc() {
    using rl

    for i in 0..<MAX_ANTS
    {
        if ants[i].ent.alive
        {
            DrawRectangleLinesEx(ants[i].ent.rec, 4, GREEN)
            DrawTexturePro(
                ant_tex, 
                ants[i].ent.spr.src, 
                ants[i].ent.spr.dest, 
                ants[i].ent.spr.center,
                ants[i].rot,
                // f32(GetTime()) * 90,
                ants[i].ent.color)
        }
    }
}
