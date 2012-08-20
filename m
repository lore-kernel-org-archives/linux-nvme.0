From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 Aug 2012 14:57:49 -0600
Subject: [PATCH] NVMe: End queued bio requests when freeing queue
Message-ID: <1345496269-24974-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..c9722f5 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -911,6 +911,10 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_cancel_ios(nvmeq, false);
+	while (bio_list_peek(&nvmeq->sq_cong)) {
+		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
+		bio_endio(bio, -EIO);
+	}
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	irq_set_affinity_hint(vector, NULL);
-- 
1.7.0.4
