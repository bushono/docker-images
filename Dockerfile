FROM debian:12.7-slim as build

ENV \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    DEBCONF_NONINTERACTIVE_SEEN="true" \
    DEBIAN_FRONTEND="noninteractive"

RUN \
    su - root -c "apt install sudo" \
    su - root -c "usermod -aG sudo goran" \
    newgrp sudo \
    sudo apt update \
    sudo apt upgrade \
    sudo apt remove \
    sudo apt autoremove \
    sudo apt autoclean 

