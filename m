From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Apr 2014 17:23:25 -0600 (MDT)
Subject: [PATCH] NVMe: Decrement online queue count on suspend
Message-ID: <alpine.LRH.2.03.1404041720080.4731@AMR>

Fixes cpu-to-queue assignment on suspend/resume or CSTS.CFS handling
when more cpus than queues exist.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
I've a branch where this has been there since the beginning... lost it
from merging by hand.

  drivers/block/nvme-core.c |    1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 625259d..ce5a4f1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1158,6 +1158,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
  		return 1;
  	}
  	nvmeq->q_suspended = 1;
+	nvmeq->dev->online_queues--;
  	spin_unlock_irq(&nvmeq->q_lock);

  	irq_set_affinity_hint(vector, NULL);
-- 
1.7.10.4
