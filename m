From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Tue,  9 Jan 2018 10:03:12 +0800
Subject: [PATCH V2 1/2] nvme: split resetting state into reset_prepate and
 resetting
In-Reply-To: <1515463393-3004-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1515463393-3004-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1515463393-3004-2-git-send-email-jianchao.w.wang@oracle.com>

Currently, the ctrl->state will be changed to NVME_CTRL_RESETTING
before queue the reset work. This is not so strict. There could be
a big gap before the reset_work callback is invoked. In addition,
there is some disable work in the reset_work callback, strictly
speaking, not part of reset work, and could lead to some confusion.

This patch splits the NVME_CTRL_RESETTING into NVME_CTRL_RESET_PREPARE
and NVME_CTRL_RESETTING. Before queue the reset work, changes state
to NVME_CTRL_RESET_PREPARE, after disable work completes, changes
state to NVME_CTRL_RESETTING.

Suggested-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/core.c   | 17 +++++++++++++++--
 drivers/nvme/host/fc.c     |  2 ++
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    | 28 ++++++++++++++++++++++------
 drivers/nvme/host/rdma.c   |  8 ++++++++
 drivers/nvme/target/loop.c |  5 +++++
 6 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e46e60..106a437 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -87,7 +87,7 @@ static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESET_PREPARE))
 		return -EBUSY;
 	if (!queue_work(nvme_wq, &ctrl->reset_work))
 		return -EBUSY;
@@ -243,7 +243,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
-	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_RESET_PREPARE:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
@@ -253,10 +253,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+
+	case NVME_CTRL_RESETTING:
+		switch (old_state) {
+		case NVME_CTRL_RESET_PREPARE:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_RECONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_RESET_PREPARE:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -267,6 +278,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_RESET_PREPARE:
 		case NVME_CTRL_RECONNECTING:
 			changed = true;
 			/* FALLTHRU */
@@ -2603,6 +2615,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
 		[NVME_CTRL_RESETTING]	= "resetting",
+		[NVME_CTRL_RESET_PREPARE]	= "reset-prepare",
 		[NVME_CTRL_RECONNECTING]= "reconnecting",
 		[NVME_CTRL_DELETING]	= "deleting",
 		[NVME_CTRL_DEAD]	= "dead",
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 794e66e..516c1ea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -547,6 +547,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
 		break;
 
 	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_RESET_PREPARE:
 		/*
 		 * Controller is already in the process of terminating the
 		 * association. No need to do anything further. The reconnect
@@ -790,6 +791,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		break;
 
 	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_RESET_PREPARE:
 		/*
 		 * Controller is already in the process of terminating the
 		 * association.  No need to do anything further. The reconnect
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ea1aa52..1f095d7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -120,6 +120,7 @@ enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
 	NVME_CTRL_RESETTING,
+	NVME_CTRL_RESET_PREPARE,
 	NVME_CTRL_RECONNECTING,
 	NVME_CTRL_DELETING,
 	NVME_CTRL_DEAD,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3..e477c35 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1141,8 +1141,13 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
 
 	/* If there is a reset ongoing, we shouldn't reset again. */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING)
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_RESET_PREPARE:
 		return false;
+	default:
+		break;
+	}
 
 	/* We shouldn't reset unless the controller is on fatal error state
 	 * _or_ if we lost the communication with it.
@@ -1220,7 +1225,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_HANDLED;
 	}
-
 	/*
  	 * Shutdown the controller immediately and schedule a reset if the
  	 * command was already aborted once before and still hasn't been
@@ -2180,9 +2184,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
+		switch (dev->ctrl.state) {
+		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_RESET_PREPARE:
 			nvme_start_freeze(&dev->ctrl);
+			break;
+		default:
+			break;
+		}
+
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
 	}
@@ -2292,7 +2303,7 @@ static void nvme_reset_work(struct work_struct *work)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 
-	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
+	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESET_PREPARE))
 		goto out;
 
 	/*
@@ -2302,6 +2313,11 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+		WARN_ON_ONCE(dev->ctrl.state != NVME_CTRL_DELETING);
+		goto out;
+	}
+
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out;
@@ -2498,7 +2514,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
-	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESET_PREPARE);
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	queue_work(nvme_wq, &dev->ctrl.reset_work);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37af565..8ae073e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1753,6 +1753,14 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
+	changed = nvme_change_ctrl_state(&ctrl->ctrl,
+			NVME_CTRL_RESET_PREPARE);
+	if (!changed) {
+		/* state change failure is ok if we're in DELETING state */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		return;
+	}
+
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto out_fail;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1e21b28..ae9973e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -481,6 +481,11 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_loop_shutdown_ctrl(ctrl);
 
+	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING);
+	if (!changed) {
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
+		return;
+	}
 	ret = nvme_loop_configure_admin_queue(ctrl);
 	if (ret)
 		goto out_disable;
-- 
2.7.4
