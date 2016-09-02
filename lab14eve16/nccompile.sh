#!/bin/sh
MODULENAME=$1
MODULETBNAME=${MODULENAME}tb

ncvlog -mess ${MODULENAME}.v ${MODULETBNAME}.v
echo 
sleep 2
echo
sleep 2
ncelab -mess -access +rwc ${MODULETBNAME}
echo 
sleep 2
echo
sleep 2
ncsim ${MODULETBNAME}

