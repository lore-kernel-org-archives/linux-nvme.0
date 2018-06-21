From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Jun 2018 09:49:37 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180621154539.GA30025@infradead.org>
References: <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
 <20180621152456.GB29947@infradead.org>
 <873b1ec2-50a9-1660-2550-c4e539c2413d@kernel.dk>
 <20180621154539.GA30025@infradead.org>
Message-ID: <697a18cb-43c7-c768-6d17-6eb8123f26ff@kernel.dk>

On 6/21/18 9:45 AM, Christoph Hellwig wrote:
> On Thu, Jun 21, 2018@09:34:02AM -0600, Jens Axboe wrote:
>> Oh, I'm totally fine with that, no rush outside of just wanting to
>> ensure it ends up in 4.18. But there's plenty of time for that.
>>
>> Below is cleaner I think, keeping it all in pci.c and fabrics should
>> just work. I'll test...
> 
> Ok, this actually looks harmless enough that with successfull testing
> and an ack from Keith we could queue it up this week..

Tested it here now (laptop and box with 6 drives), works for me. Proper
patch below.

From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: limit max IO size and segments for pci-e

nvme requires an sg table allocation for each request. If the request
is large, then the allocation can become quite large. For instance,
with our default software settings of 1280KB IO size, we'll need
10248 bytes of sg table. That turns into a 2nd order allocation,
which we can't always guarantee. If we fail the allocation, blk-mq
will retry it later. But there's no guarantee that we'll EVER be
able to allocate that much contigious memory.

Limit the IO size such that we never need more than a single page
of memory. That's a lot faster and more reliable. Then back that
allocation with a mempool, so that we know we'll always be able
to succeed the allocation at some point.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21710a7460c8..46df030b2c3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1808,6 +1808,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		u32 max_segments =
 			(ctrl->max_hw_sectors / (ctrl->page_size >> 9)) + 1;
 
+		max_segments = min_not_zero(max_segments, ctrl->max_segments);
 		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
 		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 231807cbc849..0c4a33df3b2f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -170,6 +170,7 @@ struct nvme_ctrl {
 	u64 cap;
 	u32 page_size;
 	u32 max_hw_sectors;
+	u32 max_segments;
 	u16 oncs;
 	u16 oacs;
 	u16 nssa;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fc33804662e7..276acc045983 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -38,6 +38,13 @@
 
 #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
+/*
+ * These can be higher, but we need to ensure that any command doesn't
+ * require an sg allocation that needs more than a page of data.
+ */
+#define NVME_MAX_KB_SZ	4096
+#define NVME_MAX_SEGS	127
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -100,6 +107,8 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
 
+	mempool_t *iod_mempool;
+
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
@@ -477,10 +486,7 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
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
@@ -526,7 +532,7 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	}
 
 	if (iod->sg != iod->inline_sg)
-		kfree(iod->sg);
+		mempool_free(iod->sg, dev->iod_mempool);
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
@@ -2280,6 +2286,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
 	free_opal_dev(dev->ctrl.opal_dev);
+	mempool_destroy(dev->iod_mempool);
 	kfree(dev);
 }
 
@@ -2333,6 +2340,13 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	/*
+	 * Limit the max command size to prevent iod->sg allocations going
+	 * over a single page.
+	 */
+	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
+	dev->ctrl.max_segments = NVME_MAX_SEGS;
+
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
 		goto out;
@@ -2509,6 +2523,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
+	size_t alloc_size;
 
 	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
@@ -2546,6 +2561,23 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
