From: sbradshaw@micron.com (Sam Bradshaw)
Date: Mon, 17 Nov 2014 14:54:14 -0800
Subject: [PATCH] NVMe: Reduce spinlock contention in IO timeout disposition
 path
Message-ID: <546A7C96.8070608@micron.com>

When workload queue depths exceed hardware queue depths, the kthread is 
constantly woken to resubmit queued IOs as cmdids free up.  The kthread 
routine also walks the entire list of cmdids to disposition any timeouts 
for each queue.  This sequence introduces latency variation by extending 
queue spinlock hold times and is unnecessarily coupled with kthread 
wakeups.  This patch causes the kthread routine to only disposition cmdid 
timouts if a minimum duration has passed since the last timeout check.

Since multiple devices share a single kthread, this patch has the added 
benefit of improved latency consistency by reducing the unnecessary 
spinlock contention introduced by "noisy neighbors" which trigger high 
rates of kthread wakes.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 00fa5d2..399d3ac 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1965,9 +1965,17 @@ static int nvme_submit_async_req(struct nvme_queue *nvmeq)
 static int nvme_kthread(void *data)
 {
 	struct nvme_dev *dev, *next;
+	unsigned long do_check, next_check = jiffies;
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+
+		do_check = 0;
+		if (time_after(jiffies, next_check)) {
+			do_check = 1;
+			next_check = jiffies + HZ;
+		}
+
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
@@ -1992,7 +2000,8 @@ static int nvme_kthread(void *data)
 				if (nvmeq->q_suspended)
 					goto unlock;
 				nvme_process_cq(nvmeq);
-				nvme_cancel_ios(nvmeq, true);
+				if (do_check)
+					nvme_cancel_ios(nvmeq, true);
 				nvme_resubmit_bios(nvmeq);
 				nvme_resubmit_iods(nvmeq);
 
