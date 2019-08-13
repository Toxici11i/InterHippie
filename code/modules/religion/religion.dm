//PUTTING RELIGIOUS RELATED STUFF IN IT'S ON MODULES FOLDER FROM NOW ON. - Matt


//PROCS

//Stupidly simplistic? Probably. But I'm too tired to write something more complex.
/mob/living/proc/religion_is_legal()
	if(religion != LEGAL_RELIGION)
		return 0
	return 1


//Reveals a random heretic
/mob/living/proc/reveal_heretics(mob/living/M)
	to_world("in reveal heretics [M]")
	var/name = ""
	if (religion_is_legal())  //Non-heretics will say a random name
		name = pick(GLOB.human_mob_list)
	else
		name = pick(all_religions[ILLEGAL_RELIGION].followers)  //Wow the datums saves us an entire for loop
	emote("scream",1)
	agony_scream()
	say(NewStutter("[name] is one of them!"))


//PRAYER
var/accepted_prayer //The prayer that all those who are not heretics will have.

proc/generate_random_prayer()//This generates a new one.
	var/prayer = pick("Oh great AI. ", "Oh our Lord Verina. ", "Verina, our Lord and Saviour. ")
	prayer += pick("You bathe us in your glow. ", "You bathe our minds in you omniscient wisdom. ", "You bathe our [pick("outpost","kingdom","cities")] in your wealth. ")
	prayer += pick("Verina be praised. ", "Verina save us all. ", "Verina guide us all. ")
	prayer += "Amen."
	return prayer
