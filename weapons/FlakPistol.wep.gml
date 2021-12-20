#define init
global.sprFlakPistol = sprite_add_weapon("sprites/weapons/sprFlakPistol.png", 2, 5);
global.sprMiniFlak = sprite_add("sprites/projectiles/sprMiniFlak.png", 2, 8, 8);
#define weapon_name
return "FLAK PISTOL"
#define weapon_type
return 2
#define weapon_cost
return 1
#define weapon_area
return 3
#define weapon_load
return 15
#define weapon_swap
return sndSwapPistol
#define weapon_auto
return false
#define weapon_melee
return false
#define weapon_laser_sight
return false
#define weapon_sprt
return global.sprFlakPistol
#define weapon_text
return choose("ANTI-DRONE WEAPONRY","KICKS BACK LIKE A MULE",);
#define weapon_fire
weapon_post(8, -8, 5);
sound_play_pitch(sndFlakCannon,1.6);
with(instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2,gunangle), CustomProjectile)){
      damage = 4;
      name = "MiniFlak";
      gland_value = 1;
      sprite_index = global.sprMiniFlak;
      image_index = global.sprMiniFlak;
      mask_index = global.sprMiniFlak;
      motion_add(other.gunangle + random_range(-4, 4), random_range(14,18));
      timer = 1;
      team = other.team;
      creator = other;
      image_angle = direction;
      on_draw = bloom;
      on_step = check_funny;
      on_anim = muzzle_anim;
      on_wall = flak_wall;
      on_hit = flak_hit;
      friction = 0.8;
}
#define check_funny
if speed < 10{
    if random(100) < 30{
    instance_create(x,y,Smoke);{
                }
        }
}
if speed <= 0{
    flak_wall();
}
#define muzzle_anim
image_index = 1;
image_speed = 0;
#define flak_wall
sound_play_pitchvol(sndFlakExplode,(random_range(1.2,1.4)),0.8)
repeat(4){
instance_create(x,y,Smoke);{
    motion_add(random_range(-180,180),6)
    }
}
repeat(3){
 with instance_create(x, y, Bullet2){
    motion_add(random_range(-180,180),10)
    team = other.team;
    creator = other;
    }
}
instance_destroy();
#define flak_hit
sound_play_pitchvol(sndFlakExplode,(random_range(1.2,1.4)),0.8)
repeat(4){
instance_create(x,y,Smoke);{
    motion_add(random_range(-180,180),6)
    }
}
    projectile_hit(other, damage, force, direction);
    if(fork()){
        var _x = x, _y = y, _c = creator, _t = creator.team;
        wait 0;
        repeat(3){
            with(instance_create(_x, _y, Bullet2)){
                motion_add(random(360), 10);
                team = _t;
                creator = _c;
            }
        }
        exit;
    }
instance_destroy();
#define bloom
//idk why this doesnt work but it dont! it used to but now it no longer!
with(instances_matching(CustomProjectile, "name","MiniFlak",)){
    draw_self();
    draw_sprite_ext(sprite_index, image_index, x, y, 1.5 * image_xscale, 1.5 * image_yscale, image_angle, image_blend, 0.1 * image_alpha);
                    }
