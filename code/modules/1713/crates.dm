#define DYNAMIC_AMT -1

// increase or decrease the amount of items in a crate
/*/obj/structure/closet/crate/proc/resize(decimal)
	if (decimal > 1.0)
		var/add_crates = max(1, ceil((decimal - 1.0) * contents.len))
		for (var/v in 1 to add_crates)
			if (!contents.len)
				break
			var/atom/object = pick(contents)
			if (object)
				var/object_type = object.type
				new object_type(src)

	else if (decimal < 1.0)
		var/remove_crates = ceil((1.0 - decimal) * contents.len)
		for (var/v in 1 to remove_crates)
			if (!contents.len)
				break
			contents -= pick(contents)
	update_capacity(contents.len)
	*/
/obj/structure/closet/crate/var/list/paths = list() // typepath = amount

/obj/structure/closet/crate/New()
	..()
	crate_list += src
	for (var/typepath in paths)
		var/limit = paths[typepath]
		if (limit == DYNAMIC_AMT)
			var/atom/ref = new typepath (null)
			limit = max(3, min(ceil(75/round(ref.contents.len/2)), 12))
			if (ref.contents.len < 100)
				limit += pick(2,3)
			qdel(ref)
		for (var/v in 1 to limit)
			new typepath (src)
	update_capacity(contents.len)

/obj/structure/closet/crate/Destroy()
	crate_list -= src
	..()

// new crate icons from F13 - most are unused

/* todo: turn some crates into CARTS and re-enable this
/obj/structure/closet/crate
	icon = 'icons/obj/crate.dmi'*/

obj/structure/closet/crate/chest
	name = "wood chest"
	desc = "Maybe there's a treasure inside?"
	icon_state = "wood_chest"
	icon_opened = "wood_chest_opened"
	icon_closed = "wood_chest"
	storage_capacity = 5 * MOB_MEDIUM

obj/structure/closet/crate/treasurechest
	name = "treasure chest"
	desc = "There's probably treasure inside."
	icon_state = "treasure_chest"
	icon_opened = "treasure_chest_opened"
	icon_closed = "treasure_chest"
	storage_capacity = 5 * MOB_MEDIUM

obj/structure/closet/crate/loottreasurechest
	name = "wood chest"
	desc = "There's probably treasure inside."
	icon_state = "treasure_chest"
	icon_opened = "treasure_chest_opened"
	icon_closed = "treasure_chest"
	storage_capacity = 5 * MOB_MEDIUM

