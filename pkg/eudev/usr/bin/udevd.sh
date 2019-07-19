#!/bin/sh
udevadm hwdb --update
exec /sbin/udevd
