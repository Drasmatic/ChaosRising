/obj/map_metadata/teutoburg
	ID = MAP_TEUTOBURG
	title = "Teutoburg"
	lobby_icon_state = "ancient"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall/)
	respawn_delay = 300


	faction_organization = list(
		ROMAN,
		GERMAN)

	roundend_condition_sides = list(
		list(ROMAN) = /area/caribbean/roman,
		list(GERMAN) = /area/caribbean/german/inside/objective
		)
	age = "9 A.D."
	ordinal_age = 1
	faction_distribution_coeffs = list(ROMAN = 0.4, GERMAN = 0.6)
	battle_name = "battle of Teutoburg Forest"
	mission_start_message = "<font size=4>The <b>Germanic</b> and <b>Roman</b> armies are facing each other in the Teutoburg forest! Get ready for the battle! It will start in <b>5 minutes</b>.</font>"
	faction1 = ROMAN
	faction2 = GERMAN
	ambience = list('sound/ambience/jungle1.ogg')
	songs = list(
		"Divinitus:1" = 'sound/music/divinitus.ogg',)
obj/map_metadata/teutoburg/job_enabled_specialcheck(var/datum/job/J)
	..()
	if (istype(J, /datum/job/roman))
		if (J.is_gladiator == TRUE)
			. = FALSE
		else
			. = TRUE
	else
		if (J.is_ancient == TRUE)
			. = TRUE
		else
			. = FALSE
/obj/map_metadata/teutoburg/faction2_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 3000 || admin_ended_all_grace_periods)

/obj/map_metadata/teutoburg/faction1_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 3000 || admin_ended_all_grace_periods)