obj/structure/closet/crate/loottreasurechest/New()
	..()
	var/rarity = rand(0,10)
	if(rarity <= 2)
		paths = list(/obj/item/stack/ore/tin = rand(0, 2),
				/obj/item/stack/ore/copper = rand(0, 2),
				/obj/item/stack/ore/coal = rand(0, 2),
				/obj/item/stack/ore/lead = rand(0, 2),
				/obj/item/stack/material/bone = rand(0, 2),
				/obj/item/stack/material/stone = rand(0, 2),
				/obj/item/stack/material/leather = rand(0, 2),
				/obj/item/stack/material/cotton = rand(0, 2),
				/obj/item/stack/material/cloth = rand(0, 2),
				/obj/item/stack/material/wool = rand(0, 2),
				/obj/item/stack/material/woolcloth = rand(0, 2),
				/obj/item/stack/material/rope = rand(0, 2),
				/obj/item/stack/money/coppercoin = rand(2, 4),
				/obj/item/stack/money/silvercoin = rand(2, 4),
				/obj/item/stack/money/goldnugget = rand(1, 2))
	else if(rarity > 2 && rarity <= 4)
		paths = list(/obj/item/stack/ore/iron = rand(0, 3),
				/obj/item/stack/ore/tin = rand(0, 3),
				/obj/item/stack/ore/copper = rand(0, 3),
				/obj/item/stack/ore/lead = rand(0, 3),
				/obj/item/stack/ore/gold = rand(0, 3),
				/obj/item/stack/ore/silver = rand(0, 3),
				/obj/item/stack/material/iron = rand(0, 3),
				/obj/item/stack/material/bronze = rand(0, 3),
				/obj/item/stack/material/copper = rand(0, 3),
				/obj/item/stack/material/tin = rand(0, 3),
				/obj/item/stack/material/stone = rand(0, 3),
				/obj/item/stack/material/gold = rand(0, 3),
				/obj/item/stack/material/silver = rand(0, 3),
				/obj/item/stack/money/coppercoin = rand(2, 4),
				/obj/item/stack/money/silvercoin = rand(2, 4),
				/obj/item/stack/money/goldcoin = rand(2, 4),
				/obj/item/stack/money/gems = rand(1, 2),
				/obj/item/stack/money/goldnugget = rand(2, 3),)

	else if(rarity > 4 && rarity <= 8)
		paths = list(/obj/item/stack/ore/iron = rand(0, 4),
				/obj/item/stack/ore/tin = rand(0, 4),
				/obj/item/stack/ore/copper = rand(0, 4),
				/obj/item/stack/ore/lead = rand(0, 4),
				/obj/item/stack/ore/gold = rand(0, 4),
				/obj/item/stack/ore/silver = rand(0, 4),
				/obj/item/stack/material/iron = rand(0, 4),
				/obj/item/stack/material/bronze = rand(0, 4),
				/obj/item/stack/material/copper = rand(0, 4),
				/obj/item/stack/material/tin = rand(0, 4),
				/obj/item/stack/material/stone = rand(0, 4),
				/obj/item/stack/material/gold = rand(0, 4),
				/obj/item/stack/material/silver = rand(0, 4),
				/obj/item/stack/money/coppercoin = rand(3, 4),
				/obj/item/stack/money/silvercoin = rand(3, 4),
				/obj/item/stack/money/goldcoin = rand(3, 4),
				/obj/item/stack/money/gems = rand(2, 3),
				/obj/item/stack/money/goldnugget = rand(2, 3),
				/obj/item/stack/money/goldvaluables = rand(2, 3),
				/obj/item/stack/money/pearls = rand(2, 3),)
	else
		paths = list(/obj/item/stack/ore/iron = rand(0, 4),
				/obj/item/stack/ore/tin = rand(0, 4),
				/obj/item/stack/ore/copper = rand(0, 4),
				/obj/item/stack/ore/lead = rand(0, 4),
				/obj/item/stack/ore/gold = rand(0, 4),
				/obj/item/stack/ore/silver = rand(0, 4),
				/obj/item/stack/material/iron = rand(0, 4),
				/obj/item/stack/material/bronze = rand(0, 4),
				/obj/item/stack/material/copper = rand(0, 4),
				/obj/item/stack/material/tin = rand(0, 4),
				/obj/item/stack/material/stone = rand(0, 4),
				/obj/item/stack/material/gold = rand(0, 4),
				/obj/item/stack/material/silver = rand(0, 4),
				/obj/item/stack/money/coppercoin = rand(3, 4),
				/obj/item/stack/money/silvercoin = rand(3, 4),
				/obj/item/stack/money/goldcoin = rand(3, 4),
				/obj/item/stack/money/gems = rand(2, 3),
				/obj/item/stack/money/goldnugget = rand(2, 3),
				/obj/item/stack/money/goldvaluables = rand(2, 3),
				/obj/item/stack/money/pearls = rand(2, 3),
				/obj/item/cursedtreasure = rand(0, 1),
				/obj/item/weapon/material/sword/longsword/diamond = 1,)
	for (var/stack in contents)
		var/obj/item/stack/S = stack
		S.amount = rand(1+rarity,(rarity+1)*2)

obj/structure/closet/crate/chest/treasury
	name = "colony treasury"
	desc = "Where the colony treasury is stored."
	icon_state = "treasure_chest"
	icon_opened = "treasure_chest_opened"
	icon_closed = "treasure_chest"
	anchored = TRUE
	var/faction = "civilian"

obj/structure/closet/crate/empty
	name = "wood crate"
	desc = "A wooden crate."
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"

/obj/structure/closet/crate/empty/large
	name = "large crate"
	desc = "A hefty wooden crate."
	icon = 'icons/obj/storage.dmi'
	icon_state = "densecrate"
	icon_opened = "densecrate_open"
	icon_closed = "densecrate"
	storagecap = 20

/obj/structure/closet/crate/cash_register
	name = "cash register"
	desc = "Used to hold money at a shop."
	icon = 'icons/obj/modern_structures.dmi'
	icon_state = "cash_register"
	icon_opened = "cash_register_opened"
	icon_closed = "cash_register"
	flammable = FALSE
	not_disassemblable = TRUE
	opacity = FALSE
	density = FALSE
	storagecap = 6

