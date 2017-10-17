From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Mon, 16 Oct 2017 18:24:20 -0700
Subject: [PATCH V7] nvme-pci: add SGL support
Message-ID: <1508203460-13852-1-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds SGL support for NVMe PCIe driver, based on an earlier patch
from Rajiv Shanmugam Madeswaran <smrajiv15 at gmail.com>. This patch
refactors the original code and adds new module parameter sgl_threshold
to determine whether to use SGL or PRP for IOs.

The usage of SGLs is controlled by the sgl_threshold module parameter,
which allows to conditionally use SGLs if average request segment
size (avg_seg_size) is greater than sgl_threshold. In the original patch,
the decision of using SGLs was dependent only on the IO size,
with the new approach we consider not only IO size but also the
number of physical segments present in the IO.

We calculate avg_seg_size based on request payload bytes and number
of physical segments present in the request.

For e.g.:-

1. blk_rq_nr_phys_segments = 2 blk_rq_payload_bytes = 8k
avg_seg_size = 4K use sgl if avg_seg_size >= sgl_threshold.

2. blk_rq_nr_phys_segments = 2 blk_rq_payload_bytes = 64k
avg_seg_size = 32K use sgl if avg_seg_size >= sgl_threshold.

3. blk_rq_nr_phys_segments = 16 blk_rq_payload_bytes = 64k
avg_seg_size = 4K use sgl if avg_seg_size >= sgl_threshold.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
This is the seventh version of the patch for adding SGL support
for nvme-pci driver.

Changes since v6:-

1. Refactor the code in nvme_setup_sgls() and get rid of
   the special case of handling single segment.
2. In the process of adding SGL support, we changed the signature
   of some functions. Add prefix "nvme_pci_" to those function.
3. Fix a typo in the commit message.
4. Add information about how to disable the SGLs in the
   description of newly added module parameter sgl_threshold.
5. Change the code base from Linux 4.14-rc3 to 4.14.0-rc4.

Changes since v5:-

1. Remove the NVME_CTRL_SGL_NOT_SUPP enum constant and use
   simple comparison bits to determine whether controller supports
   SGL or not.

Changes since v4:-

1. Replace NVME_CTRL_SUPP_SGL macro with enum NVME_CTRL_SGL_NOT_SUPP.
2. Adjust patch for new enum.
3. Merge two patches into one.

Changes since v3:-

1. Modify SGL helper functions and add prefix nvme_pci_sgl.
2. Use average request physical segment(s) size to conditionally use SGLs.
   This approach is different from the original one, the original approach
   was based no the IO size. The new approach considers IO size and
   number of physical segments present in the request to conditionally
   use SGLs.
3. Adjust the patch for Linux 4.14-rc3.

Changes since v2:-

1. Adjust the patch for latest nvme driver changes.
2. For initial submission use the default virt boundary values.

In future, work on the patch series for relaxing the virt boundary
for each transport.

Changes since the v1:-

1. Introduced nvme controller virt_boundary mask. For controllers that
   can handle arbitrarily sized bios (e.g advanced RDMA and PCI ctrls)
   we can allow the block layer to pass us gaps by setting the
   queue.virt_boundary_mask according to each ctrl constraints.
2. Simplified code for setting up the SGLs.
3. Added SGL helper functions.
4. Modified commit log.
5. Use the newly introduced virt_boundary mask and clear its
   value for SGL capable controllers in PCIe driver.

For reference v1 details:-

This adds SGL support for NVMe PCIe driver which is
reimplementation of the initial version provided by
Rajiv Shanmugam Madeswaran(smrajiv15 at gmail.com):-
"block: nvme-core: Scatter gather list support in the
NVMe Block Driver".

In order to enable SGL mode for the driver, the user can set the
sgl_threshold module parameter. This parameter can be used
in the two modes:-

1. Allow all IOs to use SGL mode. (set sgl_threshold to 1).
2. Set up the IO size threshold to determine whether to use
    SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
    use SGL only for IOs which are >= 4096 in the size).
---
 drivers/nvme/host/pci.c | 214 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 187 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f5a04c..45a3397 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -45,6 +45,8 @@
  */
 #define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
 
+#define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
+
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
@@ -57,6 +59,12 @@
 MODULE_PARM_DESC(max_host_mem_size_mb,
 	"Maximum Host Memory Buffer (HMB) size per controller (in MiB)");
 
