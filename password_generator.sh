#!/bin/bash

## Instead of handling user inputs via `read`, this script handles user inputs via input options
#read -p 'Type the length of the password: ' LENGTH

## Print manual while any error occurs
usage() {
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo 'Generate a random password'
    echo '  -l LENGTH  Specify a password length'
    echo '  -s         Append a special character to the password'
    echo '  -v         Increase verbosity'
    exit 1
}

## Set a default password length
LENGTH=48

## Input options.
while getopts vl:s OPTION
do
    case ${OPTION} in
        v)
            VERBOSE='true'
            echo 'Verbose mode on'
            ;;
        l)
            LENGTH="${OPTARG}"
            ;;
        s)
            USE_SPECIAL_CHARACTERS='true'
            ;;
        ?)
            Usage
            ;;
    esac
done


## Define special characters
S="!@#$%^&*()_-+="
## Generate a random special character
SPECIAL_CHAR=$(echo "${S}" | fold -b1 | shuf | head -n1)

## Generate a 8-character password based on the sha256sum of nanoseconds and random numbers in conjunction
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH-1})
echo "${PASSWORD}${SPECIAL_CHAR}"

## Notify user that this script is done successfully.
exit 0