/obj/structure/closet/crate/bayonets
	name = "bayonets crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/attachment/bayonet/military = 10)
	cratevalue = 132//100 base value from 100 planks of wood

/obj/structure/closet/crate/sandbags
	name = "sandbag crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/barrier/sandbag = 20)
	cratevalue = 90

/obj/structure/closet/crate/wood
	name = "wood planks crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/stack/material/wood = 5)
	cratevalue = 120 //100 base value from 100 planks of wood

/obj/structure/closet/crate/wood/New()
	..()
	for (var/stack in contents)
		var/obj/item/stack/S = stack
		S.amount = 20

/obj/structure/closet/crate/steel
	name = "steel sheets crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/stack/material/steel = 5)
	cratevalue = 550 //500 base value from 100 steel sheets

/obj/structure/closet/crate/steel/New()
	..()
	for (var/stack in contents)
		var/obj/item/stack/S = stack
		S.amount = 20

/obj/structure/closet/crate/iron
	name = "iron ingots crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/stack/material/iron = 5)
	cratevalue = 330 //300 base value from 100 iron sheets

/obj/structure/closet/crate/iron/New()
	..()
	for (var/stack in contents)
		var/obj/item/stack/S = stack
		S.amount = 20

/obj/structure/closet/crate/stone
	name = "stone blocks crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/stack/material/stone = 5)
	cratevalue = 130 //100 base value from 100 stone blocks

/obj/structure/closet/crate/stone/New()
	..()
	for (var/stack in contents)
		var/obj/item/stack/S = stack
		S.amount = 20


/obj/structure/closet/crate/glass
	name = "glass sheets crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/stack/material/glass = 5)
	cratevalue = 330 //300 base value from 100 glass sheets

/obj/structure/closet/crate/glass/New()
	..()
	for (var/stack in contents)
		var/obj/item/stack/S = stack
		S.amount = 20

/obj/structure/closet/crate/rations/
	name = "rations"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"

/obj/structure/closet/crate/rations/vegetables
	name = "Rations: vegetables"
	paths = list(/obj/item/weapon/reagent_containers/food/snacks/grown/potato = 4,
				/obj/item/weapon/reagent_containers/food/snacks/grown/beans = 4,
				/obj/item/weapon/reagent_containers/food/snacks/grown/cabbage = 4,
				/obj/item/weapon/reagent_containers/food/snacks/grown/carrot = 4,)
	cratevalue = 60 //48 base, 16 grown stuff x 3

/obj/structure/closet/crate/rations/fruits
	name = "Rations: fruits"
	paths = list(/obj/item/weapon/reagent_containers/food/snacks/grown/lemon = 3,
				/obj/item/weapon/reagent_containers/food/snacks/grown/lime = 3,
				/obj/item/weapon/reagent_containers/food/snacks/grown/apple = 3,
				/obj/item/weapon/reagent_containers/food/snacks/grown/orange = 3,
				/obj/item/weapon/reagent_containers/food/snacks/grown/banana = 3,
				/obj/item/weapon/reagent_containers/food/snacks/grown/coconut = 3,)
	cratevalue = 66 //54, 18 x 3

/obj/structure/closet/crate/rations/biscuits
	name = "Rations: biscuits"
	paths = list(/obj/item/weapon/reagent_containers/food/snacks/hardtack = 20,)
	cratevalue = 50 //Nutrient amt = 2, 2 x 2 for value so 20 x 2 = 40 base

/obj/structure/closet/crate/rations/beer
	name = "Rations: beer"
	paths = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/small/beer = 10,)
	cratevalue = 60 //50 base

/obj/structure/closet/crate/rations/ale
	name = "Rations: ale"
	paths = list(/obj/item/weapon/reagent_containers/food/drinks/bottle/small/ale = 10,)
	cratevalue = 70 //60 base

/obj/structure/closet/crate/rations/meat
	name = "Rations: meat"
	paths = list(/obj/item/weapon/reagent_containers/food/snacks/meat = 7,)
	cratevalue = 70 //just putting this here

/obj/structure/closet/crate/rations/seeds/trees
	name = "Seeds: Trees"
	paths = list(/obj/item/stack/farming/seeds/apple = 4,
				/obj/item/stack/farming/seeds/tree = 4,
				/obj/item/stack/farming/seeds/orange = 4,)
	cratevalue = 30 //seeds don't have a value, effort into farming harvesting and exporting is already lots of work

