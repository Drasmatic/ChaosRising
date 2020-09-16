/obj/item/weapon/grenade/smokebomb
	desc = "It is set to detonate in 2 seconds."
	name = "smoke grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "m18smoke"
	det_time = 20
	item_state = "m18smoke"
	slot_flags = SLOT_BELT
	var/datum/effect/effect/system/smoke_spread/bad/smoke

/obj/item/weapon/grenade/smokebomb/New()
	..()
	smoke = PoolOrNew(/datum/effect/effect/system/smoke_spread/bad)
	smoke.attach(src)

/obj/item/weapon/grenade/smokebomb/Destroy()
	qdel(smoke)
	smoke = null
	return ..()

/obj/item/weapon/grenade/smokebomb/prime()
	if (active)
		playsound(loc, 'sound/effects/smoke.ogg', 50, TRUE, -3)
		smoke.set_up(10, FALSE, usr ? usr.loc : loc)
		spawn(0)
			smoke.start()
			sleep(10)
			smoke.start()
			sleep(10)
			smoke.start()
			sleep(10)
			smoke.start()

		sleep(80)
		qdel(src)
		return

/obj/item/weapon/grenade/smokebomb/fast_activate()
	spawn(round(det_time/10))
		visible_message("<span class = 'warning'>\The [src] goes off!</span>")
		active = TRUE
		prime()

/obj/item/weapon/grenade/smokebomb/m18smoke
	desc = "It is set to detonate in 2 seconds."
	name = "M18 smoke grenade"
	icon_state = "m18smoke"
	det_time = 20
	item_state = "m18smoke"


/obj/item/weapon/grenade/incendiary
	desc = "It is set to detonate in 6 seconds."
	name = "incendiary grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "incendiary"
	det_time = 60
	item_state = "incendiary"
	slot_flags = SLOT_BELT
	var/spread_range = 2

/obj/item/weapon/grenade/incendiary/anm14
	name = "AN/M14 incendiary grenade"

/obj/item/weapon/grenade/incendiary/prime()
	if (active)
		playsound(loc, 'sound/effects/smoke.ogg', 50, TRUE, -3)
		var/turf/LT = get_turf(src)
		explosion(LT,0,1,1,3)
		for (var/turf/floor/T in range(spread_range,LT))
			for (var/mob/living/LS1 in T)
				LS1.adjustFireLoss(35)
				LS1.fire_stacks += rand(8,10)
				LS1.IgniteMob()
			new/obj/effect/fire(T)
		sleep(50)
		qdel(src)
		return

/obj/item/weapon/grenade/incendiary/fast_activate()
	spawn(round(det_time/10))
		visible_message("<span class = 'warning'>\The [src] goes off!</span>")
		active = TRUE
		prime()


/obj/item/weapon/grenade/chemical
	desc = "It is set to detonate in 5 seconds."
	name = "chemical grenade"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "m18smoke"
	det_time = 50
	item_state = "m18smoke"
	slot_flags = SLOT_BELT
	var/datum/effect/effect/system/smoke_spread/bad/smoke
	var/stype = /datum/effect/effect/system/smoke_spread/bad

/obj/item/weapon/grenade/chemical/New()
	..()
	smoke = PoolOrNew(stype)
	smoke.attach(src)

/obj/item/weapon/grenade/chemical/Destroy()
	qdel(smoke)
	smoke = null
	return ..()

/obj/item/weapon/grenade/chemical/prime()
	if (active)
		playsound(loc, 'sound/effects/smoke.ogg', 50, TRUE, -3)
		smoke.set_up(10, FALSE, usr ? usr.loc : loc)
		spawn(0)
			smoke.start()
			sleep(10)
			smoke.start()
			sleep(10)
			smoke.start()
			sleep(10)
			smoke.start()

		sleep(80)
		qdel(src)
		return

/obj/item/weapon/grenade/chemical/fast_activate()
	spawn(round(det_time/10))
		visible_message("<span class = 'warning'>\The [src] goes off!</span>")
		active = TRUE
		prime()

/obj/item/weapon/grenade/chemical/chlorine
	name = "chlorine gas grenade"
	stype = /datum/effect/effect/system/smoke_spread/bad/chem/payload/chlorine_gas

/obj/item/weapon/grenade/chemical/mustard
	name = "mustard gas grenade"
	stype = /datum/effect/effect/system/smoke_spread/bad/chem/payload/mustard_gas

/obj/item/weapon/grenade/chemical/phosgene
	name = "phosgene gas grenade"
	stype = /datum/effect/effect/system/smoke_spread/bad/chem/payload/phosgene

/obj/item/weapon/grenade/chemical/white_phosphorus
	name = "white phosphorus gas grenade"
	stype = /datum/effect/effect/system/smoke_spread/bad/chem/payload/white_phosphorus_gas

/obj/item/weapon/grenade/chemical/xylyl_bromide
	name = "xylyl bromide gas grenade"
	stype = /datum/effect/effect/system/smoke_spread/bad/chem/payload/xylyl_bromide

/obj/item/weapon/grenade/chemical/zyklon_b
	name = "Zyklon B gas grenade"
	stype = /datum/effect/effect/system/smoke_spread/bad/chem/payload/zyklon_b