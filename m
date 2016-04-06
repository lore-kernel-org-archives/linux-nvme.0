From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed,  6 Apr 2016 17:30:35 -0300
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
Message-ID: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>

This patch adds a check on nvme_watchdog_timer() function to avoid the
call to reset_work() when an error recovery process is ongoing on
controller. The check is made by looking at pci_channel_offline()
result.

If we don't check for this on nvme_watchdog_timer(), error recovery
mechanism can't recover well, because reset_work() won't be able to
do its job (since we're in the middle of an error) and so the
controller is removed from the system before error recovery mechanism
can perform slot reset (which would allow the adapter to recover).

Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 24ccda3..3cc146d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1357,10 +1357,12 @@ static void nvme_watchdog_timer(unsigned long data)
 
 	/*
 	 * Skip controllers currently under reset.
+	 * Also, skip controllers going through PCI error recovery.
 	 */
 	if (!work_pending(&dev->reset_work) && !work_busy(&dev->reset_work) &&
 	    ((csts & NVME_CSTS_CFS) ||
-	     (dev->subsystem && (csts & NVME_CSTS_NSSRO)))) {
+	    (dev->subsystem && (csts & NVME_CSTS_NSSRO))) &&
+	    !pci_channel_offline(to_pci_dev(dev->dev))) {
 		if (queue_work(nvme_workq, &dev->reset_work)) {
 			dev_warn(dev->dev,
 				"Failed status: 0x%x, reset controller.\n",
-- 
2.1.0
