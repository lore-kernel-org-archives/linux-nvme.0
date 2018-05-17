From: hch@lst.de (Christoph Hellwig)
Date: Thu, 17 May 2018 18:31:52 +0200
Subject: [PATCH 7/7] nvme-pci: drop IRQ disabling on submission queue lock
In-Reply-To: <20180517163152.23155-1-hch@lst.de>
References: <20180517163152.23155-1-hch@lst.de>
Message-ID: <20180517163152.23155-8-hch@lst.de>

From: Jens Axboe <axboe@kernel.dk>

Since we aren't sharing the lock for completions now, we don't
have to make it IRQ safe.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 49c783801fd4..96cf91256fc8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -895,9 +895,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	spin_lock_irq(&nvmeq->sq_lock);
+	spin_lock(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	spin_unlock_irq(&nvmeq->sq_lock);
+	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -1052,9 +1052,9 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
 
-	spin_lock_irq(&nvmeq->sq_lock);
+	spin_lock(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &c);
-	spin_unlock_irq(&nvmeq->sq_lock);
+	spin_unlock(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
-- 
2.17.0
