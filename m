From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 May 2018 13:58:08 -0600
Subject: [PATCH] nvme: remove cq check after submission
Message-ID: <b88f65b5-5fa6-45a7-48ff-77a114c31160@kernel.dk>

We always check the completion queue after submitting, but in my testing
this isn't a win even on DRAM/xpoint devices. In some cases it's
actually worse. Kill it.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..79bbfadcb7b9 100644
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
Jens Axboe
