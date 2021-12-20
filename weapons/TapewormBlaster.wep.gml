#define init
global.sprTapewormBlaster = sprite_add_weapon("sprites/weapons/sprTapewormBlaster.png", 8, 8);
global.sprTapewormHead = sprite_add("sprites/projectiles/sprTapewormHead.png", 1,8,8,)
global.sprTapewormBody = sprite_add("sprites/projectiles/sprTapewormBody.png", 1,8,8,)
global.sprTapewormTail = sprite_add("sprites/projectiles/sprTapewormTail.png", 1,8,8,)
global.sprSplorch = sprite_add("sprites/projectiles/sprTapewormSplorch.png", 4, 8, 8);
#define weapon_name
return "TAPEWORM BLASTER"
#define weapon_type
return 1
#define weapon_cost
return 5
#define weapon_area
return 9
#define weapon_load
return 20
#define weapon_swap
return sndFreakMelee
#define weapon_auto
return truther
#define weapon_melee
return false
#define weapon_laser_sight
return false
#define weapon_sprt
return global.sprTapewormBlaster
#define weapon_text
return choose("OH GOD THIS IS PUTRID","ITS SQUIRMING IN YOUR HANDS EW","CRUEL BIRTH")
#define weapon_fire()

////////////////////////////////////////////////////////////////////
//                     ABANDON ALL HOPE                           //  
//                    YE WHO  ENTER HERE                          //    
//    You tread on the grounds of dogshit pissbitch indenting!    //    
//      This is not a place of honor, you have been warned!       //
////////////////////////////////////////////////////////////////////

weapon_post(4, -8, 5);
sound_play_pitchvol(sndFrogGasRelease, random_range(0.9,1.2),0.5)
sound_play_pitchvol(sndBloodHammer, random_range(0.9,1.2),1)
repeat(3){
with(instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2,gunangle),AllyDamage)){
         }
}
    var lastGuy = noone;
    for(var i = 0; i <= 2; i++) {
        if(i=0){ //gives me HEAD
        with create_funny_projectile(x, y) {
            motion_set(other.gunangle, 10)
            projectile_init(other.team, instance_is(other, FireCont) && "creator" in other ? other.creator : other)
            image_angle = direction
            
            leader = lastGuy
            lastGuy = self
            }
        }
else{ //Shoots this bad baby THREE times!!
        if(i=1)
        repeat(3){
            with create_funnier_projectile(x, y) {
                motion_set(other.gunangle, 10)
                projectile_init(other.team, instance_is(other, FireCont) && "creator" in other ? other.creator : other)
                image_angle = direction
                
                leader = lastGuy
                lastGuy = self
                }
            }
else{ //Shoots this bad baby ONCE (LOOK AT THIS THIS DOESNT WORK)
    if(i=2)
        with create_funniest_projectile(x, y) {
            motion_set(other.gunangle, 10)
            projectile_init(other.team, instance_is(other, FireCont) && "creator" in other ? other.creator : other)
            image_angle = direction
            
            leader = lastGuy
            lastGuy = self
            }
        }
    }
}
#define create_funny_projectile(x, y)
    with instance_create(x, y, CustomProjectile) {
        name = "TapewormHead"
        on_step = funny_step
        sprite_index = global.sprTapewormHead
        damage = 10
        leader = noone
        wasFollowing = false
        funnySpeed = 0
        direction = other.gunangle;
        direction_orig = direction;
        seq = 0;
        team = 2;//other.team;
        team_orig = team;
        on_wall = splorch;
        on_hit = splorchtwo;
        speed = 6;
        if(fork()){
            var _spread = 20;
            while instance_exists(self){
                if team != team_orig exit; // Swiped by enemy or something, terminate and make normal
                seq += current_time_scale;
                direction = direction_orig + ((_spread * sin(((current_frame + seq) / 2)))); // Bigger divider = wavier wave
                image_angle = direction;
                wait 0;
            }
            exit;
        }
        return self
    }
