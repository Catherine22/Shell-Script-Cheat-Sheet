#!/bin/bash

# Display the UID and username and check if the user is the root user or not
# UID 1000 is for vagrant
echo "Your UID is ${UID} and EUID is ${EUID}"

# id includes (uid, gid and group)
id


