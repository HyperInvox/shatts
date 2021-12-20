#define init
global.sprEjectShotgun = sprite_add_weapon("sprites/weapons/sprEjectShotgun.png", 3, 3);
global.sprCoreEject = sprite_add("sprites/projectiles/sprCoreEject.png", 1, 3, 3);
#define weapon_name
return "EJECT SHOTGUN"
#define weapon_type
return 2
#define weapon_cost
return 0
#define weapon_area
return 8
#define weapon_load
return 15
#define weapon_swap
return sndSwapShotgun
#define weapon_auto
return true
#define weapon_melee
return false
#define weapon_laser_sight
return false
#define weapon_chrg  
return true;
#define weapon_sprt
return global.sprEjectShotgun
#define weapon_text
return choose("HOLD TO EJECT","NO PROJECTILE BOOSTING, SORRY.")
#define weapon_fire(_wep)
weapon_post(4, -8, 5);
	var _creator = (
		(instance_is(self, FireCont) && "creator" in self)
		? creator
		: self
	);
	
	 // Setup LWO:
	if(!is_object(_wep)){
		_wep = { "wep" : _wep };
		if("wep" in _creator && _creator.wep == _wep.wep){
			_creator.wep = _wep;
		}
	}
	
	 // 1 Frame Reload:
	var _load = variable_instance_get(_creator, "reloadspeed", 1) * current_time_scale;
	reload += _load - weapon_get_load(_wep);
	
	 // Charge Controller:
	if("cont" not in _wep || !instance_exists(_wep.cont) || _wep.cont.creator != _creator){
		_wep.cont = instance_create(x, y, CustomObject);
		with(_wep.cont){
			creator = _creator;
			wep     = _wep;
			charge  = 0;
			on_step = charge_step;
		}
	}
	with(_wep.cont){
		 // Update Vars:
		gunangle = other.gunangle;
		accuracy = other.accuracy;
		team     = other.team;
		primary  = !(other.race == "steroids" && "specfiring" in other && other.specfiring);
		
		 // Keep Charging:
		charging = true;
		charge += _load;
	}
	
	 // Charging FX:
	weapon_post(-sqrt(_wep.cont.charge), sqrt(_wep.cont.charge), 0);
	
	
#define charge_step
//I HAVE NO 
//FUCKING
//CLUE
//HOW ANY OF THIS WORKS
    if charge = 30 {
        sound_play_pitchvol(sndNadeReload,1.4,0.8)
        sound_play_pitchvol(sndSniperTarget,1.4,1.2)
    }
    
	if(charging){
		charging = false;
	}
	else{
		if(instance_exists(creator)){
			if(variable_instance_get(creator, (primary ? "wep" : "bwep"), wep) == wep){
				 // Update Vars:
				x = creator.x;
				y = creator.y;
				if("gunangle" in creator){
					gunangle = creator.gunangle;
				}
				
				 // Set Reload:
				if(primary){
					if("reload"    in creator) creator.reload   += weapon_get_load(wep);
					if("can_shoot" in creator) creator.can_shoot = false;
				}
				else{
					if("breload"    in creator) creator.breload   += weapon_get_load(wep);
					if("bcan_shoot" in creator) creator.bcan_shoot = false;
				}
                
				 // Projectile:
				if charge < 30 {
				sound_play_pitchvol(sndFireShotgun,1.4,1)
				for(var i = 0; i < 7; i++)
				with(instance_create(x, y, Bullet2)){
                    motion_add(other.gunangle + (random_range(-25, 25) * max(other.accuracy, 0.6)), random_range(14,20));;
					direction   = other.gunangle + (random_range(-8, 8) * other.accuracy);
					image_angle = direction;
					projectile_init(other.team, other.creator);
		        	}
		    	}
		    	else{
		    	sound_play_pitchvol(sndGrenade,1.5,1)
			    with(instance_create(x + lengthdir_x(2, gunangle), y + lengthdir_y(2,gunangle), Grenade)){
			    sprite_index = global.sprCoreEject
			    team = other.team
			    creator = other
		    	motion_add(other.gunangle + random_range(-3, 3) * other.accuracy, 8)
		    	image_angle = direction
			    }
		    }
		}
	}
		instance_destroy();
}
