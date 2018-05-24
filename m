From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:35:00 -0600
Subject: [PATCHv3 9/9] nvme-pci: Don't wait for HMB completion on shutdown
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-10-keith.busch@intel.com>


An nvme controller reset can't depend on the timeout handling to
complete timed out commands since we're already trying to disable the
controller. The HMB disabling is the only command in this path that was
not handling its own timeout, so this patch fixes that by putting a time
limit on how long it will wait for completion.

Based-on-patch-by: Ming Lei <ming.lei at redhat.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e12b4ee91254..83fc5bfe20e8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1764,9 +1764,25 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	}
 }
 
-static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
+static void nvme_set_host_mem_end_io(struct request *rq, blk_status_t sts)
+{
+	struct completion *wait = rq->end_io_data;
+
+	rq->end_io_data = NULL;
+	blk_mq_free_request(rq);
+	complete(wait);
+}
+
+/*
+ * Use 'wait' when sending this command in a context can't complete blocks the
+ * reset handler, as required for device shutdown.
+ */
+static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits,
+			     struct completion *wait)
 {
 	u64 dma_addr = dev->host_mem_descs_dma;
+	struct request_queue *q = dev->ctrl.admin_q;
+	struct request *req;
 	struct nvme_command c;
 	int ret;
 
@@ -1780,7 +1796,19 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
 	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
 
-	ret = nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
+	if (!wait) {
+		ret = nvme_submit_sync_cmd(q, &c, NULL, 0);
+	} else {
+		req = nvme_alloc_request(q, &c, 0, NVME_QID_ANY);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+		req->timeout = ADMIN_TIMEOUT;
+		req->end_io_data = wait;
+		blk_execute_rq_nowait(q, NULL, req, false,
+				      nvme_set_host_mem_end_io);
+		ret = wait_for_completion_io_timeout(wait, ADMIN_TIMEOUT);
+	}
+
 	if (ret) {
 		dev_warn(dev->ctrl.device,
 			 "failed to set host mem (err %d, flags %#x).\n",
@@ -1934,7 +1962,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 			dev->host_mem_size >> ilog2(SZ_1M));
 	}
 
-	ret = nvme_set_host_mem(dev, enable_bits);
+	ret = nvme_set_host_mem(dev, enable_bits, NULL);
 	if (ret)
 		nvme_free_host_mem(dev);
 	return ret;
@@ -2235,6 +2263,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	DECLARE_COMPLETION_ONSTACK(hmb_wait);
 
 	mutex_lock(&dev->shutdown_lock);
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE &&
@@ -2267,7 +2296,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 * but I'd rather be safe than sorry..
 		 */
 		if (dev->host_mem_descs)
-			nvme_set_host_mem(dev, 0);
+			nvme_set_host_mem(dev, 0, &hmb_wait);
 		nvme_disable_io_queues(dev);
 	}
 	if (dev->ctrl.queue_count > 0)
-- 
2.14.3
