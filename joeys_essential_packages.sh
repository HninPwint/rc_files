#!/bin/sh

# For automated installation, pass -yq

packages_to_install=""

install_package() {
	packages_to_install="$packages_to_install $*"
}

packages_editor="vim-gtk exuberant-ctags"

# Desktop
install_package fluxbox
install_package wmctrl xdotool xosd-bin
install_package xfonts-75dpi xfonts-100dpi
install_package xscreensaver xscreensaver-data-extra xscreensaver-screensaver-bsod xscreensaver-gl # xscreensaver-gl-extra
# Used by randomwallpaper/jxsetbg
install_package imagemagick
# Provides xsetbg, used by randomwallpaper/jxsetbg.  (They can fall back to fbsetbg, but that crops-to-fit rather than shrink-to-fit.)
install_package xloadimage
install_package gkrellm

# Core desktop apps
install_package zsh
install_package mutt
install_package geeqie

packages_remote="openssh-server screen xtightvncviewer x11vnc tightvncserver tmux"

#packages_winman="xfstt"   # To get LucidaConsole in GVim!  (See ~/FONTS folder)
packages_debugging="iotop atop nmap wireshark mesa-utils lm-sensors"
# Shows network usage by process.  'm' to toggle between rate and total, and select units.  'r' and 's' to sort by received/sent.
install_package nethogs
# Shows network usage by remote host and local/remote ports.
#install_package jnettop
# tcptrack is similar but with a simplified display.  It shows duration but no totals.
#install_package tcptrack
# Shows a graph, in a terminal, but no process separation: slurm
# But in fact this does a better job: speedometer
# Nerdy, shows TCP flags and UDP packets.  It's a bit like wireshark.
#install_package iptraf

# More desktop apps
install_package mplayer gimp inkscape
install_package okular
install_package libreoffice

install_package dict-wn
install_package dict-moby-thesaurus

# Ubuntu recommends installing mailtools in order to get the 'mail' command.
# It installs postfix.
#install_package mailtools
# But I prefer exim!
# Both postfix and exim open a dpkg config dialog.
install_package exim4

# Extended audio
install_package mp3gain vorbisgain   # For randommp3
install_package mpg123   # In case mplayer is not available
install_package lame mp3info   # For reencoding to mp3
# bladeenc 
install_package vorbis-tools   # For reencoding to ogg

# In Ubuntu 14.04, avconf from libav-tools replaces ffmpeg (it is a fork)
# However ffmpeg is back in 15.04!
#install_package libav-tools

# For reencode_video_to_x264:
install_package faac gpac x264 mencoder

install_package hugs
# ghc is also nice, but 290meg!
#install_package ghc
#install_package cabal-install

install_package wine

# System {{{

packages_system="cpufrequtils"
#install_package bootlogd

# TODO: This may be worth configuring.  It can save battery by stopping the disk from spinning when off AC power.
# It is mentioned here: https://help.ubuntu.com/community/PowerManagement/ReducedPower
# Although with all the stuff I have running (e.g. Chrome browser) I think my disk will be hit every couple of minutes at least, so it may keep waking up again.
#install_package laptop-power-mode

# Provides an easy way to flood the CPU, for testing purposes.  Supposedly optimized for different hardware, but I couldn't find a way to flood both my Celeron cores at once!
#install_package cpuburn
# Alternative.  E.g.: stress --cpu 2 --timeout 120s
#install_package stress

# }}}

packages_development="git-core ccache sshfs encfs unison lftp" # 'git-core' is transitioning to 'git'
# 20th century revision control
install_package rcs

install_package nginx

packages_packaging="aptitude dpkg-repack alien fakeroot"
install_package checkinstall   # alternative to make install which generates a deb, for easy clean removal!
install_package equivs

# Not crucial but desirable {{{

# Needed by scdl (soundcloud download)
install_package curl

# For building Debian packages
install_package devscripts build-essential

install_package rar p7zip-full
install_package festival festvox-rablpc16k
install_package compizconfig-settings-manager

# You never know when you might need this
install_package dosbox

# Color pickers, to conveniently pick colors from off the screen.
install_package gpick gcolor2

