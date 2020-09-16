// this now inherits from window as its an easy way to give it the same
// multidirectional collision behavior

/obj/structure/window/barrier/snowwall
	name = "snow barricade"
	icon_state = "snow_wall"
	icon = 'icons/obj/structures.dmi'
	layer = MOB_LAYER + 0.01 //just above mobs
	anchored = TRUE
	climbable = TRUE
	flammable = FALSE
	var/progress = FALSE
/obj/structure/window/barrier/snowwall/attack_hand(var/mob/user as mob)
	if (locate(src) in get_step(user, user.dir))
		if (WWinput(user, "Dismantle this snow barricade?", "Dismantle snow barricade", "Yes", list("Yes", "No")) == "Yes")
			visible_message("<span class='danger'>[user] starts dismantling the snow barricade.</span>", "<span class='danger'>You start dismantling the snow barricade.</span>")
			if (do_after(user, 200, src))
				visible_message("<span class='danger'>[user] finishes dismantling the snow barricade.</span>", "<span class='danger'>You finish dismantling the snow barricade.</span>")
				var/turf = get_turf(src)

				if (!istype(src, /obj/structure/window/barrier/snowwall/incomplete))
					for (var/v in TRUE to rand(4,6))
						new /obj/item/weapon/snowwall(turf)
				else
					var/obj/structure/window/barrier/snowwall/incomplete/I = src
					for (var/v in TRUE to (1 + pick(I.progress-1, I.progress)))
						new /obj/item/weapon/snowwall(turf)
				qdel(src)

/obj/structure/window/barrier/snowwall/ex_act(severity)
	switch(severity)
		if (1.0)
			qdel(src)
			return
		if (2.0)
			qdel(src)
			return
		else
			if (prob(50))
				return ex_act(2.0)
	return

/obj/structure/window/barrier/snowwall/New(location, var/mob/creator)
	loc = location
	flags |= ON_BORDER

	if (creator && ismob(creator))
		dir = creator.dir
	else
		var/ndir = creator
		dir = ndir

	set_dir(dir)

	switch (dir)
		if (NORTH)
			layer = MOB_LAYER - 0.01
			pixel_y = FALSE
		if (SOUTH)
			layer = MOB_LAYER + 0.01
			pixel_y = FALSE
		if (EAST)
			layer = MOB_LAYER - 0.05
			pixel_x = FALSE
		if (WEST)
			layer = MOB_LAYER - 0.05
			pixel_x = FALSE

//incomplete snowwall structures
/obj/structure/window/barrier/snowwall/incomplete
	name = "incomplete snow barricade"
	icon_state = "snow_wall_33%"
	flammable = FALSE
	incomplete = TRUE

/obj/structure/window/barrier/snowwall/incomplete/ex_act(severity)
	qdel(src)

/obj/structure/window/barrier/snowwall/incomplete/attackby(obj/O as obj, mob/user as mob)
	user.dir = get_dir(user, src)
	if (istype(O, /obj/item/weapon/snowwall))
		if (progress < 3)
			progress += 1
			if (progress == 2)
				icon_state = "snow_wall_66%"
			if (progress >= 3)
				icon_state = "snow_wall"
				new/obj/structure/window/barrier/snowwall(loc, dir)
				qdel(src)
			visible_message("<span class='danger'>[user] shovels snow into [src].</span>")
			qdel(O)
	else
		return

/obj/structure/window/barrier/snowwall/set_dir(direction)
	dir = direction

// snowwall window overrides

/obj/structure/window/barrier/snowwall/attackby(obj/O as obj, mob/user as mob)
	return FALSE

/obj/structure/window/barrier/snowwall/examine(mob/user)
	user << "That's a snow barricade."
	return TRUE

/obj/structure/window/barrier/snowwall/take_damage(var/damage = FALSE, var/sound_effect = TRUE)
	return FALSE

/obj/structure/window/barrier/snowwall/apply_silicate(var/amount)
	return FALSE

/obj/structure/window/barrier/snowwall/updateSilicate()
	return FALSE

