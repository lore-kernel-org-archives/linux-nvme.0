From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:53 -0600
Subject: [PATCHv3 2/9] nvme-pci: Fix queue freeze criteria on reset
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-3-keith.busch@intel.com>

The driver had been relying on the pci_dev to maintain the state of
the pci device to know when starting a freeze would be appropriate. The
blktests block/011 however shows us that users may alter the state of
pci_dev out from under drivers and break the criteria we had been using.

This patch uses the private nvme controller struct to track the
enabling/disabling state. Since we're relying on that now, the reset
will unconditionally disable the admin queue on reset. This was already
being done anyway during admin bring up, and there is no harm to do a
second time. Disable the controller just ensures the controller enable
fields are toggled appropriately, so this patch moves that outside the
'dead' controller condition.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9da28e10d942..bc2e377e029d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2206,39 +2206,38 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(pdev)) {
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE &&
+	    (dev->ctrl.state == NVME_CTRL_LIVE ||
+	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
-			nvme_start_freeze(&dev->ctrl);
+		nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+			pci_channel_offline(pdev) || !pci_is_enabled(pdev));
 	}
 
 	/*
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead) {
-		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
-	}
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
-	if (!dead && dev->ctrl.queue_count > 0) {
+	if (!dead) {
 		/*
 		 * If the controller is still alive tell it to stop using the
-		 * host memory buffer.  In theory the shutdown / reset should
+		 * host memory buffer. In theory the shutdown / reset should
 		 * make sure that it doesn't access the host memoery anymore,
 		 * but I'd rather be safe than sorry..
 		 */
 		if (dev->host_mem_descs)
 			nvme_set_host_mem(dev, 0);
 		nvme_disable_io_queues(dev);
-		nvme_disable_admin_queue(dev, shutdown);
 	}
+	if (dev->ctrl.queue_count > 0)
+		nvme_disable_admin_queue(dev, shutdown);
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
 		nvme_suspend_queue(&dev->queues[i]);
 
-- 
2.14.3
