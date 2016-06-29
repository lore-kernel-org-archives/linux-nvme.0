From: mlin@kernel.org (Ming Lin)
Date: Wed, 29 Jun 2016 10:36:37 -0700
Subject: [PATCH] nvmet-rdma: fix nvmet_rdma_rsp leak
Message-ID: <1467221797-2576-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

A "nvmet_rdma_rsp" is removed from free_list when a request is received.
But if the queue state is already changed to NVMET_RDMA_Q_DISCONNECTING,
then the nvmet_rdma_rsp is leaked. This causes below crash when freeing
all rsps.

[  431.011636] general protection fault: 0000 [#1] PREEMPT SMP
[  431.167942] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[  431.175677] task: ffff880034d60000 ti: ffff880034cac000 task.ti: ffff880034cac000
[  431.184197] RIP: 0010:[<ffffffffc08f3e29>]  [<ffffffffc08f3e29>] nvmet_rdma_free_rsps+0x79/0x110 [nvmet_rdma]
[  431.195251] RSP: 0018:ffff880034cafdb8  EFLAGS: 00010282
[  431.201641] RAX: dead000000000200 RBX: ffff8800b31d55b0 RCX: 0000000181000066
[  431.209905] RDX: dead000000000100 RSI: ffffea0003475600 RDI: 0000000040000000
[  431.218181] RBP: ffff880034cafde0 R08: ffff8800d1d58d90 R09: 0000000181000066
[  431.226467] R10: 00000000d1d58d01 R11: ffff8800d1d58d90 R12: 00000000000155b0
[  431.234755] R13: ffff8800d0b21000 R14: ffff8800b3c6dc00 R15: 0000000000023800
[  431.242999] FS:  0000000000000000(0000) GS:ffff880120280000(0000) knlGS:0000000000000000
[  431.252204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  431.259036] CR2: 00007f4bf99a0285 CR3: 0000000001c06000 CR4: 00000000001406e0
[  431.267262] Stack:
[  431.270300]  ffff8800d0b21000 ffff8800d1c65000 ffff88012029ac00 0000000000000000
[  431.278880]  ffff880120296300 ffff880034cafdf8 ffffffffc08f40e9 ffff8800b3c6dc00
[  431.287483]  ffff880034cafe18 ffffffffc08f414a ffff880035632780 ffff8800d0b210c8
[  431.296081] Call Trace:
[  431.299625]  [<ffffffffc08f40e9>] nvmet_rdma_free_queue+0x49/0x90 [nvmet_rdma]
[  431.308012]  [<ffffffffc08f414a>] nvmet_rdma_release_queue_work+0x1a/0x40 [nvmet_rdma]
[  431.317112]  [<ffffffff81083019>] process_one_work+0x159/0x370
[  431.324097]  [<ffffffff81083356>] worker_thread+0x126/0x490
[  431.330839]  [<ffffffff816f17fe>] ? __schedule+0x1de/0x590
[  431.337475]  [<ffffffff81083230>] ? process_one_work+0x370/0x370
[  431.344668]  [<ffffffff81088864>] kthread+0xc4/0xe0
[  431.350718]  [<ffffffff816f571f>] ret_from_fork+0x1f/0x40
[  431.357306]  [<ffffffff810887a0>] ? kthread_create_on_node+0x170/0x170

Fixed it by putting the rsp back to the free_list.

Reported-and-tested-by: Steve Wise <swise at opengridcomputing.com>
Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 drivers/nvme/target/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 7faf34c..e06d504 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -757,6 +757,8 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		spin_lock_irqsave(&queue->state_lock, flags);
 		if (queue->state == NVMET_RDMA_Q_CONNECTING)
 			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
+		else
+			nvmet_rdma_put_rsp(rsp);
 		spin_unlock_irqrestore(&queue->state_lock, flags);
 		return;
 	}
-- 
1.9.1
