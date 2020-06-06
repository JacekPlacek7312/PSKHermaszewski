/datum/round_event_control/processor_overload
	name = "Processor Overload"
	typepath = /datum/round_event/processor_overload
	weight = 15
	min_players = 20

/datum/round_event/processor_overload
	announceWhen	= 1

/datum/round_event/processor_overload/announce(fake)
	var/alert = pick(	"Wykryto anomalie egzosferyczną. Możliwe przeciążenie procesorów. Po więcej informacji skontaktuj się z*%xp25)`6cq-BZZT", \
						"Wykryto anomalie egzosferyczną. Możliwe przeciążenie procesorów. Po więcej infor*1eta;c5;'1v¬-BZZZT", \
						"Wykryto anomalie egzosferyczną. Możliwe przeciążenie procesov#MCi46:5.;@63-BZZZZT", \
						"Wykryto anomalie egzosferyczną. Możliwe prz'Fz\\k55_@-BZZZZZT", \
						"Wykryto anomalie egzosfery:%£ QCbyj^j</.3-BZZZZZZT", \
						"!!hy%;f3l7e,<$^-BZZZZZZZT")

	for(var/mob/living/silicon/ai/A in GLOB.ai_list)
	//AIs are always aware of processor overload
		to_chat(A, "<br><span class='warning'><b>[alert]</b></span><br>")

	// Announce most of the time, but leave a little gap so people don't know
	// whether it's, say, a tesla zapping tcomms, or some selective
	// modification of the tcomms bus
	if(prob(80) || fake)
		priority_announce(alert)


/datum/round_event/processor_overload/start()
	for(var/obj/machinery/telecomms/processor/P in GLOB.telecomms_list)
		if(prob(10))
			announce_to_ghosts(P)
			// Damage the surrounding area to indicate that it popped
			explosion(get_turf(P), 0, 0, 2)
			// Only a level 1 explosion actually damages the machine
			// at all
			SSexplosions.highobj += P
		else
			P.emp_act(EMP_HEAVY)
