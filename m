From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Nov 2015 11:35:28 -0700
Subject: [PATCHv2 2/2] NVMe: Shutdown fixes
In-Reply-To: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
References: <1448390128-25758-1-git-send-email-keith.busch@intel.com>
Message-ID: <1448390128-25758-2-git-send-email-keith.busch@intel.com>

The controller must be disabled prior to completing a presumed lost
command. This patch makes the shutdown safe to simultaneous invocations,
and directly calls it from the timeout handler if timeout occurs during
initialization.

blk-mq marks requests as completed in its timeout handler, though the
driver still owns the request. To propagate the appropriate status
to the caller, the driver must directly set req->errors. This also
happens to fix a race if the controller being reset actually completes
the request that timed out.

A side effect of this patch is a controller that times out IO queue
creation will be failed. The driver silently proceeded before, so this
sounds like an improvement. There hasn't been any reports of such
a condition actually occurring, though.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

  Get rid of the struct work for shutdown. Make shutdown robust to
  multiple invocations instead.

 drivers/nvme/host/pci.c | 56 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff253c8..cf9722f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,6 +86,7 @@ struct nvme_queue;
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
+static void nvme_dev_shutdown(struct nvme_dev *dev);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -117,6 +118,7 @@ struct nvme_dev {
 	struct work_struct reset_work;
 	struct work_struct scan_work;
 	struct work_struct remove_work;
+	wait_queue_head_t shutdown_wait;
 	bool subsystem;
 	u32 page_size;
 	void __iomem *cmb;
@@ -125,7 +127,7 @@ struct nvme_dev {
 	u32 cmbsz;
 	unsigned long flags;
 #define NVME_CTRL_RESETTING	0
-
+#define NVME_CTRL_SHUTDOWN	1
 	struct nvme_ctrl ctrl;
 };
 
@@ -723,6 +725,19 @@ static void nvme_complete_rq(struct request *req)
 	blk_mq_end_request(req, error);
 }
 
+static inline void nvme_end_req(struct request *req, int error)
+{
+	/*
+	 * The request may already be marked "complete" by blk-mq if
+	 * completion occurs during a timeout. We set req->errors
+	 * before telling blk-mq in case this is the target request
+	 * of a timeout handler. This is safe since this driver never
+	 * completes the same command twice.
+	 */
+	req->errors = error;
+	blk_mq_complete_request(req, req->errors);
+}
+
 static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 {
 	u16 head, phase;
@@ -770,8 +785,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 			u32 result = le32_to_cpu(cqe.result);
 			req->special = (void *)(uintptr_t)result;
 		}
-		blk_mq_complete_request(req, status >> 1);
-
+		nvme_end_req(req, status >> 1);
 	}
 
 	/* If the controller ignores the cq head doorbell and continuously
@@ -938,13 +952,16 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 
 	/*
-	 * Just return an error to reset_work if we're already called from
-	 * probe context.  We don't worry about request / tag reuse as
-	 * reset_work will immeditalely unwind and remove the controller
-	 * once we fail a command.
+	 * Shutdown immediately if controller times out while starting. The
+	 * reset work will see the pci device disabled when it gets the forced
+	 * cancellation error. All outstanding requests are completed on
+	 * shutdown, so we return BLK_EH_HANDLED.
 	 */
 	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
-		req->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
+		dev_warn(dev->dev,
+				"I/O %d QID %d timeout, disable controller\n",
+				 req->tag, nvmeq->qid);
+		nvme_dev_shutdown(dev);
 		return BLK_EH_HANDLED;
 	}
 
@@ -1015,7 +1032,8 @@ static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved
 
 	if (blk_queue_dying(req->q))
 		status |= NVME_SC_DNR;
-	blk_mq_complete_request(req, status);
+
+	nvme_end_req(req, status);
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
@@ -1510,9 +1528,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 
 	status = nvme_set_features(&dev->ctrl, NVME_FEAT_NUM_QUEUES, q_count, 0,
 								&result);
-	if (status < 0)
-		return status;
-	if (status > 0) {
+	if (status) {
 		dev_err(dev->dev, "Could not set queue count (%d)\n", status);
 		return 0;
 	}
@@ -2023,6 +2039,11 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	nvme_dev_list_remove(dev);
 
+	if (test_and_set_bit(NVME_CTRL_SHUTDOWN, &dev->flags)) {
+		wait_event(dev->shutdown_wait, !test_bit(NVME_CTRL_SHUTDOWN,
+								&dev->flags));
+		return;
+	}
 	if (dev->bar) {
 		nvme_freeze_queues(dev);
 		csts = readl(dev->bar + NVME_REG_CSTS);
@@ -2041,6 +2062,9 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_clear_queue(dev->queues[i]);
+
+	clear_bit(NVME_CTRL_SHUTDOWN, &dev->flags);
+	wake_up_all(&dev->shutdown_wait);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2115,7 +2139,12 @@ static void nvme_reset_work(struct work_struct *work)
 		goto free_tags;
 
 	result = nvme_setup_io_queues(dev);
-	if (result)
+
+	/*
+	 * The pci device will be disabled if a timeout occurs while setting up
+	 * IO queues, but return 0 for "result", so we have to check both.
+	 */
+	if (result || !pci_is_enabled(to_pci_dev(dev->dev)))
 		goto free_tags;
 
 	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
@@ -2251,6 +2280,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
+	init_waitqueue_head(&dev->shutdown_wait);
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-- 
2.6.2.307.g37023ba
