#!/bin/sh

SRC=/tmp/sysroot
TARGET=buildroot-prepare
rm -fr $TARGET
mkdir $TARGET
mkdir $TARGET/{var,dev,proc,run,sys,sysroot}
ln -s ../var/opt $TARGET/opt
ln -s ../var/srv $TARGET/srv
ln -s ../var/mnt $TARGET/mnt
ln -s ../var/roothome $TARGET/root
ln -s ../var/home $TARGET/home
ln -s ../run/media $TARGET/media
ln -s ../sysroot/ostree $TARGET/ostree
ln -s ../sysroot/tmp $TARGET/tmp

cp -r $SRC/usr $TARGET/usr
cp -r $SRC/etc $TARGET/etc
ln -s var/lib/rpm $TARGET/usr/share/rpm
cp -r $TARGET/usr/local $TARGET/var/usrlocal

