From: hch@lst.de (Christoph Hellwig)
Date: Sun,  2 Dec 2018 17:46:22 +0100
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when deleting
 queues
In-Reply-To: <20181202164628.1116-1-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
Message-ID: <20181202164628.1116-8-hch@lst.de>

This is the last place outside of nvme_irq that handles CQEs from
interrupt context, and thus is in the way of removing the cq_lock for
normal queues, and avoiding lockdep warnings on the poll queues, for
which we already take it without IRQ disabling.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9ceba9900ca3..2d5a468c35b1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -122,7 +122,6 @@ struct nvme_dev {
 	u32 cmbsz;
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
-	struct completion ioq_wait;
 
 	mempool_t *iod_mempool;
 
@@ -203,10 +202,12 @@ struct nvme_queue {
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
 #define NVMEQ_SQ_CMB		1
+#define NVMEQ_DELETE_ERROR	2
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
 	u32 *dbbuf_cq_ei;
+	struct completion delete_done;
 };
 
 /*
@@ -1535,6 +1536,8 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	int result;
 	s16 vector;
 
+	clear_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
+
 	/*
 	 * A queue's vector matches the queue identifier unless the controller
 	 * has only one vector available.
@@ -2208,15 +2211,15 @@ static void nvme_del_queue_end(struct request *req, blk_status_t error)
 	struct nvme_queue *nvmeq = req->end_io_data;
 
 	blk_mq_free_request(req);
-	complete(&nvmeq->dev->ioq_wait);
+	complete(&nvmeq->delete_done);
 }
 
 static void nvme_del_cq_end(struct request *req, blk_status_t error)
 {
 	struct nvme_queue *nvmeq = req->end_io_data;
 
-	if (!error)
-		nvme_poll_irqdisable(nvmeq, -1);
+	if (error)
+		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
 
 	nvme_del_queue_end(req, error);
 }
@@ -2238,6 +2241,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req->timeout = ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
+	init_completion(&nvmeq->delete_done);
 	blk_execute_rq_nowait(q, NULL, req, false,
 			opcode == nvme_admin_delete_cq ?
 				nvme_del_cq_end : nvme_del_queue_end);
@@ -2249,7 +2253,6 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
 
-	reinit_completion(&dev->ioq_wait);
  retry:
 	timeout = ADMIN_TIMEOUT;
 	while (nr_queues > 0) {
@@ -2258,11 +2261,20 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 		nr_queues--;
 		sent++;
 	}
-	while (sent--) {
-		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
+	while (sent) {
+		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
+
+		timeout = wait_for_completion_io_timeout(&nvmeq->delete_done,
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
@@ -2746,7 +2758,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
-	init_completion(&dev->ioq_wait);
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-- 
2.19.1