#packages_demodev="ocaml-nox liblz4-tool menhir ocamldsort"

# Shell development
install_package shellcheck
# For portability testing
install_package posh ksh

# Mount Android device over USB
install_package mtpfs
# This is for downloading photos from iPod/iPhone
# An alternative is shotwell, which has a GUI
install_package gphoto2

install_package mencoder

# }}}

# Dashes / launchers
#install_package kupfer
#sudo add-apt-repository ppa:synapse-core/ppa 
#install_package synapse



add_repository() {
	local ppa_repo="$1"
	. /etc/lsb-release
	local apt_sources_file="$(echo "${ppa_repo}" | tr '/.' '-_')-${DISTRIB_CODENAME}.list"
	local apt_sources_path="/etc/apt/sources.list.d/${apt_sources_file}"
	if [ -f "$apt_sources_path" ]
	then
		echo "### We already have ppa:$ppa_repo"
	else
		echo "### Installing $ppa_repo to $apt_sources_path"
		sudo add-apt-repository ppa:"$ppa_repo"
		added_repo=1
	fi
}

# Unetbootin
add_repository gezakovacs/ppa
install_package unetbootin

# MPlayer which can play h265
add_repository mc3man/mplayer-test

add_repository gwendal-lebihan-dev/hexchat-stable
packages_to_install="$packages_to_install hexchat"

# Install NodeJS 0.10
# Alternative methods can be found here: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
# To install io.js, look here: https://nodesource.com/blog/nodejs-v012-iojs-and-the-nodesource-linux-repositories
add_repository chris-lea/node.js
packages_development="$packages_development nodejs"

# But you probably want NVM so you can get the latest version of Node, or switch versions for different projects.
# To install it using `curl|sh` check the README: https://github.com/creationix/nvm/
# When I last installed it, the command was:
#     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash

# Install Java Development Kit
install_package default-jdk

# Want Heroku?
# wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

install_scala_build_tool=true
if [ -n "$install_scala_build_tool" ]
then
	if [ ! -f "/etc/apt/sources.list.d/sbt.list" ]
	then
		echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
		added_repo=1
	fi
	packages_development="$packages_development sbt"
fi

#add_repository saltstack/salt
#packages_deployment="salt-master python-software-properties"

install_latest_mongodb=true
if [ -n "$install_latest_mongodb" ]
then
	# Derived from here: http://docs.mongodb.org/master/tutorial/install-mongodb-on-ubuntu/
	. /etc/lsb-release
	apt_sources_path="/etc/apt/sources.list.d/mongodb-org-3.0.list"
	if [ ! -f "$apt_sources_path" ]
	then
		sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
		echo "deb http://repo.mongodb.org/apt/ubuntu ${DISTRIB_CODENAME}/mongodb-org/3.0 multiverse" |
		sudo tee "$apt_sources_path"
		added_repo=1
	fi
	packages_to_install="$packages_to_install mongodb-org"
	# Note that the mongo package in Ubuntu's repository is called 'mongodb' not 'mongodb-org'
	# On Ubuntu I had these installed: mongodb mongodb-clients mongodb-dev mongodb-server
	# Not sure what brought them in!  ;)
	# After removing them, they left behind /var/lib/mongodb and /var/log/mongodb
	# The mongo repo installs: mongodb-org mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools
	# Last time I installed, they gave me version 3.0.6
fi



# === Less crucial ===

#install_package msttcorefonts
# texlive-fonts-recommended

# xbacklight
# sudo add-apt-repository ppa:indicator-brightness/ppa
# indicator-brightness
# sudo add-apt-repository ppa:kamalmostafa/linux-kamal-mjgbacklight



[ -n "$added_repo" ] && sudo apt-get update

all_packages_to_install="$packages_to_install $packages_editor $packages_remote $packages_debugging $packages_system $packages_development $packages_deployment $packages_packaging"

sudo apt-get -V install $all_packages_to_install "$@"

#grep --line-buffered -v "is already the newest version.$"

# Unfortunately if we use grep, the "Do you want to continue [Y/n]?" will not be displayed, because no newline is sent!

