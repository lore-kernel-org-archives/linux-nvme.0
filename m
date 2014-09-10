From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Sep 2014 15:48:47 -0600
Subject: [PATCH] NVMe: Fix nvmeq waitqueue entry initialization
Message-ID: <1410385727-27062-1-git-send-email-keith.busch@intel.com>

We need to update the nvme queue's wait_queue_t entry during each
initialization since the nvme_thread may be ended and restarted when
the device is reset. If a device reset occurs during a large amount
of buffered IO, it would take a lot longer to complete the outstanding
requests due to the 1 second polling instead of waking up as completions
occur.

Fixes: b9afca3efb18a9b8392cb544a3e29e8b1168400c

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..1b9cd27 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1311,7 +1311,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	init_waitqueue_head(&nvmeq->sq_full);
-	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
 	INIT_LIST_HEAD(&nvmeq->iod_bio);
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1351,6 +1350,8 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	struct nvme_dev *dev = nvmeq->dev;
 	unsigned extra = nvme_queue_extra(nvmeq->q_depth);
 
+	spin_lock_irq(&nvmeq->q_lock);
+	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
@@ -1360,6 +1361,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvme_cancel_ios(nvmeq, false);
 	nvmeq->q_suspended = 0;
 	dev->online_queues++;
+	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
@@ -1379,10 +1381,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	if (result < 0)
 		goto release_sq;
 
-	spin_lock_irq(&nvmeq->q_lock);
 	nvme_init_queue(nvmeq, qid);
-	spin_unlock_irq(&nvmeq->q_lock);
-
 	return result;
 
  release_sq:
@@ -1521,9 +1520,6 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result)
 		return result;
 
-	spin_lock_irq(&nvmeq->q_lock);
-	nvme_init_queue(nvmeq, 0);
-	spin_unlock_irq(&nvmeq->q_lock);
 	return result;
 }
 
@@ -2740,6 +2736,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 		result = nvme_thread ? PTR_ERR(nvme_thread) : -EINTR;
 		goto disable;
 	}
+	nvme_init_queue(raw_nvmeq(dev, 0), 0);
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-- 
1.7.10.4
