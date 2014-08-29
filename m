From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Aug 2014 09:06:12 -0600
Subject: [PATCH] NVMe: Translate NVMe status to errno
Message-ID: <1409324772-24999-1-git-send-email-keith.busch@intel.com>

This returns a more appropriate error for the "capacity exceeded"
status. In case other NVMe statuses have a better errno, this patch adds
a convience function to translate an NVMe status code to an errno for
IO commands, defaulting to the current -EIO.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 959149b..abc289a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -445,6 +445,18 @@ static void nvme_end_io_acct(struct bio *bio, unsigned long start_time)
 	}
 }
 
+static int nvme_error_status(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_SUCCESS:
+		return 0;
+	case NVME_SC_CAP_EXCEEDED:
+		return -ENOSPC;
+	default:
+		return -EIO;
+	}
+}
+
 static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
@@ -464,7 +476,7 @@ static void bio_completion(struct nvme_queue *nvmeq, void *ctx,
 			wake_up(&nvmeq->sq_full);
 			return;
 		}
-		error = -EIO;
+		error = nvme_error_status(status);
 	}
 	if (iod->nents) {
 		dma_unmap_sg(nvmeq->q_dmadev, iod->sg, iod->nents,
-- 
1.7.10.4