/obj/structure/closet/crate/rations/seeds/cereals
	name = "Seeds: Cereals (+yeast)"
	paths = list(/obj/item/stack/farming/seeds/wheat = 6,
				/obj/item/stack/farming/seeds/corn = 6,
				/obj/item/weapon/reagent_containers/food/condiment/enzyme = 1,
				/obj/item/weapon/reagent_containers/food/condiment/enzyme = 1)
	cratevalue = 50

/obj/structure/closet/crate/rations/seeds/vegetables
	name = "Seeds: Vegetables"
	paths = list(/obj/item/stack/farming/seeds/tomato = 4,
				/obj/item/stack/farming/seeds/potato = 4,
				/obj/item/stack/farming/seeds/cabbage = 4,)
	cratevalue = 30

/obj/structure/closet/crate/rations/seeds/cashcrops
	name = "Seeds: Cash Crops"
	paths = list(/obj/item/stack/farming/seeds/tobacco = 3,
				/obj/item/stack/farming/seeds/sugarcane = 3,
				/obj/item/stack/farming/seeds/hemp = 3,
				/obj/item/stack/farming/seeds/flax = 3,
				/obj/item/stack/farming/seeds/cotton = 3,)
	cratevalue = 60

/obj/structure/closet/crate/rations/seeds/medicinal
	name = "Seeds: Medicinal"
	paths = list(/obj/item/stack/farming/seeds/poppy = 3,
				/obj/item/stack/farming/seeds/tea = 3,
				/obj/item/stack/farming/seeds/coffee = 3,
				/obj/item/stack/farming/seeds/peyote = 3,)
	cratevalue = 50

/obj/structure/closet/crate/brick
	name = "bricks crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/clay/advclaybricks/fired = 70)
	cratevalue = 120 //100 base value from 100 planks of wood
///WEAPONS///

/obj/structure/closet/crate/grenades
	name = "Grenade crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/grenade/old_grenade = 10)
	cratevalue = 110 //assuming value = 10 as no value yet

/obj/structure/closet/crate/musketball
	name = "Musket ammunition crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/musketball = 25)
	cratevalue = 100 //base 75, 25 x 3
/obj/structure/closet/crate/muskets
	name = "Musket crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/gun/projectile/flintlock/musket = 5)
	cratevalue = 550 //100*5
/obj/structure/closet/crate/musketoons
	name = "Musketoon crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/gun/projectile/flintlock/musketoon = 5)
	cratevalue = 440 //80*5
/obj/structure/closet/crate/pistols
	name = "Pistol crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/gun/projectile/flintlock/pistol = 5)
	cratevalue = 385 //70*5
/obj/structure/closet/crate/blunderbusses
	name = "blunderbuss crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/gun/projectile/flintlock/blunderbuss = 5)
	cratevalue = 495 //90*5
/obj/structure/closet/crate/musketball_pistol
	name = "Pistol ammunition crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/musketball_pistol = 25)
	cratevalue = 60 //base value 50

/obj/structure/closet/crate/blunderbuss_ammo
	name = "Blunderbuss ammunition crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/blunderbuss = 15)
	cratevalue = 60 //base value 45

/obj/structure/closet/crate/cannonball
	name = "Cannonball crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/cannon_ball = 15)
	cratevalue = 175 //assuming 10 value

/obj/structure/closet/crate/webbings
	name = "bandolier crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/clothing/accessory/storage/webbing = 10)
	cratevalue = 110 //assuming 10 value


////WW1////////
obj/structure/closet/crate/ww1/grenades_french
	name = "F1 grenade crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/grenade/modern/f1 = 10)

obj/structure/closet/crate/ww1/grenades_german
	name = "stg 1915 grenade crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/grenade/modern/stg1915 = 10)

obj/structure/closet/crate/ww1/grenades_british
	name = "Mills grenade crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/weapon/grenade/modern/mills = 10)


obj/structure/closet/crate/ww1/ammo_hotchkiss
	name = "Hotchkiss belts crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_magazine/hotchkiss = 3)

obj/structure/closet/crate/ww1/ammo_type3
	name = "Type 3 belts crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_magazine/type3 = 3)

obj/structure/closet/crate/ww1/ammo_vickers
	name = "Vickers belts crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_magazine/vickers = 3)

