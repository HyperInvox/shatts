#define init
global.sprBigDamnAxe = sprite_add_weapon("sprites/weapons/sprBigDamnAxe.png", 4, 8);
global.sprBigDamnSwing = sprite_add("sprites/projectiles/sprBigDamnSwing.png", 3, 8, 32)
#define weapon_name
return "BIG DAMN AXE"
#define weapon_type
return 0
#define weapon_cost
return 0
#define weapon_area
return 10
#define weapon_load
return 100
#define weapon_swap
return sndBloodHammer
#define weapon_auto
return false
#define weapon_melee
return true
#define weapon_laser_sight
return false
#define weapon_sprt
return global.sprBigDamnAxe
#define weapon_text
return choose("DANK SPIRITS", "OOOOHHH NUCLEAR THRONE...")
#define weapon_fire
sound_play_pitchvol(sndStatueHurt,0.8,1.0)
sound_play_pitchvol(sndBanditHit,1.2,0.8)
weapon_post(-12,0,0)
wait(10)
if (wep == mod_current){ //thank you cilian for letting me know about mod_current
weapon_post(7,0,42)
wepangle = -wepangle
sound_play_pitchvol(sndHammer,0.8,1.2)
var theangle = gunangle + random_range(-10, 10) * accuracy
motion_add(theangle, 5)
	with instance_create(x, y, CustomSlash){
	    name = "BigDamnSlash"
		motion_add(other.gunangle, 3 + (skill_get(13) * 3))
		image_speed = 0.3
		image_angle = direction
		creator = other
		team = other.team
		sprite_index = global.sprBigDamnSwing
		mask_index = global.sprBigDamnSwing
		candeflect = 1
		damage = 30
		force = 40
		on_hit = BigDamnHit
	}
}
else{ exit;}
#define BigDamnHit
//  On January 14th, 2022, at aprox. 11:40 PM. Discord user "Tildebee" called me "Neurodivergent" in DMs while talking to them about how
//  I feel like a living doomsday prophecy to most artistic/development projects I join. I needed more than an hour of processing
//	and introspection to recover myself from that. It completely took me kind of off-guard and I still cannot 
//  comprehend the full scale of what that means in terms of other's perception of me. 
//  In short, you could say that was a "BigDamnHit" to my psyche. 
if (!projectile_canhit_melee(other)) exit
projectile_hit(other, damage, force, direction);

#define weapon_reloaded(_primary) //just need to figure out how to play the flip noise after swing but it's not a huge deal tbh
  var _wep = (_primary ? wep : bwep);

sound_play(sndMeleeFlip);
    if(_primary){
    wepflip = -sign(wepangle)
}
else{
    bwepflip = -sign(bwepangle)
}
//thank you spaz for this lovely lovely code thank you thank you