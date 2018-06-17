From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 17 Jun 2018 17:57:06 +0300
Subject: [PATCH 1/1] nvme-rdma: fix error flow during controller reset
Message-ID: <1529247426-13303-1-git-send-email-maxg@mellanox.com>

In case the IO queues configuration fails, we never destroy the admin
queue.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cef24ad..c193f61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1781,7 +1781,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	if (ctrl->ctrl.queue_count > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
-			goto out_fail;
+			goto destroy_admin;
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1795,6 +1795,8 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 	return;
 
+destroy_admin:
+	nvme_rdma_destroy_admin_queue(ctrl, false);
 out_fail:
 	++ctrl->ctrl.nr_reconnects;
 	nvme_rdma_reconnect_or_remove(ctrl);
-- 
1.8.3.1
