#!/bin/bash
## Check if I am root
if [[ "${UID}" -ne 0 ]]
then
  echo 'You are not root' >&2
  exit 1
fi

## Input
read -p 'Enter the username to create: ' USERNAME
read -p 'Enter the name of the person or application that will be using this acount: ' FULLNAME
read -p 'Enter the password to use for the account: ' PASSWORD

## Create the user. 
## Notice that we quote ${FULLNAME} here is because this variable may include blanks
useradd -c "${FULLNAME}" -m ${USERNAME}

## Check to see if the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then
  echo "The useradd command did not work successfully." >&2
  exit 2
fi

## Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USERNAME}

## Check to see if the passwd command succeeded
if [[ "${?}" -ne 0 ]]
then
  echo "The passwd command did not work successfully." >&2
  exit 3
fi

## Force password change on first login
passwd -e ${USERNAME}

## Display the username, password, and the host where the user was created
echo
echo 'username: ' ${USERNAME}
echo 'password: ' ${PASSWORD}
echo 'hostname: ' ${HOSTNAME}
exit 0