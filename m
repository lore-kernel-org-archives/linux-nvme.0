Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13820C83F12
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yl4rSAtWm2DohyKC+WSCG8lQ0N5zr3M1Nf2Xp8x9Q7E=; b=uV8zqJkwuyqG5kPLOscEJU7EHt
	DrwFR58FgwV6mmzjgMV96UpRaJI9aZ3LRnUghQaTjV5fXcbIRrRXMmifx2oQ8CD6QFF2RAMKyDg6i
	3bDRIJDQjcNaBAx660hJhCWAkrxwjVspUPXCl6jML9lHp7vMTWaqeamKEB+uJeVfcFNnkN6Lx0TNN
	fh/FVdKVF5pJjJmRdYzGdxR+b2afuERyA5JQN0eO0ZO0YkJzU2+60PddULB5h8OymU3Rdnot05OOK
	kVNaJ7+k+KuuNaq2n0q22KiXk6WONx6mhqCpzaxFD/IjOZOhEl2JBAHeoqA54OS5lRW50RVtT/kOy
	4sFTpvcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYlRz-00000002Tam-18oy;
	Mon, 07 Jul 2025 13:00:03 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYlKj-00000002SeG-2agf;
	Mon, 07 Jul 2025 12:52:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me
Cc: ben.copeland@linaro.org,
	leon@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping
Date: Mon,  7 Jul 2025 14:52:23 +0200
Message-ID: <20250707125223.3022531-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The current version of the blk_rq_dma_map support in nvme-pci tries to
reconstruct the DMA mappings from the on the wire descriptors if they
are needed for unmapping.  While this is not the case for the direct
mapping fast path and the IOVA path, it is needed for the non-IOVA slow
path, e.g. when using the interconnect is not dma coherent, when using
swiotlb bounce buffering, or a IOMMU mapping that can't coalesce.

While the reconstruction is easy and works fine for the SGL path, where
the on the wire representation maps 1:1 to DMA mappings, the code to
reconstruct the DMA mapping ranges from PRPs can't always work, as a
given PRP layout can come from different DMA mappings, and the current
code doesn't even always get that right.

Give up on this approach and track the actual DMA mapping when actually
needed again.

Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Reported-by: Ben Copeland <ben.copeland@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 114 ++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a7a8bdbf385..6af184f2b73b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -173,6 +173,7 @@ struct nvme_dev {
 	bool hmb;
 	struct sg_table *hmb_sgt;
 
+	mempool_t *dmavec_mempool;
 	mempool_t *iod_meta_mempool;
 
 	/* shadow doorbell buffer support: */
@@ -262,6 +263,11 @@ enum nvme_iod_flags {
 	IOD_SINGLE_SEGMENT	= 1U << 2,
 };
 
+struct nvme_dma_vec {
+	dma_addr_t addr;
+	unsigned int len;
+};
+
 /*
  * The nvme_iod describes the data in an I/O.
  */
@@ -274,6 +280,8 @@ struct nvme_iod {
 	unsigned int total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
+	struct nvme_dma_vec *dma_vecs;
+	unsigned int nr_dma_vecs;
 
 	dma_addr_t meta_dma;
 	struct sg_table meta_sgt;
@@ -674,44 +682,12 @@ static void nvme_free_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
-	struct device *dma_dev = nvmeq->dev->dev;
-	enum dma_data_direction dir = rq_dma_dir(req);
-	int length = iod->total_len;
-	dma_addr_t dma_addr;
-	int i, desc;
-	__le64 *prp_list;
-	u32 dma_len;
-
-	dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp1);
-	dma_len = min_t(u32, length,
-		NVME_CTRL_PAGE_SIZE - (dma_addr & (NVME_CTRL_PAGE_SIZE - 1)));
-	length -= dma_len;
-	if (!length) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		return;
-	}
-
-	if (length <= NVME_CTRL_PAGE_SIZE) {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		dma_addr = le64_to_cpu(iod->cmd.common.dptr.prp2);
-		dma_unmap_page(dma_dev, dma_addr, length, dir);
-		return;
-	}
-
-	i = 0;
-	desc = 0;
-	prp_list = iod->descriptors[desc];
-	do {
-		dma_unmap_page(dma_dev, dma_addr, dma_len, dir);
-		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
-			prp_list = iod->descriptors[++desc];
-			i = 0;
-		}
+	unsigned int i;
 
