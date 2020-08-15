#!/bin/bash

# Check if I am root
if [[ "${UID}" -ne 0 ]]
then
  echo "You are not root" >&2
  exit 1
fi

# Assume the first argument is the user to be deleted
USER="${1}"

# Delete the user
userdel ${USER}

# Check the result of user deletion
if [[ "${?}" -ne 0 ]]
then
  echo "The account ${USER} was NOT deleted" >&2
  exit 1
fi

# Done
echo "The account ${USER} was deleted successfully"
exit 0