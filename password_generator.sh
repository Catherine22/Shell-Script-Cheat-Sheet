#!/bin/bash

read -p 'Type the length of the password: ' LENGTH

## Define special characters
S="!@#$%^&*()_-+="
## Generate a random special character
SPECIAL_CHAR=$(echo "${S}" | fold -b1 | shuf | head -n1)

## Generate a 8-character password based on the sha256sum of nanoseconds and random numbers in conjunction
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH-1})
echo "${PASSWORD}${SPECIAL_CHAR}"

# To notify user that this script is done successfully.
exit 0
