#!/bin/bash

# file in /tmp/ made by cronjob; to avoid getting kicked off from API access
# */5 * * * * wget https://api.9292.nl/0.1/locations/bemmel/bushalte-papenstraat/departure-times?lang=en-GB -O /tmp/deptimeswdg -o /dev/null

#usage: (script) [first bus to depart; 0] [second bus; 1] etc...
#example: ./widget.sh 0

#Bus
readarray -t destBus < <(cat /tmp/deptimeswdg | jq -r '.tabs[0] .departures[] .destinationName')
readarray -t numberBus < <(cat /tmp/deptimeswdg | jq -r '.tabs[0] .departures[] .service')
readarray -t timeBus < <(cat /tmp/deptimeswdg | jq -r '.tabs[0] .departures[] .time')
readarray -t operatorBus < <(cat /tmp/deptimeswdg | jq -r '.tabs[0] .departures[] .operatorName')
readarray -t delayedBus < <(cat /tmp/deptimeswdg | jq -r '.tabs[0] .departures[] .realtimeText')

	echo -n " N: ${numberBus[$1]} ${destBus[$1]} - V: ${timeBus[$1]}"
	if [ ! "${delayedBus[$1]}" == "null" ]
	then
		echo -ne "${delayedBus[$1]}" 
	fi