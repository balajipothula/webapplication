#!/bin/bash

# Author      : BALAJI POTHULA <balaji.pothula@techie.com>,
# Date        : 16 August 2019,
# Description : Adding webapp user on Ubuntu / RHEL8.

# Note        : Please run this file with root privilages.

# exits any line in the bash script fails.
set -e

# adding new user account on ubuntu.
useradd -m -c "WebAppServer" -s /bin/bash webapp

# adding new user account on rhel.
<<comment
adduser -m -c "WebAppServer" -s /bin/bash webapp
comment

# deleting user password access.
passwd -d webapp

# adding new user to sudoers.
chmod +w /etc/sudoers                                            && \
echo "webapp       ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers && \
chmod -w /etc/sudoers

# copying existing .ssh folder to new user.
cp -R $(pwd)/.ssh /home/webapp

# changing owner to .ssh directory.
chown -R webapp:webapp /home/webapp/.ssh

# switching to new usesr.
su - webapp
