#!/bin/bash

# Display what user typed on the command line
echo "You executed this command: ${0}"

# Display the path and filename of this file
echo "You puth the $(basename ${0}) script under the path: $(dirname ${0})"

# Check how many arguments are passed
NUMBERS_OF_PARAMS="${#}"
echo "You supplied ${NUMBERS_OF_PARAMS} argument(s) on the command line"

# Make sure the user at least supply on argument
if [[ "${NUMBERS_OF_PARAMS}" -lt 1 ]] # -lt 1: less than 1
then
  echo "Usage: ${0} USERNAME [USERNAME]..."
  exit 1
fi

# Generate passwords for each user
S="!@#$%^&*()_-+="
for USERNAME in "${@}"
do
  SPECIAL_CHAR=$(echo "${S}" | fold -b1 | shuf | head -n1)
  PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c12)
  echo "${USERNAME}:${PASSWORD}${SPECIAL_CHAR}"
done
exit 0