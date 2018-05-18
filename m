From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 08:52:31 -0600
Subject: [PATCH 3/7] nvme-pci: remove cq check after submission
In-Reply-To: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526655155-4006-4-git-send-email-axboe@kernel.dk>

We always check the completion queue after submitting, but in my testing
this isn't a win even on DRAM/xpoint devices. In some cases it's
actually worse. Kill it.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9e2510249fa2..9b32a67982e8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -68,7 +68,6 @@ MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
@@ -895,7 +894,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_cleanup_iod;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
-- 
2.7.4
