From: y@dcgshare.lm.intel.com (y@dcgshare.lm.intel.com)
Date: Mon,  4 Mar 2013 17:24:23 -0700
Subject: [PATCH 4/4] NVMe: Retry failed bio requests
In-Reply-To: <y>
References: <y>
Message-ID: <1362443063-18994-5-git-send-email-y>

From: Keith Busch <keith.busch@intel.com>

If a bio request fails with a retryable nvme status and the bio is not
flagged failfast, the command will be requeued for later submission. The
bio is flagged with failfast before being requeued so will get one retry.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   20 ++++++++++++++++++--
 include/linux/nvme.h |    1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index ff524c0..e40d799 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -559,6 +559,16 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 					iod->meta_size, iod->dma_dir);
 	kfree(iod);
 }
+ 
+static void requeue_bio(struct nvme_dev *dev, struct bio *bio)
+{
+	struct nvme_queue *nvmeq = get_nvmeq(dev);
+	if (bio_list_empty(&nvmeq->sq_cong))
+		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
+	bio_list_add(&nvmeq->sq_cong, bio);
+	put_nvmeq(nvmeq);
+	wake_up_process(nvme_thread);
+}
 
 static void bio_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
@@ -571,8 +581,14 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
 			bio_data_dir(bio) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 	nvme_free_iod(dev, iod);
-	if (status)
-		bio_endio(bio, -EIO);
+	if (unlikely(status)) {
+		if (status & NVME_SC_DNR || bio->bi_rw & REQ_FAILFAST_MASK)
+			bio_endio(bio, -EIO);
+		else {
+			bio->bi_rw |= REQ_FAILFAST_DRIVER;
+			requeue_bio(dev, bio);
+		}
+	}
 	else
 		bio_endio(bio, 0);
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ee0a1f6..4afa62e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -429,6 +429,7 @@ enum {
 	NVME_SC_REFTAG_CHECK		= 0x284,
 	NVME_SC_COMPARE_FAILED		= 0x285,
 	NVME_SC_ACCESS_DENIED		= 0x286,
+	NVME_SC_DNR			= 0x4000,
 };
 
 struct nvme_completion {
-- 
1.7.0.4
