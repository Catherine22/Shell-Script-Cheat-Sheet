#!/bin/bash

# Create an account on the local system

read -p 'Enter the username to create: ' USERNAME
read -p 'Enter the full name: ' FULLNAME
read -p 'Enter the password to use for the account: ' PASSWORD

## Create the user. 
## Notice that we quote ${FULLNAME} here is because this variable may include blanks
useradd -c "${FULLNAME}" -m ${USERNAME}

## Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USERNAME}

## Force password change on first login
passwd -e ${USERNAME}

exit 0