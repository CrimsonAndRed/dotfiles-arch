#!/bin/bash

DIR=$(cd "$( dirname "$0")" ; pwd -P)
MY_USER=$(logname)
MY_HOME=$(eval echo ~$MY_USER)

inst() {
	if [ $# -eq 0 ] ; then
		echo "No arguments presented. Specify package name."
		return 1
	fi

	pacman -S --needed $1

}

inst "base-devel" &&
inst "neovim" &&
inst "ntfs-3g" &&
inst "nvidia nvidia-settings" &&
inst "xorg-server" &&
{
	PAC_HOOK="/etc/pacman.d/hooks/"
	DEST_PAC_HOOK=
	mkdir -p $PAC_HOOK && cp $DIR/configs/nvidia.hook $PAC_HOOK &&
	echo "Copied nvidia.hook to $PAC_HOOK"
} &&
{
	ROFI_CONFIG=$MY_HOME/.config/rofi
	I3_CONFIG=$MY_HOME/.config/i3
	inst "i3-gaps rofi" &&
	mkdir -p $ROFI_CONFIG && cp $DIR/configs/rofi_config $ROFI_CONFIG/config &&
	mkdir -p $I3_CONFIG && cp $DIR/configs/i3_config $I3_CONFIG/config &&
	echo "Copied rofi config to $ROFI_CONFIG"
} &&
{
	inst "lightdm lightdm-gtk-greeter" &&
	systemctl enable lightdm.service &&
	echo "Registered lightdm.service"
} &&
{
	inst "rxvt-unicode" &&
	cp $DIR/configs/.Xresources $MY_HOME &&
	xrdb merge $MY_HOME/.Xresources &&
	echo "Copied .Xresources to $MY_HOME"
} &&
{
	inst "xorg-xinit" &&
	cp $DIR/configs/.xinitrc $MY_HOME &&
	echo "Copied xinit config to $MY_HOME"

} &&
inst "firefox" &&
inst "git" &&
inst "lxappearance" && 
inst "alsa-utils" &&
inst "network-manager-applet volumeicon" &&
{
	COMPTON_CONFIG=$MY_HOME/.config/compton
	inst "compton" &&
	mkdir -p $COMPTON_CONFIG && cp $DIR/configs/compton.conf $COMPTON_CONFIG/compton.conf &&
	echo "Copied compton config to $COMPTON_CONFIG"
} &&
inst "nitrogen" &&
inst "ttf-hack" &&
inst "tor" &&
inst "htop" &&
inst "pasystray"
