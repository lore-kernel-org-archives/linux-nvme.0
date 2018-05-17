From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 18:31:48 +0200
Subject: [PATCH 3/7] nvme-pci: remove cq check after submission
In-Reply-To: <20180517163152.23155-1-hch@lst.de>
References: <20180517163152.23155-1-hch@lst.de>
Message-ID: <20180517163152.23155-4-hch@lst.de>

From: Jens Axboe <axboe@kernel.dk>

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
index 4b8c3420ace6..16eacae3b69d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -69,7 +69,6 @@ MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
@@ -896,7 +895,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_cleanup_iod;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
-- 
2.17.0
