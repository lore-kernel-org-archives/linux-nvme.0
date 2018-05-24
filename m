From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu, 24 May 2018 09:27:38 +0800
Subject: [PATCH V3] nvme-rdma: stop queue first before free it in config admin
 queue
Message-ID: <1527125258-15825-1-git-send-email-jianchao.w.wang@oracle.com>

When any of cases after nvme_rdma_start_queue in
nvme_rdma_configure_admin_queue fails, the ctrl->queues[0] will be
freed but the NVME_RDMA_Q_LIVE is still set. If nvme_rdma_stop_queue
is invoked, we will incur use-after-free which will cause memory
corruption.
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

To fix it, call nvme_rdma_stop_queue for all the failed cases after
nvme_rdma_start_queue.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Suggested-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---

V3:
add Suggested-by Sagi

V2:
based on Sagi's suggestion, add out_stop_queue lable and invoke
nvme_rdma_stop_queue in all the failed cases after nvme_rdma_start_queue


 drivers/nvme/host/rdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1eb4438..2181299 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -778,7 +778,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 	}
 
 	ctrl->ctrl.sqsize =
@@ -786,23 +786,25 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 
 	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
 			&ctrl->async_event_sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_stop_queue;
 
 	return 0;
 
+out_stop_queue:
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 out_cleanup_queue:
 	if (new)
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
-- 
2.7.4
