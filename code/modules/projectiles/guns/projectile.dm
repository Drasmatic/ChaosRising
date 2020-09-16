/obj/item/weapon/gun/projectile
	name = "gun"
	desc = "A gun that fires bullets."
	icon_state = "musket"
	w_class = 3

	var/caliber = "musketball"		//determines which casings will fit
	var/handle_casings = EJECT_CASINGS	//determines how spent casings should be handled
	var/load_method = SINGLE_CASING|SPEEDLOADER //1 = Single shells, 2 = box or quick loader, 3 = magazine
	var/obj/item/ammo_casing/chambered = null

	//gunporn stuff
	var/unload_sound 	= 'sound/weapons/guns/interact/pistol_magout.ogg'
	var/reload_sound 	= 'sound/weapons/guns/interact/pistol_magin.ogg'
	var/cocked_sound 	= 'sound/weapons/guns/interact/pistol_cock.ogg'
	var/bulletinsert_sound 	= 'sound/weapons/guns/interact/bullet_insert.ogg'

	//For SINGLE_CASING or SPEEDLOADER guns
	var/max_shells = FALSE			//the number of casings that will fit inside
	var/ammo_type = null		//the type of ammo that the gun comes preloaded with
	var/list/loaded = list()	//stored ammo

	//For MAGAZINE guns
	var/magazine_type = null	//the type of magazine that the gun comes preloaded with
	var/list/bad_magazine_types = list() // list of magazine types that we can't use
	var/obj/item/ammo_magazine/ammo_magazine = null //stored magazine
	var/auto_eject = FALSE			//if the magazine should automatically eject itself when empty.
	var/auto_eject_sound = null
	var/ammo_mag = "default" // magazines + gun itself. if set to default, then not used
	//TODO generalize ammo icon states for guns
	//var/magazine_states = FALSE
	//var/list/icon_keys = list()		//keys
	//var/list/ammo_states = list()	//values
	var/magazine_based = TRUE
	attachment_slots = ATTACH_SILENCER|ATTACH_IRONSIGHTS

	var/load_shell_sound = 'sound/weapons/empty.ogg'

	var/executing = FALSE

	var/infinite_ammo = FALSE

	var/serial = ""
/obj/item/weapon/gun/projectile/New()
	serial = "[pick(alphabet_uppercase)][pick(alphabet_uppercase)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
	..()
	if (map && map.civilizations)
		loaded = list()
		chambered = null
	else if (!(istype(loc, /mob/living)))
		loaded = list()
		chambered = null
	else
		if (ispath(ammo_type) && (load_method & (SINGLE_CASING|SPEEDLOADER)))
			for (var/i in TRUE to max_shells)
				loaded += new ammo_type(src)
		if (ispath(magazine_type) && (load_method & MAGAZINE))
			ammo_magazine = new magazine_type(src)

	update_icon()

	var/obj/item/weapon/attachment/A = new /obj/item/weapon/attachment/scope/iron_sights(src)
	spawn_add_attachment(A, src)

/obj/item/weapon/gun/projectile/proc/cock_gun(mob/user)
	set waitfor = FALSE
	if (cocked_sound)
		sleep(3)
		if (user && loc) playsound(loc, cocked_sound, 75, TRUE)


/obj/item/weapon/gun/projectile/proc/has_next_projectile()

	// get the next casing
	if (loaded.len)
		return TRUE

	// get the ammo mag's next casing
	else if (ammo_magazine && ammo_magazine.stored_ammo.len)
		return TRUE

	return FALSE


/obj/item/weapon/gun/projectile/consume_next_projectile(var/check = FALSE)
	//get the next casing
	if (loaded.len)
		chambered = loaded[1] //load next casing.
		if (handle_casings != HOLD_CASINGS)
			loaded -= chambered
			if (infinite_ammo)
				loaded += new chambered.type

	else if (ammo_magazine && ammo_magazine.stored_ammo.len)
		chambered = ammo_magazine.stored_ammo[1]
		if (handle_casings != HOLD_CASINGS)
			ammo_magazine.stored_ammo -= chambered
			if (infinite_ammo)
				ammo_magazine.stored_ammo += new chambered.type

	if (chambered)
		if (gibs)
			chambered.BB.gibs = TRUE
		if (crushes)
			chambered.BB.crushes = TRUE
		return chambered.BB
	return null

/obj/item/weapon/gun/projectile/handle_post_fire(mob/user)
	..()
	if (chambered)
		chambered.expend()
		process_chambered()

