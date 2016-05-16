From: keith.busch@intel.com (Keith Busch)
Date: Mon, 16 May 2016 10:46:54 -0400
Subject: Accessing the NVMe flash drive of the April 2016 MacBook 12"
 (A1534) [SOLVED]
In-Reply-To: <21472d94e79a410912937ae5722c2fb4@speicherleck.de>
References: <10c3272709f4fc720d862c81da85e6e9@speicherleck.de>
 <eaaba356177409f3a40afc33d938d42c@speicherleck.de>
 <21472d94e79a410912937ae5722c2fb4@speicherleck.de>
Message-ID: <20160516144653.GA10776@localhost.localdomain>

On Mon, May 16, 2016@04:59:51AM +0200, Carina Willbold wrote:
> >Am 2016-05-15 22:19, schrieb Carina Willbold:
> >However actually trying to access one of the partitions (for instance,
> >trying
> >to mount them or executing head -c 20 /dev/nvme0n1p1) results in timeouts:
> [...]
> 
> After a reboot, the timeouts vanished.
> 
> I can now happily confirm that accessing the flash drive works using kernel
> 4.6.0-rc7 and manually binding using:
> 
>     echo 106b 2003 > /sys/bus/pci/drivers/nvme/new_id
> 
> No controller resets or other IO errors occur even with (moderately)
> drive-intense activities like compiling and installing packages.
> 
> I'll submit a patch which will make the manual binding superfluous tomorrow.

It was starting to sound like you might need to copy the current Apple
driver quirk for the 0x2001 device, but if it's working without, you
can just append the VID/DID to nvme's pci_device_id table.
