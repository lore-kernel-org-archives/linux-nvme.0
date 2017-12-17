From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 18 Dec 2017 00:47:22 +0900
Subject: [PATCH] nvme-pci: move use_sgl initialization to nvme_init_iod()
Message-ID: <1513525642-23481-1-git-send-email-minwoo.im.dev@gmail.com>

A flag "use_sgl" of "struct nvme_iod" has been used in nvme_init_iod()
without being set to any value. It seems like "use_sgl" has been set
in either nvme_pci_setup_prps() or nvme_pci_setup_sgls() which occur
later than nvme_init_iod().

Make "iod->use_sgl" being set in a proper place, nvme_init_iod().
Also move nvme_pci_use_sgls() up above nvme_init_iod() to make it
possible to be called by nvme_init_iod().

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 35331fa..0a60e50 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -448,6 +448,23 @@ static void **nvme_pci_iod_list(struct request *req)
 	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
 }
 
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
 static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(rq);
@@ -455,14 +472,17 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	unsigned int size = blk_rq_payload_bytes(rq);
 
 	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
+		bool use_sgl = nvme_pci_use_sgls(dev, rq);
 		size_t alloc_size = nvme_pci_iod_alloc_size(dev, size, nseg,
-				iod->use_sgl);
+				use_sgl);
 
 		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
 		if (!iod->sg)
 			return BLK_STS_RESOURCE;
+		iod->use_sgl = use_sgl;
 	} else {
 		iod->sg = iod->inline_sg;
+		iod->use_sgl = false;
 	}
 
 	iod->aborted = 0;
@@ -604,8 +624,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	dma_addr_t prp_dma;
 	int nprps, i;
 
-	iod->use_sgl = false;
-
 	length -= (page_size - offset);
 	if (length <= 0) {
 		iod->first_dma = 0;
@@ -715,8 +733,6 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	int entries = iod->nents, i = 0;
 	dma_addr_t sgl_dma;
 
-	iod->use_sgl = true;
-
 	/* setting the transfer type as SGL */
 	cmd->flags = NVME_CMD_SGL_METABUF;
 
@@ -770,23 +786,6 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
-static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
-{
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	unsigned int avg_seg_size;
-
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
-			blk_rq_nr_phys_segments(req));
-
-	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
-		return false;
-	if (!iod->nvmeq->qid)
-		return false;
-	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return false;
-	return true;
-}
-
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -806,7 +805,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				DMA_ATTR_NO_WARN))
 		goto out;
 
-	if (nvme_pci_use_sgls(dev, req))
+	if (iod->use_sgl)
 		ret = nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret = nvme_pci_setup_prps(dev, req, &cmnd->rw);
-- 
2.7.4
