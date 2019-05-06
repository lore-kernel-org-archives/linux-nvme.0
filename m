From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon,  6 May 2019 23:52:03 +0900
Subject: [PATCH] nvme-loop: Fix race between completions and shutdown
Message-ID: <20190506145203.2851-1-minwoo.im.dev@gmail.com>

Now we can see oops due to race between request completion and the
shutdown of the nvme-loop device with [1].

It shows that NULL pointer deref has occurred because req->mq_hctx is
NULL because other CPU already has freed the request.

We can see the race between completion and shutdown(reset) with:

         CPU #0                                CPU #1
  =================================================================
  nvme_complete_rq()
   blk_mq_end_request()
    __blk_mq_end_request()
     blk_mq_free_request()
                                      nvme_loop_reset_ctrl_work()
                                       nvme_loop_shutdown_ctrl()
                                        blk_mq_tagset_busy_iter()
                                         nvme_cancel_request()
                                          blk_mq_complete_request_sync()
      __blk_mq_free_request()
       rq->mq_hctx = NULL;
                                           nvme_complete_rq()
                                            Oops here
       blk_mq_put_tag()

CPU #0 is trying to complete a given request, CPU #1 is trying to
reset the controller by sysfs.  In this case, before blk_mq_put_tag()
is invoked, the nvme_loop_shutdown_ctrl() will iterate over the requests
which is now inflight in the tagset.  Therefore nvme_complete_rq() in
CPU #1 will have the OOPS due to CPU #0 has already make rq->mq_hctx to
NULL.

This patch makes sure that before canceling requets over the tagset,
I/O queue is freezed to not receive any other request at all until
unfreeze.

This issue is able to be reproduced in 30sec on QEMU with prepared
nvme-loop device for the nvme target.

  # fio --name=iotest --size=100% --filename=/dev/nvme0n1 --rw=randrw
        --ioengine=libaio --bs=32k --iodepth=1 --time_based=1 --runtime=30s

  # while :
    do
        echo 1 > /sys/class/nvme/nvme0/reset_controller
        sleep 0.05s
    done

