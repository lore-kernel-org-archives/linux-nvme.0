From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 22 Oct 2015 18:10:15 +0000
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <1445515421-4940-9-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-9-git-send-email-hch@lst.de>
Message-ID: <20151022181014.GE21840@localhost.localdomain>

On Thu, Oct 22, 2015@02:03:40PM +0200, Christoph Hellwig wrote:
> Compared to the kthread this gives us multiple call prevention for free.

My apologies in advance, I usually try to be more helpful debugging
new issues, but I'm running low on time today. I might be able to dig
into this more tomorrow, but if you could, please verify what happens
if an admin command times out during initialization. The reset_work
gets queued twice on two different work_queues and causes trouble. I
get one of several crashes or warnings after applying the whole series,
but this is the most frequent I'm seeing so far:

[  348.845441] BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
[  348.846615] IP: [<ffffffffa02c1a48>] nvme_dev_shutdown+0x303/0x3e8 [nvme]
[  348.847615] PGD b8749067 PUD b8748067 PMD 0
[  348.848328] Oops: 0002 [#1] SMP
[  348.848826] Modules linked in: nvme bnep rfcomm bluetooth rfkill nfsd auth_rpcgss oid_registry nfs_acl nfs lockdgrace fscache sunrpc dm_round_robin loop dm_multipath parport_pc parport evdev psmouse pcspkr serio_raw processor button ext4 crc16 jbd2 mbcache sg sr_mod sd_mod cdrom ata_generic floppy e1000 ata_piix libata scsi_mod
[  348.849428] CPU: 0 PID: 3415 Comm: kworker/0:0 Not tainted 4.3.0-rc4+ #4
[  348.849428] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
[  348.849428] Workqueue: events nvme_remove_dead_ctrl_work [nvme]
[  348.849428] task: ffff88013afe6ec0 ti: ffff88013afe8000 task.ti: ffff88013afe8000
[  348.849428] RIP: 0010:[<ffffffffa02c1a48>]  [<ffffffffa02c1a48>] nvme_dev_shutdown+0x303/0x3e8 [nvme]
[  348.849428] RSP: 0018:ffff88013afebcd8  EFLAGS: 00010202
[  348.849428] RAX: 0000000000464001 RBX: ffff8800369c2800 RCX: 0000005138ced189
[  348.849428] RDX: 0000000000000000 RSI: ffffffff81409bf0 RDI: ffff88013ab53f10
[  348.849428] RBP: ffff88013afe6ec0 R08: ffff88013afe8000 R09: 0000000000000000
[  348.849428] R10: 0000000000000000 R11: ffff88013fc142c0 R12: 0000000000000000
[  348.849428] R13: ffff880036f0c540 R14: ffff88013afebcf8 R15: 0000000000000000
[  348.849428] FS:  0000000000000000(0000) GS:ffff88013fc00000(0000) knlGS:0000000000000000
[  348.849428] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  348.849428] CR2: 0000000000000014 CR3: 00000000b8cb2000 CR4: 00000000000006f0
[  348.849428] Stack:
[  348.849428]  ffff8800b8e556b8 0000000000000000 ffff8800b8e55640 0000000000000082
[  348.849428]  ffff88013afe6ec0 ffff88013afebd10 ffff880100000000 0000000000000000
[  348.849428]  ffff88013afebd18 ffff88013afebd18 0000000000000000 0000000000000000
[  348.849428] Call Trace:
[  348.849428]  [<ffffffffa02c1bd6>] ? nvme_remove+0x6f/0xc0 [nvme]
[  348.849428]  [<ffffffff8121b67a>] ? pci_device_remove+0x43/0x8e
[  348.849428]  [<ffffffff812bb882>] ? __device_release_driver+0x91/0x109
[  348.849428]  [<ffffffff812bb90b>] ? device_release_driver+0x11/0x1a
[  348.849428]  [<ffffffff812165e2>] ? pci_stop_bus_device+0x62/0x85
[  348.849428]  [<ffffffff81216798>] ? pci_stop_and_remove_bus_device+0x9/0x12
[  348.849428]  [<ffffffff812167b9>] ? pci_stop_and_remove_bus_device_locked+0x18/0x21
[  348.849428]  [<ffffffffa02bfd44>] ? nvme_remove_dead_ctrl_work+0x1e/0x28 [nvme]
[  348.849428]  [<ffffffff810560b6>] ? process_one_work+0x177/0x27b
[  348.849428]  [<ffffffff81056394>] ? worker_thread+0x1b4/0x28b
[  348.849428]  [<ffffffff810561e0>] ? process_scheduled_works+0x26/0x26
[  348.849428]  [<ffffffff8105a4b6>] ? kthread+0x99/0xa1
[  348.849428]  [<ffffffff8105a41d>] ? kthread_parkme+0x16/0x16
[  348.849428]  [<ffffffff813c9d6f>] ? ret_from_fork+0x3f/0x70
[  348.849428]  [<ffffffff8105a41d>] ? kthread_parkme+0x16/0x16
[  348.849428] Code: 48 89 44 24 18 48 8b 44 24 18 4c 89 ef e8 ce 88 d9 e0 8b 83 2c 01 00 00 48 8b 93 38 01 00 00 80 e4 3f 80 cc 40 89 83 2c 01 00 00 <89> 42 14 0f b6 2d fe 46 00 00 48 8b 05 a7 85 34 e1 65 4c 8b 24
[  348.849428] RIP  [<ffffffffa02c1a48>] nvme_dev_shutdown+0x303/0x3e8 [nvme]
[  348.849428]  RSP <ffff88013afebcd8>
[  348.849428] CR2: 0000000000000014
[  348.849428] ---[ end trace f11db05b8d65bab0 ]---
