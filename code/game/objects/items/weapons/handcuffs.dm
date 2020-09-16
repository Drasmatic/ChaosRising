/obj/item/weapon/handcuffs
	name = "handcuffs"
	desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "handcuff"
	flags = CONDUCT
	slot_flags = SLOT_BELT
	throwforce = WEAPON_FORCE_WEAK
	w_class = 2.0
	throw_speed = 2
	throw_range = 5
	var/elastic
	var/dispenser = FALSE
	var/breakouttime = 1200 //Deciseconds = 120s = 2 minutes
	var/cuff_sound = 'sound/weapons/handcuffs.ogg'
	var/cuff_type = "handcuffs"

/obj/item/weapon/handcuffs/attack(var/mob/living/human/C, var/mob/living/user)

	if (!user.IsAdvancedToolUser())
		return

	if (!C.handcuffed)
		if (C == user)
			place_handcuffs(user, user)
			return

		//check for an aggressive grab (or robutts)
		var/can_place

		for (var/obj/item/weapon/grab/G in C.grabbed_by)
			if (G.loc == user && G.state >= GRAB_AGGRESSIVE)
				can_place = TRUE
				break

		if (C.lying)
			can_place = TRUE

		if (can_place)
			place_handcuffs(C, user)
		else
			user << "<span class='danger'>You need to have a firm grip on [C] before you can put \the [src] on!</span>"

/obj/item/weapon/handcuffs/proc/place_handcuffs(var/mob/living/human/target, var/mob/user)
	playsound(loc, cuff_sound, 30, TRUE, -2)

	var/mob/living/human/H = target
	if (!istype(H))
		return FALSE

	if (!H.has_organ_for_slot(slot_handcuffed))
		user << "<span class='danger'>\The [H] needs at least two wrists before you can cuff them together!</span>"
		return FALSE

	//user.visible_message("<span class='danger'>\The [user] is attempting to put [cuff_type] on \the [H]!</span>")

	if (!do_after(user,0, target))
		return FALSE

	H.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been handcuffed by [user.name] ([user.ckey])</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Handcuff [H.name] ([H.ckey])</font>")
	msg_admin_attack("[key_name(user)] handcuff [key_name(H)]")


	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	user.do_attack_animation(H)

	user.visible_message("<span class='danger'>\The [user] has put [cuff_type] on \the [H]!</span>")

	// Apply cuffs.
	var/obj/item/weapon/handcuffs/cuffs = src
	if (dispenser)
		cuffs = new(get_turf(user))
	else
		user.drop_from_inventory(cuffs)
	cuffs.loc = target
	target.handcuffed = cuffs
	target.update_inv_handcuffed()
	return TRUE

var/last_chew = FALSE
/mob/living/human/RestrainedClickOn(var/atom/A)
	if (A != src) return ..()
	if (last_chew + 26 > world.time) return

	var/mob/living/human/H = A
	if (!H.handcuffed) return
	if (H.a_intent != I_HARM) return
	if (H.targeted_organ != "mouth") return
	if (H.wear_mask) return
	var/obj/item/organ/external/O = H.organs_by_name[H.hand?"l_hand":"r_hand"]
	if (!O) return

	var/s = "<span class='warning'>[H.name] chews on \his [O.name]!</span>"
	H.visible_message(s, "<span class='warning'>You chew on your [O.name]!</span>")
	H.attack_log += text("\[[time_stamp()]\] <font color='red'>[s] ([H.ckey])</font>")
	log_attack("[s] ([H.ckey])")

	if (O.take_damage(3,0,1,1,"teeth marks"))
		H:UpdateDamageIcon()

	last_chew = world.time

/obj/item/weapon/handcuffs/rope
	name = "rope handcuffs"
	desc = "Use this to keep prisoners in line."
	icon = 'icons/obj/items.dmi'
	icon_state = "ropecuffs"
	flammable = TRUE

/obj/item/weapon/handcuffs/old
	name = "iron handcuffs"
	desc = "Use this to keep prisoners in line."
	icon = 'icons/obj/items.dmi'
	icon_state = "oldcuff"
	flammable = TRUE


/obj/item/weapon/handcuffs/strips
	name = "strip cuffs"
	desc = "Use this to keep prisoners in line."
	icon = 'icons/obj/items.dmi'
	icon_state = "strips"
	flammable = TRUE