#!/bin/sh
# source: https://gist.github.com/jandk/2928961

echo "Space free"
df -h | head -n 2

echo "Removing foreign man pages"
find /usr/share/man -type d -not -name man*

echo "Removing gtk docs"
rm -rf /usr/share/gtk-doc

echo "Removing locale files"
find /usr/share/locale/* -type d | xargs rm -rf

echo "Removing unused packages"
eclean -d packages

echo "Removing distfiles"
rm /var/portage/distfiles/*

echo "Removing python compiled files and tests"
find /usr/lib/python* -name \*.py? -delete
find /usr/lib/python* -type d -name __pycache__ -delete
find /usr/lib/portage -name \*.py? -delete
find /usr/lib/portage -type d -name __pycache__ -delete
rm -rf /usr/lib/python*/test

echo "Disabling python bytecode generation"
echo "PYTHONDONTWRITEBYTECODE=1" > /etc/env.d/99python
env-update && source /etc/profile

echo "Removing binutils info pages"
rm -rf binutils-data/*/*/info

# echo "Clearing out log files"
for f in $( find /var/log -type f ); do > $f; done

echo "Removing config-archive"
rm -rf /etc/config-archive

echo "Space free"
df -h | head -n 2
