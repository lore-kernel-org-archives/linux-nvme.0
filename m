From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Jun 2018 09:06:16 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
Message-ID: <d9fcda4e-9ed2-5001-ef38-61f7c0247cfa@kernel.dk>

On 6/21/18 9:04 AM, Jens Axboe wrote:
> On 6/21/18 9:01 AM, Christoph Hellwig wrote:
>> On Thu, Jun 21, 2018@08:47:34AM -0600, Jens Axboe wrote:
>>> On 6/21/18 1:10 AM, Christoph Hellwig wrote:
>>>> On Wed, Jun 20, 2018@04:30:18PM -0600, Jens Axboe wrote:
>>>>> If the fabrics folks have concerns, we could make it dependent on
>>>>> it being a pci device. That's the case I care about anyway, and the
>>>>> one that's currently breaking for me.
>>>>
>>>> Fabrics uses the SG chain allocator that SCSI also uses, so it
>>>> should already be fine, including for larger I/O sizes.
>>>
>>> I'll change it to ignore it for fabrics. What's the best way to
>>> check? ctrl->sqsize?
>>
>> ctrl->ops->flags & NVME_F_FABRICS
>>
>> but in the end we probably want a separate flag, as that is an
>> implementation detail, and not because these are fabrics drivers.
> 
> Probably fine for now with a comment, since it is pretty tightly
> coupled to the fact that we prefer larger commands on fabrics, and
> don't care so much about that for a local controller.
> 
> For now the check is moot though, since we are doing the same
> allocations...

For size I guess it's fine, as long as we limit segments. For
reference, current version below.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21710a7460c8..f40d46668532 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1808,8 +1808,9 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		u32 max_segments =
 			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
 
+		max_segments = min_not_zero(max_segments, (u32)NVME_MAX_SEGS);
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
+		blk_queue_max_segments(q, max_segments);
 	}
 	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
 	    is_power_of_2(ctrl->max_hw_sectors))
@@ -2377,8 +2378,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
-	else
+	else if (ctrl->ops->flags & NVME_F_FABRICS)
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
index fc33804662e7..d5f603b05394 100644
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
@@ -2546,6 +2547,18 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
+	alloc_size = nvme_pci_iod_alloc_size(dev, NVME_MAX_KB_SZ,
+						NVME_MAX_SEGS, true);
+	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
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