obj/structure/closet/crate/ww1/ammo_mg08
	name = "MG08 belts crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_magazine/mg08 = 3)
obj/structure/closet/crate/ww1/ammo_maxim
	name = "Maxim belts crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_magazine/maxim = 3)

obj/structure/closet/crate/ww2
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"
	name = "military crate"

obj/structure/closet/crate/ww2/mk2
	name = "Mk2 grenade crate"
	paths = list(/obj/item/weapon/grenade/ww2/mk2 = 10)

obj/structure/closet/crate/ww2/rgd33
	name = "RGD33 grenade crate"
	paths = list(/obj/item/weapon/grenade/ww2/rgd33 = 10)

obj/structure/closet/crate/ww2/stg1924
	name = "stg 1924 grenade crate"
	paths = list(/obj/item/weapon/grenade/ww2/stg1924 = 10)

obj/structure/closet/crate/ww2/ammo_mg34
	name = "MG34 belts crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_magazine/mg34belt = 3)
obj/structure/closet/crate/ww2/panzerfaust
	name = "Panzerfaust crate"
	paths = list(/obj/item/weapon/gun/launcher/rocket/panzerfaust = 6)

obj/structure/closet/crate/ww2/atmines
	name = "anti-tank mines crate"
	paths = list(/obj/item/mine/at = 5)

obj/structure/closet/crate/ww2/rpg40
	name = "RPG-40 AT grenade crate"
	paths = list(/obj/item/weapon/grenade/antitank/rpg40 = 6)

obj/structure/closet/crate/ww2/g43
	name = "G43 ammunition crate"
	paths = list(/obj/item/ammo_magazine/g43 = 10)

obj/structure/closet/crate/ww2/mp40
	name = "MP40 ammunition crate"
	paths = list(/obj/item/ammo_magazine/mp40 = 8)

obj/structure/closet/crate/ww2/mosin_ammo
	name = "Mosin ammunition crate"
	paths = list(/obj/item/ammo_magazine/mosin = 25)

obj/structure/closet/crate/ww2/mosin
	name = "Mosin 1891/30 crate"
	paths = list(/obj/item/weapon/gun/projectile/boltaction/mosin/m30 = 20)

obj/structure/closet/crate/ww2/mosin_old
	name = "Mosin 1891 crate"
	paths = list(/obj/item/weapon/gun/projectile/boltaction/mosin = 20)

obj/structure/closet/crate/ww2/stg
	name = "StG44 ammunition crate"
	paths = list(/obj/item/ammo_magazine/stg = 8)

obj/structure/closet/crate/ww2/svt
	name = "SVT-40 ammunition crate"
	paths = list(/obj/item/ammo_magazine/svt = 10)

obj/structure/closet/crate/ww2/ppsh
	name = "PPSH ammunition crate"
	paths = list(/obj/item/ammo_magazine/c762x25_ppsh = 8)

obj/structure/closet/crate/ww2/pps
	name = "PPS ammunition crate"
	paths = list(/obj/item/ammo_magazine/c762x25_pps = 8)

obj/structure/closet/crate/coldwar/m26
	name = "M26 grenade crate"
	paths = list(/obj/item/weapon/grenade/coldwar/m26 = 10)

obj/structure/closet/crate/coldwar/m18
	name = "M18 smoke grenade crate"
	paths = list(/obj/item/weapon/grenade/smokebomb/m18smoke = 10)

obj/structure/closet/crate/ww2/mortar_shells
	name = "mortar shells"
	paths = list(/obj/item/cannon_ball/mortar_shell = 15)

obj/structure/closet/crate/ww2/artillery_shells
	name = "HE artillery shells"
	paths = list(/obj/item/cannon_ball/shell = 10)

obj/structure/closet/crate/ww2/artillery_shells/HE57
	name = "57 mm HE shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/HE57 = 10)

obj/structure/closet/crate/ww2/artillery_shells/AP57
	name = "57 mm AP shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/AP57 = 10)

obj/structure/closet/crate/ww2/artillery_shells/APCR57
	name = "57 mm APCR shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/APCR57 = 10)

obj/structure/closet/crate/ww2/artillery_shells/HE75
	name = "75 mm HE shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/HE75 = 10)

obj/structure/closet/crate/ww2/artillery_shells/AP75
	name = "75 mm AP shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/AP75 = 10)

