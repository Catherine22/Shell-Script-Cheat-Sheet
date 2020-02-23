#!/bin/bash

LOG_FILE='log.txt'
if [[ -f "${LOG_FILE}" ]]
then
    rm ${LOG_FILE}
fi

# Check if I am root
echo '┌─────────────────────────┐' >> ${LOG_FILE}
echo '│ Step 1: Check privilege │' >> ${LOG_FILE}
echo '└─────────────────────────┘' >> ${LOG_FILE}
if [[ "${UID}" -ne 0 ]]
then
  echo '[Error] You are not root' >> ${LOG_FILE}
  echo '[Error] You are not root' |& cat
  exit 1
fi

# Check inputs
echo 'Done' >> ${LOG_FILE}
echo '┌──────────────────────┐' >> ${LOG_FILE}
echo '│ Step 2: Check Inputs │' >> ${LOG_FILE}
echo '└──────────────────────┘' >> ${LOG_FILE}
NUMBERS_OF_USERS="${#}"
if [[ "${NUMBERS_OF_USERS}" -lt 1 ]]
then
  echo '[Error] Please input username(s)' >> ${LOG_FILE}
  echo '[Error] Please input username(s)' |& cat
  exit 1
fi

# Create new local users
echo 'Done' >> ${LOG_FILE}
echo '┌──────────────────────────────────┐' >> ${LOG_FILE}
echo '│ Step 3: Create new local user(s) │' >> ${LOG_FILE}
echo '└──────────────────────────────────┘' >> ${LOG_FILE}
for USERNAME in "${@}"
do
  useradd -c "${USERNAME}" -m ${USERNAME} >> /dev/null 2>> ${LOG_FILE}

  ## Check to see if the useradd command succeeded
  if [[ "${?}" -ne 0 ]]
  then
    echo '[Error] The useradd command did not work successfully' >> ${LOG_FILE}
    echo '[Error] The useradd command did not work successfully' |& cat
    exit 1
  fi
done

# Set up passwords
echo 'Done' >> ${LOG_FILE}
echo '┌─────────────────────────┐' >> ${LOG_FILE}
echo '│ Step 4: Set up password │' >> ${LOG_FILE}
echo '└─────────────────────────┘' >> ${LOG_FILE}
S="!@#$%^&*()_-+="
for USERNAME in "${@}"
do
  ## Generate passwords for each user
  SPECIAL_CHAR=$(echo "${S}" | fold -b1 | shuf | head -n1)
  PASSWORD_TEMP=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c12)
  PASSWORD=${PASSWORD_TEMP}${SPECIAL_CHAR}

  ## Set the password for the user
  echo ${PASSWORD} | passwd --stdin ${USERNAME} >> /dev/null 2>> ${LOG_FILE}
  
  ## Check to see if the passwd command succeeded
  if [[ "${?}" -ne 0 ]]
  then
    echo '[Error] The passwd command did not work successfully' >> ${LOG_FILE}
    echo '[Error] The passwd command did not work successfully' |& cat
    exit 1
  fi

  ## Force password change on first login 
  passwd -e ${USERNAME} >> /dev/null 2>> ${LOG_FILE}

  echo "${USERNAME}:${PASSWORD}"
done
echo 'Done' >> ${LOG_FILE}

# To see if users are all created
# less /etc/passwd

# To delete a user
# userdel USERNAME

exit 0
