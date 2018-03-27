#!/bin/bash

wget "https://api.9292.nl/0.1/locations/?lang=en-GB&q=$1" -O /tmp/OVsearch -o /dev/null

readarray -t ID < <(cat /tmp/OVsearch | jq -r '.locations[] .id')
readarray -t name < <(cat /tmp/OVsearch | jq -r '.locations[] .name')

for ix in ${!ID[*]}
do
    echo -e "ID: ${ID[$ix]} - Naam: ${name[$ix]}"
done