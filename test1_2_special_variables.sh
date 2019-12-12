!/bin/bash

# Display the UID and username and check if the user is the root user or not
# UID 1000 is for vagrant
echo "Your UID is ${UID} and EUID is ${EUID}"

# id includes (uid, gid and groups)
id

# User's info
USERNAME=$(id -un)
echo "Your username: ${USERNAME}"

# If statement

if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root'
else
  echo 'You are not root'
fi
