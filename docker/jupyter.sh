#!/bin/bash

FOUND=false
for HOMEDIR in /home/* ; do 
  if [[ -d "$HOMEDIR" && ! -L "$HOMEDIR" ]]; then
    NEWUSER=$(basename "$HOMEDIR")
    NEWUID=$(stat -c %u "$HOMEDIR")
    NEWGID=$(stat -c %g "$HOMEDIR")
    echo "Creating new user with name $NEWUSER, uid $NEWUID, gid $NEWGID"
    groupadd -g "$NEWGID" group
    useradd -g "$NEWGID" -u "$NEWUID" -M -d "$HOMEDIR" "$NEWUSER"
    cd "$HOMEDIR" || exit
    FOUND=true
    break
  fi 
done

if [ "$FOUND" = false ]; then
  NEWUSER=user
  echo "No user home directory found, making user named 'user'."
  useradd -m "$NEWUSER"
  cd "/home/$NEWUSER" || exit
fi

exec su "$NEWUSER" -c 'jupyter-notebook --ip 0.0.0.0 --no-browser'
