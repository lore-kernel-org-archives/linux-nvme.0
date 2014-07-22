From: mundu2510@gmail.com (Mundu)
Date: Tue, 22 Jul 2014 22:55:39 +0530
Subject: [PATCH 1/1]  If device hotplug out,
 controller status become 0xFFFF_FFFF 1. Controller fatal status
 become true in nvme_kthread() 2. Ready bit will not be reset to 0 in
 nvme_wait_ready() for controller disable above two scenarios controller
 status data is not a valid data,
 since  device/controller is already removed (hotplug)
In-Reply-To: <1406049939-29310-1-git-send-email-mundu2510@gmail.com>
References: <1406049939-29310-1-git-send-email-mundu2510@gmail.com>
Message-ID: <1406049939-29310-2-git-send-email-mundu2510@gmail.com>

Signed-off-by: Mundu <mundu2510 at gmail.com>
---
 drivers/block/nvme-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..6c6998e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1396,10 +1396,14 @@ static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
 {
 	unsigned long timeout;
 	u32 bit = enabled ? NVME_CSTS_RDY : 0;
+	u32 csts;
 
 	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
 
-	while ((readl(&dev->bar->csts) & NVME_CSTS_RDY) != bit) {
+	while (((csts = readl(&dev->bar->csts)) & NVME_CSTS_RDY) != bit) {
+		/* If device is hot plugout, csts become 0xFFFFFFFF */
+		if (csts == -1)
+			return -ENODEV;
 		msleep(100);
 		if (fatal_signal_pending(current))
 			return -EINTR;
@@ -1905,14 +1909,19 @@ static int nvme_submit_async_req(struct nvme_queue *nvmeq)
 static int nvme_kthread(void *data)
 {
 	struct nvme_dev *dev, *next;
+	u32 csts;
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
-			if (readl(&dev->bar->csts) & NVME_CSTS_CFS &&
+			if ((csts = readl(&dev->bar->csts)) & NVME_CSTS_CFS &&
 							dev->initialized) {
+				/* If device is hot plugout,
+				   csts become 0xFFFFFFFF */
+				if (csts == -1)
+					continue;
 				if (work_busy(&dev->reset_work))
 					continue;
 				list_del_init(&dev->node);
-- 
1.9.1
