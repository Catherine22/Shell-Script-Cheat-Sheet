#!/bin/bash

## Generate a random password
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

## Generate a random password based on seconds (which will increase every second)
PASSWORD=$(date +%s)
echo "${PASSWORD}"

## Generate a rather stronger random password based on nanoseconds
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

## Generate a 8-character password based on the sha256sum of nanoseconds
PASSWORD=$(date +%s%N | sha256sum | head -c8)
echo "${PASSWORD}"

## Generate a 8-character password based on the sha256sum of nanoseconds and random numbers in conjunction
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c8)
echo "${PASSWORD}"

## Add special characters to the generated password
### Define special characters
S="!@#$%^&*()_-+="

### The 'shuf' method works on shuffling lines of text, you cannot shuffle a string directly, you must 'fold' it at first.
#### echo "${S}" | fold -b1 | shuf
### And retrieve the first line (including solely one character) from the shuffled, folded string
#### echo "${S}" | fold -b1 | shuf | head -n1
SPECIAL_CHAR=$(echo "${S}" | fold -b1 | shuf | head -n1)
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c8)
echo "${PASSWORD}${SPECIAL_CHAR}"

# To notify user that this script is done successfully.
exit 0
