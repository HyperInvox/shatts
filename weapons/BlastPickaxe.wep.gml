#define init
global.sprBlastPickaxe = (sprite_add_weapon("sprites/weapons/sprBlastPickaxe.png", 5, 10));
global.sprExploSwing = sprite_add("sprites/projectiles/sprKablooeySwooshy.png", 7, 8, 24) //thank you fumi for this beautiful beautiful sprite mwah mwah
#define weapon_name
return "BLAST PICKAXE"
#define weapon_type
return 4
#define weapon_cost
return 3
#define weapon_area
return 8
#define weapon_load
return 20
#define weapon_swap
return sndSwapHammer
#define weapon_auto
return false
#define weapon_melee
return true
#define weapon_laser_sight
return false
#define weapon_sprt
return global.sprBlastPickaxe
#define weapon_text
return choose("KAHBEWM", "DIG TO YOUR HEARTS CONTENT")
#define weapon_fire
sound_play_pitchvol(sndHammer,0.8,1.2)
sound_play_pitchvol(sndExplosion,1,1,)
weapon_post(7,0,42)
wepangle = -wepangle
	with instance_create(x, y, CustomSlash){
	    sprite_index = global.sprExploSwing
	    motion_add(other.gunangle, 3 + (skill_get(13) * 3))
	    name = "Boomslash"
	    image_angle = direction
	    image_speed = 0.6
	    creator = other
	    team = other.team
	    on_draw = bloom
	    on_hit = pickhit
	    on_wall = bustit
	    damage = 15
	    candeflect = 1
	    is_explosion = true
	    ammo_type = 4
	}
#define pickhit
if (!projectile_canhit_melee(other)) exit
projectile_hit(other, damage, force, direction);

#define bustit
with other{instance_create(x,y,FloorExplo);instance_destroy(){
    }
}
#define bloom
with(instances_matching(CustomProjectile, "name","Boomslash",)){
    draw_self();
    draw_sprite_ext(sprite_index, image_index, x, y, 1.5 * image_xscale, 1.5 * image_yscale, image_angle, image_blend, 0.1 * image_alpha);
                    }
