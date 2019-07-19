From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 12:45:44 -0700
Subject: [PATCH 2/4] nvme: move sqsize setting to the core
In-Reply-To: <20190719194546.24229-1-sagi@grimberg.me>
References: <20190719194546.24229-1-sagi@grimberg.me>
Message-ID: <20190719194546.24229-3-sagi@grimberg.me>

nvme_init_identify reads the cap register right after, so
no need to do that locally in the transport driver.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c   |  1 +
 drivers/nvme/host/fc.c     | 10 ----------
 drivers/nvme/host/pci.c    |  1 +
 drivers/nvme/host/rdma.c   | 11 -----------
 drivers/nvme/host/tcp.c    |  9 ---------
 drivers/nvme/target/loop.c | 10 ----------
 6 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 058e06e40df8..da4182aa16b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2579,6 +2579,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return ret;
 	}
 	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
 
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
 		ctrl->subsystem = NVME_CAP_NSSRC(ctrl->cap);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1a391aa1f7d5..67d420bd79f6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2647,16 +2647,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * prior connection values
 	 */
 
-	ret = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
-	if (ret) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_disconnect_admin_queue;
-	}
-
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
-
 	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (ret)
 		goto out_disconnect_admin_queue;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb970ca82517..0f38c1d96d19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2316,6 +2316,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
+	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7b074323bcdf..8e9f0fd5b01f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -809,17 +809,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_cleanup_queue;
 
-	error = ctrl->ctrl.ops->reg_read64(&ctrl->ctrl, NVME_REG_CAP,
-			&ctrl->ctrl.cap);
-	if (error) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_stop_queue;
-	}
-
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
-
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (error)
 		goto out_stop_queue;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8d4965031399..fba80dc61ce1 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1721,15 +1721,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_cleanup_queue;
 
-	error = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
-	if (error) {
-		dev_err(ctrl->device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_stop_queue;
-	}
-
-	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
-
 	error = nvme_enable_ctrl(ctrl, ctrl->cap);
 	if (error)
 		goto out_stop_queue;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9e211ad6bdd3..d901a019e3a2 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -369,16 +369,6 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 
-	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP, &ctrl->ctrl.cap);
-	if (error) {
-		dev_err(ctrl->ctrl.device,
-			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
-	}
-
-	ctrl->ctrl.sqsize =
-		min_t(int, NVME_CAP_MQES(ctrl->ctrl.cap), ctrl->ctrl.sqsize);
-
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (error)
 		goto out_cleanup_queue;
-- 
2.17.1
