
///////////////////////
////Stationary maxim////
///////////////////////
/obj/item/weapon/gun/projectile/automatic/stationary/modern
	name = "Maxim 1895"
	desc = "Heavy Maxim machinegun on cart mount."
	icon_state = "maxim"
	base_icon = "maxim"
	load_method = MAGAZINE
	handle_casings = EJECT_CASINGS
	caliber = "a762x54"
	magazine_type = /obj/item/ammo_magazine/maxim
	ammo_type = /obj/item/ammo_casing/a762x54

	max_shells = FALSE
	anchored = FALSE
	auto_eject = TRUE
	fire_sound = 'sound/weapons/guns/fire/Maxim.ogg'
	firemodes = list(
		list(name="full auto", burst=6, burst_delay=2, fire_delay=2, dispersion=list(0.8, 0.9, 1.1, 1.2, 1.3), accuracy=list(2))
		)
	full_auto = TRUE
	fire_delay = 3
/obj/item/weapon/gun/projectile/automatic/stationary/modern/rotate_to(mob/user, atom/A)
	var/shot_dir = get_carginal_dir(src, A)
	dir = shot_dir

	//if (zoomed)
		//zoom(user, FALSE) //Stop Zoom

	user.forceMove(loc)
	user.dir = dir

// helpers

/mob/var/using_MG = null
/mob/proc/use_MG(o)
	if (!o || !istype(o, /obj/item/weapon/gun/projectile/automatic/stationary))
		using_MG = null
	else
		using_MG = o

/mob/proc/handle_MG_operation(var/stop_using = FALSE)
	if (using_MG && istype(using_MG, /obj/item/weapon/gun/projectile/automatic/stationary))
		var/obj/item/weapon/gun/projectile/automatic/stationary/mg = using_MG
		if (!(locate(src) in range(mg.maximum_use_range, mg)) || stop_using)
			use_MG(null)
			mg.stopped_using(src)
	else if (!locate(using_MG) in range(1, src) || stop_using)
		use_MG(null)

/mob/living/human/Move()
	handle_MG_operation()
	..()

/mob/living/human/update_canmove()
	if (lying || stat)
		handle_MG_operation(stop_using = TRUE)
	..()

/obj/item/weapon/gun/projectile/automatic/stationary/modern/update_icon()
	if (ammo_magazine)
		icon_state = base_icon
	else
		icon_state = "[base_icon][0]"
	update_held_icon()
	return

