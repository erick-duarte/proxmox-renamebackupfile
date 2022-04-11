##!/bin/bash

directory="/DIRECTORY"
files=(`ls -f $directory/dump/ | grep .log`)
prefix='@'

for i in $(echo ${files[@]}); do
     echo "For result: $i"
     
     vmname=$(cat $directory/dump/$i | grep "VM Name:" | cut -d':' -f5 | cut -d' ' -f2)
     echo "VM Name: $vmname"

     bkpname=$(echo $i | cut -d'.' -f1)
     echo "Backup name: $bkpname"

     if [ -f "$directory/dump/$bkpname.vma.zst" ]
     then
          newfilename=$vmname-$prefix$bkpname.vma.zst
          mv $directory/dump/$bkpname.vma.zst $directory/dump/$newfilename
          echo "File name has been changed to: $newfilename"

          #rclone -P --bwlimit 7M copy $directory/dump/$newfilename DRIVE:PROXMOX/dump/
          #sleep 1

          if [ -f "$directory/dump/$newfilename" ]
          then
               rm -rf $directory/dump/*$bkpname*
          fi
     else
          echo "File does not exist"
     fi
done
