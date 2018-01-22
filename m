From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:56:28 -0700
Subject: [PATCH 3/5] nvme/pci: End stopped queue requests directly
In-Reply-To: <20180122215630.13697-1-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
Message-ID: <20180122215630.13697-3-keith.busch@intel.com>

For requests that have entered a queue that is not able to be brought
back online, this patch will end those requests directly rather than
rely on the IO path to handle this error.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 63b477bfef37..9e9e3a59bfb3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2272,6 +2272,19 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
+static void nvme_end_stopped_queue_request(struct request *req, void *data,
+				   bool reserved)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_queue *nvmeq = iod->nvmeq;
+
+	if (nvmeq->cq_vector != -1)
+		return;
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+			    "Ending I/O %d QID:%d", req->tag, nvmeq->qid);
+	blk_mq_end_request(req, BLK_STS_IOERR);
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev =
@@ -2344,6 +2357,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
+		nvme_set_iter(&dev->ctrl, dev->ctrl.tagset,
+			      nvme_end_stopped_queue_request);
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
-- 
2.14.3
