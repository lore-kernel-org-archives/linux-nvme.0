From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Nov 2015 11:17:45 -0700
Subject: [PATCH] NVMe: Split shutdown work
Message-ID: <1448302665-9703-1-git-send-email-keith.busch@intel.com>

A command timeout during controller start should safely disable the
controller first. This requires decoupling shutdown work from start-up,
and special handling for timeouts that occur during start-up.

Setting the queue count has a special check for a disabled device in
order to set an appropriate return code as this command may legitimately
fail. All other initialization commands do not need to distinguish
timeouts and command error.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This is based on Christoph's block tree:

  http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-req.9

 drivers/nvme/host/pci.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ff253c8..cc08fae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -86,6 +86,7 @@ struct nvme_queue;
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
+static void nvme_dev_shutdown(struct nvme_dev *dev);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -116,6 +117,7 @@ struct nvme_dev {
 	void __iomem *bar;
 	struct work_struct reset_work;
 	struct work_struct scan_work;
+	struct work_struct shutdown_work;
 	struct work_struct remove_work;
 	bool subsystem;
 	u32 page_size;
@@ -938,14 +940,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	struct nvme_command cmd;
 
 	/*
-	 * Just return an error to reset_work if we're already called from
-	 * probe context.  We don't worry about request / tag reuse as
-	 * reset_work will immeditalely unwind and remove the controller
-	 * once we fail a command.
+	 * Shutdown immediately if controller times out while starting. The
+	 * reset work will see the pci device disabled when it gets the forced
+	 * cancellation error.
 	 */
 	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
-		req->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
-		return BLK_EH_HANDLED;
+		dev_warn(dev->dev, "timeout during initialization\n");
+		queue_work(nvme_workq, &dev->shutdown_work);
+		return BLK_EH_QUIESCED;
 	}
 
 	/*
@@ -1510,11 +1512,12 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 
 	status = nvme_set_features(&dev->ctrl, NVME_FEAT_NUM_QUEUES, q_count, 0,
 								&result);
-	if (status < 0)
-		return status;
-	if (status > 0) {
-		dev_err(dev->dev, "Could not set queue count (%d)\n", status);
-		return 0;
+	if (status) {
+		bool enabled = pci_is_enabled(to_pci_dev(dev->dev));
+
+		dev_err(dev->dev, "Could not set queue count (%d) enabled:%d\n",
+								status, enabled);
+		return enabled ? 0 : -ENODEV;
 	}
 	return min(result & 0xffff, result >> 16) + 1;
 }
@@ -2080,6 +2083,12 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	kfree(dev);
 }
 
+static void nvme_shutdown_work(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, shutdown_work);
+	nvme_dev_shutdown(dev);
+}
+
 static void nvme_reset_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
@@ -2092,8 +2101,10 @@ static void nvme_reset_work(struct work_struct *work)
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
 	 */
-	if (dev->bar)
-		nvme_dev_shutdown(dev);
+	if (dev->bar) {
+		queue_work(nvme_workq, &dev->shutdown_work);
+		flush_work(&dev->shutdown_work);
+	}
 
 	set_bit(NVME_CTRL_RESETTING, &dev->flags);
 
@@ -2250,6 +2261,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
+	INIT_WORK(&dev->shutdown_work, nvme_shutdown_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 
 	result = nvme_setup_prp_pools(dev);
@@ -2305,6 +2317,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_shutdown(dev);
+	flush_work(&dev->shutdown_work);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
-- 
2.6.2.307.g37023ba
