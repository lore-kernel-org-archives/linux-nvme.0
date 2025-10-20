Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A84BCCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TyS9mFbD5TaFnKJUVfmdb06VP/2NdYpFkCQvarvtz0A=; b=PQD03TBOjn5rOhmOW8Osef895u
	aF+0NbANPoZBVLsFOh8PQl6i+znWW6x+jQXFmo4154XsbTz7No5GVT9MDpg675HQb/kU4IPGYkwQy
	gu9rVJdIXpYu+fD3LaVhJdaZDlL5HrljfVJhXUQxTpDZrCqiLVgd0by1+rbR0hqWNPJxHWWkOlKG8
	6tlScFs8fg033pSLJ09EgLVAx8LObtBZ2EgbbEEligt/lWQTKClKBtPrsQpDbBu6jvbxCsg1gPpAP
	vExOcMtsxF+LPZFGE43psbOcJt4FTLbIDFNMAMIAP3sF93oamfnUHPn153DsJojGY0qOfSs6y74kA
	eF7FIfRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtFP-0000000EOkb-2Yn6;
	Mon, 20 Oct 2025 17:00:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtFN-0000000EOkF-3jGd
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 17:00:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0FCDB620A9;
	Mon, 20 Oct 2025 17:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE23C116B1;
	Mon, 20 Oct 2025 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979636;
	bh=BU3E31v1tzbfSNTfzttdVX/zcrCKLPuxR+y2TXX47C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rH/0U3I59eKLObUfB/6bgVypw316c+hwH4CMBh1hcv8VJ8H6yogYx5PcmfmSGgOgi
	 Ltmkcm4AGogUL8Kn7lN+qoMnAVV0khCe16lfAyj5VtLIhg4AF7kgjkMYdf0In+xJtN
	 FjzaaPT6UP8pKUF3gzFYRQwRdsbnoIKIOVucWRWlZ8FiuJWAEsNsYkjGNFzLb98fwo
	 5gDKG7hf2vv3TlrJMZ7RAGgZ/35Z6E95MtxHBKoNfepTCMVRJnZGeMbWXRTDKLHg81
	 5VeMx3ZQdd9GoBV3X9ALrMqC8AR6X7Vpkk6XjJ1Ud19vG3uQbkDG2gcD841PpayDNz
	 iaTdr6vseKAww==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/2] block-dma: properly take MMIO path
Date: Mon, 20 Oct 2025 20:00:21 +0300
Message-ID: <20251020-block-with-mmio-v2-2-147e9f93d8d4@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
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

From: Leon Romanovsky <leonro@nvidia.com>

In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
MMIO addresses, which require to avoid any memory cache flushing, as
an outcome of the discussion pointed in Link tag below.

In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
treated this as regular page and relied on "struct page" DMA flow.
That flow performs CPU cache flushing, which shouldn't be done here,
and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.

Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            |  6 ++++--
 drivers/nvme/host/pci.c       | 23 +++++++++++++++++++++--
 include/linux/blk-integrity.h |  7 ++++---
 include/linux/blk-mq-dma.h    | 11 +++++++----
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 4ba7b0323da4..3ede8022b41c 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -94,7 +94,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
-			rq_dma_dir(req), 0);
+			rq_dma_dir(req), iter->attrs);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
@@ -116,7 +116,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+				vec->len, dir, iter->attrs);
 		if (error)
 			break;
 		mapped += vec->len;
@@ -184,6 +184,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		 * P2P transfers through the host bridge are treated the
 		 * same as non-P2P transfers below and during unmap.
 		 */
+		iter->attrs |= DMA_ATTR_MMIO;
+		fallthrough;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 91a8965754f0..f45d1968611d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -260,6 +260,12 @@ enum nvme_iod_flags {
 	/* single segment dma mapping */
 	IOD_SINGLE_SEGMENT	= 1U << 2,
 
+	/* Data payload contains MMIO memory */
+	IOD_DATA_MMIO		= 1U << 3,
+
+	/* Metadata contains MMIO memory */
+	IOD_META_MMIO		= 1U << 4,
+
 	/* Metadata using non-coalesced MPTR */
 	IOD_SINGLE_META_SEGMENT	= 1U << 5,
 };
@@ -733,8 +739,11 @@ static void nvme_unmap_metadata(struct request *req)
 		return;
 	}
 
+	if (iod->flags & IOD_META_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-					iod->meta_total_len)) {
+					iod->meta_total_len, attrs)) {
 		if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
 			nvme_free_sgls(req, sge, &sge[1], attrs);
 		else
@@ -762,7 +771,11 @@ static void nvme_unmap_data(struct request *req)
 		return;
 	}
 
-	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
+	if (iod->flags & IOD_DATA_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
+	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len,
+			      attrs)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
 			nvme_free_sgls(req, iod->descriptors[0],
 				       &iod->cmd.common.dptr.sgl, attrs);
@@ -1038,6 +1051,9 @@ static blk_status_t nvme_map_data(struct request *req)
 	if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
 		return iter.status;
 
+	if (iter.attrs & DMA_ATTR_MMIO)
+		iod->flags |= IOD_DATA_MMIO;
+
 	if (use_sgl == SGL_FORCED ||
 	    (use_sgl == SGL_SUPPORTED &&
 	     (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
@@ -1060,6 +1076,9 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
 						&iod->meta_dma_state, &iter))
 		return iter.status;
 
+	if (iter.attrs & DMA_ATTR_MMIO)
+		iod->flags |= IOD_META_MMIO;
+
 	if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
 		entries = 1;
 
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b659373788f6..aa42172f5cc9 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -30,10 +30,11 @@ int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 
 static inline bool blk_rq_integrity_dma_unmap(struct request *req,
 		struct device *dma_dev, struct dma_iova_state *state,
-		size_t mapped_len)
+		size_t mapped_len, unsigned int attrs)
 {
 	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA);
+			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA,
+			attrs);
 }
 
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
@@ -126,7 +127,7 @@ static inline int blk_rq_map_integrity_sg(struct request *q,
 }
 static inline bool blk_rq_integrity_dma_unmap(struct request *req,
 		struct device *dma_dev, struct dma_iova_state *state,
-		size_t mapped_len)
+		size_t mapped_len, unsigned int attrs)
 {
 	return false;
 }
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index faf4dd574c62..aab4d04e6c69 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -50,19 +50,21 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
  * @is_p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @attrs:	DMA attributes
  *
  * Returns %false if the callers need to manually unmap every DMA segment
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
+		struct dma_iova_state *state, size_t mapped_len, bool is_p2p,
+		unsigned int attrs)
 {
 	if (is_p2p)
 		return true;
 
 	if (dma_use_iova(state)) {
 		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
-				 0);
+				 attrs);
 		return true;
 	}
 
@@ -70,10 +72,11 @@ static inline bool blk_dma_unmap(struct request *req, struct device *dma_dev,
 }
 
 static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len)
+		struct dma_iova_state *state, size_t mapped_len,
+		unsigned int attrs)
 {
 	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-				req->cmd_flags & REQ_P2PDMA);
+			     req->cmd_flags & REQ_P2PDMA, attrs);
 }
 
 #endif /* BLK_MQ_DMA_H */

-- 
2.51.0


