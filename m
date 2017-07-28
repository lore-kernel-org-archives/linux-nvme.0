From: sweda@ibl.org (Sean Sweda)
Date: Fri, 28 Jul 2017 13:22:52 -0400
Subject: kernel panic during mkfs (4.12.2, 4.13-rc2) 
Message-ID: <7B47340E-0B9A-4C61-A166-71F832A2BB80@ibl.org>

I consistently experience an "invalid opcode" kernel panic while running  
mkfs.ext4 on a md raid hybrid mirror (nvme SSD + standard SATA hard drive)  
under kernels 4.12.2 & 4.13-rc2.  No problem with kernel 4.11.x.  The panic  
occurs at the very end of "Discarding device blocks" portion of mkfs.


Here's an attempt to transcribe a partial backtrace from a picture I took  
of console (can fwd if desired):

invalid opcode: 0000 [#1] SMP
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.13.0-rc2 #1
Hardware name: Sytem manufacturer System Product Name/PRIME x370-PRO, BIOS  
0805 06/20
RIP: blk_mq_end_request+0x5e/0x60
...
Call Trace:
<IRQ>
nvme_complete_rq+0x17/0xb8
nvme_pci_complete_rq+0x77/0xc0
__blk_mq_complete_request+0x8a/0x138
blk_mq_complete_request+0x12/0x18
nvme_process_cq+0xa8/0x170
nvme_irq+0x19/0x30
__handle_irq_event_percpu+0x38/0x190
handle_irq_event_percpu+0x1e/0x50
handle_irq_event+0x27/0x50
handle_edge_irq+0x68/0x198
handle_irq+0x6a/0x100
do_IRQ+0x41/0xc0
common_interrupt+0x86/0x86


command that triggers the panic is simply
$ mkfs.ext4 -m0 /dev/md1


kernel config & boot log:
https://gist.github.com/seansweda/2e3d921bae61a30d13fdafb0d7816a58


RAID 1 created by:
$ mdadm --create -n 2 -l 1 --bitmap=internal --write-behind=4096 /dev/md1  
/dev/nvme0n1p2 -W /dev/sda2

$ cat /proc/mdstat
md1 : active raid1 sda2[1](W) nvme0n1p2[0]
       365756736 blocks super 1.2 [2/2] [UU]
       bitmap: 1/3 pages [4KB], 65536KB chunk


$ smartctl -i /dev/nvme0n1
smartctl 6.5 2016-05-07 r4318 [x86_64-linux-4.11.11-gentoo] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Model Number:                       PLEXTOR PX-512M8PeG
Serial Number:                      P02709118023
Firmware Version:                   1.05
PCI Vendor ID:                      0x14a4
PCI Vendor Subsystem ID:            0x1b4b
IEEE OUI Identifier:                0x002303
Total NVM Capacity:                 512,110,190,592 [512 GB]
Unallocated NVM Capacity:           0
Controller ID:                      1
Number of Namespaces:               1
Namespace 1 Size/Capacity:          512,110,190,592 [512 GB]
Namespace 1 Utilization:            0
Namespace 1 Formatted LBA Size:     512
Local Time is:                      Fri Jul 28 02:01:49 2017 EDT
