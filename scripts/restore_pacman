#!/bin/bash

arch=x86_64
mirror=http://mirror.rit.edu/archlinux

# link to cache (or download) and extract: openssl,libarchive,libfetch,pacman
cd /tmp
for pkg in openssl-1.0.0.g-1 libarchive-3.0.3-2 libfetch-2.33-3 pacman-4.0.1-4; do
    pkgname=${pkg}-${arch}.pkg.tar.gz
    if [[ -e /var/cache/pacman/pkg/${pkgname} ]]; then
        ln -sf /var/cache/pacman/pkg/${pkgname} .
    else
        wget ${mirror}/core/os/${arch}/${pkgname} || exit 1
    fi
    sudo tar -xvpf ${pkgname} -C / --exclude .PKGINFO --exclude .INSTALL || exit 1
done

# now reinstall using pacman to update the local pacman db 
sudo pacman -Sf openssl libarchive libfetch pacman || exit 1

# now update your system
sudo pacman -Syu
