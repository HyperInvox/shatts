#define init
global.sprPeashooter = sprite_add_weapon("sprites/weapons/sprPeashooter.png", 3, 3);
global.sprPea = sprite_add("sprites/projectiles/sprPea.png", 2, 8, 8);
global.sprPeaPod = sprite_add("sprites/shells/sprPeaPod.png", 1, 8, 8);
global.sprPeaSplat = sprite_add("sprites/projectiles/sprPeaSplat.png", 4, 8, 8);
#define weapon_name
return "PEASHOOTER"
#define weapon_type
return 1
#define weapon_cost
return 1
#define weapon_area
return 2
#define weapon_load
return 4
#define weapon_swap
return sndSwapPistol
#define weapon_auto
return false
#define weapon_melee
return false
#define weapon_laser_sight
return false
#define weapon_sprt
return global.sprPeashooter
#define weapon_text
return choose("LEGUME?","THREE PEAS IN A GUN","PEAS ARE EFFECTIVE WITH RECYCLE GLAND");
#define muzzle_anim
image_index = 1;
image_speed = 0;
#define weapon_fire
if random(100) < 10{ //The chance for it to do three shots
  weapon_post(4, -8, 5);
  sound_play_pitch(sndGrenade,.6);
  sound_play_pitchvol(sndBouncerShotgun,random_range(1.2,1.5),0.8)
  sound_play_pitchvol(sndAssassinGetUp,random_range(0.8,1.5),0.4)
        // create casings
                with instance_create(x, y, Shell){
				motion_add(other.gunangle + (other.right * 90) + random_range(-10, 10), random_range(3,5));
				sprite_index = global.sprPeaPod;
				image_xscale = 1;
		    	image_yscale = 1;
                }
  for(var i = 0; i < 3; i++)
    with(instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2,gunangle), CustomProjectile)){
      damage = 1;
      name = "Pea";
      gland_value = 1;
      sprite_index = global.sprPea;
      mask_index = global.sprPea;
      motion_add(other.gunangle + random_range(-8, 8), random_range(14,18));
      timer = 1;
      team = other.team;
      creator = other;
      image_angle = direction;
      on_anim = muzzle_anim;
      on_wall = pea_pop;
      on_hit = pea_hit;
    }
}
else{ //Basic one shot thing
  weapon_post(4, -8, 5);
  sound_play_pitch(sndGrenade,random_range(.8,1.2));
  sound_play_pitchvol(sndAssassinGetUp,random_range(0.8,1.5),0.4)
  with(instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2,gunangle), CustomProjectile)){
    damage = 1;
    name = "Pea";
    gland_value = 1;
    sprite_index = global.sprPea;
    mask_index = global.sprPea;
    motion_add(other.gunangle + random_range(-8, 8), 16);
    timer = 1;
    team = other.team;
    creator = other;
    image_angle = direction;
    on_anim = muzzle_anim;
    on_wall = pea_pop;
    on_hit = pea_hit;
  }
}
#define pea_pop
with instance_create(x,y,BulletHit) sprite_index = global.sprPeaSplat;
sound_play_pitchvol(sndFreakHurt,random_range(1.2,1.5),1);
instance_destroy();

#define pea_hit
	projectile_hit(other, damage, force, direction)
		if(skill_get(16) && random(5) < 3){
			instance_create(other.x, other.y, RecycleGland);
			sound_play(sndRecGlandProc);
			with(creator) ammo[1] = min(typ_amax[1], ammo[1] + other.gland_value);
		}
		with instance_create(x,y,BulletHit) sprite_index = global.sprPeaSplat;
        sound_play_pitchvol(sndFreakHurt,random_range(1.2,1.5),1);
	instance_destroy();