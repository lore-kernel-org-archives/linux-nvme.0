From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 13 Jul 2017 10:54:39 -0700
Subject: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe driver.
In-Reply-To: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
References: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
Message-ID: <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>

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

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 drivers/nvme/host/pci.c | 232 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/nvme.h    |   2 +
 2 files changed, 217 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d10d2f2..f30465d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/poison.h>
+#include <linux/scatterlist.h>
 #include <linux/t10-pi.h>
 #include <linux/timer.h>
 #include <linux/types.h>
@@ -56,6 +57,10 @@ module_param(max_host_mem_size_mb, uint, 0444);
 MODULE_PARM_DESC(max_host_mem_size_mb,
 	"Maximum Host Memory Buffer (HMB) size per controller (in MiB)");
 
+static unsigned int sgl_threshold = 32 * 1024;
+module_param(sgl_threshold, uint, 0644);
+MODULE_PARM_DESC(sgl_threshold, "use SGL for I/O SQes");
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
 static const struct kernel_param_ops io_queue_depth_ops = {
 	.set = io_queue_depth_set,
@@ -113,6 +118,15 @@ struct nvme_dev {
 	void **host_mem_desc_bufs;
 };
 
+/* move this to right place */
+static inline void put_unaligned_le24(u32 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+	*p++ = val >> 16;
+}
+
+
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
 	int n = 0, ret;
@@ -176,6 +190,7 @@ struct nvme_queue {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_queue *nvmeq;
+	int sgl_threshold;
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
@@ -329,17 +344,32 @@ static int nvme_npages(unsigned size, struct nvme_dev *dev)
 	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
 }
 
+/* calculates the number of pages needed for framing the
+ * SGL segments. for ex: 4k page can accommodate 256 SGL descriptors
+ */
+static int nvme_npages_sgl(unsigned int num_seg)
+{
+	return DIV_ROUND_UP(num_seg * 16, PAGE_SIZE);
+}
+
 static unsigned int nvme_iod_alloc_size(struct nvme_dev *dev,
-		unsigned int size, unsigned int nseg)
+		unsigned int size, unsigned int nseg, bool sgl_threshold)
 {
-	return sizeof(__le64 *) * nvme_npages(size, dev) +
-			sizeof(struct scatterlist) * nseg;
+	size_t alloc_size;
+
+	if (sgl_threshold)
+		alloc_size = sizeof(__le64 *) * nvme_npages_sgl(nseg);
+	else
+		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
+
+	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
 
-static unsigned int nvme_cmd_size(struct nvme_dev *dev)
+static unsigned int nvme_cmd_size(struct nvme_dev *dev, bool sgl_threshold)
 {
 	return sizeof(struct nvme_iod) +
-		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
+		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES,
+				sgl_threshold);
 }
 
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
@@ -436,9 +466,11 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	unsigned int size = blk_rq_payload_bytes(rq);
 
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
-		iod->sg = kmalloc(nvme_iod_alloc_size(dev, size, nseg), GFP_ATOMIC);
-		if (!iod->sg)
-			return BLK_STS_RESOURCE;
+		size_t alloc_size;
+
+		alloc_size = nvme_iod_alloc_size(dev, size, nseg,
+				iod->sgl_threshold);
+		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
 	} else {
 		iod->sg = iod->inline_sg;
 	}
@@ -451,6 +483,32 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	return BLK_STS_OK;
 }
 
+static void nvme_free_iod_sgl(struct nvme_dev *dev, struct request *req)
+{
+	int i;
+	int last_entry;
+	__le64 **list = iod_list(req);
+	dma_addr_t sgl_dma, next_sgl_dma;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	sgl_dma = iod->first_dma;
+	if (iod->npages == 0)
+		dma_pool_free(dev->prp_small_pool, list[0], sgl_dma);
+
+	last_entry = PAGE_SIZE / 16 - 1;
+	for (i = 0; i < iod->npages; i++) {
+		struct nvme_sgl_desc *sg_list = (struct nvme_sgl_desc *)list[i];
+
+		next_sgl_dma = le64_to_cpu((sg_list[last_entry]).addr);
+		dma_pool_free(dev->prp_page_pool, sg_list, sgl_dma);
+		sgl_dma = next_sgl_dma;
+	}
+
+	if (iod->sg != iod->inline_sg)
+		kfree(iod->sg);
+}
+
+
 static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -459,6 +517,11 @@ static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
 	__le64 **list = iod_list(req);
 	dma_addr_t prp_dma = iod->first_dma;
 
