#!/bin/bash

wget "https://api.9292.nl/0.1/locations/?lang=en-GB&q=$1" -O /tmp/OVsearch -o /dev/null

readarray -t ID < <(cat /tmp/OVsearch | jq -r '.locations[] .id')
readarray -t name < <(cat /tmp/OVsearch | jq -r '.locations[] .name')
readarray -t placeType < <(cat /tmp/OVsearch | jq -r '.locations[] .type')


echo "Resultaten: "
for ix in ${!ID[*]}
do
	if [[ ${placeType[$ix]} = "poi" ]]; then
		ID[$ix]=null 
		name[$ix]=null
	fi
	if [[ ${placeType[$ix]} = "place" ]]; then
		ID[$ix]=null 
		name[$ix]=null
	fi
	if [[ ${placeType[$ix]} = "street" ]]; then
		ID[$ix]=null 
		name[$ix]=null
	fi
	if [[ ${placeType[$ix]} = "address" ]]; then
		ID[$ix]=null 
		name[$ix]=null
	fi
	if [[ ${placeType[$ix]} = "station" ]]; then
		echo -e "\e[32m\e[1mNaam:\e[0m\e[39m ${name[$ix]} \e[32m\e[1mID:\e[0m\e[39m ${ID[$ix]} - \e[93m\e[1mOutput URL: https://api.9292.nl/0.1/locations/${ID[$ix]}/departure-times?lang=nl-NL\e[0m\e[39m"
	fi
	if [[ ${placeType[$ix]} = "stop" ]]; then
		echo -e "\e[32m\e[1mNaam:\e[0m\e[39m ${name[$ix]} \e[32m\e[1mID:\e[0m\e[39m ${ID[$ix]} - \e[93m\e[1mOutput URL: https://api.9292.nl/0.1/locations/${ID[$ix]}/departure-times?lang=nl-NL\e[0m\e[39m"
	fi
done