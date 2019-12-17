#!/bin/bash

# Display the UID and username of the user executing this script.
echo "UID: ${UID}"

# If-statement
TEST_UID='1000'

if [[ "${UID}" -ne "${TEST_UID}" ]]
then
  echo "Your UID does not match ${TEST_UID}"
  exit 1
fi


USERNAME=$(id -un)

# Test if the command worked (check the exit status of the previous command, i.e. 'id -un' in this case
if [[ "${?}" -ne 0 ]]
then
  echo "The id command did not work successfully."
  exit 2
fi

echo "Username: ${USERNAME}"