+	if (iod->sgl_threshold) {
+		nvme_free_iod_sgl(dev, req);
+		return;
+	}
+
 	if (iod->npages == 0)
 		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
 	for (i = 0; i < iod->npages; i++) {
@@ -539,7 +602,8 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
-static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
+static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req,
+		int total_len, struct nvme_rw_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct dma_pool *pool;
@@ -554,9 +618,12 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	dma_addr_t prp_dma;
 	int nprps, i;
 
+	/* check if pre-zeroed, then not needed */
+	iod->sgl_threshold = false;
+
 	length -= (page_size - offset);
 	if (length <= 0)
-		return true;
+		goto out;
 
 	dma_len -= (page_size - offset);
 	if (dma_len) {
@@ -569,7 +636,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 
 	if (length <= page_size) {
 		iod->first_dma = dma_addr;
-		return true;
+		goto out;
 	}
 
 	nprps = DIV_ROUND_UP(length, page_size);
@@ -615,6 +682,128 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 		dma_len = sg_dma_len(sg);
 	}
 
+out:
+	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
+
+	return true;
+}
+
+/* frames NVMe specific SGL's for data transfer */
+static bool nvme_setup_sgls(struct nvme_dev *dev, struct request *req,
+		int total_len, struct nvme_rw_command *cmd)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct dma_pool *pool;
+	struct nvme_sgl_desc *sg_list;
+	dma_addr_t sgl_dma;
+	int i;
+	int length = total_len;
+	struct scatterlist *sg = iod->sg;
+	__le64 **list = iod_list(req);
+	int num_entries = iod->nents;
+	int entry = (PAGE_SIZE / 16) - 1;
+	struct nvme_sgl_desc *sg_seg;
+
+	iod->sgl_threshold = true;
+
+	cmd->flags = 1 << 6; /* setting the transfer type as SGL */
+
+	if (total_len == sg_dma_len(sg)) {
+		cmd->dptr.sgl.addr = cpu_to_le64(sg_dma_address(sg));
+		cmd->dptr.sgl.type |= NVME_SGL_FMT_DATA_DESC << 4;
+		cmd->dptr.sgl.length = cpu_to_le32(sg_dma_len(sg));
+		return true;
+	}
+
+	if (num_entries <= (256 / 16)) {
+		pool = dev->prp_small_pool;
+		iod->npages = 0;
+	} else {
+		pool = dev->prp_page_pool;
+		iod->npages = 1;
+	}
+
+	sg_list = (struct nvme_sgl_desc *)
+		dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
+
+	if (!sg_list) {
+		cmd->dptr.sgl.addr = cpu_to_le64(sg_dma_address(sg));
+		cmd->dptr.sgl.type |= NVME_SGL_FMT_DATA_DESC << 4;
+		cmd->dptr.sgl.length = cpu_to_le32(sg_dma_len(sg));
+		length -= sg_dma_len(sg);
+		return false;
+	}
+
+	list[0] = (__le64 *)sg_list;
+	iod->first_dma = sgl_dma;
+
+	if (num_entries <= (PAGE_SIZE / 16)) {
+		cmd->dptr.sgl.addr = cpu_to_le64(sgl_dma);
+		cmd->dptr.sgl.length = cpu_to_le32(num_entries * 16);
+		cmd->dptr.sgl.type |= NVME_SGL_FMT_LAST_SEG_DESC << 4;
+		for (i = 0; i < num_entries; i++) {
+			sg_list[i].addr = cpu_to_le64(sg_dma_address(sg));
+			sg_list[i].length = cpu_to_le32(sg_dma_len(sg));
+			sg_list[i].type |= NVME_SGL_FMT_DATA_DESC << 4;
+			length -= sg_dma_len(sg);
+			sg = sg_next(sg);
+		}
+
+		WARN_ON(length > 0);
+		return true;
+	}
+	cmd->dptr.sgl.addr = cpu_to_le64(sgl_dma);
+	cmd->dptr.sgl.length = cpu_to_le32(PAGE_SIZE);
+	cmd->dptr.sgl.type |= NVME_SGL_FMT_SEG_DESC << 4;
+	i = 0;
+	for (;;) {
+		if (i == PAGE_SIZE / 16) {
+			struct nvme_sgl_desc *old_sg_desc = sg_list;
+
+			sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
+			if (!sg_list) {
+				if (iod->npages == 1) {
+					cmd->dptr.sgl.type |=
+						NVME_SGL_FMT_LAST_SEG_DESC << 4;
+				} else {
+					int page = iod->npages - 2;
+
+					sg_seg = (struct nvme_sgl_desc *)
+						list[page];
+					sg_seg[entry].type |=
+						NVME_SGL_FMT_LAST_SEG_DESC << 4;
+				}
+				return false;
+			}
+			list[iod->npages++] = (__le64 *)sg_list;
+			sg_list[0] = old_sg_desc[i - 1];
+			old_sg_desc[i - 1].addr = cpu_to_le64(sgl_dma);
+
+			if (num_entries < (PAGE_SIZE / 16)) {
+				old_sg_desc[i - 1].length =
+					cpu_to_le32(num_entries * 16);
+				old_sg_desc[i - 1].type |=
+					NVME_SGL_FMT_LAST_SEG_DESC << 4;
+			} else {
+				old_sg_desc[i - 1].length =
+					cpu_to_le32(PAGE_SIZE);
+				old_sg_desc[i - 1].type |=
+					NVME_SGL_FMT_SEG_DESC << 4;
+			}
+			i = 1;
+		}
+
+		sg_list[i].addr = cpu_to_le64(sg_dma_address(sg));
+		sg_list[i].length = cpu_to_le32(sg_dma_len(sg));
+		sg_list[i++].type |= NVME_SGL_FMT_DATA_DESC << 4;
+		length -= sg_dma_len(sg);
+		sg = sg_next(sg);
+		num_entries--;
+		if (length <= 0)
+			break;
+	}
+	WARN_ON(num_entries > 0);
 	return true;
 }
 
