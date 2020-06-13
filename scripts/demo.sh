#!/bin/sh

source ./logger.sh
SCRIPTENTRY
updateUserDetails(){
    ENTRY
    DEBUG "Username: $1, Key: $2"
    INFO "User details updated for $1"
    EXIT
}

INFO "Updating user details..."
updateUserDetails "volante" "3445"

rc=2

if [ ! "$rc" = "0" ]
then
    ERROR "Failed to update user details. RC=$rc"
fi
SCRIPTEXIT