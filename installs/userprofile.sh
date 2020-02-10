SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
useradd -m -G wheel -s /bin/bash $USERNAME
passwd $USERNAME

echo adding user $USERNAME to sudoers file...
groupadd sudo
usermod -a -G sudo $USERNAME
echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers # need this for ansible install later

echo provisioning dotfiles...
mv $SCRIPT_DIR/../configs/.* /home/$USERNAME/

echo cleaning up...
rmdir $SCRIPT_DIR/../configs
chown -R $USERNAME:users /home/$USERNAME
