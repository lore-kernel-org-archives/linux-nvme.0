Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D356CCD184
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 05:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZ/b+vkbGjWwABTXhiFj3nYmhRJqOLZSfTd2odptgS0=; b=gmfUEL7DJvlkwM+nJtmVpEpVah
	EKwgfQXtNrq6Nd28N/Vw/tMaff47HQMoQ5Xe827pJyuzhldU/98263Y2G4r3NFc+cpZi1M0ZXCOax
	wmZoHy4ASXckpstY2WWh0xWlmqQf6CkQVOS0kBJzmaFI/fBHEtAmc2cXQlCrpu+U/nubzGlulG8KG
	zNArby94/SrbdlXtzE71XizElxb9sqQPfe2ZKUvgJh99EIeQNLwBct84oju/wP4LmG18jHS8FCJjU
	VCWghtA7XGQ5fCm5Iez+arlmsiJvYiJ1lN4iThB0mpEgJmjIxY1BBItLZN5/P1Jn1MZqeHKPhyJtS
	2n/qj3oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4i-00000006cyF-2rfA;
	Fri, 17 Oct 2025 05:32:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4g-00000006cx3-3CHh
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 05:32:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BF04641E2;
	Fri, 17 Oct 2025 05:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D1AC4CEE7;
	Fri, 17 Oct 2025 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679142;
	bh=+4Tk3wM6BSkHKqGN1nHxd6sRm5b99SgBMl22sbkCveo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tk1dafpyL1RMMBd6Ph1HYZxwP+qDCKOxCLp7P/HuNWsWsa/1m7wol3XDVAqLQPPZH
	 EBHuvQ0Z3Q9ltRVYXN53ZDnAXDttR9HpPSEsHas5SSUCZ28nm2n4wH7IN34WOvebtm
	 39nDTFr25MtWNaxk2z/rGmIlyKnCOU1Fbzkey3OAeVsq6WQIeaaq0vRVQvBo8gfFO7
	 bbBry4lOFz4HBUV2eNU/lH3PeXwmUavOPfqkTj1yW4DB8piFLU1D8gzcLEhjDdxBoa
	 qTDm9im5eWpHrcv5HehK6MAEdzzaNfdQff37cC9LwjEpjwB/XY2n/EfV0E/bW2rXps
	 NzjVs0apSQyRw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] block-dma: properly take MMIO path
Date: Fri, 17 Oct 2025 08:32:00 +0300
Message-ID: <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
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

Make sure that CPU is not synced and IOMMU is configured to take
MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            | 10 ++++++++--
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h |  3 ++-
 include/linux/blk-mq-dma.h    | 14 +++++++++++---
 include/linux/blk_types.h     |  2 ++
 5 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 4ba7b0323da4..e1f460da95d7 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -94,7 +94,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
-			rq_dma_dir(req), 0);
+			rq_dma_dir(req), iter->iter.attrs);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
@@ -116,7 +116,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+				vec->len, dir, iter->iter.attrs);
 		if (error)
 			break;
 		mapped += vec->len;
@@ -184,6 +184,12 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		 * P2P transfers through the host bridge are treated the
 		 * same as non-P2P transfers below and during unmap.
 		 */
+		if (iter->iter.is_integrity)
+			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
+		else
+			req->cmd_flags |= REQ_MMIO;
+		iter->iter.attrs |= DMA_ATTR_MMIO;
+		fallthrough;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 851254f36eb3..b77b2cfb7b0f 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -14,6 +14,7 @@ enum bip_flags {
 	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
 	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
 	BIP_P2P_DMA		= 1 << 8, /* using P2P address */
+	BIP_MMIO		= 1 << 9, /* contains MMIO memory */
 };
 
 struct bio_integrity_payload {
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b659373788f6..34648d6c14d7 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -33,7 +33,8 @@ static inline bool blk_rq_integrity_dma_unmap(struct request *req,
 		size_t mapped_len)
 {
 	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA);
+			bio_integrity(req->bio)->bip_flags & BIP_P2P_DMA,
+			bio_integrity(req->bio)->bip_flags & BIP_MMIO);
 }
 
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
diff --git a/include/linux/blk-mq-dma.h b/include/linux/blk-mq-dma.h
index 51829958d872..916ca1deaf2c 100644
--- a/include/linux/blk-mq-dma.h
+++ b/include/linux/blk-mq-dma.h
@@ -10,6 +10,7 @@ struct blk_map_iter {
 	struct bio			*bio;
 	struct bio_vec			*bvecs;
 	bool				is_integrity;
+	unsigned int			attrs;
 };
 
 struct blk_dma_iter {
@@ -49,19 +50,25 @@ static inline bool blk_rq_dma_map_coalesce(struct dma_iova_state *state)
  * @state:	DMA IOVA state
  * @mapped_len: number of bytes to unmap
  * @is_p2p:	true if mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @is_mmio:	true if mapped with PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
  *
  * Returns %false if the callers need to manually unmap every DMA segment
  * mapped using @iter or %true if no work is left to be done.
  */
 static inline bool blk_dma_unmap(struct request *req, struct device *dma_dev,
-		struct dma_iova_state *state, size_t mapped_len, bool is_p2p)
+		struct dma_iova_state *state, size_t mapped_len, bool is_p2p,
+		bool is_mmio)
 {
 	if (is_p2p)
 		return true;
 
 	if (dma_use_iova(state)) {
+		unsigned int attrs = 0;
+
+		if (is_mmio)
+			attrs = DMA_ATTR_MMIO;
 		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
-				 0);
+				 attrs);
 		return true;
 	}
 
@@ -72,7 +79,8 @@ static inline bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, size_t mapped_len)
 {
 	return blk_dma_unmap(req, dma_dev, state, mapped_len,
-				req->cmd_flags & REQ_P2PDMA);
+			     req->cmd_flags & REQ_P2PDMA,
+			     req->cmd_flags & REQ_MMIO);
 }
 
 #endif /* BLK_MQ_DMA_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8e8d1cc8b06c..9affa3b2d047 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -382,6 +382,7 @@ enum req_flag_bits {
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 	__REQ_ATOMIC,		/* for atomic write operations */
 	__REQ_P2PDMA,		/* contains P2P DMA pages */
+	__REQ_MMIO,		/* contains MMIO memory */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -415,6 +416,7 @@ enum req_flag_bits {
 #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
 #define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
 #define REQ_P2PDMA	(__force blk_opf_t)(1ULL << __REQ_P2PDMA)
+#define REQ_MMIO	(__force blk_opf_t)(1ULL << __REQ_MMIO)
 
 #define REQ_NOUNMAP	(__force blk_opf_t)(1ULL << __REQ_NOUNMAP)
 

-- 
2.51.0


