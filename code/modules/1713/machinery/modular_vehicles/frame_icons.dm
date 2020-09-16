/obj/structure/vehicleparts/frame/update_icon()
	..()
	overlays.Cut()
	var/ticon = normal_icon
	if (!axis)
		dir = 1
	if (axis && mwheel)
		if (broken)
			icon = broken_icon
		else
			icon = normal_icon
		movemento = image(icon=mwheel.icon, loc=src, icon_state=mwheel.icon_state, layer=6, dir=mwheel.dir)
		if (mwheel.ntype == "track")
			movemento.color = axis.color
			if (axis.corners[1] == src || axis.corners[2] == src)
				switch(dir)
					if (NORTH)
						movemento.pixel_x = 0
						movemento.pixel_y = 32
					if (SOUTH)
						movemento.pixel_x = 0
						movemento.pixel_y = -32
					if (WEST)
						movemento.pixel_x = -32
						movemento.pixel_y = 0
					if (EAST)
						movemento.pixel_x = 32
						movemento.pixel_y = 0
			else if (axis.corners[3] == src || axis.corners[4] == src)
				switch(dir)
					if (NORTH)
						movemento.pixel_x = 0
						movemento.pixel_y = -32
					if (SOUTH)
						movemento.pixel_x = 0
						movemento.pixel_y = 32
					if (WEST)
						movemento.pixel_x = 32
						movemento.pixel_y = 0
					if (EAST)
						movemento.pixel_x = -32
						movemento.pixel_y = 0
			overlays += movemento
		else if (mwheel.ntype == "wheel")
			switch(dir)
				if (NORTH)
					if (mwheel.dir == dir)
						movemento.pixel_x = 16
						movemento.pixel_y = 0
					else if (mwheel.dir == OPPOSITE_DIR(dir))
						movemento.pixel_x = -16
						movemento.pixel_y = 0
					overlays += movemento
				if (SOUTH)
					if (mwheel.dir == dir)
						movemento.pixel_x = -16
						movemento.pixel_y = 0
					else if (mwheel.dir == OPPOSITE_DIR(dir))
						movemento.pixel_x = 16
						movemento.pixel_y = 0
					overlays += movemento
				if (WEST)
					if (mwheel.dir == OPPOSITE_DIR(dir))
						movemento.pixel_x = 0
						movemento.pixel_y = -22
						overlays += movemento
				if (EAST)
					if (mwheel.dir == dir)
						movemento.pixel_x = 0
						movemento.pixel_y = -22
						overlays += movemento
	if (!noroof && axis)
		roof = image(icon=icon, loc=src, icon_state="roof_steel[rand(1,4)]", layer=10)
		roof.overlays.Cut()
	else
		roof = image(icon=icon, loc=src, icon_state="", layer=1)
		roof.overlays.Cut()
	var/turf/T = get_turf(src)
	if (!noroof)
		for(var/obj/structure/cannon/C in T)
			if (axis)
				roof_turret = image(icon='icons/obj/vehicles/vehicles96x96.dmi',loc=src, icon_state="[axis.turret_type][broken]", layer=11.1, dir=C.dir)
			else
				roof_turret = image(icon='icons/obj/vehicles/vehicles96x96.dmi',loc=src, icon_state="", layer=11.1, dir=C.dir)
			if (roof_turret)
				roof_turret.color = axis.color
			if (C.dir == NORTH)
				if (dir == NORTH)
					roof_turret.pixel_y = 0
					roof_turret.pixel_x = -32
				else if (dir == SOUTH)
					roof_turret.pixel_y = -16
					roof_turret.pixel_x = -32
				else if (dir == WEST)
					roof_turret.pixel_x = -48
					roof_turret.pixel_y = -48
				else if (dir == EAST)
					roof_turret.pixel_x = -32
					roof_turret.pixel_y = 0
			else if (C.dir == SOUTH)
				if (dir == NORTH)
					roof_turret.pixel_y = -32
					roof_turret.pixel_x = -32
				else if (dir == SOUTH)
					roof_turret.pixel_y = -64
					roof_turret.pixel_x = -32
				else if (dir == WEST)
					roof_turret.pixel_x = -48
					roof_turret.pixel_y = -48
				else if (dir == EAST)
					roof_turret.pixel_x = -32
					roof_turret.pixel_y = -48
			else if (C.dir == WEST)
				if (dir == NORTH)
					roof_turret.pixel_y = -16
					roof_turret.pixel_x = -64
				else if (dir == SOUTH)
					roof_turret.pixel_y = -32
					roof_turret.pixel_x = -64
				else if (dir == WEST)
					roof_turret.pixel_x = -32
					roof_turret.pixel_y = -32
				else if (dir == EAST)
					roof_turret.pixel_x = -64
					roof_turret.pixel_y = -16
			else if (C.dir == EAST)
				if (dir == NORTH)
					roof_turret.pixel_y = -16
					roof_turret.pixel_x = 0
				else if (dir == SOUTH)
					roof_turret.pixel_y = -32
					roof_turret.pixel_x = 0
				else if (dir == WEST)
					roof_turret.pixel_x = 0
					roof_turret.pixel_y = -16
				else if (dir == EAST)
					roof_turret.pixel_x = -16
					roof_turret.pixel_y = -16
			roof.overlays += roof_turret
		for (var/obj/CC in T)
			if (istype(CC, /obj/structure/bed/chair/drivers) && istype(axis, /obj/structure/vehicleparts/axis/heavy))
				roof.icon_state = "roof_steel_hatch_driver"
			else if (istype(CC, /obj/structure/bed/chair) && istype(axis, /obj/structure/vehicleparts/axis/heavy))
				roof.icon_state = "roof_steel_hatch"
			else if (istype(CC, /obj/structure/engine) && istype(axis, /obj/structure/vehicleparts/axis/heavy))
				roof.icon_state = "roof_steel_exhaust"
			else if (istype(CC, /obj/item/weapon/reagent_containers/glass/barrel/fueltank) && istype(axis, /obj/structure/vehicleparts/axis/heavy))
				roof.icon_state = "roof_steel_closedhatch"
		if (axis)
			if (broken)
				ticon = broken_icon
			else
				ticon = normal_icon

		roof = image(icon=icon, loc=src, icon_state=replacetext(src.icon_state,"frame","roof"), layer=9.9)

		if (override_roof_icon)
			roof.icon_state = override_roof_icon
		if (override_color)
			roof.color = override_color
		else
			roof.color = axis.color

	switch (dir)
		if (NORTH)
			if (w_left[1] != "")
				if (w_left[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_left[1]]", layer=10, dir=WEST)
				if (w_left.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_right[1] != "")
				if (w_right[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_right[1]]", layer=10, dir=EAST)
				if (w_right.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_front[1] != "")
				if (w_front[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_front[1]]", layer=10, dir=NORTH)
				if (w_front.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_back[1] != "")
				if (w_back[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_back[1]]", layer=10.5, dir=SOUTH)
				if (w_back.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1

		//Front-Right, Front-Left, Back-Right,Back-Left; FR, FL, BR, BL
			ticon = normal_icon

		if (SOUTH)
			if (w_left[1] != "")
				if (w_left[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_left[1]]", layer=10, dir=EAST)
				if (w_left.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_right[1] != "")
				if (w_right[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_right[1]]", layer=10, dir=WEST)
				if (w_right.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_front[1] != "")
				if (w_front[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_front[1]]", layer=10.5, dir=SOUTH)
				if (w_front.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_back[1] != "")
				if (w_back[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_back[1]]", layer=10, dir=NORTH)
				if (w_back.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1

		//Front-Right, Front-Left, Back-Right,Back-Left; FR, FL, BR, BL
			ticon = normal_icon

		if (EAST)
			if (w_left[1] != "")
				if (w_left[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_left[1]]", layer=10, dir=NORTH)
				if (w_left.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_right[1] != "")
				if (w_right[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_right[1]]", layer=10.5, dir=SOUTH)
				if (w_right.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_front[1] != "")
				if (w_front[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_front[1]]", layer=10, dir=EAST)
				if (w_front.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_back[1] != "")
				if (w_back[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_back[1]]", layer=10, dir=WEST)
				if (w_back.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1

		//Front-Right, Front-Left, Back-Right,Back-Left; FR, FL, BR, BL
			ticon = normal_icon

		if (WEST)
			if (w_left[1] != "")
				if (w_left[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_left[1]]", layer=10.5, dir=SOUTH)
				if (w_left.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_right[1] != "")
				if (w_right[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_right[1]]", layer=10, dir=NORTH)
				if (w_right.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_front[1] != "")
				if (w_front[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_front[1]]", layer=10, dir=WEST)
				if (w_front.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
			if (w_back[1] != "")
				if (w_back[5]<=0)
					ticon = broken_icon
				else
					ticon = normal_icon
				var/image/tmpimg1 = image(icon=ticon, icon_state="[w_back[1]]", layer=10, dir=EAST)
				if (w_back.len < 8)
					if (axis)
						if (override_color)
							tmpimg1.color = override_color
						else
							tmpimg1.color = axis.color
				overlays += tmpimg1
	if (hasoverlay)
		overlays += image(icon=ticon, icon_state=hasoverlay, layer=11, dir=OPPOSITE_DIR(src.dir))
	if (lights && !noroof)
		var/image/IMG = image(icon=ticon, icon_state="[lights.atype]_lights[lights.on ? "_on" : ""]", layer=11.1, dir=src.dir)
		if (!lights.centered)
			IMG.pixel_x = lights.pixel_x
			IMG.pixel_y = lights.pixel_y
		IMG.color = ""
		var/matrix/M = matrix()
		M.Scale(1.5)
		IMG.transform = M
		roof.overlays += IMG
	if (axis)
		var/image/overtracks = null
		for (var/image/II in overlays)
			if (mwheel && II.icon==mwheel.icon)
				II.color = axis.color
				overtracks = image(icon=mwheel.icon, loc=src, icon_state="[mwheel.icon_state]_u", layer=6, dir=mwheel.dir)
				overtracks.color = ""
		if (overtracks)
			overlays += overtracks