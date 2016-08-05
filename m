From: marc@merlins.org (Marc MERLIN)
Date: Fri, 5 Aug 2016 12:03:23 -0700
Subject: NVME regression in all kernels after 4.4.x for NVME in M2 slot for
 laptop?
Message-ID: <20160805190323.GA12853@merlins.org>

I've been stuck on 4.4.x for a while (currently 4.4.5) because any
subsequent kernel would fail to suspend or resume (S3 sleep) on my
Thinkpad P70.

Due to lack of time, I only got around to doing a git bisect now
(sorry), and did it between 4.4.0 and 4.5.0
It's my first bisect, but I hope I did it right outside of the fact that
my kernel wasn't exactly the same each time due to having my .config
file change depending on which kernel I ended up on.

However, the patch found by bisect makes sense that it would be a good
culprit.
I use an NVME 512GB SSD in my laptop, and I guess very few people use those
which could be why I'm the first/only person to report this.

Sadly because NVME changed a lot between 4.4 and 4.5 and I'm not a
kernel hacker, I can't just reverse apply the patch to 4.5 and see if it
works because I'd have to unroll a bunch of other changes too, and
that's a bit beyond my expertise and time at hand right now.

Would this patch make sense as being the reason why I can't S3 sleep
anymore and would you have a test patch against 4.5, 4.6, or 4.7 I can
try to see if it fixes the problem?
Symptom is that my red LED (the dot for in in thinkpad on the back
cover) goes flashing in weird ways when I shut the lid, but not always
the same pattern, however none are the normal on/off gentle pulsing that
indicate proper S3 sleep.
The caps lock key LED also flashes rapidly when I open the lid and the
laptop is stone dead at this point.

Boot logs on 4.4.5 kernel where sleep works fine:
[    1.245549] ahci 0000:00:17.0: version 3.0
[    1.245733] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0xc impl SATA mode
[    1.245771] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
[    1.251140] scsi host0: ahci
[    1.251587] scsi host1: ahci
[    1.251972] scsi host2: ahci
[    1.252360] scsi host3: ahci
[    1.252437] ata1: DUMMY
[    1.252449] ata2: DUMMY
[    1.252462] ata3: SATA max UDMA/133 abar m2048 at 0xd584c000 port 0xd584c200 irq 122
[    1.252499] ata4: SATA max UDMA/133 abar m2048 at 0xd584c000 port 0xd584c280 irq 122
[    1.253374] scsi host4: pata_legacy
[    1.253439] ata5: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[    1.355385]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8
[    1.570804] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.570877] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.573097] ata3.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.573101] ata3.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.573690] ata3.00: supports DRM functions and may not be fully accessible
[    1.574399] ata3.00: disabling queued TRIM support
[    1.574402] ata3.00: ATA-9: Samsung SSD 850 EVO 2TB, EMT01B6Q, max UDMA/133
[    1.574435] ata3.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.575954] ata3.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.575958] ata3.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[    1.576550] ata3.00: supports DRM functions and may not be fully accessible
[    1.577209] ata3.00: disabling queued TRIM support
[    1.578007] ata3.00: configured for UDMA/133
[    1.578037] ata4.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[    1.578040] ata4.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out


Patch found by bisect, attached

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
-------------- next part --------------
A non-text attachment was scrubbed...
Name: freeze.diff
Type: text/x-diff
Size: 3888 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160805/934c1a84/attachment.bin>
