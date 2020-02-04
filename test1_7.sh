#!/bin/bash

# shift + while-loop
while [[ "${#}" -gt 0 ]]
do
   echo "Number of parameters: ${#}"
   echo "Param 1: ${1}"
   echo "Param 2: ${2}"
   echo "Param 3: ${3}"
   echo
   shift
done