From: sbradshaw@micron.com (Sam Bradshaw)
Date: Mon, 8 Dec 2014 11:21:45 -0800
Subject: [PATCH] NVMe: Fix abort handling
Message-ID: <5485FA49.8020707@micron.com>

This patch fixes some problems in the abort handling code; freeing the 
correct request (abort_req) and setting abort_limit & rq_aborted if 
submitted the abort request fails.  In addition, a device reset is 
scheduled pro-actively if the device fails to successful abort a command 
rather than waiting for the timeout handler to disposition the condition.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c154165..34021ed 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -284,6 +284,18 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 
 	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
 	++nvmeq->dev->abort_limit;
+
+	/* Reset controller if abort failed */
+	if (cqe->result & 0x1) {
+		if (work_busy(&nvmeq->dev->reset_work))
+			return;
+		spin_lock(&dev_list_lock);
+		list_del_init(&nvmeq->dev->node);
+		nvmeq->dev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &nvmeq->dev->reset_work);
+		spin_unlock(&dev_list_lock);
+		return;
+	}
 }
 
 static void async_completion(struct nvme_queue *nvmeq, void *ctx,
@@ -1054,7 +1066,9 @@ static void nvme_abort_req(struct request *req)
 		dev_warn(nvmeq->q_dmadev,
 				"Could not abort I/O %d QID %d",
 				req->tag, nvmeq->qid);
-		blk_mq_free_request(req);
+		blk_mq_free_request(abort_req);
+		++dev->abort_limit;
+		cmd_rq->aborted = 0;
 	}
 }
 