+static unsigned int sgl_threshold = SZ_32K;
+module_param(sgl_threshold, uint, 0644);
+MODULE_PARM_DESC(sgl_threshold,
+		"Use SGLs when average request segment size is larger or equal to "
+		"this size. Use 0 to disable SGLs.");
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -178,6 +186,7 @@ struct nvme_queue {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_queue *nvmeq;
+	bool use_sgl;
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
@@ -331,17 +340,35 @@ static int nvme_npages(unsigned size, struct nvme_dev *dev)
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
 
-static unsigned int nvme_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg)
+/*
+ * Calculates the number of pages needed for the SGL segments. For example a 4k
+ * page can accommodate 256 SGL descriptors.
+ */
+static int nvme_pci_npages_sgl(unsigned int num_seg)
+{
+	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
+}
+
+static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
+		unsigned int size, unsigned int nseg, bool use_sgl)
 {
-	return sizeof(__le64 *) * nvme_npages(size, dev) +
-			sizeof(struct scatterlist) * nseg;
+	size_t alloc_size;
+
+	if (use_sgl)
+		alloc_size = sizeof(__le64 *) * nvme_pci_npages_sgl(nseg);
+	else
+		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
+
+	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
 
-static unsigned int nvme_cmd_size(struct nvme_dev *dev)
+static unsigned int nvme_pci_cmd_size(struct nvme_dev *dev, bool use_sgl)
 {
-	return sizeof(struct nvme_iod) +
-		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
+	unsigned int alloc_size = nvme_pci_iod_alloc_size(dev,
+				    NVME_INT_BYTES(dev), NVME_INT_PAGES,
+				    use_sgl);
+
+	return sizeof(struct nvme_iod) + alloc_size;
 }
 
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -425,10 +452,10 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 	nvmeq->sq_tail = tail;
 }
 
-static __le64 **iod_list(struct request *req)
+static void **nvme_pci_iod_list(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	return (__le64 **)(iod->sg + blk_rq_nr_phys_segments(req));
+	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
 }
 
 static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
@@ -438,7 +465,10 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	unsigned int size = blk_rq_payload_bytes(rq);
 
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		iod->sg = kmalloc(nvme_iod_alloc_size(dev, size, nseg), GFP_ATOMIC);
+		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
+				iod->use_sgl);
+
+		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
 		if (!iod->sg)
 			return BLK_STS_RESOURCE;
 	} else {
@@ -456,18 +486,31 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	const int last_prp = dev->ctrl.page_size / 8 - 1;
+	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
+	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
+
 	int i;
-	__le64 **list = iod_list(req);
-	dma_addr_t prp_dma = iod->first_dma;
 
 	if (iod->npages == 0)
-		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
+		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
+			dma_addr);
+
 	for (i = 0; i < iod->npages; i++) {
-		__le64 *prp_list = list[i];
-		dma_addr_t next_prp_dma = le64_to_cpu(prp_list[last_prp]);
-		dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
-		prp_dma = next_prp_dma;
+		void *addr = nvme_pci_iod_list(req)[i];
+
+		if (iod->use_sgl) {
+			struct nvme_sgl_desc *sg_list = addr;
+
+			next_dma_addr =
+			    le64_to_cpu((sg_list[SGES_PER_PAGE - 1]).addr);
+		} else {
+			__le64 *prp_list = addr;
+
+			next_dma_addr = le64_to_cpu(prp_list[last_prp]);
+		}
+
+		dma_pool_free(dev->prp_page_pool, addr, dma_addr);
+		dma_addr = next_dma_addr;
 	}
 
 	if (iod->sg != iod->inline_sg)
@@ -555,7 +598,8 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
 	}
 }
 
-static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
+static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
+		struct request *req, struct nvme_rw_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
@@ -566,14 +610,16 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	u32 page_size = dev->ctrl.page_size;
 	int offset = dma_addr & (page_size - 1);
 	__le64 *prp_list;
-	__le64 **list = iod_list(req);
+	void **list = nvme_pci_iod_list(req);
 	dma_addr_t prp_dma;
 	int nprps, i;
 
+	iod->use_sgl = false;
+
 	length -= (page_size - offset);
 	if (length <= 0) {
 		iod->first_dma = 0;
-		return BLK_STS_OK;
+		goto done;
 	}
 
 	dma_len -= (page_size - offset);
