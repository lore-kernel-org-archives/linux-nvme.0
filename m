From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:42 -0700
Subject: [PATCHv2-4.5 05/10] NVMe: Requeue requests on suspended queues
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455221147-24228-6-git-send-email-keith.busch@intel.com>

It's possible a request may get to the driver after the nvme queue was
disabled. This has the request requeue if that happens.

Note the request is still "started" by the driver, but requeuing will
clear the start state for timeout handling.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..e5c2bea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -678,6 +678,11 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
 	spin_lock_irq(&nvmeq->q_lock);
+	if (unlikely(nvmeq->cq_vector < 0)) {
+		ret = BLK_MQ_RQ_QUEUE_BUSY;
+		spin_unlock_irq(&nvmeq->q_lock);
+		goto out;
+	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
 	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
-- 
2.6.2.307.g37023ba
