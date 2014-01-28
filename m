From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:53 +0100
Subject: [PATCH 07/14] NVMe: Make returning value consistent across all
 functions
In-Reply-To: <cover.1390897693.git.agordeev@redhat.com>
References: <cover.1390897693.git.agordeev@redhat.com>
Message-ID: <ee09a5257c25b1c2bf552a1c4fcd1a731a10ec84.1390897693.git.agordeev@redhat.com>

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/nvme-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f03f123..e004c09 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1315,7 +1315,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq)
 	nvme_init_queue(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	return result;
+	return 0;
 
  release_sq:
 	adapter_delete_sq(nvmeq);
@@ -1431,7 +1431,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_init_queue(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
-	return result;
+	return 0;
 }
 
 struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
@@ -2414,7 +2414,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	if (result && result != -EBUSY)
 		goto disable;
 
-	return result;
+	return 0;
 
  disable:
 	nvme_disable_queue(dev->queues[0]);
-- 
1.7.7.6
