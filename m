Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA4BCCD18D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eMRA1zPBWTSaEkfc/ivYZRufbJrExpghzoVKIA/MEJ0=; b=B1drwURETDMJ3dr6i+Bn/7Tf2p
	at8xlYo76EpGec4kSrQ22W2IlTmZL1OlHGV87rZ/ZyYhS6oD5cQ1X+0yJYzOjLx7LriLexWUMj112
	WDsB+w0kFxmLEhLz8hKaKIQIU+JmmQAwXe68/Mimer5hUFunjYZqkHEeNF1UbiSujYZlrLZ1isEve
	dgEKfaYTzs4k+k5inDFWX1um5dNOyJrmX+isY+3L695CPXW1QBW8GjDm/YegOJNYIvp5FMPSYwmCs
	hWG5zWMDLGe0bvaefdiZ1+AAf1MO/G452rTtLGlSBm4vKRHAYQP5qc8eHDS4UFdKwn2eAPLgMgkCq
	IWLzxFug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZj-0000000Dhlh-3Olz;
	Mon, 13 Oct 2025 15:35:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZj-0000000DhlJ-196e
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 15:35:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F6A661F06;
	Mon, 13 Oct 2025 15:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91320C4CEFE;
	Mon, 13 Oct 2025 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369672;
	bh=I/bIg0SylyULmnELuDpSe4YzHJvk370MpRdC3YqM1nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBPvh7xRMMewUScVOm/eXWpnWns22gL3BrIOK8cV43ptyFh2xtEGdjQSOblaApeUF
	 9/Q0qATsR2ygAJBHupUuvZlKSyDPgkyf+8gtJb3HdqYres5ibwxGiLYDFWyFT619vz
	 +UdSLgV7QTKW9+2wW8kL0qyzLnaOYasvokPH1P5bo1NNQnqIMhvjnXD7IBhylVnndc
	 kq/547Q+w+5XDkhZDh0gXOmcNBT8wiDoXEc+ZfqhY4rgK9z9kY8ul4qlx7sYJMkFpv
	 L/8BGjgERorFQpjRM7ddh1w+X5XLa9VcTUBNiLfZMkroaOLlLQnJhQROs6qVwgzAUX
	 cCn3UOGFb/+SQ==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/4] block-dma: properly take MMIO path
Date: Mon, 13 Oct 2025 18:34:11 +0300
Message-ID: <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760369219.git.leon@kernel.org>
References: <cover.1760369219.git.leon@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

Make sure that CPU is not synced and IOMMU is configured to take
MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c            | 23 ++++++++++++++++++++---
 include/linux/bio-integrity.h |  1 +
 include/linux/blk_types.h     |  2 ++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 0648bcb705ff..9495b78b6fd3 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,13 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
+	unsigned int attrs = 0;
+
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
-			rq_dma_dir(req), 0);
+			rq_dma_dir(req), attrs);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;
@@ -109,14 +114,17 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
 	unsigned int mapped = 0;
+	unsigned int attrs = 0;
 	int error;
 
 	iter->addr = state->addr;
 	iter->len = dma_iova_size(state);
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
-				vec->len, dir, 0);
+				vec->len, dir, attrs);
 		if (error)
 			break;
 		mapped += vec->len;
@@ -184,6 +192,11 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		 * P2P transfers through the host bridge are treated the
 		 * same as non-P2P transfers below and during unmap.
 		 */
+		if (iter->iter.is_integrity)
+			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
+		else
+			req->cmd_flags |= REQ_MMIO;
+		fallthrough;
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	default:
@@ -274,14 +287,18 @@ bool blk_rq_dma_unmap(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, size_t mapped_len)
 {
 	struct bio_integrity_payload *bip = bio_integrity(req->bio);
+	unsigned int attrs = 0;
 
 	if ((!bip && req->cmd_flags & REQ_P2PDMA) ||
 	    bio_integrity_flagged(req->bio, BIP_P2P_DMA))
 		return true;
 
 	if (dma_use_iova(state)) {
+		if ((!bip && req->cmd_flags & REQ_MMIO) ||
+		    bio_integrity_flagged(req->bio, BIP_MMIO))
+			attrs |= DMA_ATTR_MMIO;
 		dma_iova_destroy(dma_dev, state, mapped_len, rq_dma_dir(req),
-				 0);
+				 attrs);
 		return true;
 	}
 
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


