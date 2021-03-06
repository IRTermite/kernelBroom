#!/bin/bash

## Writing for Ubuntu ONLY to start; will add an if else later

# ALERT!!!
# Comment these lines when you uncomment the remove line below
printf "\n*********************************************************************\n"
printf "\nATTENTION: Right now, this is only outputting your installed kernels.\n"
printf "It is not actually doing anything yet.\n"
printf "You need to edit this file to uncomment the remove command.\n"

# How many installed kernels to keep
keepCount=0
# Log location
kernelBroomLog=~/kernelBroom.log
# Kernels to delete (Temp File)
kernelBroomTmp=~/kernelBroom.tmp
# Kernels to delete (Temp File)
kernelBroomDelete=~/kernelBroomDelete.tmp
# Kernels backup location
kernelBroomBkup=~/kernelBroomBkup
# Output current running kernel
currentKernel=$(uname -r)

# Output currently installed kernels
#installedKernels=$(sudo dpkg -l linux-image-\* | grep ^ii | awk '{print $2}')

# Set run date in log
printf "\n*********************************************************************" | tee -a $kernelBroomLog
printf "\n\nkernelBroom Last Run: $(date)\n" | tee -a $kernelBroomLog

# Just test it all works.
printf "\nCurrent running kernel\n" | tee -a $kernelBroomLog
printf "$currentKernel\n" | tee -a $kernelBroomLog
printf "\nInstalled kernels\n" | tee -a $kernelBroomLog

# Need to sort by unique only
dpkg -l linux-image-\* | grep ^ii | awk '{print $2}' | sed s/linux-image-// | sed s/extra-// | sort | uniq | while read readKernels
do
#	echo $readKernels && echo $readKernels >> $kernelBroomLog
	echo $readKernels | tee -a $kernelBroomLog | tee -a $kernelBroomTmp
done

#dpkg -l linux-image-\* | grep ^ii | awk '{print $3}' | sort | uniq > installedKernels.list
#cat installedKernels.list

# Need to make this output to a temporary file, read all but the two most recent versions, then auto prune the rest
printf "\nKeeping these kernels\n" | tee -a $kernelBroomLog
tail -$keepCount $kernelBroomTmp | tee -a $kernelBroomLog

# Make sure to remove current running kernel from delete list
#sed --in-place '/$currentKernel/d' $kernelBroomTmp
grep -v $currentKernel $kernelBroomTmp > ${kernelBroomTmp}.tmp && mv ${kernelBroomTmp}.tmp ${kernelBroomTmp}

printf "\nRemoving these\n" | tee -a $kernelBroomLog
# rm -f $(ls -1t /path/to/your/logs/ | tail -n +11)
head -n -$keepCount $kernelBroomTmp | tee -a $kernelBroomLog | tee -a $kernelBroomDelete


### Uncomment to ACTUALLY remove the kernels
printf "\nCommands being run\n"
cat $kernelBroomDelete | while read kernel2delete
do
echo "dpkg -r $kernel2delete"
#	echo "mv -p /boot/*$kernel2delete* $kernelBroomBkup/ << Need to uncomment the next line to work"
#	mv -p /boot/*$kernel2delete* $kernelBroomBkup/	
#	echo "rm /boot/*$kernel2delete*"
#	rm /boot/*$kernel2delete*
done

## Update grub
echo "update-grub"
# update-grub
## Load current running kernel in 'uname -r' on next reboot
echo update-initramfs –u -k all
# update-initramfs –u -k all

## Cleanup
rm $kernelBroomTmp && rm $kernelBroomDelete