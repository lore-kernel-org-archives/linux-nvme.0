From: hare@suse.de (Hannes Reinecke)
Date: Wed, 13 Jan 2016 09:26:29 +0100
Subject: NVM and swap device
In-Reply-To: <20160112194030.5b74ecdc@xeon-e3>
References: <20160112194030.5b74ecdc@xeon-e3>
Message-ID: <56960A35.9020507@suse.de>

On 01/13/2016 04:40 AM, Stephen Hemminger wrote:
> I have a nice shiny new Intel NVM PCI card; decided to use it for a filesystem and swap.
> The filesystem (btrfs) is doing fine, but the swap device was throwing occasional
> random errors. Suspect a driver problem rather than hardware.
>
> I am using 4.4 kernel without patches.
>
> kern.log:Jan 12 08:11:57 xeon-e3 kernel: [159474.037390] Read-error on swap-device (259:0:17597808)
> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855526] Read-error on swap-device (259:0:11355648)
> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855530] Read-error on swap-device (259:0:11355656)
> kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87939.855467] Read-error on swap-device (259:0:16180824)
> kern.log.1:Jan  8 08:24:07 xeon-e3 kernel: [63670.777981] Read-error on swap-device (259:0:32690768)
> kern.log.1:Jan  9 09:25:02 xeon-e3 kernel: [153720.919325] Read-error on swap-device (259:0:220488)
> kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.957675] Read-error on swap-device (259:0:24476232)
> kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.962673] Read-error on swap-device (259:0:33292816)
>
> The swap device was being added via /etc/fstab by UUID.
>
> I gave up and went back to spinning rust for swap device for stabilty.
>
> Device partitions are:
>
> Disk /dev/nvme0n1: 781422768 sectors, 372.6 GiB
> Logical sector size: 512 bytes
> Disk identifier (GUID): 304117A4-18EF-4B51-92F4-8015758B5CB0
> Partition table holds up to 128 entries
> First usable sector is 34, last usable sector is 781422734
> Partitions will be aligned on 8-sector boundaries
> Total free space is 0 sectors (0 bytes)
>
> Number  Start (sector)    End (sector)  Size       Code  Name
>     1              34            2047   1007.0 KiB  EF02  BIOS boot partition
>     2            2048        33556479   16.0 GiB    8200  Linux swap
>     3        33556480       781422734   356.6 GiB   8300  Linux filesystem
>
Ouch.

34 sectors is aligned to basically nothing, and is guaranteed to 
trip any alignment issues there are.

Please repartition the device and use some sane value like 2M alignment.

Cheers,

Hannes


-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
