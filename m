From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 09:02:17 -0600
Subject: [PATCH 3/3] nvme: drop IRQ disabling on submission queue lock
In-Reply-To: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
Message-ID: <1526569337-3489-4-git-send-email-axboe@kernel.dk>

Since we aren't sharing the lock for completions now, we don't
have to make it IRQ safe.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ae982edfa4f3..31b8e1808b3c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -887,9 +887,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	spin_lock_irq(&nvmeq->sq_lock);
+	spin_lock(&nvmeq->sq_lock);
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	spin_unlock_irq(&nvmeq->sq_lock);
+	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -1046,9 +1046,9 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
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