@@ -626,6 +815,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	enum dma_data_direction dma_dir = rq_data_dir(req) ?
 			DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	blk_status_t ret = BLK_STS_IOERR;
+	unsigned int size = blk_rq_bytes(req);
 
 	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(q, req, iod->sg);
@@ -637,8 +827,14 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				DMA_ATTR_NO_WARN))
 		goto out;
 
-	if (!nvme_setup_prps(dev, req))
-		goto out_unmap;
+	if (sgl_threshold && size >= sgl_threshold &&
+			NVME_CTRL_SUPP_SGL(dev->ctrl.sgls) && iod->nvmeq->qid) {
+		if (!nvme_setup_sgls(dev, req, size, &cmnd->rw))
+			goto out_unmap;
+	} else {
+		if (!nvme_setup_prps(dev, req, size, &cmnd->rw))
+			goto out_unmap;
+	}
 
 	ret = BLK_STS_IOERR;
 	if (blk_integrity_rq(req)) {
@@ -656,8 +852,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 			goto out_unmap;
 	}
 
-	cmnd->rw.dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	cmnd->rw.dptr.prp2 = cpu_to_le64(iod->first_dma);
 	if (blk_integrity_rq(req))
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
 	return BLK_STS_OK;
@@ -1354,7 +1548,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
-		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
+		dev->admin_tagset.cmd_size = nvme_cmd_size(dev, false);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
 		dev->admin_tagset.driver_data = dev;
 
@@ -1863,7 +2057,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
-		dev->tagset.cmd_size = nvme_cmd_size(dev);
+		dev->tagset.cmd_size = nvme_cmd_size(dev, false);
+		if (sgl_threshold && NVME_CTRL_SUPP_SGL(dev->ctrl.sgls)) {
+			dev->tagset.cmd_size = max(dev->tagset.cmd_size,
+					nvme_cmd_size(dev, true));
+		}
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6b8ee9e..10dd44ae 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -446,6 +446,8 @@ enum nvme_opcode {
 	nvme_cmd_resv_release	= 0x15,
 };
 
+#define NVME_CTRL_SUPP_SGL(sgls)       (sgls & 1)
+
 /*
  * Descriptor subtype - lower 4 bits of nvme_(keyed_)sgl_desc identifier
  *
-- 
2.7.4
