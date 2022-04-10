#!/bin/bash

directory="/lvm-disk4tb"
files=(`ls -f $directory/dump/ | grep .log`)

for i in $(echo ${files[@]}); do
     echo "For result: $i"
     
     vmname=$(cat $directory/dump/$i | grep "VM Name:" | cut -d':' -f5 | cut -d' ' -f2)
     echo "VM Name: $vmname"

     bkpname=$(echo $i | cut -d'.' -f1)
     echo "Backup name: $bkpname"

     if [ -f "$directory/dump/$bkpname.vma.zst" ]
     then
          mv $directory/dump/$bkpname.vma.zst $directory/dump/$vmname-$bkpname.vma.zst
          echo "File name has been changed to: $vmname-$bkpname.vma.zst"
     else
          echo "File does not exist"
     fi
done
