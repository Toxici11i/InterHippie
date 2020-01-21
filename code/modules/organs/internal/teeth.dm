/obj/item/stack/teeth
	name = "teeth"
	icon_state = "teeth"
	gender = PLURAL
	organ_tag = BP_TEETH
	parent_organ = BP_HEAD
	surface_accesible = FALSE
	relative_size = 5
	max_damage = 100
	desc = "Welp. Someone had their teeth knocked out."
	icon = 'icons/obj/teeth.dmi'

/obj/item/stack/teeth/human
	name = "human teeth"
	singular_name = "human tooth"

/datum/species/human
	teeth_type = /obj/item/stack/teeth/human

/datum/species/skeleton
	teeth_type = /obj/item/stack/teeth/human
