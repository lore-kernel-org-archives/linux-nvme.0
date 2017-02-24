From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 24 Feb 2017 16:03:26 -0700
Subject: NVMe IO error due to abort..
In-Reply-To: <38e75ee9-e20a-3a64-c570-c780cb593958@kernel.dk>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
 <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
 <CA+55aFzb8uLKbYaAdGHkJzRfSSqzr3irh0EOQ5NTO4Noeb8htw@mail.gmail.com>
 <18390BD4-644C-40DD-A6FF-E8327962D5F2@kernel.dk>
 <7cc18f03-935e-c053-8752-1c42b711f441@kernel.dk>
 <CA+55aFw8=Xh=GS0KJzYKcV612EtWOvCMkfZe7H3vGT8W7AYmwQ@mail.gmail.com>
 <38e75ee9-e20a-3a64-c570-c780cb593958@kernel.dk>
Message-ID: <b8efa7ec-be2b-cb26-9fff-e3f1c5412719@kernel.dk>

Hi,

Since I might not be too available later in the day, here's a debug
patch that might help us figure out where things are going wrong.
It's against master+for-linus. It has two parts:

- Debug check to see if we are issuing a request on the wrong hw
  queue for nvme.

- Timeout patch from Keith, that shows if we missed a completion
  or not.


diff --git a/block/blk-core.c b/block/blk-core.c
index b9e857f4afe8..64ace6095f40 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -147,15 +147,18 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 
 void blk_dump_rq_flags(struct request *rq, char *msg)
 {
-	printk(KERN_INFO "%s: dev %s: flags=%llx\n", msg,
+	printk(KERN_INFO "%s: dev %s: flags=%llx/%llx\n", msg,
 		rq->rq_disk ? rq->rq_disk->disk_name : "?",
-		(unsigned long long) rq->cmd_flags);
+		(unsigned long long) rq->cmd_flags,
+		(unsigned long long) rq->rq_flags);
 
 	printk(KERN_INFO "  sector %llu, nr/cnr %u/%u\n",
 	       (unsigned long long)blk_rq_pos(rq),
 	       blk_rq_sectors(rq), blk_rq_cur_sectors(rq));
 	printk(KERN_INFO "  bio %p, biotail %p, len %u\n",
 	       rq->bio, rq->biotail, blk_rq_bytes(rq));
+	printk(KERN_INFO "  tag=%d, internal_tag=%d\n",
+		rq->tag, rq->internal_tag);
 }
 EXPORT_SYMBOL(blk_dump_rq_flags);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 57a1af52b06e..dd38a814c721 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -46,6 +46,7 @@
 #include <linux/sed-opal.h>
 
 #include "nvme.h"
+#include "../../block/blk-mq.h"
 
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
@@ -582,6 +583,9 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_command cmnd;
 	int ret = BLK_MQ_RQ_QUEUE_OK;
 
+	if (WARN_ON_ONCE(hctx != blk_mq_map_queue(req->q, req->mq_ctx->cpu)))
+		blk_dump_rq_flags(req, "nvme hctx mismatch");
+
 	/*
 	 * If formated with metadata, require the block layer provide a buffer
 	 * unless this namespace is formated such that the metadata can be
@@ -745,10 +749,8 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
 	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		spin_lock_irq(&nvmeq->q_lock);
 		__nvme_process_cq(nvmeq, &tag);
@@ -761,6 +763,13 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return 0;
 }
 
+static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	return __nvme_poll(nvmeq, tag);
+}
+
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl, int aer_idx)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -859,6 +868,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 
 	/*
+	 * Did we miss an interrupt?
+	 */
+	if (__nvme_poll(nvmeq, req->tag)) {
+		dev_warn(dev->ctrl.device,
+			 "I/O %d QID %d timeout, completion polled\n",
+			 req->tag, nvmeq->qid);
+		return BLK_EH_HANDLED;
+	}
+
+	/*
 	 * Shutdown immediately if controller times out while starting. The
 	 * reset work will see the pci device disabled when it gets the forced
 	 * cancellation error. All outstanding requests are completed on

-- 
Jens Axboe
