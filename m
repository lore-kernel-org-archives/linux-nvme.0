From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 10 Mar 2016 16:07:04 +0100 (CET)
Subject: [PATCH] nvme: avoid cqe corruption when update at the same time
 as read
In-Reply-To: <20160310143650.GA8689@infradead.org>
References: <1963234885.1121305.1457109031908.JavaMail.zimbra@kalray.eu>
 <1380738962.1128342.1457162595145.JavaMail.zimbra@kalray.eu>
 <20160309170846.GA14926@infradead.org>
 <881149974.3314758.1457608128188.JavaMail.zimbra@kalray.eu>
 <20160310143650.GA8689@infradead.org>
Message-ID: <83595671.3507467.1457622424395.JavaMail.zimbra@kalray.eu>

----- Le 10 Mar 16, ? 15:36, Christoph Hellwig hch at infradead.org a ?crit :
> 
> Yeah, this doesn't work as-is.  I still think that non-obvious
> check should be split out into something.  Maybe just:
> 
> static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head, u16 phase)
> {
>	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
> }

I did the same in my version. Here's what I have now:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e9f18e1..6d4a616 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -704,6 +704,13 @@ static void nvme_complete_rq(struct request *req)
         blk_mq_end_request(req, error);
 }
 
+/* We read the CQE phase first to check if the rest of the entry is valid */
+static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head,
+        u16 phase)
+{
+        return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
+}
+
 static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
         u16 head, phase;
@@ -711,13 +718,10 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
         head = nvmeq->cq_head;
         phase = nvmeq->cq_phase;
 
-        for (;;) {
+        while (nvme_cqe_valid(nvmeq, head, phase)) {
                 struct nvme_completion cqe = nvmeq->cqes[head];
-                u16 status = le16_to_cpu(cqe.status);
                 struct request *req;
 
-                if ((status & 1) != phase)
-                        break;
                 if (++head == nvmeq->q_depth) {
                         head = 0;
                         phase = !phase;
@@ -748,7 +752,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
                 req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
                 if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
                         memcpy(req->special, &cqe, sizeof(cqe));
-                blk_mq_complete_request(req, status >> 1);
+                blk_mq_complete_request(req, le16_to_cpu(cqe.status) >> 1);
 
         }
 
@@ -789,18 +793,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
         struct nvme_queue *nvmeq = data;
-        struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
-        if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
-                return IRQ_NONE;
-        return IRQ_WAKE_THREAD;
+        if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
+                return IRQ_WAKE_THREAD;
+        return IRQ_NONE;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
         struct nvme_queue *nvmeq = hctx->driver_data;
 
-        if ((le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
-            nvmeq->cq_phase) {
+        if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
                 spin_lock_irq(&nvmeq->q_lock);
                 __nvme_process_cq(nvmeq, &tag);
                 spin_unlock_irq(&nvmeq->q_lock);
-- 
2.1.0
