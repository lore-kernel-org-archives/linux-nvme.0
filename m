From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 17 May 2013 08:57:00 -0400
Subject: [PATCH] Call nvme_process_cq from submit path
Message-ID: <20130517125700.GN6057@linux.intel.com>


There are a couple of good reasons to process the CQ from the submit path.

One is that if the SQ is full, processing the CQ may free up some slots
in the SQ.

Another is that, if the interrupt mitigation is configured correctly, we
may be able to avoid receiving an interrupt if we process the completion
before the timer fires.

Processing an empty CQ should be cheap; it's two loads from the nvmeq
data structure, a 64-bit load from the CQ and three compares.  I'd be
intrigued to see if anyone can measure a performance decrease from doing
this with any workload.

NB: this isn't the patch I'd be committing; I'll move nvme_process_cq
above nvme_make_request, but that move makes this look like a Big Deal
when at its heart, it's a one-line patch.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8efdfaa..f55d666 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -708,6 +708,8 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	return result;
 }
 
+static irqreturn_t nvme_process_cq(struct nvme_queue *nvmeq);
+
 static void nvme_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct nvme_ns *ns = q->queuedata;
@@ -722,7 +724,7 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 			add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
 		bio_list_add(&nvmeq->sq_cong, bio);
 	}
-
+	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	put_nvmeq(nvmeq);
 }