-		dma_addr = le64_to_cpu(prp_list[i++]);
-		dma_len = min(length, NVME_CTRL_PAGE_SIZE);
-		length -= dma_len;
-	} while (length);
+	for (i = 0; i < iod->nr_dma_vecs; i++)
+		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+				iod->dma_vecs[i].len, rq_dma_dir(req));
+	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
 static void nvme_free_sgls(struct request *req)
@@ -760,6 +736,23 @@ static void nvme_unmap_data(struct request *req)
 		nvme_free_descriptors(req);
 }
 
+static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
+		struct blk_dma_iter *iter)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if (iter->len)
+		return true;
+	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
+		return false;
+	if (dma_need_unmap(dma_dev)) {
+		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
+		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
+		iod->nr_dma_vecs++;
+	}
+	return true;
+}
+
 static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -770,6 +763,16 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
+	if (dma_need_unmap(nvmeq->dev->dev)) {
+		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
+				GFP_ATOMIC);
+		if (!iod->dma_vecs)
+			return BLK_STS_RESOURCE;
+		iod->dma_vecs[0].addr = iter->addr;
+		iod->dma_vecs[0].len = iter->len;
+		iod->nr_dma_vecs = 1;
+	}
+
 	/*
 	 * PRP1 always points to the start of the DMA transfers.
 	 *
@@ -786,13 +789,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	if (!length)
 		goto done;
 
-	if (!iter->len) {
-		if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
-				&iod->dma_state, iter)) {
-			if (WARN_ON_ONCE(!iter->status))
-				goto bad_sgl;
-			goto done;
-		}
+	if (!nvme_pci_prp_iter_next(req, nvmeq->dev->dev, iter)) {
+		if (WARN_ON_ONCE(!iter->status))
+			goto bad_sgl;
+		goto done;
 	}
 
 	/*
@@ -831,13 +831,10 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 		if (!length)
 			break;
 
-		if (iter->len == 0) {
-			if (!blk_rq_dma_map_iter_next(req, nvmeq->dev->dev,
-					&iod->dma_state, iter)) {
-				if (WARN_ON_ONCE(!iter->status))
-					goto bad_sgl;
-				goto done;
-			}
+		if (!nvme_pci_prp_iter_next(req, nvmeq->dev->dev, iter)) {
+			if (WARN_ON_ONCE(!iter->status))
+				goto bad_sgl;
+			goto done;
 		}
 
 		/*
@@ -3025,14 +3022,25 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
 {
 	size_t meta_size = sizeof(struct scatterlist) * (NVME_MAX_META_SEGS + 1);
+	size_t alloc_size = sizeof(struct nvme_dma_vec) * NVME_MAX_SEGS;
+
+	dev->dmavec_mempool = mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)alloc_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->dmavec_mempool)
+		return -ENOMEM;
 
 	dev->iod_meta_mempool = mempool_create_node(1,
 			mempool_kmalloc, mempool_kfree,
 			(void *)meta_size, GFP_KERNEL,
 			dev_to_node(dev->dev));
 	if (!dev->iod_meta_mempool)
-		return -ENOMEM;
+		goto free;
 	return 0;
+free:
+	mempool_destroy(dev->dmavec_mempool);
+	return -ENOMEM;
 }
 
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3477,6 +3485,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
 out_release_iod_mempool:
+	mempool_destroy(dev->dmavec_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
 out_dev_unmap:
 	nvme_dev_unmap(dev);
@@ -3540,6 +3549,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
 	nvme_free_queues(dev, 0);
+	mempool_destroy(dev->dmavec_mempool);
 	mempool_destroy(dev->iod_meta_mempool);
 	nvme_release_descriptor_pools(dev);
 	nvme_dev_unmap(dev);
-- 
2.47.2


