From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 9 Mar 2016 09:08:46 -0800
Subject: [PATCH] nvme: avoid cqe corruption when update at the same time
 as read
In-Reply-To: <1380738962.1128342.1457162595145.JavaMail.zimbra@kalray.eu>
References: <1963234885.1121305.1457109031908.JavaMail.zimbra@kalray.eu>
 <1380738962.1128342.1457162595145.JavaMail.zimbra@kalray.eu>
Message-ID: <20160309170846.GA14926@infradead.org>

On Sat, Mar 05, 2016@08:23:15AM +0100, Marta Rybczynska wrote:
> The cqe structure read normally happens from lower to upper addresses
> and the validity bit (status) is at the highest address. If the PCI
> updates the memory when the cqe is read by multiple non-atomic loads,
> the structure may be corrupted. Avoid this by reading the status
> first and then the whole structure.

Doing the phase check separately sounds sensible to me, but how about
doing something like the version below, which ensures we only read the
whole cqe after the check, and cleans things up a bit by using a common
helper:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1d1c6d1..f6ea5d3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -704,6 +704,11 @@ static void nvme_complete_rq(struct request *req)
 	blk_mq_end_request(req, error);
 }
 
+static inline bool nvme_cqe_valid(struct nvme_queue *nvmeq, u16 head)
+{
+	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) == head;
+}
+
 static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
 	u16 head, phase;
@@ -711,13 +716,10 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 	head = nvmeq->cq_head;
 	phase = nvmeq->cq_phase;
 
-	for (;;) {
+	while (nvme_cqe_valid(nvmeq, head)) {
 		struct nvme_completion cqe = nvmeq->cqes[head];
-		u16 status = le16_to_cpu(cqe.status);
 		struct request *req;
 
-		if ((status & 1) != phase)
-			break;
 		if (++head == nvmeq->q_depth) {
 			head = 0;
 			phase = !phase;
@@ -748,7 +750,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
 			memcpy(req->special, &cqe, sizeof(cqe));
-		blk_mq_complete_request(req, status >> 1);
+		blk_mq_complete_request(req, le16_to_cpu(cqe.status) >> 1);
 
 	}
 
@@ -789,18 +791,17 @@ static irqreturn_t nvme_irq(int irq, void *data)
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
-	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
-	if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
-		return IRQ_NONE;
-	return IRQ_WAKE_THREAD;
+
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head))
+		return IRQ_WAKE_THREAD;
+	return IRQ_NONE;
 }
 
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
-	if ((le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
-	    nvmeq->cq_phase) {
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head)) {
 		spin_lock_irq(&nvmeq->q_lock);
 		__nvme_process_cq(nvmeq, &tag);
 		spin_unlock_irq(&nvmeq->q_lock);
