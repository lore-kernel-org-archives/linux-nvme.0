From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:58 -0600
Subject: [PATCHv3 7/9] nvme-pci: Attempt reset retry for IO failures
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-8-keith.busch@intel.com>

If the reset failed due to a non-fatal error, this patch will attempt
to reset the controller again, with a maximum of 4 attempts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 40863ed759de..7c8076411dbc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -38,6 +38,8 @@
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
+#define MAX_RESET_FAILURES 4
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -2324,7 +2326,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 {
-	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
+	dev_warn(dev->ctrl.device, "Removing after reset failure status:%d\n", status);
 
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
@@ -2337,8 +2339,9 @@ static void nvme_reset_work(struct work_struct *work)
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
-	int result = -ENODEV;
-	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
+	int result = -ENODEV, reset_failures = 0;
+	enum nvme_ctrl_state new_state;
+
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
 		goto out;
@@ -2363,6 +2366,8 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+ retry:
+	new_state = NVME_CTRL_LIVE;
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out;
@@ -2427,6 +2432,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller state %d\n", new_state);
+		result = -ENODEV;
 		goto out;
 	}
 
@@ -2434,6 +2440,22 @@ static void nvme_reset_work(struct work_struct *work)
 	return;
 
  out:
+	reset_failures++;
+
+	/* IO and Interrupted Call may indicate a retryable error */
+	switch (result) {
+	case -EIO:
+	case -EINTR:
+		if (reset_failures < MAX_RESET_FAILURES &&
+		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
+			dev_warn(dev->ctrl.device,
+				 "Reset failure status:%d, failures:%d\n",
+				 result, reset_failures);
+			nvme_dev_disable(dev, false);
+			goto retry;
+		}
+		break;
+	}
 	nvme_remove_dead_ctrl(dev, result);
 }
 
-- 
2.14.3
