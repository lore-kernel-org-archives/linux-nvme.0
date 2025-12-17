Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074E5D65521
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Dec 2025 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4b/Hn1pjk+6/VOs2pPvRhPT0QhpKD+i40+gzrmSZ6d0=; b=YWtx7NCbwVMb3A32exJuMvJVgb
	5mQ6maWxQVYqsp03c9RUWTOPSWk+PaO08Dj1gMYaJaEc8qYVqN7oivTE0j6fHF1Spne28zX0vLtOU
	aRYzAA4/2gz7m5m73GqCE37oE2BN3egEsyNV1MvDGPoHOKMvuNKJ6N9lAq9c/2gLo8KIu/H8MsXou
	0EdOwMblWrwgJPZt7IaWnaLrzuQrAEApoeWKoN2x6VqGVtJZCXILwFj7xJzldqaURBtXodfuXqqoV
	Hatk9tfp9xFrSfwz089e5x5PMO6daFd8l9wV0rX06zq1NhQHO3UR/P7Kc7soKpEXDzbiIsTP3eyo2
	B0mAehOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo2Q-00000006SMW-2NhU;
	Wed, 17 Dec 2025 09:41:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo2P-00000006SLs-0Tr7
	for linux-nvme@lists.infradead.org;
	Wed, 17 Dec 2025 09:41:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CEBF60559;
	Wed, 17 Dec 2025 09:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44055C4CEFB;
	Wed, 17 Dec 2025 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765964499;
	bh=bhmUjCgORYgMLhD23jxTIthHkqK7rsSxHpOwfaP7JV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFDtizeVSbnSht7m+d06svueBoFPM0X0UQfEp/6oNW+CjVu5JBy7pAFEP6SjnSN9X
	 QmuwxSWlvF1MIskAkqrhBGRxLP5rBwK0U8FglsU/3/dE6+pfca2kahS1WgGfK9IPW6
	 BSGcjZ3+pLxrs8glq5JF/MisVi4LMa+cqebG8WgoeDGbbvhF3+fu+O8zkIoaiLUtke
	 zCJ/9Ii/AmLy45XsGbyVL9VbNdh1yVpV/HdkbztsSwtKNNOHIeZpYCkDDA6/tI0IUC
	 8YeAC3XzIoDTbQwq6CWk7Ow+E3v2mHihE7yrkDhzyTRyGl8Jsmhr9kGzfHE4RP1aE6
	 /a7hjqy64Gb2w==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 1/2] nvme-pci: Use size_t for length fields to handle larger sizes
Date: Wed, 17 Dec 2025 11:41:23 +0200
Message-ID: <20251217-nvme-phys-types-v3-1-f27fd1608f48@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
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

This patch changes the length variables from unsigned int to size_t.
Using size_t ensures that we can handle larger sizes, as size_t is
always equal to or larger than the previously used u32 type.

Originally, u32 was used because blk-mq-dma code evolved from
scatter-gather implementation, which uses unsigned int to describe length.
This change will also allow us to reuse the existing struct phys_vec in places
that don't need scatter-gather.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq-dma.c      | 8 ++++++--
 drivers/nvme/host/pci.c | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index fb018fffffdc..a2bedc8f8666 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -8,7 +8,7 @@
 
 struct phys_vec {
 	phys_addr_t	paddr;
-	u32		len;
+	size_t		len;
 };
 
 static bool __blk_map_iter_next(struct blk_map_iter *iter)
@@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 		struct phys_vec *vec)
 {
 	enum dma_data_direction dir = rq_dma_dir(req);
-	unsigned int mapped = 0;
 	unsigned int attrs = 0;
+	size_t mapped = 0;
 	int error;
 
 	iter->addr = state->addr;
@@ -297,6 +297,8 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 	blk_rq_map_iter_init(rq, &iter);
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
+
+		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
 				offset_in_page(vec.paddr));
 		nsegs++;
@@ -417,6 +419,8 @@ int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
 
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		sg = blk_next_sg(&sg, sglist);
+
+		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
 		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
 				offset_in_page(vec.paddr));
 		segments++;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..3b528369f545 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -290,14 +290,14 @@ struct nvme_iod {
 	u8 flags;
 	u8 nr_descriptors;
 
-	unsigned int total_len;
+	size_t total_len;
 	struct dma_iova_state dma_state;
 	void *descriptors[NVME_MAX_NR_DESCRIPTORS];
 	struct nvme_dma_vec *dma_vecs;
 	unsigned int nr_dma_vecs;
 
 	dma_addr_t meta_dma;
-	unsigned int meta_total_len;
+	size_t meta_total_len;
 	struct dma_iova_state meta_dma_state;
 	struct nvme_sgl_desc *meta_descriptor;
 };

-- 
2.51.1


