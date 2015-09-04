From: ks0204.kim@samsung.com (=?utf-8?B?6rmA6rK97IKw?=)
Date: Fri, 04 Sep 2015 17:08:11 +0900
Subject: [PATCH] NVMe: Set affinity after allocating request queues
In-Reply-To: <1441289897-16839-1-git-send-email-keith.busch@intel.com>
References: <1441289897-16839-1-git-send-email-keith.busch@intel.com>
Message-ID: <000101d0e6e8$d7a74850$86f5d8f0$@samsung.com>

Hello, Keith Busch.
Thank you for the patch. I've confirmed  that setting hint is now working with the patch.

However, I think setting affinity hint is not sufficient to balance interrupts.
We've observed that affinity hint has not much impact on distributing interrupts across cores on  a distro such as debian 7.0
while setting affinity directly has worked on the distro.

Plus, hint information is also provided by device driver with intention that balances interrupt loads across cores.
And it also needs to collaborate with irqbalance option to work on.
So, I think setting affinity is a clear way to achieve balancing effect provided by driver rather than hint information.
I hope to listen your opinion regarding this.


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Thursday, September 03, 2015 11:18 PM
To: linux-nvme at lists.infradead.org
Cc: ???; Keith Busch
Subject: [PATCH] NVMe: Set affinity after allocating request queues

The asynchronous namespace scanning caused affinity hints to be set before its tagset initialized, so there was no cpu mask to set the hint. This patch moves the affinity hint setting to after namespaces are scanned.

Reported-by: ??? <ks0204.kim at samsung.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index b97fc3f..30758bd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2439,6 +2439,22 @@ static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
 	list_sort(NULL, &dev->namespaces, ns_cmp);  }
 
+static void nvme_set_irq_hints(struct nvme_dev *dev) {
+	struct nvme_queue *nvmeq;
+	int i;
+
+	for (i = 0; i < dev->online_queues; i++) {
+		nvmeq = dev->queues[i];
+
+		if (!nvmeq->tags || !(*nvmeq->tags))
+			continue;
+
+		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
+					blk_mq_tags_cpumask(*nvmeq->tags));
+	}
+}
+
 static void nvme_dev_scan(struct work_struct *work)  {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work); @@ -2450,6 +2466,7 @@ static void nvme_dev_scan(struct work_struct *work)
 		return;
 	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
 	kfree(ctrl);
+	nvme_set_irq_hints(dev);
 }
 
 /*
@@ -2953,22 +2970,6 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
-static void nvme_set_irq_hints(struct nvme_dev *dev) -{
-	struct nvme_queue *nvmeq;
-	int i;
-
-	for (i = 0; i < dev->online_queues; i++) {
-		nvmeq = dev->queues[i];
-
-		if (!nvmeq->tags || !(*nvmeq->tags))
-			continue;
-
-		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-					blk_mq_tags_cpumask(*nvmeq->tags));
-	}
-}
-
 static int nvme_dev_start(struct nvme_dev *dev)  {
 	int result;
@@ -3010,8 +3011,6 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	if (result)
 		goto free_tags;
 
-	nvme_set_irq_hints(dev);
-
 	dev->event_limit = 1;
 	return result;
 
@@ -3062,7 +3061,6 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
-		nvme_set_irq_hints(dev);
 	}
 	return 0;
 }
--
1.7.10.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
