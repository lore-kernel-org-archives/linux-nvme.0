From: mlin@kernel.org (Ming Lin)
Date: Wed, 13 Jul 2016 14:26:36 -0700
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to nvme_rdma_free_ctrl
In-Reply-To: <1468445196-6915-1-git-send-email-mlin@kernel.org>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
Message-ID: <1468445196-6915-3-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Steve reported below crash when unloading iw_cxgb4.

[59079.932154] nvme nvme1: Got rdma device removal event, deleting ctrl
[59080.034208] BUG: unable to handle kernel paging request at ffff880f4e6c01f8
[59080.041972] IP: [<ffffffffa02e5a46>] __ib_process_cq+0x46/0xc0 [ib_core]
[59080.049422] PGD 22a5067 PUD 10788d8067 PMD 1078864067 PTE 8000000f4e6c0060
[59080.057109] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC

[59080.164160] CPU: 0 PID: 14879 Comm: kworker/u64:2 Tainted: G            E   4.7.0-rc2-block-for-next+ #78
[59080.174704] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[59080.182673] Workqueue: iw_cxgb4 process_work [iw_cxgb4]
[59080.188924] task: ffff8810278646c0 ti: ffff880ff271c000 task.ti: ffff880ff271c000
[59080.197448] RIP: 0010:[<ffffffffa02e5a46>]  [<ffffffffa02e5a46>] __ib_process_cq+0x46/0xc0 [ib_core]
[59080.207647] RSP: 0018:ffff881036e03e48  EFLAGS: 00010282
[59080.214000] RAX: 0000000000000010 RBX: ffff8810203f3508 RCX: 0000000000000000
[59080.222194] RDX: ffff880f4e6c01f8 RSI: ffff880f4e6a1fe8 RDI: ffff8810203f3508
[59080.230393] RBP: ffff881036e03e88 R08: 0000000000000000 R09: 000000000000000c
[59080.238598] R10: 0000000000000000 R11: 00000000000001f8 R12: 0000000000000020
[59080.246800] R13: 0000000000000100 R14: 0000000000000000 R15: 0000000000000000
[59080.255002] FS:  0000000000000000(0000) GS:ffff881036e00000(0000) knlGS:0000000000000000
[59080.264173] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[59080.271013] CR2: ffff880f4e6c01f8 CR3: 000000102105f000 CR4: 00000000000406f0
[59080.279258] Stack:
[59080.282377]  0000000000000000 00000010fcddc1f8 0000000000000246 ffff8810203f3548
[59080.290979]  ffff881036e13630 0000000000000100 ffff8810203f3508 ffff881036e03ed8
[59080.299587]  ffff881036e03eb8 ffffffffa02e5e12 ffff8810203f3548 ffff881036e13630
[59080.308198] Call Trace:
[59080.311779]  <IRQ>
[59080.313731]  [<ffffffffa02e5e12>] ib_poll_handler+0x32/0x80 [ib_core]
[59080.322653]  [<ffffffff81395695>] irq_poll_softirq+0xa5/0xf0
[59080.329484]  [<ffffffff816f186a>] __do_softirq+0xda/0x304
[59080.336047]  [<ffffffff816f15b5>] ? do_IRQ+0x65/0xf0
[59080.342193]  [<ffffffff816f08fc>] do_softirq_own_stack+0x1c/0x30
[59080.349381]  <EOI>
[59080.351351]  [<ffffffff8109004e>] do_softirq+0x4e/0x50
[59080.359018]  [<ffffffff81090127>] __local_bh_enable_ip+0x87/0x90
[59080.366178]  [<ffffffffa081b837>] t4_ofld_send+0x127/0x180 [cxgb4]
[59080.373499]  [<ffffffffa08095ae>] cxgb4_remove_tid+0x9e/0x140 [cxgb4]
[59080.381079]  [<ffffffffa039235c>] _c4iw_free_ep+0x5c/0x100 [iw_cxgb4]
[59080.388665]  [<ffffffffa0396812>] peer_close+0x102/0x260 [iw_cxgb4]
[59080.396082]  [<ffffffffa039629a>] ? process_work+0x5a/0x70 [iw_cxgb4]
[59080.403664]  [<ffffffffa039629a>] ? process_work+0x5a/0x70 [iw_cxgb4]
[59080.411254]  [<ffffffff815c42c4>] ? __kfree_skb+0x34/0x80
[59080.417762]  [<ffffffff815c4437>] ? kfree_skb+0x47/0xb0
[59080.424084]  [<ffffffff815c24e7>] ? skb_dequeue+0x67/0x80
[59080.430569]  [<ffffffffa039628e>] process_work+0x4e/0x70 [iw_cxgb4]
[59080.437940]  [<ffffffff810a4d03>] process_one_work+0x183/0x4d0
[59080.444862]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[59080.451373]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[59080.457506]  [<ffffffff810a59bd>] worker_thread+0x16d/0x530
[59080.464056]  [<ffffffff8102eb1d>] ? __switch_to+0x1cd/0x5e0
[59080.470570]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[59080.476985]  [<ffffffff810ccbc6>] ? __wake_up_common+0x56/0x90
[59080.483696]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[59080.490824]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[59080.496808]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[59080.503892]  [<ffffffff810aa5dc>] kthread+0xcc/0xf0
[59080.509573]  [<ffffffff810b4ffe>] ? schedule_tail+0x1e/0xc0
[59080.515928]  [<ffffffff816eed3f>] ret_from_fork+0x1f/0x40
[59080.522093]  [<ffffffff810aa510>] ? kthread_freezable_should_stop+0x70/0x70

Copy Steve's analysis:

"I think the problem is nvme_destroy_admin_queue() is called as part of
destroying the controller: nvme_rdma_del_ctrl_work() calls
nvme_rdma_shutdown_ctrl() which calls nvme_rdma_destroy_admin_queue().  The
admin nvme_rdma_queue doesn't get destroyed/freed, though, because the
NVME_RDMA_Q_CONNECTED flag has already been cleared by
nvme_rdma_device_unplug().  However nvme_destroy_admin_queue() _does_ free the
tag set memory, which I believe contains the nvme_rdma_request structs that
contain the ib_cqe struct, so when nvme_rdma_device_unplug() does finally flush
the QP we crash..."

Move the admin queue cleanup to nvme_rdma_free_ctrl() where we can make sure that
the RDMA queue was already disconnected and drained and no code will access it
any more.

Reported-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 drivers/nvme/host/rdma.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f845304..0d3c227 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -671,9 +671,6 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-	nvme_rdma_dev_put(ctrl->device);
 }
 
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
@@ -687,6 +684,10 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
+	blk_cleanup_queue(ctrl->ctrl.admin_q);
+	blk_mq_free_tag_set(&ctrl->admin_tag_set);
+	nvme_rdma_dev_put(ctrl->device);
+
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(&ctrl->tag_set);
-- 
1.9.1
