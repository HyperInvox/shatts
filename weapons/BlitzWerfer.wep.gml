#define init
global.sprBlitzwerfer = (sprite_add_weapon("sprites/weapons/sprBlitzwerfer.png", 4, 6));
#define weapon_name
return "BLITZWERFER"
#define weapon_type
return 5
#define weapon_cost
return 1
#define weapon_area
return 10
#define weapon_load
return 6
#define weapon_swap
return sndSwapEnergy
#define weapon_auto
return true
#define weapon_melee
return false
#define weapon_laser_sight
return false
#define weapon_sprt
return global.sprBlitzwerfer
#define weapon_text
return choose("KZRRRRT", "LIGHT SHOW",);
#define weapon_fire
repeat(3){
sound_play_pitch(sndLightningPistol,random_range(1,1.2,));
  sound_play_pitchvol(sndEnergyScrewdriver,random_range(0.8,1.5),0.4)
  weapon_post(4, -8, 20);
    with(instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2,gunangle),Lightning)) {
        motion_add(other.gunangle + random_range(-16, 16), 16);
        image_angle = direction;
        team = other.team
        ammo = 4 + irandom(2) + 2*skill_get(mut_laser_brain)
        alarm0 = 1
        wait(3)
    }
}
