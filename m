From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Oct 2016 12:42:11 +0300
Subject: [PATCH rfc 3/6] nvme-pci: Use irq-poll for completion processing
In-Reply-To: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
Message-ID: <1475660534-16681-4-git-send-email-sagi@grimberg.me>

irq-poll interface allows us to implement correct
cq polling in terms of completion context processing
(helps drivers to _not_ abuse irq context) and maintain
fairness between multiple completion queues that share
the same MSI/MSIX assignments. It is done by mainataining
per-cpu completion processing contexts queues and dispatching
the completion processing routines a budget that they
need to obay.

Also, select IRQ_POLL in Kconfig as we rely on it now.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/Kconfig |  1 +
 drivers/nvme/host/pci.c   | 28 +++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index db39d53cdfb9..1523fdaff537 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -5,6 +5,7 @@ config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
 	select NVME_CORE
+	select IRQ_POLL
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 85bfd76fbee9..f37fad10007f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -42,6 +42,7 @@
 #include <linux/types.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/unaligned.h>
+#include <linux/irq_poll.h>
 
 #include "nvme.h"
 
@@ -49,6 +50,7 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
+#define NVME_POLL_BUDGET_IRQ	256
 		
 /*
  * We handle AEN commands ourselves and don't even let the
@@ -130,6 +132,7 @@ struct nvme_queue {
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
+	struct irq_poll	iop;
 };
 
 /*
@@ -733,13 +736,30 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	return __nvme_process_cq(nvmeq, INT_MAX, NULL);
 }
 
+static int nvme_irqpoll_handler(struct irq_poll *iop, int budget)
+{
+	struct nvme_queue *nvmeq = container_of(iop, struct nvme_queue, iop);
+	int completed;
+
+	spin_lock_irq(&nvmeq->q_lock);
+	completed = __nvme_process_cq(nvmeq, budget, NULL);
+	if (completed < budget) {
+		irq_poll_complete(&nvmeq->iop);
+		enable_irq(nvmeq->dev->entry[nvmeq->cq_vector].vector);
+	}
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	return completed;
+}
+
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
 
-	spin_lock(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	spin_unlock(&nvmeq->q_lock);
+	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
+		disable_irq_nosync(irq);
+		irq_poll_sched(&nvmeq->iop);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -937,6 +957,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
+	irq_poll_disable(&nvmeq->iop);
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (nvmeq->sq_cmds)
@@ -1066,6 +1087,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
 			dev->ctrl.instance, qid);
 	spin_lock_init(&nvmeq->q_lock);
+	irq_poll_init(&nvmeq->iop, NVME_POLL_BUDGET_IRQ, nvme_irqpoll_handler);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-- 
2.7.4
