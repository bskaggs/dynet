#!/bin/bash

for HOMEDIR in /home/* ; do 
  if [[ -d "$HOMEDIR" && ! -L "$HOMEDIR" ]]; then
    NEWUSER=$(basename "$HOMEDIR")
    NEWUID=$(stat -c %u "$HOMEDIR")
    NEWGID=$(stat -c %g "$HOMEDIR")
    echo "Creating new user with name $NEWUSER, uid $NEWUID, gid $NEWGID"
    groupadd -g $NEWGID group
    useradd -g $NEWGID -u $NEWUID -M -d "$HOMEDIR" "$NEWUSER"
    cd "$HOMEDIR"
    exec su "$NEWUSER" -c 'jupyter-notebook --ip 0.0.0.0 --no-browser'
  fi 
done
echo "No user home directory found, making user named 'user'."
useradd -m user
cd /home/user
exec su user -c 'jupyter-notebook --ip 0.0.0.0 --no-browser'

