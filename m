From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 4 May 2016 03:03:13 -0700
Subject: RFC: what to do about abort?
Message-ID: <20160504100313.GA22726@infradead.org>

I've recently spent some time on the Abort implementation for
the Fabrics host and target drivers, and given how vaguele Abort
is defined in the spec, I fail to see how sending an abort actually
buys us anything.  The controller doesn't even have to respond, and
in fact many don't, so we simply end up escalation to a reset after
the abort command times out.  Similarly the amount of abort commands
is severly limited, and I've not seen a controller exceeding the
recommended 4 allowed abort commands, leading to sever pressure on
the error handling code for the typical case of a somehow stuck
controller that has multiple outstanding commands beyoned the allowed
timeout.

Based on that I came to the conclusion that we'd be much better off
to just use the 60 second timeout for I/O command as well, and simply
avoid ever sending the abort command.  RFC patch below:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2de248b..21b10ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -38,7 +38,7 @@ module_param(admin_timeout, byte, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
 EXPORT_SYMBOL_GPL(admin_timeout);
 
-unsigned char nvme_io_timeout = 30;
+unsigned char nvme_io_timeout = 60;
 module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
@@ -1100,7 +1100,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
-	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
 	memcpy(ctrl->serial, id->sn, sizeof(id->sn));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 114b928..4ea0914 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,7 +102,6 @@ struct nvme_ctrl {
 	u32 stripe_size;
 	u16 oncs;
 	u16 vid;
-	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
 	u32 vs;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb741d0..3ac42d3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -141,7 +141,6 @@ struct nvme_queue {
  */
 struct nvme_iod {
 	struct nvme_queue *nvmeq;
-	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
 	int length;		/* Of data, in bytes */
@@ -306,7 +305,6 @@ static int nvme_init_iod(struct request *rq, unsigned size,
 		iod->sg = iod->inline_sg;
 	}
 
-	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
 	iod->length = size;
@@ -633,12 +631,6 @@ static void nvme_complete_rq(struct request *req)
 			error = nvme_error_status(req->errors);
 	}
 
-	if (unlikely(iod->aborted)) {
-		dev_warn(dev->ctrl.device,
-			"completing aborted command with status: %04x\n",
-			req->errors);
-	}
-
 	blk_mq_end_request(req, error);
 }
 
@@ -830,93 +822,26 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
-static void abort_endio(struct request *req, int error)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = iod->nvmeq;
-	u16 status = req->errors;
-
-	dev_warn(nvmeq->dev->ctrl.device, "Abort status: 0x%x", status);
-	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
-	blk_mq_free_request(req);
-}
-
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = iod->nvmeq;
 	struct nvme_dev *dev = nvmeq->dev;
-	struct request *abort_req;
-	struct nvme_command cmd;
-
-	/*
-	 * Shutdown immediately if controller times out while starting. The
-	 * reset work will see the pci device disabled when it gets the forced
-	 * cancellation error. All outstanding requests are completed on
-	 * shutdown, so we return BLK_EH_HANDLED.
-	 */
-	if (dev->ctrl.state == NVME_CTRL_RESETTING) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
-		req->errors = NVME_SC_CANCELLED;
-		return BLK_EH_HANDLED;
-	}
-
-	/*
- 	 * Shutdown the controller immediately and schedule a reset if the
- 	 * command was already aborted once before and still hasn't been
- 	 * returned to the driver, or if this is the admin queue.
-	 */
-	if (!nvmeq->qid || iod->aborted) {
-		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, reset controller\n",
-			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
-		queue_work(nvme_workq, &dev->reset_work);
+	enum nvme_ctrl_state state = dev->ctrl.state;
 
-		/*
-		 * Mark the request as handled, since the inline shutdown
-		 * forces all outstanding requests to complete.
-		 */
-		req->errors = NVME_SC_CANCELLED;
-		return BLK_EH_HANDLED;
-	}
-
-	iod->aborted = 1;
-
-	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
-		atomic_inc(&dev->ctrl.abort_limit);
-		return BLK_EH_RESET_TIMER;
-	}
-
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abort.opcode = nvme_admin_abort_cmd;
-	cmd.abort.cid = req->tag;
-	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
-
-	dev_warn(nvmeq->dev->ctrl.device,
-		"I/O %d QID %d timeout, aborting\n",
+	dev_warn(dev->ctrl.device,
+		 "I/O %d QID %d timeout, reset controller\n",
 		 req->tag, nvmeq->qid);
-
-	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT);
-	if (IS_ERR(abort_req)) {
-		atomic_inc(&dev->ctrl.abort_limit);
-		return BLK_EH_RESET_TIMER;
-	}
-
-	abort_req->timeout = ADMIN_TIMEOUT;
-	abort_req->end_io_data = NULL;
-	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
+	nvme_dev_disable(dev, false);
+	if (state != NVME_CTRL_RESETTING)
+		queue_work(nvme_workq, &dev->reset_work);
 
 	/*
-	 * The aborted req will be completed on receiving the abort req.
-	 * We enable the timer again. If hit twice, it'll cause a device reset,
-	 * as the device then is in a faulty state.
+	 * Mark the request as handled, since the inline shutdown
+	 * forces all outstanding requests to complete.
 	 */
-	return BLK_EH_RESET_TIMER;
+	req->errors = NVME_SC_CANCELLED;
+	return BLK_EH_HANDLED;
 }
 
 static void nvme_cancel_io(struct request *req, void *data, bool reserved)
