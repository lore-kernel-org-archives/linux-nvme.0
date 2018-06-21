From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Jun 2018 09:11:28 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180621150624.GA1718@infradead.org>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180621070954.GA21304@infradead.org>
 <ce58c5ca-e2cd-de6a-a021-7f65b56d8a21@kernel.dk>
 <20180621145812.GB17825@infradead.org>
 <87f5c54b-dc09-817b-0660-440a75af7407@kernel.dk>
 <20180621150624.GA1718@infradead.org>
Message-ID: <b142d5e6-e7cd-fa41-776e-2acd18691bae@kernel.dk>

On 6/21/18 9:06 AM, Christoph Hellwig wrote:
> On Thu, Jun 21, 2018@09:02:18AM -0600, Jens Axboe wrote:
>> >From a quick look, the fabric code goes through the same nvme_queue_rq()
>> and ends up doing the same iod->sg allocation. I don't see any use of
>> chained sg lists, we're allocating one big sg table for the command.
> 
> nvme_queue_rq is only used for PCIe.
> 
> E.g. for RDMA the call is:
> 
> nvme_rdma_queue_rq
>  -> nvme_rdma_map_data
>   -> sg_alloc_table_chained
> 
> similar for FC and loop.

Gotcha. So we can safely ignore limiting segments and max size for
fabrics for now.

How about the below?


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21710a7460c8..f1af08171d38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1799,6 +1799,16 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
 
+/*
+ * For non-fabrics, limit the max IO size and segments so that we know our
+ * iod->sg allocation can fall within a single page. Fabrics is more sensitive
+ * to command size, and it also does sg chaining to avoid large allocations.
+ */
+static bool nvme_ctrl_limit_io_size(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->ops->flags & NVME_F_FABRICS) == 0;
+}
+
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
@@ -1808,8 +1818,11 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		u32 max_segments =
 			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
 
+		if (nvme_ctrl_limit_io_size(ctrl))
+			max_segments = min_not_zero(max_segments,
+							(u32)NVME_MAX_SEGS);
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
+		blk_queue_max_segments(q, max_segments);
 	}
 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
 	    is_power_of_2(ctrl->max_hw_sectors))
@@ -2377,8 +2390,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-	else
+	else if (!nvme_ctrl_limit_io_size(ctrl))
 		max_hw_sectors = UINT_MAX;
+	else
+		max_hw_sectors = NVME_MAX_KB_SZ << 1;
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 231807cbc849..efce853a6638 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -33,6 +33,13 @@ extern unsigned int admin_timeout;
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
 
+/*
+ * These can be higher, but we need to ensure that any command doesn't
+ * require an sg allocation that needs more than a page of data.
+ */
+#define NVME_MAX_KB_SZ	4096
+#define NVME_MAX_SEGS	127
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804662e7..663446d55a49 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -100,6 +100,8 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
 
+	mempool_t *iod_mempool;
+
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
@@ -477,10 +479,7 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
 
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
-				iod->use_sgl);
-
-		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
+		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 		if (!iod->sg)
 			return BLK_STS_RESOURCE;
 	} else {
@@ -526,7 +525,7 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	}
 
 	if (iod->sg != iod->inline_sg)
-		kfree(iod->sg);
+		mempool_free(iod->sg, dev->iod_mempool);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
@@ -2280,6 +2279,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
 	free_opal_dev(dev->ctrl.opal_dev);
+	mempool_destroy(dev->iod_mempool);
 	kfree(dev);
 }
 
@@ -2509,6 +2509,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
+	size_t alloc_size;
 
 	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
@@ -2546,6 +2547,23 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
+	/*
+	 * Double check that our mempool alloc size will cover the biggest
+	 * command we support.
+	 */
+	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
+						NVME_MAX_SEGS, true);
+	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
+
+	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
+						mempool_kfree,
+						(void *) alloc_size,
+						GFP_KERNEL, node);
+	if (!dev->iod_mempool) {
+		result = -ENOMEM;
+		goto release_pools;
+	}
+
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	nvme_get_ctrl(&dev->ctrl);

-- 
Jens Axboe
