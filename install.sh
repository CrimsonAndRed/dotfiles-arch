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
{
	NVIM_CONFIG=$MY_HOME/.config/nvim
	inst "neovim"  &&
	mkdir -p $NVIM_CONFIG && cp $DIR/configs/init.vim $NVIM_CONFIG &&
	echo "Copied init.vim to $NVIM_CONFIG"
	
} &&
inst "ntfs-3g" &&
inst "nvidia nvidia-settings" &&
inst "xorg-server" &&
{
	PAC_HOOK="/etc/pacman.d/hooks/"
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
inst "pasystray" &&
inst "xorg-xrandr" && 
{
	POLYBAR_CONFIG=$MY_HOME/.config/polybar
	mkdir -p $POLYBAR_CONFIG && cp $DIR/configs/polybar_config $POLYBAR_CONFIG/compton &&
	cp $DIR/configs/polybar_launch.sh $POLYBAR_CONFIG/launch.sh
	echo "Copied polybar config to $POLYBAR_CONFIG"
	
} &&
inst "adobe-source-han-sans-itc-fonts" &&
inst "xorg-xprop" &&
inst "pcmanfm udiskie" &&
{
	NOBEEP_CONFIG=/etc/modprobe.d/
	cp $DIR/configs/nobeep.conf $NOBEEP_CONFIG/nobeep.conf
	echo "Copied nobeep config to $NOBEEP_CONFIG"
} &&
inst "fzf"
