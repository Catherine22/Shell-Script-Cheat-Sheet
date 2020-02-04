#!/bin/bash
# Check if I am root
if [[ "${UID}" -ne 0 ]]
then
  echo 'You are not root'
  exit 1
fi

# Check inputs
NUMBERS_OF_USERS="${#}"
if [[ "${NUMBERS_OF_USERS}" -lt 1 ]]
then
  echo 'Please input username(s)'
  exit 2
fi

# Create new local users
for USERNAME in "${@}"
do
  useradd -c "${USERNAME}" -m ${USERNAME}

  ## Check to see if the useradd command succeeded
  if [[ "${?}" -ne 0 ]]
  then
    echo "The useradd command did not work successfully."
    exit 3
  fi
done

# Set up passwords
S="!@#$%^&*()_-+="
for USERNAME in "${@}"
do
  ## Generate passwords for each user
  SPECIAL_CHAR=$(echo "${S}" | fold -b1 | shuf | head -n1)
  PASSWORD_TEMP=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c12)
  PASSWORD=${PASSWORD_TEMP}${SPECIAL_CHAR}

  ## Set the password for the user
  echo ${PASSWORD} | passwd --stdin ${USERNAME}
  
  ## Check to see if the passwd command succeeded
  if [[ "${?}" -ne 0 ]]
  then
    echo "The passwd command did not work successfully."
    exit 4
  fi

  ## Force password change on first login 
  passwd -e ${USERNAME}

  echo "${USERNAME}:${PASSWORD}"
  echo
done

# To see if users are all created
# less /etc/passwd

# To delete a user
# userdel USERNAME

exit 0