/obj/item/weapon/gun/projectile/handle_click_empty()
	..()
	process_chambered()

/obj/item/weapon/gun/projectile/proc/process_chambered()
	if (!chambered) return

	// Aurora forensics port, gunpowder residue.
	if (chambered.leaves_residue)
		var/mob/living/human/H = loc
		if (istype(H))
			if (!H.gloves)
				H.gunshot_residue = chambered.caliber
			else
				var/obj/item/clothing/G = H.gloves
				G.gunshot_residue = chambered.caliber

	#define DISABLE_CASINGS // goodbye lag (EXPERIMENTAL) - Kachnov

	switch(handle_casings)
		if (EJECT_CASINGS) //eject casing onto ground.
			#ifndef DISABLE_CASINGS
			chambered.loc = get_turf(src)
			chambered.randomrotation()
			#endif

			playsound(loc, casing_sound, 50, TRUE)

		if (CYCLE_CASINGS) //cycle the casing back to the end.
			if (ammo_magazine)
				ammo_magazine.stored_ammo += chambered
			else
				loaded += chambered

		if (REMOVE_CASINGS) //deletes the casing (arrows, for example, where the casing is effectively the projectile)
			qdel(chambered)
			chambered = null

	if (handle_casings != HOLD_CASINGS)
		chambered = null

