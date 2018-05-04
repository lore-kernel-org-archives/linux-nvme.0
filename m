From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri,  4 May 2018 16:02:38 +0800
Subject: [PATCH] nvme-rdma: clear NVME_RDMA_Q_LIVE before free the queue
Message-ID: <1525420958-9537-1-git-send-email-jianchao.w.wang@oracle.com>

When nvme_init_identify in nvme_rdma_configure_admin_queue fails,
the ctrl->queues[0] is freed but the NVME_RDMA_Q_LIVE is still set.
If nvme_rdma_stop_queue is invoked, we will incur use-after-free
which will cause memory corruption.
 BUG: KASAN: use-after-free in rdma_disconnect+0x1f/0xe0 [rdma_cm]
 Read of size 8 at addr ffff8801dc3969c0 by task kworker/u16:3/9304

 CPU: 3 PID: 9304 Comm: kworker/u16:3 Kdump: loaded Tainted: G        W         4.17.0-rc3+ #20
 Workqueue: nvme-delete-wq nvme_delete_ctrl_work
 Call Trace:
  dump_stack+0x91/0xeb
  print_address_description+0x6b/0x290
  kasan_report+0x261/0x360
  rdma_disconnect+0x1f/0xe0 [rdma_cm]
  nvme_rdma_stop_queue+0x25/0x40 [nvme_rdma]
  nvme_rdma_shutdown_ctrl+0xf3/0x150 [nvme_rdma]
  nvme_delete_ctrl_work+0x98/0xe0
  process_one_work+0x3ca/0xaa0
  worker_thread+0x4e2/0x6c0
  kthread+0x18d/0x1e0
  ret_from_fork+0x24/0x30

To fix it, clear the NVME_RDMA_Q_LIVE before free the ctrl->queues[0].
The queue will be freed, so it certainly is not LIVE any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/rdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index fd965d0..ffbfe82 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -812,6 +812,11 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (new)
 		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 out_free_queue:
+	/*
+	 * The queue will be freed, so it is not LIVE any more.
+	 * This could avoid use-after-free in nvme_rdma_stop_queue.
+	 */
+	clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
 }
-- 
2.7.4
