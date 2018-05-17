#!/bin/bash

# file in /tmp/ made by cronjob; to avoid getting kicked off from API access
# */5 * * * * wget https://api.9292.nl/0.1/locations/bemmel/bushalte-papenstraat/departure-times?lang=en-GB -O /tmp/deptimeswdg -o /dev/null

#usage: (script) [first bus to depart; 0] [second bus; 1] etc...
#example: ./widget.sh 0

#Generic
readarray -t stationName < <(cat /tmp/wdg-$2 | jq -r '.location .name')
readarray -t stationPlace < <(cat /tmp/wdg-$2 | jq -r '.location .place .name')

#Bus
readarray -t destBus < <(cat /tmp/wdg-$2 | jq -r '.tabs[0] .departures[] .destinationName')
readarray -t numberBus < <(cat /tmp/wdg-$2 | jq -r '.tabs[0] .departures[] .service')
readarray -t timeBus < <(cat /tmp/wdg-$2 | jq -r '.tabs[0] .departures[] .time')
readarray -t operatorBus < <(cat /tmp/wdg-$2 | jq -r '.tabs[0] .departures[] .operatorName')
readarray -t delayedBus < <(cat /tmp/wdg-$2 | jq -r '.tabs[0] .departures[] .realtimeText')

	if [[ ${operatorBus[$1]} = "Arriva" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Breng" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Syntus" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "OV Regio IJsselmond" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Prov Zeeland" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "GVU" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Connexxion" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Qbuzz" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Busverkehr Levelink" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "U-OV" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "EBS" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Flixbus" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "HTM" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "HTMbuzz" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "GVB" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "RET" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "Hermes" ]]; then
		operatorBusIcon[$1]="" 
	fi
	if [[ ${operatorBus[$1]} = "null" ]]; then
		operatorBusIcon[$1]="" 
	fi

	if [ ! "${numberBus[$1]}" == "" ]
        then
                echo -n "<txt><span font_style='normal' fgcolor='#2ff979'>${operatorBusIcon[$1]} <b>${numberBus[$1]}</b></span> ${destBus[$1]} - <span weight='bold' fgcolor='#2fd1f9'>${timeBus[$1]}</span>"
			if [ ! "${delayedBus[$1]}" == "null" ]
		then
			echo -n " <span weight='bold' fgcolor='red'>${delayedBus[$1]}</span></txt>"
			echo "<tool>Vertraagde ${operatorBusIcon[$1]} ${operatorBus[$1]} lijn ${numberBus[$1]} vanaf ${stationName[0]}, ${stationPlace[0]}</tool>"
		else
			echo -n "</txt>"
			echo "<tool>${operatorBusIcon[$1]} ${operatorBus[$1]} lijn ${numberBus[$1]} vanaf ${stationName[0]}, ${stationPlace[0]}</tool>"
		fi

        else
                echo -n "<txt><span font_style='italic' weight='bold' color='red'>Geen informatie beschikbaar</span></txt>"
                echo -n "<tool>Er rijden momenteel geen bussen vanaf ${stationName[0]}, ${stationPlace[0]}</tool>"
		echo "<tool>Geen informatie beschikbaar. Controleer de verbinding.</tool>"
        fi
