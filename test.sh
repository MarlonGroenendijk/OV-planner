#!/bin/bash

wget https://api.9292.nl/0.1/locations/station-arnhem/departure-times?lang=en-GB -O /tmp/deptimes -o /dev/null

#Train
readarray -t destTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .destinationName')
readarray -t timeTrain < <(cat /tmp/deptimes | jq -r '.tabs[0] .departures[] .time')

#Bus
readarray -t destBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .destinationName')
readarray -t timeBus < <(cat /tmp/deptimes | jq -r '.tabs[1] .departures[] .time')

echo "Trein"

for ix in ${!destTrain[*]}
do
    echo -e "\e[33m  \e[32m\e[1mRichting:\e[0m\e[39m ${destTrain[$ix]} - \e[32m\e[1mVertrek:\e[0m\e[39m ${timeTrain[$ix]}"
done

echo "Bus"

for ix in ${!destBus[*]}
do
    echo -e "\e[33m  \e[32m\e[1mRichting:\e[0m\e[39m ${destBus[$ix]} - \e[32m\e[1mVertrek:\e[0m\e[39m ${timeBus[$ix]}"
done