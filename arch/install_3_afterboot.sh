#!/bin/bash

# default values
INST_USER=xon

## Basic Desktop
sudo pacman -S --noconfirm --needed avahi reflector pipewire pipewire-alsa pipewire-pulse pipewire-jack xdg-user-dirs xdg-utils bluez bluez-utils cups hplip networkmanager iwd
sudo systemctl enable bluetooth
sudo systemctl enable avahi-daemon
sudo systemctl enable cups

## uncomment for basic GNOME
sudo pacman -S --noconfirm --needed gnome gnome-extra firefox pop-gtk-theme pop-icon-theme papirus-icon-theme ttf-roboto
sudo systemctl enable gdm

## uncomment for basic KDE
#sudo pacman -S --noconfirm --needed plasma-meta kde-applications-meta firefox papirus-icon-theme
#sudo systemctl enable sddm

## laptop and power management
sudo pacman -S --noconfirm --needed thermald power-profiles-daemon
sudo systemctl enable thermald
sudo systemctl enable power-profiles-daemon

## kvm, qemu, libvirt
sudo pacman -S --noconfirm --needed libvirt qemu bridge-utils vde2 ovmf virt-manager
sudo usermod -aG libvirt $INST_USER
sudo systemctl enable libvirtd

## docker
sudo pacman -S --noconfirm --needed docker
sudo usermod -aG docker $INST_USER
sudo systemctl enable docker

## add aur helper
git clone https://aur.archlinux.org/pikaur.git
cd pikaur/
makepkg -si --noconfirm

## system 76 stuff for clevo laptops
#pikaur -S --noconfirm --needed system76-power

## Plymouth
#pikaur -S --noconfirm --needed plymouth gdm-plymouth

#sudo mkinitcpio -P

/bin/echo -e "\e[1;32mDone!\e[0m"
