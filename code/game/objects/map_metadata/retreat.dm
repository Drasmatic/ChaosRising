/obj/map_metadata/retreat
	ID = MAP_RETREAT
	title = "Retreat"
	lobby_icon_state = "coldwar"
	caribbean_blocking_area_types = list(/area/caribbean/no_mans_land/invisible_wall/)
	respawn_delay = 1200

	faction_organization = list(
		AMERICAN,
		CHINESE)

	roundend_condition_sides = list(
		list(AMERICAN) = /area/caribbean/japanese/land,
		list(CHINESE) = /area/caribbean/russian/land,
		)
	age = "1950"
	ordinal_age = 7
	faction_distribution_coeffs = list(CHINESE = 0.6, AMERICAN = 0.4)
	battle_name = "Retreat"
	mission_start_message = "<font size=4>All factions have <b>8 minutes</b> to prepare before the ceasefire ends!<br>The Chinese Army will win if they hold out for <b>30 minutes</b>. The Americans will win if they manage to cross the bridge to friendly territory!</font>"
	faction1 = AMERICAN
	faction2 = CHINESE
	valid_weather_types = list(WEATHER_WET, WEATHER_NONE, WEATHER_EXTREME)
	songs = list(
		"Fortunate Son:1" = 'sound/music/fortunate_son.ogg',)
	artillery_count = 5
/obj/map_metadata/retreat/job_enabled_specialcheck(var/datum/job/J)
	..()
	if (istype(J, /datum/job/american))
		if (J.is_korean_war == TRUE)
			. = TRUE
		else
			. = FALSE
	if (istype(J, /datum/job/chinese))
		if (J.is_korean_war == TRUE)
			. = TRUE
		else
			. = FALSE

/obj/map_metadata/retreat/faction2_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 36000 || admin_ended_all_grace_periods)

/obj/map_metadata/retreat/faction1_can_cross_blocks()
	return (processes.ticker.playtime_elapsed >= 4800 || admin_ended_all_grace_periods)


/obj/map_metadata/retreat/roundend_condition_def2name(define)
	..()
	switch (define)
		if (CHINESE)
			return "Chinese"
		if (AMERICAN)
			return "American"
/obj/map_metadata/retreat/roundend_condition_def2army(define)
	..()
	switch (define)
		if (CHINESE)
			return "Chinese"
		if (AMERICAN)
			return "Americans"

/obj/map_metadata/retreat/army2name(army)
	..()
	switch (army)
		if ("Chinese")
			return "Chinese"
		if ("Americans")
			return "American"


/obj/map_metadata/retreat/cross_message(faction)
	if (faction == AMERICAN)
		return "<font size = 4>The Americans may now cross the invisible wall!</font>"
	else if (faction == CHINESE)
		return ""
	else
		return ""

/obj/map_metadata/retreat/reverse_cross_message(faction)
	if (faction == AMERICAN)
		return "<span class = 'userdanger'>The Americans may no longer cross the invisible wall!</span>"
	else if (faction == CHINESE)
		return ""
	else
		return ""


var/no_loop_ret = FALSE

/obj/map_metadata/retreat/update_win_condition()
	if (!win_condition_specialcheck())
		return FALSE
	if (world.time >= 18000)
		if (win_condition_spam_check)
			return FALSE
		ticker.finished = TRUE
		var/message = "The <b>Chinese</b> have successfuly deterred the withdrawal! The Americans have halted the Retreat!"
		world << "<font size = 4><span class = 'notice'>[message]</span></font>"
		show_global_battle_report(null)
		win_condition_spam_check = TRUE
		return FALSE
	if ((current_winner && current_loser && world.time > next_win) && no_loop_ret == FALSE)
		ticker.finished = TRUE
		var/message = "The <b>Americans</b> have crossed the bridge into friendly territory! The retreat is completed!"
		world << "<font size = 4><span class = 'notice'>[message]</span></font>"
		show_global_battle_report(null)
		win_condition_spam_check = TRUE
		no_loop_ret = TRUE
		return FALSE
	// German major
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.33, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.33))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have crossed the bridge into friendly territory! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[1][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[2][1])
	// German minor
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.01, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.01))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have crossed the bridge into friendly territory! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[1][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[2][1])
	// Soviet major
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.33, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.33))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have crossed the bridge into friendly territory! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[2][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[1][1])
	// Soviet minor
	else if (win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[1]]), roundend_condition_sides[2], roundend_condition_sides[1], 1.01, TRUE))
		if (!win_condition.check(typesof(roundend_condition_sides[roundend_condition_sides[2]]), roundend_condition_sides[1], roundend_condition_sides[2], 1.01))
			if (last_win_condition != win_condition.hash)
				current_win_condition = "The <b>Americans</b> have crossed the bridge into friendly territory! They will win in {time} minutes."
				next_win = world.time + short_win_time(AMERICAN)
				announce_current_win_condition()
				current_winner = roundend_condition_def2army(roundend_condition_sides[2][1])
				current_loser = roundend_condition_def2army(roundend_condition_sides[1][1])
	else
		if (current_win_condition != no_winner && current_winner && current_loser)
			world << "<font size = 3>The <b>Americans</b> have oddly retreated back into enemy tarritory!</font>"
			current_winner = null
			current_loser = null
		next_win = -1
		current_win_condition = no_winner
		win_condition.hash = 0
	last_win_condition = win_condition.hash
	return TRUE