/obj/item/weapon/gun/projectile/automatic/stationary/modern/maxim
	name = "Maxim 1895"
	desc = "Russian version of the original Maxim machinegun, on cart mount. Uses Russian 7.62x54mm rounds."
	icon_state = "maxim"
	base_icon = "maxim"
	caliber = "a762x54_weak"
	fire_sound = 'sound/weapons/guns/fire/Maxim.ogg'
	magazine_type = /obj/item/ammo_magazine/maxim
	firemodes = list(
		list(name="full auto", burst=6, burst_delay=2, fire_delay=2, dispersion=list(0.8, 0.9, 1.0, 1.1, 1.2), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a762x54/weak

obj/item/weapon/gun/projectile/automatic/stationary/modern/maxim/ww2
	name = "Maxim"
	desc = "Russian version of the original Maxim machinegun, on cart mount. Uses Russian 7.62x54mm rounds."
	icon_state = "maxim_ww2"
	base_icon = "maxim_ww2"
	caliber = "a762x54_weak"
	fire_sound = 'sound/weapons/guns/fire/Maxim.ogg'
	magazine_type = /obj/item/ammo_magazine/maxim
	firemodes = list(
		list(name="full auto", burst=6, burst_delay=2, fire_delay=2, dispersion=list(0.8, 0.9, 1.0, 1.1, 1.2), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a762x54/weak

/obj/item/weapon/gun/projectile/automatic/stationary/modern/mg08
	name = "Maschinengewehr 08"
	desc = "German Heavy Maxim machinegun, based on the original Maxim. Uses 7.92x57mm Mauser rounds."
	icon_state = "mg08"
	base_icon = "mg08"
	caliber = "a792x57_weak"
	fire_sound = 'sound/weapons/guns/fire/Maxim.ogg'
	magazine_type = /obj/item/ammo_magazine/mg08
	firemodes = list(
		list(name="full auto", burst=6, burst_delay=2, fire_delay=2, dispersion=list(0.8, 0.9, 1.0, 1.1, 1.2), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a792x57/weak

/obj/item/weapon/gun/projectile/automatic/stationary/modern/pkm
	name = "PKM machine gun"
	desc = "Soviet Heavy Maxim machinegun. Uses 7.62x54mm rounds."
	icon_state = "pkm"
	base_icon = "pkm"
	caliber = "a762x54_weak"
	magazine_type = /obj/item/ammo_magazine/pkm
	firemodes = list(
		list(name="full auto", burst=4, burst_delay=1.3, fire_delay=1.3, dispersion=list(0.8, 0.9, 1.1, 1.2, 1.3), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a762x54/weak

/obj/item/weapon/gun/projectile/automatic/stationary/modern/vickers
	name = "Vickers machine gun"
	desc = "A water-cooled heavy machinegun, using .303 british rounds."
	icon_state = "vickers"
	base_icon = "vickers"
	caliber = "a303_weak"
	fire_sound = 'sound/weapons/guns/fire/Vickers.ogg'
	magazine_type = /obj/item/ammo_magazine/vickers
	firemodes = list(
		list(name="full auto", burst=6, burst_delay=2, fire_delay=2, dispersion=list(0.8, 0.9, 1.0, 1.1, 1.2), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a303/weak


/obj/item/weapon/gun/projectile/automatic/stationary/modern/hotchkiss1914
	name = "Hotchkiss M1914 machine gun"
	desc = "A french heavy machinegun, using 8x50mm Lebel rounds."
	icon_state = "hotchkiss1914"
	base_icon = "hotchkiss1914"
	caliber = "a8x50_weak"
	magazine_type = /obj/item/ammo_magazine/hotchkiss
	ammo_type = /obj/item/ammo_casing/a8x50/weak

/obj/item/weapon/gun/projectile/automatic/stationary/modern/type3
	name = "Type 3 machine gun"
	desc = "A japanese heavy machinegun based on the French Hotchkiss. Uses 6.5x50mm Arisaka rounds."
	icon_state = "type3"
	base_icon = "type3"
	caliber = "a65x50_weak"
	magazine_type = /obj/item/ammo_magazine/type3
	ammo_type = /obj/item/ammo_casing/a65x50/weak

/obj/item/weapon/gun/projectile/automatic/stationary/modern/type98
	name = "Type 92 machine gun"
	desc = "A japanese heavy machinegun. Uses 7.7x58mm Arisaka rounds."
	icon_state = "type92hmg"
	base_icon = "type92hmg"
	caliber = "a77x58"
	fire_sound = 'sound/weapons/guns/fire/Type92.ogg'
	magazine_type = /obj/item/ammo_magazine/type92
	firemodes = list(
		list(name="full auto", burst=3, burst_delay=1.8, fire_delay=1.8, dispersion=list(0.8, 0.9, 1.1, 1.2, 1.3), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a77x58
	attachment_slots = ATTACH_SCOPE
/obj/item/weapon/gun/projectile/automatic/stationary/modern/type98/update_icon()
	icon_state = "type92hmg[ammo_magazine ? round(ammo_magazine.stored_ammo.len, 5) : "-empty"]"

/obj/item/weapon/gun/projectile/automatic/stationary/modern/browning
	name = "M1919A1 browning machine gun"
	desc = "An american heavy machinegun. Uses 30-06. rounds."
	icon_state = "browning"
	base_icon = "browning"
	caliber = "a3006"
	fire_sound = 'sound/weapons/guns/fire/M1919.ogg'
	magazine_type = /obj/item/ammo_magazine/browning
	firemodes = list(
		list(name="full auto", burst=5, burst_delay=1.8, fire_delay=1.1, dispersion=list(0.8, 0.9, 1.1, 1.2, 1.3), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a3006
/obj/item/weapon/gun/projectile/automatic/stationary/modern/browning/update_icon()
	icon_state = "browning[ammo_magazine ? round(ammo_magazine.stored_ammo.len, 50) : "-empty"]"


/obj/item/weapon/gun/projectile/automatic/stationary/modern/mg34
	name = "MG 34 machine gun"
	desc = "A german heavy machinegun, using 7.92x57 Mauser rounds."
	icon_state = "mg34hmg"
	base_icon = "mg34hmg"
	caliber = "a792x57_weak"
	magazine_type = /obj/item/ammo_magazine/mg34belt
	firemodes = list(
		list(name="full auto", burst=4, burst_delay=1, fire_delay=1, dispersion=list(0.8, 0.9, 1.1, 1.2, 1.3), accuracy=list(2))
		)
	ammo_type = /obj/item/ammo_casing/a792x57/weak