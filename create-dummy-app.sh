#!/bin/sh

BUILDDIR=$1
shift
APP_ID=$1
shift
RUNTIME_ID=$1
shift
COMMAND=$1
shift
REPO=$1

flatpak build-init $BUILDDIR $APP_ID org.openSUSE.Sdk $RUNTIME_ID
flatpak build-finish $BUILDDIR --command=$COMMAND
flatpak build-export $REPO $BUILDDIR