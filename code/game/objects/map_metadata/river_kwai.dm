/obj/map_metadata/river_kwai
	ID = MAP_RIVER_KWAI
	title = "Bridge Over River Kwai"
	no_winner ="The round is proceeding normally."
	lobby_icon_state = "camp"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall/tundra)
	respawn_delay = 3600
	has_hunger = TRUE
	faction_organization = list(
		JAPANESE,
		BRITISH)

	roundend_condition_sides = list(
		list(JAPANESE) = /area/caribbean/british,
		list(BRITISH) = /area/caribbean/russian/land/inside/command,
		)
	age = "1943"
	ordinal_age = 6
	is_RP = TRUE
	faction_distribution_coeffs = list(JAPANESE = 0.25, BRITISH = 0.75)
	battle_name = "Bridge Over the River Kwai"
	mission_start_message = "<font size=4>All factions have <b>4 minutes</b> to prepare before the grace wall is removed.<br>The <b>Japanese</b> must keep the prisoners contained, and make them construct a railroad. The <b>Prisoners</b> must try to survive, follow their orders.</font>"
	faction1 = JAPANESE
	faction2 = BRITISH
	valid_weather_types = list(WEATHER_NONE, WEATHER_WET, WEATHER_EXTREME)
	songs = list(
		"The Great Escape:1" = 'sound/music/the_great_escape.ogg')
	gamemode = "Prison Simulation"
	var/gracedown1 = TRUE
	var/siren = FALSE
obj/map_metadata/river_kwai/job_enabled_specialcheck(var/datum/job/J)
	..()
	if (istype(J, /datum/job/japanese))
		if (J.is_prison)
			. = TRUE
		else
			. = FALSE
	else if (istype(J, /datum/job/british))
		if (J.is_prison)
			. = TRUE
		else
			. = FALSE

/obj/map_metadata/river_kwai/faction1_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 2400 || admin_ended_all_grace_periods)

/obj/map_metadata/river_kwai/faction2_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 2400 || admin_ended_all_grace_periods)


/obj/map_metadata/river_kwai/roundend_condition_def2name(define)
	..()
	switch (define)
		if (JAPANESE)
			return "Japanese"
		if (BRITISH)
			return "Prisoner"
/obj/map_metadata/river_kwai/roundend_condition_def2army(define)
	..()
	switch (define)
		if (JAPANESE)
			return "Japanese Guards"
		if (BRITISH)
			return "Prisoners"

/obj/map_metadata/river_kwai/army2name(army)
	..()
	switch (army)
		if ("Japanese Guards")
			return "Japanese"
		if ("Prisoners")
			return "Prisoner"


/obj/map_metadata/river_kwai/cross_message(faction)
	if (faction == BRITISH)
		return ""
	else if (faction == JAPANESE)
		return "<font size = 4>The grace wall is down!</font>"
	else
		return ""

/obj/map_metadata/river_kwai/reverse_cross_message(faction)
	if (faction == BRITISH)
		return ""
	else if (faction == JAPANESE)
		return "<font size = 4>The grace wall is up!</font>"
	else
		return ""
/obj/map_metadata/river_kwai/New()
	..()
	spawn(100)
		load_new_recipes()

/obj/map_metadata/river_kwai/proc/load_new_recipes()
	var/F3 = file("config/material_recipes_kwai.txt")
	if (fexists(F3))
		craftlist_list = list()
		var/list/craftlist_temp = file2list(F3,"\n")
		for (var/i in craftlist_temp)
			if (findtext(i, ","))
				var/tmpi = replacetext(i, "RECIPE: ", "")
				var/list/current = splittext(tmpi, ",")
				craftlist_list += list(current)
				if (current.len != 13)
					world.log << "Error! Recipe [current[2]] has a length of [current.len] (should be 13)."
