From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Dec 2017 13:46:34 -0700
Subject: [PATCH 1/3] nvme/pci: Start request after doorbell ring
In-Reply-To: <20171221204636.2924-1-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
Message-ID: <20171221204636.2924-2-keith.busch@intel.com>

This is a performance optimization that allows the hardware to work on
a command in parallel with the kernel's stats and timeout tracking.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3c9082..df5550ce0531 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -886,8 +886,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto out_cleanup_iod;
 	}
 
-	blk_mq_start_request(req);
-
 	spin_lock_irq(&nvmeq->q_lock);
 	if (unlikely(nvmeq->cq_vector < 0)) {
 		ret = BLK_STS_IOERR;
@@ -895,6 +893,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_cleanup_iod;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
+	blk_mq_start_request(req);
 	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
-- 
2.13.6
