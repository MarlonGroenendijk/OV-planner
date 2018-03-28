#!/bin/bash

#wget https://api.9292.nl/0.1/locations/station-amersfoort/departure-times?lang=nl-NL -O /tmp/deptimes -o /dev/null

#Train
readarray -t destTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .destinationName')
readarray -t timeTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .time')
readarray -t platformTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .platform')
readarray -t remarkTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .remark')
readarray -t typeTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .mode .name')
readarray -t operatorTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .operatorName')

#Bus
readarray -t destBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .destinationName')
readarray -t numberBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .service')
readarray -t timeBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .time')
readarray -t operatorBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .operatorName')
readarray -t delayedBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .realtimeText')

echo "Treinen"

for ix in ${!destTrain[*]}
do
	if [[ ${typeTrain[$ix]} = "Intercity" ]]; then
		typeTrain[$ix]="IC" 
	fi
	if [[ ${typeTrain[$ix]} = "Sprinter" ]]; then
		typeTrain[$ix]="SPR" 
	fi
	if [[ ${typeTrain[$ix]} = "Stoptrein" ]]; then
		typeTrain[$ix]="ST" 
	fi
	if [[ ${typeTrain[$ix]} = "Spitstrein" ]]; then
		typeTrain[$ix]="SP" 
	fi
	if [[ ${typeTrain[$ix]} = "Sneltrein" ]]; then
		typeTrain[$ix]="SN" 
	fi
	if [[ ${operatorTrain[$ix]} = "NS" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "Arriva" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "Breng" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "Blauwnet" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "Valleilijn" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "NS International" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "NMBS" ]]; then
		operatorTrainIcon[$ix]="" 
	fi
	if [[ ${operatorTrain[$ix]} = "DB" ]]; then
		operatorTrainIcon[$ix]="" 
	fi

	echo -e "\e[32m${operatorTrainIcon[$ix]}  ${operatorTrain[$ix]} \t\e[33m ${typeTrain[$ix]}\t\e[32m\e[1mRichting:\e[0m\e[39m ${destTrain[$ix]}\t\e[32m\e[1mVertrek:\e[0m\e[39m ${timeTrain[$ix]} \e[32m\e[1mSpoor:\e[0m\e[39m ${platformTrain[$ix]}"
	if [ ! "${remarkTrain[$ix]}" == "null" ]
	then
		echo -e " ^ \e[31m\e[1m  ${remarkTrain[$ix]}\e[0m ^"
	else
		echo -n ""
	fi
done

echo "Bus"

for ix in ${!destBus[*]}
do
	echo -ne "\e[32m${operatorBus[$ix]} \e[33m  \e[93m ${numberBus[$ix]}\t\e[32m\e[1mRichting:\t\e[0m\e[39m ${destBus[$ix]}\t\e[32m\e[1mVertrek:\e[0m\e[39m ${timeBus[$ix]}"
	if [ ! "${delayedBus[$ix]}" == "null" ]
	then
		echo -e "\e[31m\e[1m${delayedBus[$ix]}\e[0m" 
	else
		echo ""
	fi
done