From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 08:52:35 -0600
Subject: [PATCH 7/7] nvme-pci: drop IRQ disabling on submission queue lock
In-Reply-To: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526655155-4006-8-git-send-email-axboe@kernel.dk>

Since we aren't sharing the lock for completions now, we don't
have to make it IRQ safe.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1d64761e66f8..06d1a5cd619e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -894,9 +894,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	spin_lock_irq(&nvmeq->sq_lock);
+	spin_lock(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	spin_unlock_irq(&nvmeq->sq_lock);
+	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -1051,9 +1051,9 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
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
2.7.4
