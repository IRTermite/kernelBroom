# kernelBroom
## Sweeping up /boot, but not really

(Currently built for Ubuntu)

kernelBroom came about as a need for systems that have a dedicated /boot partition that seems to just get neglected.  Too often, I see people with ~200MB /boot that fills after about 5-6 kernel upgrades.  

Sure, you could simply run through a remove them all, or follow these instructions to remove all but current. http://askubuntu.com/questions/2793/how-do-i-remove-or-hide-old-kernel-versions-to-clean-up-the-boot-menu 

But, what if you wanted to keep a couple of the most recent?  kernelBroom would allow you to set that count.  Yea, it's just a simple dirty script; nothing spectacular.