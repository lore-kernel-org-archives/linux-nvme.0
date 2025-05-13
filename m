Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C1C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qV/xTDjnCIxiJ4Hi/4r+Upq26KGB12urGCJbBIVkNVo=; b=Y8PHvB15t5FeY1nz8Hbn4P0BRg
	Od/g3r7+bGfIcSCkh6nvXEyxZTYCxs5PZ084b6pnB7JqQGk69mtb97xiWFlhJOmKk9mHwLLc+ZoEB
	XQpTpjeZE0Tkj+OZ1tZTcjM/2JHThkGPyhkAk8Q1PPtTr8mbkngi4ObC6Ha0giEkRu2s2NMFHzMc7
	eUhC27WoQQIWizx9IBZwDT4VTVvXgPXRL2ASZpAuYaiRn7FB2uZWZiL6REgyTdGxXUjhvteCQIXlX
	8WGxBPnt0gzma2mB3uIiYwR72kxuyBU67W4dfN0atJC1ghxgVlEbfJ/dWuuXU+2nC9v+6V1E8Gb6S
	5ZqEng9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd6-0000000BZ3x-3DYr;
	Tue, 13 May 2025 07:00:44 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd4-0000000BZ1U-4626;
	Tue, 13 May 2025 07:00:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool allocations
Date: Tue, 13 May 2025 09:00:21 +0200
Message-ID: <20250513070025.830930-6-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513070025.830930-1-hch@lst.de>
References: <20250513070025.830930-1-hch@lst.de>
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

Add a separate flag to encode that the transfer is using the small
page sized pool, and use a normal 0..n count for the number of
descriptors.

Contains improvements and suggestions from Kanchan Joshi
<joshi.k@samsung.com> and Leon Romanovsky <leonro@nvidia.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 82 ++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 773a2e625657..16e2ce25da83 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -229,6 +229,9 @@ struct nvme_queue {
 enum nvme_iod_flags {
 	/* this command has been aborted by the timeout handler */
 	IOD_ABORTED		= 1U << 0,
+
+	/* uses the small descriptor pool */
+	IOD_SMALL_DESCRIPTOR		= 1U << 1,
 };
 
 /*
@@ -238,7 +241,7 @@ struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
 	u8 flags;
-	s8 nr_descriptors;
+	u8 nr_descriptors;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
 	dma_addr_t first_dma;
 	dma_addr_t meta_dma;
@@ -589,13 +592,27 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 	return true;
 }
 
-static void nvme_free_prps(struct nvme_queue *nvmeq, struct request *req)
+static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
+		struct nvme_iod *iod)
+{
+	if (iod->flags & IOD_SMALL_DESCRIPTOR)
+		return nvmeq->descriptor_pools.small;
+	return nvmeq->descriptor_pools.large;
+}
+
+static void nvme_free_descriptors(struct nvme_queue *nvmeq, struct request *req)
 {
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	dma_addr_t dma_addr = iod->first_dma;
 	int i;
 
+	if (iod->nr_descriptors == 1) {
+		dma_pool_free(nvme_dma_pool(nvmeq, iod), iod->descriptors[0],
+				dma_addr);
+		return;
+	}
+
 	for (i = 0; i < iod->nr_descriptors; i++) {
 		__le64 *prp_list = iod->descriptors[i];
 		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
@@ -620,15 +637,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	WARN_ON_ONCE(!iod->sgt.nents);
 
 	dma_unmap_sgtable(dev->dev, &iod->sgt, rq_dma_dir(req), 0);
-
-	if (iod->nr_descriptors == 0)
-		dma_pool_free(nvmeq->descriptor_pools.small,
-				iod->descriptors[0], iod->first_dma);
-	else if (iod->nr_descriptors == 1)
-		dma_pool_free(nvmeq->descriptor_pools.large,
-				iod->descriptors[0], iod->first_dma);
-	else
-		nvme_free_prps(nvmeq, req);
+	nvme_free_descriptors(nvmeq, req);
 	mempool_free(iod->sgt.sgl, dev->iod_mempool);
 }
 
@@ -650,7 +659,6 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 		struct request *req, struct nvme_rw_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct dma_pool *pool;
 	int length = blk_rq_payload_bytes(req);
 	struct scatterlist *sg = iod->sgt.sgl;
 	int dma_len = sg_dma_len(sg);
@@ -658,7 +666,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 	int offset = dma_addr & (NVME_CTRL_PAGE_SIZE - 1);
 	__le64 *prp_list;
 	dma_addr_t prp_dma;
-	int nprps, i;
+	int i;
 
 	length -= (NVME_CTRL_PAGE_SIZE - offset);
 	if (length <= 0) {
@@ -680,27 +688,23 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 		goto done;
 	}
 
-	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
-	if (nprps <= (256 / 8)) {
-		pool = nvmeq->descriptor_pools.small;
-		iod->nr_descriptors = 0;
-	} else {
-		pool = nvmeq->descriptor_pools.large;
-		iod->nr_descriptors = 1;
-	}
+	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
+	    256 / sizeof(__le64))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
 
-	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
-	if (!prp_list) {
-		iod->nr_descriptors = -1;
+	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+			&prp_dma);
+	if (!prp_list)
 		return BLK_STS_RESOURCE;
-	}
-	iod->descriptors[0] = prp_list;
+	iod->descriptors[iod->nr_descriptors++] = prp_list;
 	iod->first_dma = prp_dma;
 	i = 0;
 	for (;;) {
 		if (i == NVME_CTRL_PAGE_SIZE >> 3) {
 			__le64 *old_prp_list = prp_list;
-			prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
+
+			prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod),
+					GFP_ATOMIC, &prp_dma);
 			if (!prp_list)
 				goto free_prps;
 			iod->descriptors[iod->nr_descriptors++] = prp_list;
@@ -727,7 +731,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
 	return BLK_STS_OK;
 free_prps:
-	nvme_free_prps(nvmeq, req);
+	nvme_free_descriptors(nvmeq, req);
 	return BLK_STS_RESOURCE;
 bad_sgl:
 	WARN(DO_ONCE(nvme_print_sgl, iod->sgt.sgl, iod->sgt.nents),
@@ -756,7 +760,6 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 		struct request *req, struct nvme_rw_command *cmd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct dma_pool *pool;
 	struct nvme_sgl_desc *sg_list;
 	struct scatterlist *sg = iod->sgt.sgl;
 	unsigned int entries = iod->sgt.nents;
@@ -771,21 +774,14 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 		return BLK_STS_OK;
 	}
 
-	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
-		pool = nvmeq->descriptor_pools.small;
-		iod->nr_descriptors = 0;
-	} else {
-		pool = nvmeq->descriptor_pools.large;
-		iod->nr_descriptors = 1;
-	}
+	if (entries <= 256 / sizeof(*sg_list))
+		iod->flags |= IOD_SMALL_DESCRIPTOR;
 
-	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
-	if (!sg_list) {
-		iod->nr_descriptors = -1;
+	sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+			&sgl_dma);
+	if (!sg_list)
 		return BLK_STS_RESOURCE;
-	}
-
-	iod->descriptors[0] = sg_list;
+	iod->descriptors[iod->nr_descriptors++] = sg_list;
 	iod->first_dma = sgl_dma;
 
 	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma, entries);
@@ -982,7 +978,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	blk_status_t ret;
 
 	iod->flags = 0;
-	iod->nr_descriptors = -1;
+	iod->nr_descriptors = 0;
 	iod->sgt.nents = 0;
 	iod->meta_sgt.nents = 0;
 
-- 
2.47.2


