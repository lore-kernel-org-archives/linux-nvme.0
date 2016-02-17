From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Feb 2016 19:03:13 +0100
Subject: [PATCH 2/3] nvme: don't poll the CQ from the kthread
In-Reply-To: <1455732194-30790-1-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
Message-ID: <1455732194-30790-3-git-send-email-hch@lst.de>

There is no reason to do unconditional polling of CQs per the NVMe
spec.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 21b0be4..10839f7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1156,9 +1156,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->qid = qid;
 	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
-
-	/* make sure queue descriptor is set before queue count, for kthread */
-	mb();
 	dev->queue_count++;
 
 	return nvmeq;
@@ -1345,7 +1342,6 @@ static int nvme_kthread(void *data)
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
-			int i;
 			u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 			/*
@@ -1363,14 +1359,6 @@ static int nvme_kthread(void *data)
 				}
 				continue;
 			}
-			for (i = 0; i < dev->queue_count; i++) {
-				struct nvme_queue *nvmeq = dev->queues[i];
-				if (!nvmeq)
-					continue;
-				spin_lock_irq(&nvmeq->q_lock);
-				nvme_process_cq(nvmeq);
-				spin_unlock_irq(&nvmeq->q_lock);
-			}
 		}
 		spin_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
-- 
2.1.4
