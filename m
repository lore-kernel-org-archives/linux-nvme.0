From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:51 +0100
Subject: [PATCH 05/14] NVMe: Get rid of superfluous qid parameter to
 nvme_init_queue()
In-Reply-To: <cover.1390897693.git.agordeev@redhat.com>
References: <cover.1390897693.git.agordeev@redhat.com>
Message-ID: <7dc26be1ec7da1bcfb01a546d57dba15a05b0e27.1390897693.git.agordeev@redhat.com>

Parameter qid is not only superfluous, but also confusing -
it suggests nvme_init_queue() could reinit the queue with an
ID other than index into device queues[] array.

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/nvme-core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 652f0f6..661277d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1278,9 +1278,10 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				IRQF_SHARED, name, nvmeq);
 }
 
-static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+static void nvme_init_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_dev *dev = nvmeq->dev;
+	u16 qid = nvmeq->qid;
 	unsigned extra = nvme_queue_extra(nvmeq->q_depth);
 
 	nvmeq->sq_tail = 0;
@@ -1296,7 +1297,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 static int nvme_create_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-	int qid = nvmeq->qid;
 	int result;
 
 	result = adapter_alloc_cq(nvmeq);
@@ -1312,7 +1312,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq)
 		goto release_sq;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_init_queue(nvmeq, qid);
+	nvme_init_queue(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	return result;
@@ -1429,7 +1429,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_init_queue(nvmeq, 0);
+	nvme_init_queue(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return result;
 }
-- 
1.7.7.6
