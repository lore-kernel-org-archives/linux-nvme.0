From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:29 -0600
Subject: [PATCHv2 5/8] nvme-pci: Attempt reset retry for IO failures
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180522220332.9244-6-keith.busch@intel.com>

If the reset failed due to a non-fatal error, this patch will attempt
to reset the controller again, with a maximum of 4 attempts.

Since the failed reset case has changed purpose, this patch provides a
more appropriate name and warning message for the reset failure.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5de8d79bad20..dfaf22ff6328 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -37,6 +37,8 @@
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
+#define MAX_RESET_FAILURES 4
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -101,6 +103,8 @@ struct nvme_dev {
 	struct completion ioq_wait;
 	bool queues_froze;
 
+	int reset_failures;
+
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
@@ -2305,9 +2309,23 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	kfree(dev);
 }
 
-static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
+static void nvme_reset_failure(struct nvme_dev *dev, int status)
 {
-	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
+	dev->reset_failures++;
+	dev_warn(dev->ctrl.device, "Reset failure status: %d, failures:%d\n",
+		status, dev->reset_failures);
+
+	/* IO and Interrupted Call may indicate a retryable error */
+	switch (status) {
+	case -EIO:
+	case -EINTR:
+		if (dev->reset_failures < MAX_RESET_FAILURES &&
+		    !nvme_reset_ctrl(&dev->ctrl))
+			return;
+		break;
+	default:
+		break;
+	}
 
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
@@ -2410,14 +2428,16 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller state %d\n", new_state);
+		result = -ENODEV;
 		goto out;
 	}
 
+	dev->reset_failures = 0;
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
  out:
-	nvme_remove_dead_ctrl(dev, result);
+	nvme_reset_failure(dev, result);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
-- 
2.14.3