#define create_funnier_projectile(x, y)
    with instance_create(x, y, CustomProjectile) {
        name = "TapewormBody"
        on_step = funny_step
        sprite_index = global.sprTapewormBody
        damage = 5
        leader = noone
        wasFollowing = false
        funnySpeed = 0
        direction = other.gunangle;
        direction_orig = direction;
        seq = 0;
        team = 2;//other.team;
        team_orig = team;
        on_wall = splorch;
        on_hit = splorchtwo;
        speed = 6;
        if(fork()){
            var _spread = 20;
            while instance_exists(self){
                if team != team_orig exit; // Swiped by enemy or something, terminate and make normal
                seq += current_time_scale;
                direction = direction_orig + ((_spread * sin(((current_frame + seq) / 2)))); // Bigger divider = wavier wave
                image_angle = direction;
                wait 0;
            }
            exit;
        }
        return self
    }
#define create_funniest_projectile(x, y)
    with instance_create(x, y, CustomProjectile) {
        name = "TapewormTail"
        on_step = funny_step
        sprite_index = global.sprTapewormTail
        damage = 2
        leader = noone
        wasFollowing = false
        funnySpeed = 0
        direction = other.gunangle;
        direction_orig = direction;
        seq = 0;
        team = 2;//other.team;
        team_orig = team;
        on_wall = splorch;
        on_hit = splorchtwo;
        speed = 6;
        if(fork()){
            var _spread = 20;
            while instance_exists(self){
                if team != team_orig exit; // Swiped by enemy or something, terminate and make normal
                seq += current_time_scale;
                direction = direction_orig + ((_spread * sin(((current_frame + seq) / 2)))); // Bigger divider = wavier wave
                image_angle = direction;
                wait 0;
            }
            exit;
        }
        return self
    }
#define funny_step
    
    //If following
    if instance_exists(leader) {
        if !(wasFollowing) {
            wasFollowing = true
            //Store speed when it starts following, ensures they stay put and dont slide weirdly
            funnySpeed = speed
            speed = 0
        }
        
        //Follow
        x = leader.xprevious
        y = leader.yprevious
    }
    //If leading
    else {
        if (wasFollowing) {
            wasFollowing = false
            //Restore speed so it can continue to lead
            speed = funnySpeed
        }
        
    }

#macro truther true + 1

#define splorch
with instance_create(x,y,Dust){
    motion_add(random_range(-180,180),3)
}
with instance_create(x,y,BulletHit) sprite_index = global.sprSplorch;
sound_play_pitchvol(sndCocoonBreak,random_range(1.2,1.5),1);
instance_destroy();
#define splorchtwo
	projectile_hit(other, damage, force, direction)
	sound_play_pitchvol(sndCocoonBreak,random_range(1.2,1.5),1);
	with instance_create(x,y,BloodStreak)
	image_xscale = 1;
	image_yscale = random_range(1,1.2);
	with instance_create(x,y,BulletHit) sprite_index = global.sprSplorch;
	instance_destroy();
#define step(_primary)
	var _wep = (_primary ? wep : bwep);
	
	 // Blood for Ammo:
	if(infammo == 0){
		if(
			_primary
			? (drawempty  == 30 && canfire && button_pressed(index, "fire"))
			: (drawemptyb == 30 && canspec && button_pressed(index, "spec") && race == "steroids")
		){
			var _type = weapon_get_type(_wep),
			    _cost = weapon_get_cost(_wep);
			    
			if(ammo[_type] < _cost){
				ammo[_type] += _cost;
				
				 // Damage:
				var _damage = floor(sqrt(_cost));
				lasthit = [weapon_get_sprt(_wep), weapon_get_name(_wep)];
				projectile_hit_raw(self, _damage, 1);
				sound_play_hit(sndBloodHurt, 0.1);
				sleep(40);
				
				 // Insta-Use Ammo:
				if(_primary && can_shoot == true){
					clicked = true;
				}
			}
		}
	}

//fucking wack ass shit man im gonna use a slur
