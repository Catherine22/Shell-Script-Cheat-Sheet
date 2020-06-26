#!/bin/bash

## Instead of handling user inputs via `read`, this script handles user inputs via input options
#read -p 'Type the length of the password: ' LENGTH

## Print manual while any error occurs
usage() {
    echo 'Generate a random password'
    echo '  -l, --length  LENGTH   Specify a password length'
    echo '  -s                     Append a special character to the password'
    echo '  -v, --verbose          Increase verbosity'
    exit 1
}

log() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}

## Set a default password length
LENGTH=48
USE_SPECIAL_CHARACTERS='false'
## Define special characters
SPECIAL_CHARACTERS="!@#$%^&*()_-+="

## Input options (l:vs means the option (l) must be followed with an argument whereas options(vs) after : are not)
while getopts l:vs OPTION
do
    case ${OPTION} in
        h)
            usage
            ;;
        v)
            VERBOSE='true'
            log 'Verbose mode: [on]'
            ;;
        l)
            LENGTH="${OPTARG}"
            ;;
        s)
            USE_SPECIAL_CHARACTERS='true'
            ;;
        ?)
            echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
            usage
            ;;
    esac
done

log "Number of args: [${#}]"
log "All args: [${@}]"

## Remove the options while remaining arguments
shift "$(( OPTIND - 1 ))"
if [[ "${#}" -gt 0 ]]
then
    usage
fi

log '> Generating a password...'

if [[ "${USE_SPECIAL_CHARACTERS}" = 'true' ]]
then
    log '> Selecting a random special character...'
    
    ## Generate a random special character
    SPECIAL_CHAR=$(echo "${SPECIAL_CHARACTERS}" | fold -b1 | shuf | head -n1)

    ## Generate a 8-character password based on the sha256sum of nanoseconds and random numbers in conjunction
    PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH-1})
else
    ## Generate a 8-character password based on the sha256sum of nanoseconds and random numbers in conjunction
    PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})
fi

log '> Done.'
log 'Here is the password:'

if [[ "${USE_SPECIAL_CHARACTERS}" = 'true' ]]
then
    echo "${PASSWORD}${SPECIAL_CHAR}"
else
    echo "${PASSWORD}"
fi
## Notify user that this script is done successfully
exit 0

