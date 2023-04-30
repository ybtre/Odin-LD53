package LD_53

import rl "vendor:raylib"

liver : Liver
liver_tex : rl.Texture2D

MAX_PIECES :: MAX_ANTS
liver_pieces : []Entity
liver_piece_tex : rl.Texture2D

setup_liver :: proc() {
    liver_tex = rl.LoadTexture("../assets/liver_temp.png")
    liver_piece_tex = rl.LoadTexture("../assets/liver_piece.png")

    liver.ent.spr.src = {0,0, 320, 160}
    liver.ent.spr.dest = { 0, 0, liver.ent.spr.src.width, liver.ent.spr.src.height }
    liver.ent.spr.center = { liver.ent.spr.src.width / 2.0, liver.ent.spr.src.height / 2.0 }

    liver.ent.alive = true
    liver.ent.rec = {0, 0, liver.ent.spr.src.width, liver.ent.spr.src.height}
    liver.ent.color = rl.WHITE
    liver.ent.speed = 0
   
    liver.rot = 0
    liver.de_livering_progress = 0
    liver.de_livering_stage = 0

    liver.hp = 0
}

set_liver_pos :: proc(new_pos : rl.Vector2) {
    liver.ent.rec = { new_pos.x - liver.ent.spr.src.width /2, new_pos.y - liver.ent.spr.src.height /2, liver.ent.spr.src.width, liver.ent.spr.src.height} 
    liver.ent.spr.dest = {new_pos.x, new_pos.y, liver.ent.spr.src.width, liver.ent.spr.src.height }
}

render_liver :: proc() {
    rl.DrawRectangleLinesEx(liver.ent.rec, 4, rl.BLUE)
    rl.DrawTexturePro(
        liver_tex, 
        liver.ent.spr.src, 
        liver.ent.spr.dest, 
        liver.ent.spr.center,
        liver.rot,
        liver.ent.color)
}

spawn_liver_piece :: proc(ant : ^Ant) {
    for i in 0..<MAX_PIECES
    {
        if !liver_pieces[i].alive
        {
            liver_pieces[i].spr.src = {0,0, 160, 160}
            liver_pieces[i].spr.dest = { 0, 0, liver.ent.spr.src.width, liver.ent.spr.src.height }
            liver_pieces[i].spr.center = { liver.ent.spr.src.width / 2.0, liver.ent.spr.src.height / 2.0 }
            
            liver_pieces[i].alive = true
            liver_pieces[i].rec = {0, 0, liver.ent.spr.src.width, liver.ent.spr.src.height}
            liver_pieces[i].color = rl.WHITE
            liver_pieces[i].speed = 0

            break
        }
    }
}