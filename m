From: mundu2510@gmail.com (Mundu)
Date: Tue, 15 Jul 2014 23:41:46 +0530
Subject: [PATCH 1/1] Replace the dma_alloc_coherent() with
 dma_zalloc_coherent()
Message-ID: <1405447906-7220-1-git-send-email-mundu2510@gmail.com>

Signed-off-by: Mundu <mundu2510 at gmail.com>

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..63f3e19 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1295,7 +1295,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
+	nvmeq->sq_cmds = dma_zalloc_coherent(dmadev, SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		goto free_cqdma;
@@ -1356,7 +1356,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset(nvmeq->cmdid_data, 0, extra);
-	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_cancel_ios(nvmeq, false);
 	nvmeq->q_suspended = 0;
 	dev->online_queues++;
@@ -1652,7 +1651,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			goto unmap;
 		}
 
-		meta_mem = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
+		meta_mem = dma_zalloc_coherent(&dev->pci_dev->dev, meta_len,
 						&meta_dma_addr, GFP_KERNEL);
 		if (!meta_mem) {
 			status = -ENOMEM;
@@ -2293,7 +2292,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dma_addr_t dma_addr;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
-	mem = dma_alloc_coherent(&pdev->dev, 8192, &dma_addr, GFP_KERNEL);
+	mem = dma_zalloc_coherent(&pdev->dev, 8192, &dma_addr, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
 
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index a4cd6d6..ce08fed 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -682,7 +682,7 @@ static int nvme_trans_standard_inquiry_page(struct nvme_ns *ns,
 	u8 cmdque = 0x01 << 1;
 	u8 fw_offset = sizeof(dev->firmware_rev);
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 				&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -786,7 +786,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int xfer_len;
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -868,7 +868,7 @@ static int nvme_trans_ext_inq_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out_mem;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1004,7 +1004,7 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 		goto out_mem;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev,
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev,
 					sizeof(struct nvme_smart_log),
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
@@ -1072,7 +1072,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out_mem;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev,
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev,
 					sizeof(struct nvme_smart_log),
 					&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
@@ -1175,7 +1175,7 @@ static int nvme_trans_fill_blk_desc(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	else if (llbaa > 0 && len < MODE_PAGE_LLBAA_BLK_DES_LEN)
 		return SNTI_INTERNAL_ERROR;
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -1460,7 +1460,7 @@ static int nvme_trans_power_state(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	unsigned ps_desired = 0;
 
 	/* NVMe Controller Identify */
-	mem = dma_alloc_coherent(&dev->pci_dev->dev,
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev,
 				sizeof(struct nvme_id_ctrl),
 				&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
@@ -1786,7 +1786,7 @@ static int nvme_trans_fmt_set_blk_size_count(struct nvme_ns *ns,
 	 */
 
 	if (ns->mode_select_num_blocks == 0 || ns->mode_select_block_len == 0) {
-		mem = dma_alloc_coherent(&dev->pci_dev->dev,
+		mem = dma_zalloc_coherent(&dev->pci_dev->dev,
 			sizeof(struct nvme_id_ns), &dma_addr, GFP_KERNEL);
 		if (mem == NULL) {
 			res = -ENOMEM;
@@ -1894,7 +1894,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	struct nvme_command c;
 
 	/* Loop thru LBAF's in id_ns to match reqd lbaf, put in cdw10 */
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -2447,7 +2447,7 @@ static int nvme_trans_read_capacity(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		resp_size = READ_CAP_16_RESP_SIZE;
 	}
 
-	mem = dma_alloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
+	mem = dma_zalloc_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns),
 							&dma_addr, GFP_KERNEL);
 	if (mem == NULL) {
 		res = -ENOMEM;
@@ -2510,7 +2510,7 @@ static int nvme_trans_report_luns(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out;
 	} else {
 		/* NVMe Controller Identify */
-		mem = dma_alloc_coherent(&dev->pci_dev->dev,
+		mem = dma_zalloc_coherent(&dev->pci_dev->dev,
 					sizeof(struct nvme_id_ctrl),
 					&dma_addr, GFP_KERNEL);
 		if (mem == NULL) {
@@ -2876,7 +2876,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		goto out;
 	}
 
-	range = dma_alloc_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
+	range = dma_zalloc_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
 							&dma_addr, GFP_KERNEL);
 	if (!range)
 		goto out;
@@ -2884,7 +2884,6 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	for (i = 0; i < ndesc; i++) {
 		range[i].nlb = cpu_to_le32(be32_to_cpu(plist->desc[i].nlb));
 		range[i].slba = cpu_to_le64(be64_to_cpu(plist->desc[i].slba));
-		range[i].cattr = 0;
 	}
 
 	memset(&c, 0, sizeof(c));
-- 
1.9.1
