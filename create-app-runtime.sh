#!/bin/sh

BUILDDIR=$1
shift
RUNTIME_ID=$1
shift
PACKAGE=$1
shift
REPO=$1

mkdir -p $BUILDDIR
cd $BUILDDIR

flatpak build-init -w --type=runtime $BUILDDIR $RUNTIME_ID org.openSUSE.Sdk org.openSUSE.Runtime 1

## Setup resolv.conf
flatpak build $BUILDDIR rm /etc/resolv.conf
flatpak build $BUILDDIR ln -s /run/host/etc/resolv.conf /etc/resolv.conf

## Setup zypper repo
flatpak build --share=network $BUILDDIR fakeroot-sysv zypper ar http://download.opensuse.org/tumbleweed/repo/oss/ repo-oss
flatpak build --share=network $BUILDDIR fakeroot-sysv zypper -n --no-gpg-checks ref

## Install package
flatpak build --share=network $BUILDDIR fakeroot-sysv zypper -n --no-gpg-checks in $PACKAGE

## Clean up
flatpak build $BUILDDIR rm /etc/resolv.conf 
flatpak build $BUILDDIR rm -rf /etc/zypp

## Finish and export built runtime
flatpak build-finish $BUILDDIR
flatpak build-export -r $REPO $BUILDDIR