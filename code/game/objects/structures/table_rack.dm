/obj/structure/table/rack
	name = "rack"
	desc = "Different from the Middle Ages version."
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	flipped = -1
	low = TRUE
	fixedsprite = TRUE

/obj/structure/table/rack/New()
	..()
//	verbs -= /obj/structure/table/verb/do_flip
//	verbs -= /obj/structure/table/proc/do_put
/*
/obj/structure/table/rack/update_connections()
	return

/obj/structure/table/rack/update_desc()
	return*/

/obj/structure/table/rack/update_icon()
	return

/obj/structure/table/fancy
	name = "table"
	desc = "A old expensive table."
	icon = 'icons/obj/objects.dmi'
	icon_state = "fancytable"
	flipped = -1
	low = TRUE
	fixedsprite = TRUE