#!/bin/bash

# Display the UID and username and check if the user is the root user or not
# UID 1000 is for vagrant
echo "Your UID is ${UID} and EUID is ${EUID}"

# id includes (uid, gid and groups)
id

# User's info
USERNAME=$(id -un) # or `id -un`
echo "Your username: ${USERNAME}"

