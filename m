From: bernat.ada@gmail.com (Andreea-Cristina Bernat)
Date: Mon, 18 Aug 2014 17:41:01 +0300
Subject: [PATCH] nvme: Replace rcu_assign_pointer() with RCU_INIT_POINTER()
Message-ID: <20140818144101.GA13840@ada>

The use of "rcu_assign_pointer()" is NULLing out the pointer.
According to RCU_INIT_POINTER()'s block comment:
"1.   This use of RCU_INIT_POINTER() is NULLing out the pointer"
it is better to use it instead of rcu_assign_pointer() because it has a
smaller overhead.

The following Coccinelle semantic patch was used:
@@
@@

- rcu_assign_pointer
+ RCU_INIT_POINTER
  (..., NULL)

Signed-off-by: Andreea-Cristina Bernat <bernat.ada at gmail.com>
---
 drivers/block/nvme-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..cb25bdd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1209,7 +1209,7 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 
 	for (i = dev->queue_count - 1; i >= lowest; i--) {
 		struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
-		rcu_assign_pointer(dev->queues[i], NULL);
+		RCU_INIT_POINTER(dev->queues[i], NULL);
 		call_rcu(&nvmeq->r_head, nvme_free_queue);
 		dev->queue_count--;
 	}
-- 
1.9.1