//Attempts to load A into src, depending on the type of thing being loaded and the load_method
//Maybe this should be broken up into separate procs for each load method?
/mob/var/next_load = -1
/obj/item/weapon/gun/projectile/proc/load_ammo(var/obj/item/A, mob/user)

	if (world.time < user.next_load)
		return

	if (load_delay && !do_after(user, load_delay, src, can_move = TRUE))
		return

	user.next_load = world.time + 1

	// special scenario: A is an ammo box, src is a PTRD or something
	// turn A from the ammo magazine to the first bullet in the ammo magazine
	if (istype(A, /obj/item/ammo_magazine) && A.vars.Find("is_box") && A:is_box && A:ammo_type == ammo_type)
		var/obj/item/ammo_magazine/AM = A
		if (AM.stored_ammo.len)
			A = AM.stored_ammo[1]
			return load_ammo(A, user)

	else if (istype(A, /obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/AM = A

		if (!(load_method & AM.mag_type) || caliber != AM.caliber)
			return // incompatible

		if (bad_magazine_types.Find(AM.type))
			return // incompatible

		switch(AM.mag_type)
			if (MAGAZINE)
				if (AM.ammo_mag != ammo_mag && ammo_mag != "default")
					user << "<span class='warning'>[src] requires another magazine.</span>" //wrong magazine
					return
				if (ammo_magazine)
					user << "<span class='warning'>[src] already has a magazine loaded.</span>" //already a magazine here
					return
				user.remove_from_mob(AM)
				AM.loc = src
				ammo_magazine = AM

				if (reload_sound) playsound(loc, reload_sound, 75, TRUE)
				cock_gun(user)
			if (SPEEDLOADER)
				if (loaded.len >= max_shells)
					user << "<span class='warning'>[src] is full!</span>"
					return
				var/count = FALSE
				for (var/obj/item/ammo_casing/C in AM.stored_ammo)
					if (loaded.len >= max_shells)
						break
					if (C.caliber == caliber)
						C.loc = src
						loaded += C
						AM.stored_ammo -= C //should probably go inside an ammo_magazine proc, but I guess less proc calls this way...
						count++
				if (count)
					user.visible_message("[user] reloads [src].", "<span class='notice'>You load [count] round\s into \the [src].</span>")
					if (reload_sound) playsound(loc, reload_sound, 75, TRUE)
					cock_gun(user)
		AM.update_icon()

	else if (istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/C = A
		if (!(load_method & SINGLE_CASING))
			user << "<span class='warning'>You can't load \the [src] with a single casing!</span>"
			return
		if (caliber != C.caliber)
			user << "<span class='warning'>\The [C] is of the wrong caliber!</span>"
			return //incompatible
		if (loaded.len >= max_shells)
			user << "<span class='warning'>[src] is full.</span>"
			return

		user.remove_from_mob(C)
		C.loc = src
		loaded.Insert(1, C) //add to the head of the list
		user.visible_message("[user] inserts \a [C] into [src].", "<span class='notice'>You insert \a [C] into [src].</span>")
		if (bulletinsert_sound) playsound(loc, bulletinsert_sound, 75, TRUE)

	update_icon()

//attempts to unload  If allow_dump is set to FALSE, the speedloader unloading method will be disabled
/obj/item/weapon/gun/projectile/proc/unload_ammo(mob/user, var/allow_dump=1)
	if (ammo_magazine)
		user.put_in_hands(ammo_magazine)

		if (unload_sound) playsound(loc, unload_sound, 75, TRUE)
		ammo_magazine.update_icon()
		ammo_magazine = null
	else if (loaded.len)
		//presumably, if it can be speed-loaded, it can be speed-unloaded.
		if (allow_dump && (load_method & SPEEDLOADER))
			var/count = FALSE
			var/turf/T = get_turf(user)
			if (T)
				for (var/obj/item/ammo_casing/C in loaded)
					C.loc = T
					count++
				loaded.Cut()
			if (count)
				user.visible_message("[user] unloads [src].", "<span class='notice'>You unload [count] round\s from [src].</span>")
				if (bulletinsert_sound) playsound(loc, bulletinsert_sound, 75, TRUE)
		else if (load_method & SINGLE_CASING)
			var/obj/item/ammo_casing/C = loaded[loaded.len]
			loaded.len--
			user.put_in_hands(C)
			user.visible_message("[user] removes \a [C] from [src].", "<span class='notice'>You remove \a [C] from [src].</span>")
			if (bulletinsert_sound) playsound(loc, bulletinsert_sound, 75, TRUE)
	else
		user << "<span class='warning'>[src] is empty.</span>"
	update_icon()

/obj/item/weapon/gun/projectile/attackby(var/obj/item/A as obj, mob/user)
	..()
	if (istype(A, /obj/item/ammo_magazine) || istype(A, /obj/item/ammo_casing))
		load_ammo(A, user)

/obj/item/weapon/gun/projectile/attack_self(mob/user as mob)
	if (firemodes.len > 1)
		..()
	else
		unload_ammo(user)
		update_icon()

/obj/item/weapon/gun/projectile/attack_hand(mob/user as mob)
	if (user.get_inactive_hand() == src)
		unload_ammo(user, allow_dump=0)
		update_icon()
	else
		return ..()

/obj/item/weapon/gun/projectile/afterattack(atom/A, mob/living/user)
	..()
	if (auto_eject && ammo_magazine && ammo_magazine.stored_ammo && !ammo_magazine.stored_ammo.len)
		ammo_magazine.loc = get_turf(loc)
		user.visible_message(
			"[ammo_magazine] falls out and clatters on the floor!",
			"<span class='notice'>[ammo_magazine] falls out and clatters on the floor!</span>"
			)
		if (auto_eject_sound)
			playsound(user, auto_eject_sound, 40, TRUE)
		ammo_magazine.update_icon()
		ammo_magazine = null
		update_icon() //make sure to do this after unsetting ammo_magazine

/obj/item/weapon/gun/projectile/examine(mob/user)
	..(user)
	if (ammo_magazine)
		user << "<span class='notice'>It has \a [ammo_magazine] loaded.</span>"
	if (!magazine_based)
		user << "<span class='notice'>[inexactAmmo()]</span>"
	if (!(istype(src, /obj/item/weapon/gun/projectile/bow)))
		if (serial == "")
			user << "<span class='warning'><b>The serial number has been filed out.</b></span>"
		else
			user << "<i>Serial no. <b>[serial]</b></i>"
/obj/item/weapon/gun/projectile/proc/getAmmo()
	var/bullets = FALSE
	if (loaded)
		bullets += loaded.len
	if (ammo_magazine && ammo_magazine.stored_ammo)
		bullets += ammo_magazine.stored_ammo.len
	if (chambered)
		bullets += 1
	return bullets

/obj/item/weapon/gun/projectile/proc/inexactAmmo()
	var/ammo = getAmmo()
	var/message

	var/mob/living/M = loc
	if (istype(M))
		if (M.l_hand == src || M.r_hand == src)//Gotta be holding it or this won't work.
			if (ammo >= 6)
				message = "It feels very heavy."
			if (ammo > 3 && ammo < 6)
				message = "It feels heavy."
			if (ammo <= 3 && ammo != FALSE)
				message = "It feels light."
			if (ammo == FALSE)
				message = "It feels empty."
	return message

/* Unneeded -- so far.
//in case the weapon has firemodes and can't unload using attack_hand()
/obj/item/weapon/gun/projectile/verb/unload_gun()
	set name = "Unload Ammo"
	set category = null
	set src in usr

	if (usr.stat || usr.restrained()) return

	unload_ammo(usr)
*/
