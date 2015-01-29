#!/bin/bash

## Writing for Ubuntu ONLY to start; will add an if else later

# ALERT!!!
# Comment these lines when you uncomment the remove line below
printf "\n*********************************************************************\n"
printf "\nATTENTION: Right now, this is only outputting your installed kernels.\n"
printf "It is not actually doing anything yet.\n"
printf "You need to edit this file to uncomment the remove command.\n"
printf "\n*********************************************************************\n"

# Log location
kernelBroomLog=~/kernelBroom.log

# List current running kernel
currentKernel=$(uname -r)

# Output currently installed kernels
#installedKernels=$(sudo dpkg -l linux-image-\* | grep ^ii | awk '{print $2}')

# Set run date in log
printf "\n\nkernelBroom Last Run: $(date)\n" | tee -a $kernelBroomLog

# Just test it all works.
printf "\nCurrent running kernel\n" | tee -a $kernelBroomLog
printf "$currentKernel\n" | tee -a $kernelBroomLog
printf "\nInstalled kernels\n" | tee -a $kernelBroomLog

dpkg -l linux-image-\* | grep ^ii | awk '{print $3}' | sort | uniq | while read readKernels
do
#	echo $readKernels && echo $readKernels >> $kernelBroomLog
	echo $readKernels | tee -a $kernelBroomLog
done

#dpkg -l linux-image-\* | grep ^ii | awk '{print $3}' | sort | uniq > installedKernels.list
#cat installedKernels.list


# Need to sort by unique only


# Need to make this output to a temporary file, read all but the two most recent versions, then auto prune the rest
printf "\nGoing to keep these kernels\n"
tail -3 $kernelBroomLog

# Uncomment the following line to ACTUALLY remove the kernels
# for removeKernels in 