[1] Kernel oops messages based on [2]
[   19.815739] BUG: unable to handle kernel NULL pointer dereference at 0000000000000198
[   19.818632] #PF error: [WRITE]
[   19.819636] PGD 0 P4D 0
[   19.820317] Oops: 0002 [#1] SMP PTI
[   19.821240] CPU: 0 PID: 1827 Comm: kworker/0:3 Not tainted 5.1.0-rc6+ #25
[   19.823146] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   19.826463] Workqueue: events nvme_loop_execute_work [nvme_loop]
[   19.828225] RIP: 0010:blk_mq_free_request+0x80/0xf0
[   19.829206] Code: 00 00 00 00 8b 53 18 b8 01 00 00 00 84 d2 74 0b 31 c0 81 e2 00 08 06 00 0f 95 c0 48 83 84 c5 80 00 00 00 01 f6 43 1c 40 74 08 <f0> 41 ff 8d 98 01 00 00 8b 05 1a 6f 77 01 85 c0 74 16 0f b6 43 18
[   19.833062] RSP: 0018:ffff88813ba03e90 EFLAGS: 00010202
[   19.834151] RAX: 0000000000000001 RBX: ffff88813571c080 RCX: 0000000000000000
[   19.835731] RDX: 0000000000000800 RSI: ffff888132018848 RDI: ffff88813571c080
[   19.837244] RBP: ffffe8ffffc05b40 R08: 0000000000000000 R09: ffffffff8137ba00
[   19.838756] R10: ffffea00046c5380 R11: ffff88813fff9000 R12: ffff8881395f8718
[   19.839957] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.841365] FS:  0000000000000000(0000) GS:ffff88813ba00000(0000) knlGS:0000000000000000
[   19.843037] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.843980] CR2: 0000000000000198 CR3: 0000000139e94000 CR4: 00000000000006f0
[   19.845296] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   19.846476] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   19.847552] Call Trace:
[   19.847932]  <IRQ>
[   19.848214]  blk_mq_complete_request+0xd3/0xe0
[   19.848861]  nvmet_req_complete+0x11/0x40 [nvmet]
[   19.849473]  nvmet_bio_done+0xe1/0x100 [nvmet]
[   19.850038]  blk_update_request+0x16a/0x2c0
[   19.850574]  blk_mq_end_request+0x1a/0x110
[   19.851099]  blk_done_softirq+0x8d/0xc0
[   19.851604]  __do_softirq+0x152/0x311
[   19.852083]  irq_exit+0x53/0xc0
[   19.852500]  call_function_single_interrupt+0xf/0x20
[   19.853127]  </IRQ>
[   19.853415] RIP: 0010:process_one_work+0x1bc/0x3e0
[   19.854026] Code: 45 38 48 85 c0 74 09 48 8b 78 38 e8 de 04 01 00 8b 75 0c 48 89 df e8 f3 da ff ff c6 45 00 00 e8 ca 18 0b 00 fb 0f 1f 44 00 00 <eb> 15 65 8b 05 0b f9 f8 7e 89 c0 48 0f a3 05 71 05 4c 01 72 04 eb
[   19.856836] RSP: 0018:ffffc900008bfea0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff04
[   19.857735] RAX: 0000000080000000 RBX: ffff888135701638 RCX: ffff888135702980
[   19.858649] RDX: ffff88813ba20460 RSI: 0000000000000000 RDI: ffffffff8107f816
[   19.859449] RBP: ffff88813ba20440 R08: 000073746e657665 R09: 8080808080808080
[   19.860241] R10: ffffc90002323df0 R11: fefefefefefefeff R12: ffff88813ba24300
[   19.861023] R13: 0000000000000000 R14: ffff88813a7fc3c0 R15: 0ffff88813ba2430
[   19.861812]  ? process_one_work+0x1b6/0x3e0
[   19.862281]  worker_thread+0x1f9/0x3d0
[   19.862711]  ? cancel_delayed_work+0xa0/0xa0
[   19.863185]  kthread+0x117/0x120
[   19.863591]  ? kthread_stop+0xf0/0xf0
[   19.864067]  ret_from_fork+0x3a/0x50
[   19.864495] Modules linked in: nvme_loop nvme_fabrics nvmet nvme nvme_core
[   19.865270] CR2: 0000000000000198
[   19.865663] ---[ end trace 8374e189caec6067 ]---
[   19.866205] RIP: 0010:blk_mq_free_request+0x80/0xf0
[   19.866789] Code: 00 00 00 00 8b 53 18 b8 01 00 00 00 84 d2 74 0b 31 c0 81 e2 00 08 06 00 0f 95 c0 48 83 84 c5 80 00 00 00 01 f6 43 1c 40 74 08 <f0> 41 ff 8d 98 01 00 00 8b 05 1a 6f 77 01 85 c0 74 16 0f b6 43 18
[   19.868945] RSP: 0018:ffff88813ba03e90 EFLAGS: 00010202
[   19.869557] RAX: 0000000000000001 RBX: ffff88813571c080 RCX: 0000000000000000
[   19.870410] RDX: 0000000000000800 RSI: ffff888132018848 RDI: ffff88813571c080
[   19.871210] RBP: ffffe8ffffc05b40 R08: 0000000000000000 R09: ffffffff8137ba00
[   19.872164] R10: ffffea00046c5380 R11: ffff88813fff9000 R12: ffff8881395f8718
[   19.872915] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   19.873785] FS:  0000000000000000(0000) GS:ffff88813ba00000(0000) knlGS:0000000000000000
[   19.874831] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   19.875494] CR2: 0000000000000198 CR3: 0000000139e94000 CR4: 00000000000006f0
[   19.876344] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   19.877173] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   19.878007] Kernel panic - not syncing: Fatal exception in interrupt
[   19.879005] Kernel Offset: disabled
[   19.879414] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

[2] Based branch
  git://git.infradead.org/nvme.git nvme-5.1
    commit d808b7f759b5 ("nvmet: fix discover log page when offsets
                          are used")

Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/target/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9e211ad6bdd3..10ccda7c182a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -404,10 +404,15 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(&ctrl->ctrl);
+		nvme_wait_freeze(&ctrl->ctrl);
+
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
+
+		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-- 
2.17.1
