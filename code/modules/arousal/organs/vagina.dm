/obj/item/organ/genital/vagina
	name = "vagina"
	desc = "A female reproductive organ."
	icon = 'icons/obj/genitals/vagina.dmi'
	icon_state = ORGAN_SLOT_VAGINA
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA
	size = 1 //There is only 1 size right now
	shape = DEF_VAGINA_SHAPE
	genital_flags = CAN_MASTURBATE_WITH|CAN_CLIMAX_WITH|GENITAL_CAN_AROUSE|GENITAL_UNDIES_HIDDEN|CAN_CUM_INTO
	masturbation_verb = "finger"
	arousal_verb = "You feel wetness on your crotch"
	unarousal_verb = "You no longer feel wet"
	fluid_transfer_factor = 0.1 //Yes, some amount is exposed to you, go get your AIDS
	layer_index = VAGINA_LAYER_INDEX
	var/cap_length = 8//D   E   P   T   H (cap = capacity)
	var/cap_girth = 12
	var/cap_girth_ratio = 1.5
	var/clits = 1
	var/clit_diam = 0.25
	var/clit_len = 0.25
	var/list/vag_types = list("tentacle", "dentata", "hairy", "spade", "furred")

/obj/item/organ/genital/vagina/update_appearance()
	. = ..()
	icon_state = "vagina"
	var/lowershape = lowertext(shape)
	var/details

	switch(lowershape)
		if("tentacle")
			details = "Its opening is lined with several tentacles and "
		if("dentata")
			details = "There's teeth inside it and it "
		if("hairy")
			details = "It has quite a bit of hair growing on it and "
		if("human")
			details = "It is taut with smooth skin, though without much hair and "
		if("gaping")
			details = "It is gaping slightly open, though without much hair and "
		if("spade")
			details = "It is a plush canine spade, it "
		if("furred")
			details = "It has neatly groomed fur around the outer folds, it "
		if("cloaca")
			details = "It it a tight, small horizontal vent and "
		else
			details = "It has an exotic shape and "
	if(aroused_state)
		details += "is slick with female arousal."
	else
		details += "seems to be dry."

	desc = "You see a vagina. [details]"

	if(owner)
		if(owner.dna.species.use_skintones && owner.dna.features["genitals_use_skintone"])
			if(ishuman(owner)) // Check before recasting type, although someone fucked up if you're not human AND have use_skintones somehow...
				var/mob/living/carbon/human/H = owner // only human mobs have skin_tone, which we need.
				color = SKINTONE2HEX(H.skin_tone)
				if(!H.dna.skin_tone_override)
					icon_state += "_s"
		else
			color = "#[owner.dna.features["vag_color"]]"
		if(ishuman(owner))
			var/mob/living/carbon/human/H = owner
			H.update_genitals()

/obj/item/organ/genital/vagina/get_features(mob/living/carbon/human/H)
	var/datum/dna/D = H.dna
	if(D.species.use_skintones && D.features["genitals_use_skintone"])
		color = SKINTONE2HEX(H.skin_tone)
	else
		color = "[D.features["vag_color"]]"
	shape = "[D.features["vag_shape"]]"
	toggle_visibility(D.features["vag_visibility"], FALSE)
