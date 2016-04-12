From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 12 Apr 2016 20:32:09 -0300
Subject: [PATCH v2] nvme: Avoid reset work on watchdog timer function during
 error recovery
Message-ID: <1460503929-22613-1-git-send-email-gpiccoli@linux.vnet.ibm.com>

This patch adds a check on nvme_watchdog_timer() function to avoid the
call to reset_work() when an error recovery process is ongoing on
controller. The check is made by looking at pci_channel_offline()
result.

If we don't check for this on nvme_watchdog_timer(), error recovery
mechanism can't recover well, because reset_work() won't be able to
do its job (since we're in the middle of an error) and so the
controller is removed from the system before error recovery mechanism
can perform slot reset (which would allow the adapter to recover).

In this patch we also have splitted the huge condition expression in
nvme_watchdog_timer() by introducing an auxiliary function to help
make the code more readable.

Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

v2:
  * Refactored the if condition on nvme_watchdog_timer() into a
new auxiliary function to improve readability.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 24ccda3..897cfcb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1350,22 +1350,42 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	return result;
 }
 
+static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
+{
+
+	/* If true, indicates loss of adapter communication, possibly by a
+	 * NVMe Subsystem reset. */
+	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
+
+	/* If there is a reset ongoing, we shouldn't reset again. */
+	if (work_busy(&dev->reset_work))
+		return false;
+
+	/* We shouldn't reset unless the controller is on fatal error state
+	 * _or_ if we lost the communication with it. */
+	if (!(csts & NVME_CSTS_CFS) &&
+	    !(dev->subsystem && (csts & NVME_CSTS_NSSRO)))
+		return false;
+
+	/* If PCI error recovery process is happening, we cannot reset or
+	 * the recovery mechanism will surely fail. */
+	if (pci_channel_offline(to_pci_dev(dev->dev)))
+		return false;
+
+	return true;
+}
+
 static void nvme_watchdog_timer(unsigned long data)
 {
 	struct nvme_dev *dev = (struct nvme_dev *)data;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-	/*
-	 * Skip controllers currently under reset.
-	 */
-	if (!work_pending(&dev->reset_work) && !work_busy(&dev->reset_work) &&
-	    ((csts & NVME_CSTS_CFS) ||
-	     (dev->subsystem && (csts & NVME_CSTS_NSSRO)))) {
-		if (queue_work(nvme_workq, &dev->reset_work)) {
+	/* Skip controllers under certain specific conditions. */
+	if (nvme_should_reset(dev, csts)) {
+		if (queue_work(nvme_workq, &dev->reset_work))
 			dev_warn(dev->dev,
 				"Failed status: 0x%x, reset controller.\n",
 				csts);
-		}
 		return;
 	}
 
-- 
2.1.0
