#!/bin/bash
## Author: Charis Cayetano
## Last Modified By: Charis Cayetano
## Last Modified Date: 2022-01-08

## Define location of source file.
SOURCE=scenario.yml

## Confirm source file exists as defined and prompt for correction if not
if [ ! -f $SOURCE ]; then
        echo "YAML Source File not found. Please ensure file exists in current working directory and run this script again, exiting..."
        exit 25
fi

## Filter Physical Volume Name, mountpoint and filesystem type for entry 1
fs1="`grep [0-9] scenario.yml | cut -d':' -f1|grep [0-9]|sed -n '1p'|awk '{ print $1 }'`"
mount1="`grep mount scenario.yml | cut -d':' -f2|sed -n '1p'`"
type1="`grep type scenario.yml | cut -d':' -f2|sed -n '1p'`"

## Filter Physical Volume Name, mountpoint and filesystem type for entry 2
fs2="`grep [0-9] scenario.yml | cut -d':' -f1|grep [0-9]|sed -n '2p'|awk '{ print $1 }'`"
mount2="`grep mount scenario.yml | cut -d':' -f2|sed -n '2p'`"
type2="`grep type scenario.yml | cut -d':' -f2|sed -n '2p'`"

## Filter Physical Volume Name, mountpoint and filesystem type for entry 3
fs3="`grep [0-9] scenario.yml | cut -d':' -f1|grep [0-9]|sed -n '3p'|awk '{ print $1 }'`"
mount3="`grep mount scenario.yml | cut -d':' -f2|sed -n '3p'`"
type3="`grep type scenario.yml | cut -d':' -f2|sed -n '3p'`"

## Filter Physical Volume Name, mountpoint and filesystem type for entry 4
fs4="`grep [0-9] scenario.yml | cut -d':' -f1|grep [0-9]|sed -n '4p'|awk '{ print $1 }'`"
mount4="`grep mount scenario.yml | cut -d':' -f2|sed -n '4p'`"
export="`grep export scenario.yml | cut -d':' -f2|sed -n '1p'`"
type4="`grep type scenario.yml | cut -d':' -f2|sed -n '4p'`"
option1="`grep no scenario.yml | cut -d'-' -f2|sed -n '1p'`"
option2="`grep no scenario.yml | cut -d'-' -f2|sed -n '2p'`"

## Write contents of fstab file with appropriate spacing
echo $fs1"      "$mount1"               "$type1"        defaults        1       2" > fstab
echo $fs2"      "$mount2"               "$type2"        defaults        1       1" >> fstab
echo $fs3"      "$mount3"               "$type3"        defaults        1       2" >> fstab
echo $fs4":"$export"    "$mount4"               "$type4"        defaults,"$option1","$option2"          1       2"| sed 's/ //g' >> fstab

## Check if /etc/fstab exists on server. If yes, do not overwrite existing file
if [ -f /etc/fstab ]; then
        echo "A file with the name /etc/fstab already exists. A backup will be taken and file replaced"
        cp /etc/fstab fstab.backup
        cp fstab /etc/fstab
else
        echo "/etc/fstab will be installed"
        cp fstab /etc/fstab
## Uncomment the line below to mount fstab entries
        #mount -a
## Uncomment the line below to add root reserve of 10% for filesystem; adjust variables as needed
        #tune2fs -m10 $fs3
fi
