From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Sun, 14 Jan 2018 16:32:03 +0000
Subject: [PATCH] nvme-rdma: fix sysfs invoked reset_ctrl error flow
Message-ID: <20180114163203.4771-1-nitzanc@mellanox.com>

When reset_controller that is invoked by sysfs fails,
it enters an error flow which practically removes the
nvme ctrl entirely (similar to delete_ctrl flow). It
causes the system to hang, since a sysfs attribute cannot
be unregistered by one of its own methods.

This can be fixed by calling delete_ctrl as a work rather
than sequential code. In addition, it should give the ctrl
a chance to recover using reconnection mechanism (consistant
with FC reset_ctrl error flow). Also, while we're here, return
suitable errno in case the reset ended with non live ctrl.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 6 +++++-
 drivers/nvme/host/rdma.c | 6 +-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6358cd..84b80a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -100,8 +100,12 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
 	int ret;
 
 	ret = nvme_reset_ctrl(ctrl);
-	if (!ret)
+	if (!ret) {
 		flush_work(&ctrl->reset_work);
+		if (ctrl->state != NVME_CTRL_LIVE)
+			ret = -ENETRESET;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d06641b..890c488 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1791,11 +1791,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	return;
 
 out_fail:
-	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_remove_namespaces(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, true);
-	nvme_uninit_ctrl(&ctrl->ctrl);
-	nvme_put_ctrl(&ctrl->ctrl);
+	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
-- 
2.9.4
