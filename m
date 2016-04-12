From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Apr 2016 11:13:11 -0600
Subject: [PATCHv2] NVMe: Skip async events for degraded controllers
Message-ID: <1460481191-19012-1-git-send-email-keith.busch@intel.com>

If the controller is degraded, the driver should stay out of the way so
the user can recover the drive. This patch skips driver initiated async
event requests when the drive is in this state.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

---
v1 -> v2:

   Added comment explaining the degraded controller condition and reasoning for
   skipping the event notification.

 drivers/nvme/host/pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 28d434d..dda19cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1890,8 +1890,16 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
-	queue_work(nvme_workq, &dev->async_work);
+	/*
+	 * A controller that can not execute IO typically requires user
+	 * intervention to correct. For such degraded controllers, the driver
+	 * should not submit commands the user did not request, so skip
+	 * registering for asynchronous event notification on this condition.
+	 */
+	if (dev->online_queues > 1) {
+		dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
+		queue_work(nvme_workq, &dev->async_work);
+	}
 
 	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
 
-- 
2.7.2