@@ -587,7 +633,7 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 
 	if (length <= page_size) {
 		iod->first_dma = dma_addr;
-		return BLK_STS_OK;
+		goto done;
 	}
 
 	nprps = DIV_ROUND_UP(length, page_size);
@@ -634,6 +680,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 		dma_len = sg_dma_len(sg);
 	}
 
+done:
+	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
+
 	return BLK_STS_OK;
 
  bad_sgl:
@@ -643,6 +693,110 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	return BLK_STS_IOERR;
 }
 
+static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+		struct scatterlist *sg)
+{
+	sge->addr = cpu_to_le64(sg_dma_address(sg));
+	sge->length = cpu_to_le32(sg_dma_len(sg));
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
+static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
+		dma_addr_t dma_addr, int entries)
+{
+	sge->addr = cpu_to_le64(dma_addr);
+	if (entries < SGES_PER_PAGE) {
+		sge->length = cpu_to_le32(entries * sizeof(*sge));
+		sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
+	} else {
+		sge->length = cpu_to_le32(PAGE_SIZE);
+		sge->type = NVME_SGL_FMT_SEG_DESC << 4;
+	}
+}
+
+static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
+		struct request *req, struct nvme_rw_command *cmd)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	int length = blk_rq_payload_bytes(req);
+	struct dma_pool *pool;
+	struct nvme_sgl_desc *sg_list;
+	struct scatterlist *sg = iod->sg;
+	int entries = iod->nents, i = 0;
+	dma_addr_t sgl_dma;
+
+	iod->use_sgl = true;
+
+	/* setting the transfer type as SGL */
+	cmd->flags = NVME_CMD_SGL_METABUF;
+
+	if (length == sg_dma_len(sg)) {
+		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
+		return BLK_STS_OK;
+	}
+
+	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
+		pool = dev->prp_small_pool;
+		iod->npages = 0;
+	} else {
+		pool = dev->prp_page_pool;
+		iod->npages = 1;
+	}
+
+	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
+	if (!sg_list) {
+		iod->npages = -1;
+		return BLK_STS_RESOURCE;
+	}
+
+	nvme_pci_iod_list(req)[0] = sg_list;
+	iod->first_dma = sgl_dma;
+
+	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
+
+	do {
+		if (i == SGES_PER_PAGE) {
+			struct nvme_sgl_desc *old_sg_desc = sg_list;
+			struct nvme_sgl_desc *link = &old_sg_desc[i - 1];
+
+			sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
+			if (!sg_list)
+				return BLK_STS_RESOURCE;
+
+			i = 0;
+			nvme_pci_iod_list(req)[iod->npages++] = sg_list;
+			sg_list[i++] = *link;
+			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
+		}
+
+		nvme_pci_sgl_set_data(&sg_list[i++], sg);
+
+		length -= sg_dma_len(sg);
+		sg = sg_next(sg);
+		entries--;
+	} while (length > 0);
+
+	WARN_ON(entries > 0);
+	return BLK_STS_OK;
+}
+
+static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	unsigned int avg_seg_size;
+
+	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
+			blk_rq_nr_phys_segments(req));
+
+	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
+		return false;
+	if (!iod->nvmeq->qid)
+		return false;
+	if (!sgl_threshold || avg_seg_size < sgl_threshold)
+		return false;
+	return true;
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -662,7 +816,11 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				DMA_ATTR_NO_WARN))
 		goto out;
 
-	ret = nvme_setup_prps(dev, req);
+	if (nvme_pci_use_sgls(dev, req))
+		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
+	else
+		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
+
 	if (ret != BLK_STS_OK)
 		goto out_unmap;
 
@@ -682,8 +840,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 			goto out_unmap;
 	}
 
-	cmnd->rw.dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	cmnd->rw.dptr.prp2 = cpu_to_le64(iod->first_dma);
 	if (blk_integrity_rq(req))
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
 	return BLK_STS_OK;
@@ -1379,7 +1535,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
-		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
@@ -1906,7 +2062,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-		dev->tagset.cmd_size = nvme_cmd_size(dev);
+		dev->tagset.cmd_size = nvme_pci_cmd_size(dev, false);
+		if ((dev->ctrl.sgls & ((1 << 0) | (1 << 1))) && sgl_threshold) {
+			dev->tagset.cmd_size = max(dev->tagset.cmd_size,
+					nvme_pci_cmd_size(dev, true));
+		}
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
-- 
1.8.3.1
