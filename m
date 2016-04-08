From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Apr 2016 16:09:56 -0600
Subject: [PATCH] NVMe: Skip async events for degraded controllers
Message-ID: <1460153396-5070-1-git-send-email-keith.busch@intel.com>

If the controller is degraded, the driver should stay out of the way so
the user can recover the drive. This patch skips driver initiated async
event requests when the drive is in this state.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This is to fix communication with a specific controller, but I thought
this was generally applicable anyway. If anyone really wants to see async
events on degraded controllers, I can provide this as a quirk instead.

 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 28d434d..1e176c8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1890,8 +1890,10 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
-	queue_work(nvme_workq, &dev->async_work);
+	if (dev->online_queues > 1) {
+		dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
+		queue_work(nvme_workq, &dev->async_work);
+	}
 
 	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
 
-- 
2.7.2
