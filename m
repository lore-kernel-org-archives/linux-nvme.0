From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Oct 2016 12:42:12 +0300
Subject: [PATCH rfc 4/6] nvme: don't consume cq in queue_rq
In-Reply-To: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
Message-ID: <1475660534-16681-5-git-send-email-sagi@grimberg.me>

Now that we have irq-poll we don't need to flow
control our queues from the submission path. It
doesn't make sense to completely drain the completion
queue for each submit (or budgeting it either).

Also, now we can remove the forward declaration of
nvme_process_cq.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f37fad10007f..ba448fb755be 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -71,7 +71,6 @@ struct nvme_dev;
 struct nvme_queue;
 
 static int nvme_reset(struct nvme_dev *dev);
-static int nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
@@ -612,7 +611,6 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
-	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_MQ_RQ_QUEUE_OK;
 out:
-- 
2.7.4