/obj/structure/window/barrier/snowwall/shatter(var/display_message = TRUE)
	return FALSE

/obj/structure/window/barrier/snowwall/bullet_act(var/obj/item/projectile/Proj)
	return FALSE

/obj/structure/window/barrier/snowwall/ex_act(severity)
	switch(severity)
		if (1.0)
			qdel(src)
			return
		if (2.0)
			qdel(src)
			return
		if (3.0)
			if (prob(50))
				qdel(src)

/obj/structure/window/barrier/snowwall/is_full_window()
	return FALSE

/obj/structure/window/hitby(AM as mob|obj)
	return FALSE // don't move

/obj/structure/window/barrier/snowwall/attack_generic(var/mob/user, var/damage)
	return FALSE

/obj/structure/window/barrier/snowwall/rotate()
	return

/obj/structure/window/barrier/snowwall/revrotate()
	return

/obj/structure/window/barrier/snowwall/is_fulltile()
	return FALSE

/obj/structure/window/barrier/snowwall/update_verbs()
	verbs -= /obj/structure/window/proc/rotate
	verbs -= /obj/structure/window/proc/revrotate

//merges adjacent full-tile windows into one (blatant ripoff from game/smoothwall.dm)
/obj/structure/window/barrier/snowwall/update_icon()
	return

/obj/structure/window/barrier/snowwall/fire_act(temperature)
	return

/obj/item/weapon/snowwall
	name = "snow pile"
	icon_state = "snow_pile"
	icon = 'icons/obj/items.dmi'
	w_class = TRUE
	var/sand_amount = FALSE
	flammable = FALSE

/obj/item/weapon/snowwall/attack_self(mob/user)
	user << "You start building the snow blocks wall..."
	if (do_after(user, 25, src))
		user << "You finish the placement of the snow blocks wall foundation."
		new /obj/covers/snow_wall/blocks/incomplete(user.loc)
		qdel(src)
		return

/obj/item/weapon/snowwall/attack_hand(mob/user)
	if (user.a_intent == I_GRAB)
		user << "You start moulding the snow into some snowballs..."
		if (do_after(user,40,user.loc))
			user << "You finish the snowballs."
			new/obj/item/weapon/snowball(user.loc)
			new/obj/item/weapon/snowball(user.loc)
			new/obj/item/weapon/snowball(user.loc)
			qdel(src)
	else
		..()

/obj/covers/snow_wall/blocks
	name = "snow blocks wall"
	desc = "A snow blocks wall."
	icon = 'icons/turf/walls.dmi'
	icon_state = "igloo_wall"
	passable = TRUE
	not_movable = TRUE
	density = TRUE
	opacity = TRUE
	amount = 0
	layer = 2.12
	health = 110
	wood = FALSE
	wall = TRUE
	flammable = FALSE
	buildstack = /obj/item/weapon/snowwall

/obj/covers/snow_wall/blocks/incomplete
	name = "snow blocks wall"
	desc = "A snow blocks wall."
	icon = 'icons/turf/walls.dmi'
	icon_state = "igloo_wall_inc1"
	passable = TRUE
	not_movable = TRUE
	density = TRUE
	opacity = FALSE
	amount = 0
	layer = 2.12
	health = 30
	var/stage = 1
	wood = FALSE
	wall = TRUE
	flammable = FALSE
	incomplete = TRUE

/obj/covers/snow_wall/blocks/incomplete/attackby(obj/item/W as obj, mob/user as mob)
	if (istype(W, /obj/item/weapon/snowwall))
		if (stage == 3)
			user << "You start adding snow to the wall..."
			if (do_after(user, 20, src) && W)
				user << "You finish adding snow to the wall, completing it."
				qdel(W)
				new /obj/covers/snow_wall/blocks(loc)
				qdel(src)
				return
		else if (stage <= 2)
			user << "You start adding snow to the wall..."
			if (do_after(user, 20, src))
				if (stage <= 2)
					user << "You finish adding snow to the wall."
					stage = (stage+1)
					icon_state = "igloo_wall_inc[stage]"
					health = (20*stage)
					qdel(W)
					return
	..()
