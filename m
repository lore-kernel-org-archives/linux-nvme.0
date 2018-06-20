From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 20 Jun 2018 14:09:03 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
Message-ID: <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>

On 6/20/18 1:16 PM, Jens Axboe wrote:
> On 6/20/18 1:10 PM, Jens Axboe wrote:
>> This begs the question is we should limit the size in general. The
>> command overhead is low enough that I think we should default to
>> something sane that doesn't require _any_ > 0 order allocations.
>>
>> Our default 1280kb will require 10248 bytes of iod, which is an
>> order 2 allocation.... That's not helping tail latencies in
>> data centers, where memory is always full and fragmented.
> 
> In terms of sizing, defaulting to 256kb might not be a bad idea.
> That'd be 2056 bytes for a normal config. Alternatively we could
> go 1280/4 == 320k, which would be 2568 bytes.
> 
> In any case, I think it's something that's worth doing.

Talking more to myself - higher order allocations needed to make
progress isn't a viable approach. There may _never_ be any available,
which means we are stuck since this isn't backed by a mempool.

How about something like the below. Default to a size that will
never require > PAGE_SIZE allocation, and back that with a single
entry mempool. Even if we don't wait on it, if we keep retrying
we'll always be able to allocate memory and make forward progress.
And allocating a single page is a hell of a lot more likely than
a 2nd order allocation.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21710a7460c8..fe301423d06c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -37,6 +37,12 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+/*
+ * This can be higher, but we need to ensure that any command doesn't
+ * require an iod->sg allocation that needs more than a page of aux data.
+ */
+#define NVME_MAX_SECTORS	512
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -2378,7 +2384,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (id->mdts)
 		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
 	else
-		max_hw_sectors = UINT_MAX;
+		max_hw_sectors = NVME_MAX_SECTORS;
 	ctrl->max_hw_sectors =
 		min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804662e7..603998e7d7a6 100644
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
@@ -477,10 +479,10 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	iod->use_sgl = nvme_pci_use_sgls(dev, rq);
 
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
-				iod->use_sgl);
-
-		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
+		BUG_ON(nvme_pci_iod_alloc_size(dev, size,
+						blk_rq_nr_phys_segments(rq),
+						iod->use_sgl) > PAGE_SIZE);
+		iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
 		if (!iod->sg)
 			return BLK_STS_RESOURCE;
 	} else {
@@ -526,7 +528,7 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	}
 
 	if (iod->sg != iod->inline_sg)
-		kfree(iod->sg);
+		mempool_free(iod->sg, dev->iod_mempool);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
@@ -2280,6 +2282,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
 	free_opal_dev(dev->ctrl.opal_dev);
+	mempool_destroy(dev->iod_mempool);
 	kfree(dev);
 }
 
@@ -2546,6 +2549,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto release_pools;
 
+	dev->iod_mempool = mempool_create_node(1, mempool_alloc_pages,
+						mempool_free_pages, (void *) 0,
+						GFP_ATOMIC, node);
+	if (!dev->iod_mempool) {
+		result = -ENOMEM;
+		goto release_pools;
+	}
+
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	nvme_get_ctrl(&dev->ctrl);

-- 
Jens Axboe
