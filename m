From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 15:28:35 +0200
Subject: [PATCH 1/4] nvme: factor out pci abort handling into core
In-Reply-To: <20180719132838.15556-1-jthumshirn@suse.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
Message-ID: <20180719132838.15556-2-jthumshirn@suse.de>

Currently PCI is the only transport which does a more fine grained
error handling than just resetting the controller.

Factor out the command abort logic into nvme-core so other transports
can benefit of it as well.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 47 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 61 ++++++++++--------------------------------------
 3 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e77e6418a21c..82896be14191 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -702,6 +702,53 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+
+static void abort_endio(struct request *req, blk_status_t error)
+{
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
+	dev_warn(ctrl->device,
+		 "Abort status: 0x%x", nvme_req(req)->status);
+	atomic_inc(&ctrl->abort_limit);
+	blk_mq_free_request(req);
+}
+
+int nvme_abort_cmd(struct nvme_ctrl *ctrl,
+					struct request *rq, __le16 sqid)
+{
+	struct request *abort_req;
+	struct nvme_command cmd;
+
+	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+		return -EAGAIN;
+
+	if (atomic_dec_return(&ctrl->abort_limit) < 0) {
+		atomic_inc(&ctrl->abort_limit);
+		return -EBUSY;
+	}
+
+	nvme_req(rq)->flags |= NVME_REQ_CANCELLED;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abort.opcode = nvme_admin_abort_cmd;
+	cmd.abort.cid = rq->tag;
+	cmd.abort.sqid = sqid;
+
+	abort_req = nvme_alloc_request(ctrl->admin_q, &cmd,
+				       BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	if (IS_ERR(abort_req)) {
+		atomic_inc(&ctrl->abort_limit);
+		return PTR_ERR(abort_req);
+	}
+
+	abort_req->timeout = ADMIN_TIMEOUT;
+	abort_req->end_io_data = NULL;
+	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_abort_cmd);
+
 static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 		unsigned len, u32 seed, bool write)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4ad0c8ad2a27..39d6e4bc0402 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -445,6 +445,7 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		u8 log_page, void *log, size_t size, u64 offset);
+int nvme_abort_cmd(struct nvme_ctrl *ctrl, struct request  *rq, __le16 sqid);
 
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6678e9134348..321b8d55b693 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -188,7 +188,6 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_queue *nvmeq;
 	bool use_sgl;
-	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
@@ -495,7 +494,6 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 		iod->sg = iod->inline_sg;
 	}
 
-	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
 	iod->length = size;
@@ -1133,17 +1131,6 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
-static void abort_endio(struct request *req, blk_status_t error)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = iod->nvmeq;
-
-	dev_warn(nvmeq->dev->ctrl.device,
-		 "Abort status: 0x%x", nvme_req(req)->status);
-	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
-	blk_mq_free_request(req);
-}
-
 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 {
 
@@ -1193,9 +1180,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = iod->nvmeq;
 	struct nvme_dev *dev = nvmeq->dev;
-	struct request *abort_req;
-	struct nvme_command cmd;
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
+	int ret;
 
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
@@ -1243,54 +1229,31 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		break;
 	}
 
+	/*
+	 * The aborted req will be completed on receiving the abort req.
+	 * We enable the timer again. If hit twice, it'll cause a device reset,
+	 * as the device then is in a faulty state.
+	 */
+	ret = nvme_abort_cmd(&dev->ctrl, req, nvmeq->qid);
+	if (!ret)
+		return BLK_EH_RESET_TIMER;
+
 	/*
  	 * Shutdown the controller immediately and schedule a reset if the
  	 * command was already aborted once before and still hasn't been
  	 * returned to the driver, or if this is the admin queue.
 	 */
-	if (!nvmeq->qid || iod->aborted) {
+	if (ret || !nvmeq->qid || nvme_req(req)->flags & NVME_REQ_CANCELLED) {
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	}
 
-	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
-		atomic_inc(&dev->ctrl.abort_limit);
-		return BLK_EH_RESET_TIMER;
-	}
-	iod->aborted = 1;
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abort.opcode = nvme_admin_abort_cmd;
-	cmd.abort.cid = req->tag;
-	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
-
-	dev_warn(nvmeq->dev->ctrl.device,
-		"I/O %d QID %d timeout, aborting\n",
-		 req->tag, nvmeq->qid);
-
-	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
-	if (IS_ERR(abort_req)) {
-		atomic_inc(&dev->ctrl.abort_limit);
-		return BLK_EH_RESET_TIMER;
-	}
-
-	abort_req->timeout = ADMIN_TIMEOUT;
-	abort_req->end_io_data = NULL;
-	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
-
-	/*
-	 * The aborted req will be completed on receiving the abort req.
-	 * We enable the timer again. If hit twice, it'll cause a device reset,
-	 * as the device then is in a faulty state.
-	 */
-	return BLK_EH_RESET_TIMER;
+	return BLK_EH_DONE;
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
-- 
2.16.4
