From: kaoudis@colorado.edu (kaoudis@colorado.edu)
Date: Wed, 14 Jan 2015 21:01:58 -0700
Subject: [PATCH for 3.20] NVMe: within nvme_free_queues(),
 delete RCU sychro/deferred free
Message-ID: <1421294518-13131-1-git-send-email-kaoudis@colorado.edu>

From: kaoudis <kaoudis@colorado.edu>

Converting from to blk-queue got rid of the driver's RCU
locking-on-queue, so removing unnecessary RCU locking-on-queue
artefacts.

Reviewed-by: Keith Busch <keith.busch at intel.com>

Signed-off-by: Kelly Nicole Kaoudis <kaoudis at colorado.edu>
---
 drivers/block/nvme-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b1d5d87..4eaf28e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1108,21 +1108,14 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)

 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
-	LLIST_HEAD(q_list);
-	struct nvme_queue *nvmeq, *next;
-	struct llist_node *entry;
 	int i;

 	for (i = dev->queue_count - 1; i >= lowest; i--) {
 		struct nvme_queue *nvmeq = dev->queues[i];
-		llist_add(&nvmeq->node, &q_list);
 		dev->queue_count--;
 		dev->queues[i] = NULL;
-	}
-	synchronize_rcu();
-	entry = llist_del_all(&q_list);
-	llist_for_each_entry_safe(nvmeq, next, entry, node)
 		nvme_free_queue(nvmeq);
+	}
 }

 /**
--
2.2.1
