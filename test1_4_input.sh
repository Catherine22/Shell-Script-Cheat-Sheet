#!/bin/bash

# Create an account on the local system

read -p 'Enter the username to create: ' USERNAME
read -p 'Enter the name of the person who this account is for: ' COMMENT
read -p 'Enter the password to use for the account: ' PASSWORD

## Create the user
useradd -c "${COMMENT}" -m ${USERNAME}

## Set the password for the user
echo "${PASSWORD}" | passwd  --stdin ${USERNAME}

## Force password change on first login
passwd -e ${USERNAME}