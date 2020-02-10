SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo verifying user...
if [[ "${EUID}" != 0 ]] ; then
   echo "Must run as root."
   exit 1
fi

if [[ ! -f "/home/alarm/quickstart.sh" ]]; then # not currently booted into pi
  echo this is only intended to be used in conjunction with the arclinux.sh install script! would you like to install archlinux on an sd card now? [Y/n]
  read SHOULD_INSTALL_ARCH_LINUX
  if [[ $SHOULD_INSTALL_ARCH_LINUX == 'n' ]]; then
    echo "nothing to do!"
    exit 0
  else
    bash $SCRIPT_DIR/installs/archlinux.sh
    exit 0
  fi
fi

echo what would you like to name this machine?
read HOSTNAME
hostnamectl set-hostname $HOSTNAME

echo setting global options...
sed -i 's/\#Color/Color\nILoveCandy\nTotalDownload/g' /etc/pacman.conf

echo updating and installing programs with pacman...
bash $SCRIPT_DIR/installs/pacman.sh

echo installing user profile...
echo what would you like to name your user?
read USERNAME
export USERNAME
bash $SCRIPT_DIR/installs/userprofile.sh

echo installing packages from the aur...
bash $SCRIPT_DIR/installs/aur.sh

echo installing kubetools...
cd /opt
sudo -u $USERNAME git clone
ln -s /opt/kubetools/kubetools.sh /usr/local/bin/kubetools
sed -i 's/SCRIPT_DIR=.*/SCRIPT_DIR=\/opt\/kubetools/' /opt/kubetools/kubetools.sh

echo provisioning cluster...
sudo -u $USERNAME kubetools

echo "to clean up, please run:

  rm -rf /home/alarm
  userdel alarm"
