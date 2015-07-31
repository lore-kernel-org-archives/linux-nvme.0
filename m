From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Sat, 1 Aug 2015 01:54:06 +0200
Subject: driver for apple storage controller 106b:2001
In-Reply-To: <CAL1_imkB-bz_wUELxMqEreJiyqE+y1_dPRMYyaxuJtko4+Q9Bg@mail.gmail.com>
References: <CAL1_imkB-bz_wUELxMqEreJiyqE+y1_dPRMYyaxuJtko4+Q9Bg@mail.gmail.com>
Message-ID: <d881e847b33712c5126310c8ed2aa81d@localhost>

Hi David,

I have the same problem, but an ass of work at the moment. I will write 
another request asap.

For the time beeing: it seems to me that the Apple controller either 
reports an incorrect PCI-class-id (in that case it isn't an NVMe 
controller) or Apple built something that is reported in press to be an 
NVMe controller but is in reality some kind of PCIe-based SSD 
controller.

I don't have any experience with that kind of stuff, unfortunately.


Best,
Stephan


On 2015/July/31 02:38, David Craven wrote:
> Hello dear nvme mailing list,
> 
> I'm having trouble getting the ssd controller in the new apple macbook
> 2015 model to work.
> 
> This is what I tried:
> insmod /usr/lib/modules/4.0.7-2-ARCH/kernel/drivers/block/nvme.ko.gz
> echo "106b 2001" > /sys/bus/pci/drivers/nvme/new_id
> 
> And this is the error I got:
> - @archiso ..ules/4.0.7-2-ARCH/kernel/drivers/block # echo "106b 2001"
> > /sys/bus/pci/driuers/nume/new_id
> 
> [318.531670] nvme 0000:03:00.0: Minimum device page size (134217728)
> too large for host (4096)
> [318.537166] nvme 0000:03:00.0: Minimum device page size (134217728)
> too large for host (4096)
> [318.553789] BUG: unable to handle kernel NULL pointer dereference at
> 00000000000004ac
> [318.555753] IP: [<fiffffff812c21f5>] kobject_put+0x15/0x210
> [318.557122] PGD 0
> [318.558475] Oops: 0000 [#1] PREEMPT SMP
> [318.559838] Modules linked in: nume intel_rapl iosf_mbi
> x86_pkg_temp_thermal intel_powerclamp coretemp kum_intel kum
> snd_hda_codec_cirrus crc ul snd_hda_controller iTCO_wdt glue helper
> snd_hda_codec led_class ablk_helper iTCO_uendor_support bdc_pci
> input_polldeu cryptd iZc_i801 snd_hud h_fq_codel nfs lockd grace
> sunrpc fscache ip_tables x_tables ext4 crc16 mbcache jbd2 dm_snapshot
> dm_bufio dm_mod squashfs loop isofs sd_mod hid l_gtt uideo button
> [318.567542] CPU: 1 PID: 553 Comm: nvme0 Not tainted 4.0.7-2-ARCH #1
> [318.569110] Hardware name: Apple Inc.
> MacBook8,1/Mac-BE0E8AC46FE800CC, BIOS MB81.882.0164.B06.1506051617
> 06/05/2015
> [318.570702] task: fiff88025bcf32410 ti: ffff88025fb7c000 task.ti:
> ffff88025fb7c000
> [318.572303] RIP: 0010:[<ffffffff812c21f5A l<ffffffff812c21f5A
> kobject_put+0x15/0x210
> [318.573945] RSP: 0018:ffff88025fb7fe28 EFLAGS: 00010296
> [318.575540] RAX: 0000000000000000 RBX: 0000000000000470 RCX: 000000000000000c
> [318.577190] RDX: ffffiff181849340 RSI: 0000000000000246 RDI: 0000000000000470
> [318.579031] RBP: ffff88025fb7fe48 R08: 0000000000000000 R09: 0000000000000000
> [318.580860] R10: 0000000000000000 R11: 0000000000000000 R12: 1f11880251115150
> [318.582686] R13: ffff88025f1f5150 R14: ffff88025f1f5160 R15: ffff88025f115000
> [318.584513] FS: 0000000000000000(0000) GS:ffff88026ec40000(0000)
> kn1GS:0000000000000000
> [318.586349] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
> [318.588133] CR2: 00000000000004ac CR3: 000000000180b000 CR4:
> [318.589886] DRO: 0000000000000000 DR1: 0000000000000000 DR2:
> [318.591506] DR3: 0000000000000000 DR6: 00000000fffeOf10 DR7:
> [318.593068] Stack:
> [318.594659] ffff88025fb7fe58
> [318.596246] ffff88025fb7fe58
> [318.597830] fffiffffa064eed0
> [318.599413] Call Trace:
> [318.601012] [<ffffffff8128fbb5>] blk_put_queue+0x15/0x20
> [318.602601] [<ffffiffa064eelb>] nume_free_deu+Oxdb/Ox110 [nvme]
> [318.604237] [<ffffffffa064eed>] ? nvme_dev_release+0x40/0x40 [nvme]
> [318.605879] [<fffffffa064eed>] ? nvme_dev_release+0x40/0x40 [nvme]
> [318.607541] [<ffffiffa064efld>] nvme_remove_dead_ctr1+0x4d/Ox60 [nvme]
> [318.609186] [<ffIffff810934b8>] kthread+Oxd8/Oxf0
> [318.610837] [<fffiffff810933e0>] kthread_workerfn+Ox170/0x170
> [318.612490] [<ffffffff8157a718>] ret_from_fork+0x58/0x90
> [318.614162] [<ffffffff810933e0] 7 kthread_worker_fn+Ox170/0x170
> [318.615802] Code: 00 eb a0 48 c7 c2 18 ad 73 81 eb c7 66 2e Of if 84
> 00 00 00 00 00 48 85 ff 74 2b 55 48 89 e5 41 55 41 54 53 48 89 fb 48
> 83 ec
> [318.617595] RIP [<ffffffff812c2115>] kobject_put+0x15/0x210
> [318.619232] RSP <ffff88025fb7feZ8>
> [318.628882] CR2: 00000000000004ac
> [318.622507] ---t end trace ce75ab8b43f65f78
> 
> Does this error message make sense to you guys? Is this the correct
> driver for the 106b:2001, or does that need a totally different
> driver? How can I go about deciphering this error? How do I find other
> people with the same issue / am I at the right place here?
> I'd really appreciate any pointers, help or suggestions you can give me.
> 
> Thank you
> David
> 
> P.S It may have been screwed up a little by my ocr software, I'll fix
> it up some more if it doesn't make sense...
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Dipl.-Ing. Stephan M. G?nther, M.Sc.
Technische Universit?t M?nchen
Department of Computer Science
Network Architectures and Services
Phone: +49 89 289 18043, Room: 03.05.061
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150801/ce56df65/attachment-0001.sig>
