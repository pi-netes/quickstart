SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo updating...
pacman-key --init
pacman-key --populate archlinuxarm
pacman -Syu --noconfirm
pacman -S --noconfirm archlinux-keyring

echo installing base utility programs...
pacman -S --noconfirm \
  ansible \
  binutils \
  cni-plugins \
  docker \
  docker-compose \
  ebtables \
  ethtool \
  fakeroot \
  k9s \
  gcc \
  git \
  go \
  make \
  neovim \
  openvpn \
  ranger \
  socat \
  sudo \
  tmux \
  wget
