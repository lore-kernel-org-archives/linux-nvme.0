From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Dec 2014 16:38:05 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <5495CDFE.3060404@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
Message-ID: <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>

On Sat, 20 Dec 2014, Jens Axboe wrote:
> Here's the patch referenced. Keith, if you tested it, can I add your 
> tested/reviewed-by to it?

Oh, the perils of sending patches at the end of a Friday before holiday...

I re-tested on my dual-ported machine but without the linux-dm 3.20
bits, so we're not multipath capable here. DM rejects the device, clears
its request_queue and hits a bug, like the wait queue's task_list has
something invalid.

---
device-mapper: table: table load rejected: including non-request-stackable devices
device-mapper: table: unable to set table type
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: [<ffffffff81065459>] __wake_up_common+0x1e/0x78
PGD 7bb0d067 PUD 36b24067 PMD 0
SMP
Modules linked in: nvme bnep rfcomm bluetooth rfkill nfsd auth_rpcgss oid_registry nfs_acl nfs lockd grace fscache sunrpc dm_round_robin loop dm_multipath parport_pc evdev parport pcspkr psmouse serio_raw processor thermal_sys button ext4 crc16 jbd2 mbcache sg sr_mod cdrom sd_mod ata_generic ata_piix e1000 floppy libata scsi_mod [last unloaded: nvme]
CPU: 0 PID: 4597 Comm: multipath Tainted: G      D        3.18.0+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
task: ffff880036ac15d0 ti: ffff880076880000 task.ti: ffff880076880000
RIP: 0010:[<ffffffff81065459>]  [<ffffffff81065459>] __wake_up_common+0x1e/0x78
RSP: 0018:ffff880076883bd8  EFLAGS: 00010096
RAX: 0000000000000296 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff88007ab00878
RBP: ffff88007ab00880 R08: 0000000000000000 R09: 000000000000c201
R10: 000000000000c210 R11: 000000000000c1c1 R12: 0000000000000003
R13: 0000000000000000 R14: ffff880077ca5110 R15: ffff880076883d50
FS:  00007f53829d67a0(0000) GS:ffff88007f200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000776be000 CR4: 00000000000006f0
Stack:
  ffff88007c3df800 ffffffff810e75ae ffff88007f219430 ffff88007ab00878
  0000000000000296 ffff88007ab00e90 ffff880077ca5110 ffff880077ca5110
  ffff880076883d50 ffffffff8106579f ffff880077ca5110 0000000000000000
Call Trace:
  [<ffffffff810e75ae>] ? pcpu_free_area+0x79/0xf8
  [<ffffffff8106579f>] ? __wake_up+0x35/0x46
  [<ffffffff811bb67d>] ? blk_set_queue_dying+0x33/0x69
  [<ffffffff811bce39>] ? blk_cleanup_queue+0x25/0xfd
  [<ffffffff812b2ca5>] ? __dm_destroy+0x22c/0x254
  [<ffffffff812b6ff8>] ? dev_suspend+0x1cd/0x1cd
  [<ffffffff812b70e4>] ? dev_remove+0xec/0xf8
  [<ffffffff812b6223>] ? ctl_ioctl+0x384/0x3ac
  [<ffffffff81177d07>] ? SYSC_semtimedop+0x669/0x6ce
  [<ffffffff812b6257>] ? dm_ctl_ioctl+0xc/0x11
  [<ffffffff81126622>] ? do_vfs_ioctl+0x413/0x45a
  [<ffffffff81175492>] ? ipcget+0x129/0x14e
  [<ffffffff811266b2>] ? SyS_ioctl+0x49/0x77
  [<ffffffff813a3ed2>] ? system_call_fastpath+0x12/0x17
Code: 00 00 00 00 48 89 47 08 48 89 47 10 c3 41 57 41 56 41 55 41 89 cd 41 54 41 89 f4 55 48 8d 6f 08 53 89 d3 48 83 ec 18 48 8b 57 08 <4c> 8b 3a 48 8d 42 e8 49 83 ef 18 eb 35 44 8b 30 4c 89 c1 4c 89
RIP  [<ffffffff81065459>] __wake_up_common+0x1e/0x78
  RSP <ffff880076883bd8>
CR2: 0000000000000000
---[ end trace d9242e782d917b09 ]---

I also couldn't remember if I wrote this next part. It looks like I did,
and it's needed when we run out of requests. I think this still might lose
a "wake" in the case we call blk_cleanup_queue() just before bt_get()
calls prepare_to_wait(), so maybe need to check for dying before and
after io_schedule().

---
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 32e8dbb..69628ef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -275,6 +275,9 @@ static int bt_get(struct blk_mq_alloc_data *data,

                 io_schedule();

+               if (blk_queue_dying(data->q))
+                       break;
+
                 data->ctx = blk_mq_get_ctx(data->q);
                 data->hctx = data->q->mq_ops->map_queue(data->q,
                                 data->ctx->cpu);
--

Finally as Willy pointed out, I messed the nvme_queue struct's natural
alignment, so it doesn't pack.
