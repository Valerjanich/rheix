
Debian
====================
This directory contains files used to package rheixd/rheix-qt
for Debian-based Linux systems. If you compile rheixd/rheix-qt yourself, there are some useful files here.

## rheix: URI support ##


rheix-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install rheix-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your rheix-qt binary to `/usr/bin`
and the `../../share/pixmaps/rheix128.png` to `/usr/share/pixmaps`

rheix-qt.protocol (KDE)

