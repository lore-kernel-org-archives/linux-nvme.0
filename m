From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 13 Nov 2018 08:42:23 -0700
Subject: [PATCH 01/11] nvme: don't disable local ints for polled queue
In-Reply-To: <20181113154233.15256-1-axboe@kernel.dk>
References: <20181113154233.15256-1-axboe@kernel.dk>
Message-ID: <20181113154233.15256-2-axboe@kernel.dk>

A polled queued doesn't trigger interrupts, so it's always safe
to grab the queue lock without disabling interrupts.

Cc: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6aa86dfcb32c..bb22ae567208 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1067,9 +1067,18 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock_irq(&nvmeq->cq_lock);
+	/*
+	 * Polled queue doesn't have an IRQ, no need to disable ints
+	 */
+	if (!nvmeq->polled)
+		local_irq_disable();
+
+	spin_lock(&nvmeq->cq_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irq(&nvmeq->cq_lock);
+	spin_unlock(&nvmeq->cq_lock);
+
+	if (!nvmeq->polled)
+		local_irq_enable();
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
-- 
2.17.1
