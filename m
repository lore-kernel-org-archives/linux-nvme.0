From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Jan 2018 16:59:49 -0700
Subject: [PATCH 3/3] nvme-pci: Delete HMB asynchronously
In-Reply-To: <20180129235949.26267-1-keith.busch@intel.com>
References: <20180129235949.26267-1-keith.busch@intel.com>
Message-ID: <20180129235949.26267-3-keith.busch@intel.com>

Deleting the host memory buffer occurs in the controller disabling
path. The driver needs to be able to make forward progress even if
the controller can't produce a completion for that command. Issuing a
synchronous nvme command within the controller shutdown path could block
indefinitely if the controller is unable to provide a response for any
reason, so this patch sends the HMB teardown asynchronously.

Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8fd0e87f0efe..9977b66d98cd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1714,7 +1714,15 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	}
 }
 
-static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
+static void nvme_hmb_endio(struct request *req, blk_status_t error)
+{
+	struct completion *c = req->end_io_data;
+
+	blk_mq_free_request(req);
+	complete(c);
+}
+
+static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits, struct completion *complete)
 {
 	u64 dma_addr = dev->host_mem_descs_dma;
 	struct nvme_command c;
@@ -1730,6 +1738,11 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
 	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
 
+	if (complete)
+		return nvme_submit_async_cmd(dev->ctrl.admin_q, &c,
+					     complete, nvme_hmb_endio,
+					     ADMIN_TIMEOUT, BLK_MQ_REQ_NOWAIT);
+
 	ret = nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
 	if (ret) {
 		dev_warn(dev->ctrl.device,
@@ -1760,9 +1773,7 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	dev->nr_host_mem_descs = 0;
 }
 
-static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
-		u32 chunk_size)
-{
+static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred, u32 chunk_size) {
 	struct nvme_host_mem_buf_desc *descs;
 	u32 max_entries, len;
 	dma_addr_t descs_dma;
@@ -1884,7 +1895,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 			dev->host_mem_size >> ilog2(SZ_1M));
 	}
 
-	ret = nvme_set_host_mem(dev, enable_bits);
+	ret = nvme_set_host_mem(dev, enable_bits, NULL);
 	if (ret)
 		nvme_free_host_mem(dev);
 	return ret;
@@ -2152,8 +2163,9 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
-	bool dead = true;
+	bool dead = true, hmb_wait = false;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	DECLARE_COMPLETION_ONSTACK(hmb_complete);
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
@@ -2181,13 +2193,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 * but I'd rather be safe than sorry..
 		 */
 		if (dev->host_mem_descs)
-			nvme_set_host_mem(dev, 0);
+			hmb_wait = !nvme_set_host_mem(dev, 0, &hmb_complete);
 
 	}
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead) {
 		nvme_disable_io_queues(dev);
+		if (hmb_wait)
+			wait_for_completion_timeout(&hmb_complete,
+						    ADMIN_TIMEOUT);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
-- 
2.14.3
