From: keith.busch@intel.com (Keith Busch)
Date: Mon,  4 Apr 2016 16:24:49 -0600
Subject: [PATCH] NVMe: Re-introduce polling for completions
Message-ID: <1459808689-7689-1-git-send-email-keith.busch@intel.com>

Multiple users have reported device initialization failure on some
platforms due the driver not receiving expected interrupts. This is not
the fault of any particular controller. This patch polls for completions
on the admin queue in the watchdog timer, and starts the timer immediately
after controller initialization completes, just before the first admin
command is issued.

Reported-by: Tim Muhlemmer <muhlemmer at gmail.com>
Reported-by: Jon Derrick <jonathan.derrick at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 29f31bc..9e03fe3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1354,6 +1354,7 @@ static void nvme_watchdog_timer(unsigned long data)
 {
 	struct nvme_dev *dev = (struct nvme_dev *)data;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
+	struct nvme_queue *admin_q = dev->queues[0];
 
 	/*
 	 * Skip controllers currently under reset.
@@ -1369,6 +1370,10 @@ static void nvme_watchdog_timer(unsigned long data)
 		return;
 	}
 
+	spin_lock_irq(&admin_q->q_lock);
+	nvme_process_cq(admin_q);
+	spin_unlock_irq(&admin_q->q_lock);
+
 	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
 }
 
@@ -1877,6 +1882,8 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
+
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
 		goto out;
@@ -1888,8 +1895,6 @@ static void nvme_reset_work(struct work_struct *work)
 	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
 	queue_work(nvme_workq, &dev->async_work);
 
-	mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + HZ));
-
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
-- 
2.7.2
