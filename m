From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Tue, 18 Dec 2018 22:28:57 +0000
Subject: Problems with commit "cb4bfda62afa nvme-pci: fix hot removal during
 error handling"
Message-ID: <ab932da928c242ab976ff469be2fdc44@ausx13mps321.AMER.DELL.COM>

Hi,

I've been seeing two issues with this commit. One was a NULL dereference
that appears to have been fixed in 4.20-rc7.

For the second issue, I've included a system log in Appendix B with an 
explanation of what events are being generated -- all done with a 
hardware yanker, not ACPI or fake injection techniques.

After the second or so removal, the kernel will think the device is 
gone, and fails to recognize hotplug interrupts that bring the device 
back online. The hardware continues to send hotplug interrupts, but the 
handler doesn't want to recognize them -- look for "pciehp_isr hit" 
message in the logs.

I'm seeing this issue starting with commit
cb4bfda62afa "nvme-pci: fix hot removal during error handling"
I can't reproduce it with the commit right before it.

I'm not sure if this is a PCI or NVME bug, and it is baffling as to what 
the heck is going on. Even if I revert the commit from v4.20-rc7, I 
continue to see the hotplug interrupt misfire. I suspect it's the 
combination of several changes that breaks things.

Who let the bugs out?

Alex


Appendix B: System log with explanations

[  133.772812] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready

**** Lanes 0-2 are disconnected here

[  599.231003] pcieport 0000:b0:04.0: pciehp_isr hit
[  599.231067] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down
[  599.272506] pcieport 0000:b0:04.0: pciehp_isr hit
[  599.299943] pciehp 0000:b0:04.0:pcie204: Slot(178): Card present
[  599.299947] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up
[  599.605523] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802
[  599.605565] pci 0000:b1:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  599.605612] pci 0000:b1:00.0: Max Payload Size set to 256 (was 128,
max 512)
[  599.605618] pci 0000:b1:00.0: enabling Extended Tags
[  599.605845] acpi_run_hpx: Type 3 record not supported
[  599.605984] pci 0000:b1:00.0: 7.876 Gb/s available PCIe bandwidth,
limited by 8 GT/s x1 link at 0000:b0:04.0 (capable of 31.504 Gb/s with 8
GT/s x4 link)
[  599.606356] pcieport 0000:b0:04.0: bridge window [io  0x1000-0x0fff]
to [bus b1] add_size 1000
[  599.606364] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000]
[  599.606368] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size
0x1000]
[  599.606371] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000]
[  599.606375] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size
0x1000]
[  599.606382] pci 0000:b1:00.0: BAR 0: assigned [mem
0xe1500000-0xe1503fff 64bit]
[  599.606426] pcieport 0000:b0:04.0: PCI bridge to [bus b1]
[  599.606434] pcieport 0000:b0:04.0:   bridge window [mem
0xe1500000-0xe15fffff]
[  599.606440] pcieport 0000:b0:04.0:   bridge window [mem
0x386000000000-0x3860001fffff 64bit pref]
[  599.608379] nvme nvme4: pci function 0000:b1:00.0
[  599.608680] nvme 0000:b1:00.0: enabling device (0000 -> 0002)
[  603.386826]  nvme1n2: p1
[  603.475185] md: super_written gets error=10
[  603.475192] md/raid1:mdX: Disk failure on dm-13, disabling device.
                md/raid1:mdX: Operation continuing on 2 devices.
[  603.519511] device-mapper: raid: Faulty raid1 device #1 has readable
super block.  Attempting to revive it.

*** Lanes 0-2 are reconnected

[  603.548495] md: recovery of RAID array mdX

*** All PCIe lanes are disconnected here

[  623.162103] pcieport 0000:b0:04.0: pciehp_isr hit
[  623.162169] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down
[  623.168534] pcieport 0000:b0:04.0: pciehp_isr hit
[  623.185774] print_req_error: I/O error, dev nvme1n2, sector 7860864
[  623.185812] print_req_error: I/O error, dev nvme1n2, sector 7861248
[  623.185817] print_req_error: I/O error, dev nvme1n2, sector 7857920
[  623.185822] print_req_error: I/O error, dev nvme1n2, sector 7858432
[  623.185826] print_req_error: I/O error, dev nvme1n2, sector 7858560
[  623.185830] print_req_error: I/O error, dev nvme1n2, sector 7862144
[  623.185835] print_req_error: I/O error, dev nvme1n2, sector 7858944
[  623.185870] md/raid1:mdX: Disk failure on dm-13, disabling device.
                md/raid1:mdX: Operation continuing on 2 devices.
[  623.185873] md: mdX: recovery interrupted.
[  623.185881] print_req_error: I/O error, dev nvme1n2, sector 7861376
[  623.197723] print_req_error: I/O error, dev nvme1n2, sector 7859072
[  623.197727] print_req_error: I/O error, dev nvme1n2, sector 7862528

*** All PCIe lanes are re-connected

[  628.842766] pcieport 0000:b0:04.0: pciehp_isr hit
[  628.842829] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up
[  629.147089] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802
[  629.147130] pci 0000:b1:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  629.147177] pci 0000:b1:00.0: Max Payload Size set to 256 (was 128,
max 512)
[  629.147182] pci 0000:b1:00.0: enabling Extended Tags
[  629.147401] acpi_run_hpx: Type 3 record not supported
[  629.147888] pcieport 0000:b0:04.0: bridge window [io  0x1000-0x0fff]
to [bus b1] add_size 1000
[  629.147896] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000]
[  629.147899] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size
0x1000]
[  629.147903] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000]
[  629.147906] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size
0x1000]
[  629.147913] pci 0000:b1:00.0: BAR 0: assigned [mem
0xe1500000-0xe1503fff 64bit]
[  629.147926] pcieport 0000:b0:04.0: PCI bridge to [bus b1]
[  629.147933] pcieport 0000:b0:04.0:   bridge window [mem
0xe1500000-0xe15fffff]
[  629.147939] pcieport 0000:b0:04.0:   bridge window [mem
0x386000000000-0x3860001fffff 64bit pref]
[  629.148891] nvme nvme2: pci function 0000:b1:00.0
[  629.148932] nvme 0000:b1:00.0: enabling device (0000 -> 0002)
[  629.239386] pcieport 0000:b0:04.0: pciehp_isr hit
[  629.239420] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present

*** Lanes not disconnected again until here

[  635.951171] pcieport 0000:b0:04.0: pciehp_isr hit
[  635.992718] pcieport 0000:b0:04.0: pciehp_isr hit
[  659.866526] pcieport 0000:b0:04.0: pciehp_isr hit
[  659.877189] pcieport 0000:b0:04.0: pciehp_isr hit
[  665.555242] pcieport 0000:b0:04.0: pciehp_isr hit