obj/structure/closet/crate/ww2/artillery_shells/APCR75
	name = "75 mm APCR shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/APCR75 = 10)

obj/structure/closet/crate/ww2/artillery_shells/HE76
	name = "76.2 mm HE shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/HE76 = 10)

obj/structure/closet/crate/ww2/artillery_shells/AP76
	name = "76.2 mm AP shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/AP76 = 10)

obj/structure/closet/crate/ww2/artillery_shells/APCR76
	name = "76.2 mm APCR shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/APCR76 = 10)

obj/structure/closet/crate/ww2/artillery_shells/HE88
	name = "88 mm HE shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/HE88 = 10)

obj/structure/closet/crate/ww2/artillery_shells/AP88
	name = "88 mm AP shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/AP88 = 10)

obj/structure/closet/crate/ww2/artillery_shells/APCR88
	name = "88 mm APCR shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/APCR88 = 10)

obj/structure/closet/crate/ww2/artillery_shells/HE85
	name = "85 mm HE shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/HE85 = 10)

obj/structure/closet/crate/ww2/artillery_shells/AP85
	name = "85 mm AP shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/AP85 = 10)

obj/structure/closet/crate/ww2/artillery_shells/APCR85
	name = "85 mm APCR shells crate"
	paths = list(/obj/item/cannon_ball/shell/tank/APCR85 = 10)

obj/structure/closet/crate/airdrops
	icon_state = "mil_crate_closed"
	icon_opened = "mil_crate_opened"
	icon_closed = "mil_crate_closed"
	name = "military crate"

obj/structure/closet/crate/airdrops/supplies
	name = "supplies crate"
	paths = list(/obj/item/weapon/reagent_containers/food/snacks/MRE/generic = 3,
				/obj/item/stack/medical/advanced/bruise_pack = 1,
				/obj/item/stack/medical/advanced/ointment = 1,
				/obj/item/stack/material/steel/twentyfive = 1,
				/obj/item/weapon/storage/pill_bottle/potassium_iodide = 1,)

obj/structure/closet/crate/airdrops/food
	name = "food crate"
	paths = list(/obj/item/weapon/reagent_containers/food/snacks/MRE/generic = 10,)

obj/structure/closet/crate/airdrops/weapons
	name = "weapons crate"
	paths = list(/obj/item/weapon/gun/projectile/submachinegun/makeshiftak47 = 1,
				/obj/item/weapon/gun/projectile/boltaction/singleshot/makeshiftbolt = 1,
				/obj/item/ammo_magazine/ak47/makeshift = 2,
				/obj/item/ammo_casing/a762x54 = 10)

obj/structure/closet/crate/airdrops/military
	name = "military crate"
	paths = list(/obj/item/weapon/gun/projectile/submachinegun/m16 = 1,
				/obj/item/ammo_magazine/m16 = 2,
				/obj/item/clothing/mask/gas/military = 1,
				/obj/item/clothing/accessory/armor/nomads/thickcarrier = 1,
				/obj/item/weapon/grenade/modern/f1 = 1,
				/obj/item/clothing/head/helmet/modern/lwh = 1,
				/obj/item/weapon/reagent_containers/food/snacks/MRE/generic/american = 2)

obj/structure/closet/crate/airdrops/medicine
	name = "medicine crate"
	paths = list(/obj/item/weapon/storage/firstaid/combat/modern = 1,
				/obj/item/weapon/storage/firstaid/adv = 1,
				/obj/item/weapon/storage/pill_bottle/potassium_iodide = 1,)

/obj/structure/closet/crate/arrows
	name = "arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow = 20)

/obj/structure/closet/crate/arrows/bronze
	name = "bronze arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow/bronze = 20)

/obj/structure/closet/crate/arrows/copper
	name = "copper arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow/copper = 20)

/obj/structure/closet/crate/arrows/iron
	name = "iron arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow/iron = 20)

/obj/structure/closet/crate/arrows/modern
	name = "modern arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow/modern = 20)

/obj/structure/closet/crate/arrows/steel
	name = "steel arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow/steel = 20)

/obj/structure/closet/crate/arrows/stone
	name = "stone arrow crate"
	icon_state = "wood_crate"
	icon_opened = "wood_crate_opened"
	icon_closed = "wood_crate"
	paths = list(/obj/item/ammo_casing/arrow/stone = 20)
#undef DYNAMIC_AMT
