From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:41 +0100
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when deleting
 queues
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-8-hch@lst.de>

This is the last place outside of nvme_irq that handles CQEs from
interrupt context, and thus is in the way of removing the cq_lock for
normal queues, and avoiding lockdep warnings on the poll queues, for
which we already take it without IRQ disabling.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 29072ad0a268..ef10279f4e58 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -202,6 +202,7 @@ struct nvme_queue {
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
+#define NVMEQ_DELETE_ERROR	2
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -2185,7 +2186,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 	struct nvme_queue *nvmeq = req->end_io_data;
 
 	if (!error)
-		nvme_poll_irqdisable(nvmeq, -1);
+		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
 	nvme_del_queue_end(req, error);
 }
@@ -2227,11 +2228,20 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 		nr_queues--;
 		sent++;
 	}
-	while (sent--) {
+	while (sent) {
+		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
+
 		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
 				timeout);
 		if (timeout == 0)
 			return false;
+
+		/* handle any remaining CQEs */
+		if (opcode == nvme_admin_delete_cq &&
+		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
+			nvme_poll_irqdisable(nvmeq, -1);
+
+		sent--;
 		if (nr_queues)
 			goto retry;
 	}
-- 
2.19.1
