/datum/controller/process/trade/setup()
	name = "trade"
	schedule_interval = 600 //1 minute
	for(var/i in 1 to rand(3,5))
		generateTrader(1)

/datum/controller/process/trade/doWork()
	for(var/a in traders)
		var/datum/trader/T = a
		if(!T.tick())
			traders -= T
			qdel(T)
	if(prob(50/traders.len))
		generateTrader()

/datum/controller/process/trade/proc/generateTrader(var/stations = 0)
	var/list/possible = list()
	if(stations)
		possible += subtypesof(/datum/trader) - typesof(/datum/trader/ship)
	else
		if(prob(0.5))
			possible += subtypesof(/datum/trader/ship/unique)
		else
			possible += subtypesof(/datum/trader/ship) - typesof(/datum/trader/ship/unique)

	var/type = pick(possible)
	traders += new type