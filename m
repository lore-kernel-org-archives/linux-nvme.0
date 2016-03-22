From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 Mar 2016 15:25:56 -0600
Subject: [PATCH] NVMe: Fix reset/remove race
Message-ID: <1458681956-27047-1-git-send-email-keith.busch@intel.com>

This fixes a scenario where device is present and being reset, but a
request to unbind the driver occurs.

A previous patch series addressing a device failure removal scenario
flushed reset_work after controller disable to unblock reset_work waiting
on a completion that wouldn't occur. This isn't safe as-is. The broken
scenario can potentially be induced with:

  modprobe nvme && modprobe -r nvme

To fix, the reset work is flushed immediately after setting the controller
removing flag, and any subsequent reset will not proceed with controller
initialization if the flag is set.

The controller status must be polled while active, so the watchdog timer
is also left active until the controller is disabled to cleanup requests
that may be stuck during namespace removal.

[Fixes: ff23a2a15a2117245b4599c1352343c8b8fb4c43]
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 24ccda3..70093f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -934,12 +934,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 
 	/*
-	 * Shutdown immediately if controller times out while starting. The
-	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_HANDLED.
+	 * Disable immediately if controller times out while starting or
+	 * stopping. If resetting, the work will see the pci device disabled
+	 * when it gets the forced cancellation error. All outstanding requests
+	 * are completed on shutdown, so we return BLK_EH_HANDLED.
 	 */
-	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
+	if (test_bit(NVME_CTRL_RESETTING, &dev->flags) ||
+	    test_bit(NVME_CTRL_REMOVING, &dev->flags)) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
@@ -1859,6 +1860,9 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
+	if (test_bit(NVME_CTRL_REMOVING, &dev->flags))
+		goto out;
+
 	set_bit(NVME_CTRL_RESETTING, &dev->flags);
 
 	result = nvme_pci_enable(dev);
@@ -2078,11 +2082,10 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	del_timer_sync(&dev->watchdog_timer);
-
 	set_bit(NVME_CTRL_REMOVING, &dev->flags);
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->async_work);
+	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
-- 
2.7.2
