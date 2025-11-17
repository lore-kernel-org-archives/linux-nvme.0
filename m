Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BD1CEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=26o6O0PQIWPyg5AIQlE6tDs+xKusexKfz16vIGa3Dgg=; b=X14fNu2GfFiD/9ql84lNBg9VgM
	fRdRfWDPoLVE6v5eEGUMTDB2tnJene+/1wPypLeRRYoon/0s8v8MwxPMBKo7LIZXgAIs0vI03bar7
	1o3MqT6NN+b1FD4eegOm6oysDTMqcF5btHEwVR2tRo4KAy9C4AKlTW3q/KNb6+XNX9C/Oz+D0BnD5
	W2ElKkay0eGGeTaCKRVGWtQXBj/8DEgCo3xPDb+KWGf8NQ3sl52GmAOYn213+iQr6akEYcfQcHDO8
	A9LLpikJsEkNXEwHQwTtz0TU1/SYlild9bEUCiyWxg2n8JvyHA54JBabPNEVIrdTBSzsrdQ2gbKG1
	5ss/EYRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4ob-0000000GkBX-2srT;
	Mon, 17 Nov 2025 19:23:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4oa-0000000GkB6-2xmE
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 19:23:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 24B4160252;
	Mon, 17 Nov 2025 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292AFC19423;
	Mon, 17 Nov 2025 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407383;
	bh=kwXV7VvQqsHtm6PcemDwoalXBnMmZg+fzEz3ion/gBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6FNuLzAZQmsgrSdPZjmkHRxOlSva4JQywyXwXeh348MhoDN0kp13lgX1cMKK5NJy
	 B+M3Mrt6bc35Mz+xP/Gv2reifMcyE/efTRXHU6U8PMmawDlPY7XbrYzUqGga8S5Sb0
	 n8hpDzOGCmQQ6d0qjHIDXjF/e/ltqL+5ElzClrmc6o56jNZcCU3ScQdVU9pRaoGHfu
	 gQo185gL/uh6LpbxssGYXcQL1YzWXiE06v+O3VBf9fqLujm2T5D2lDmoavwESufSQv
	 drBuZ6/zVf1xi+xEhmqj3IMzkjctL1jaoUdnyFUzhWomOZLtIAIfHhAjotPZI5L7B4
	 lB+8nHBUbtNyw==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle larger sizes
Date: Mon, 17 Nov 2025 21:22:43 +0200
Message-ID: <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
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
index e9108ccaf4b0..e7d9b54c3eed 100644
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
@@ -296,6 +296,8 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 	blk_rq_map_iter_init(rq, &iter);
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
+
+		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
 				offset_in_page(vec.paddr));
 		nsegs++;
@@ -416,6 +418,8 @@ int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
 
 	while (blk_map_iter_next(rq, &iter, &vec)) {
 		sg = blk_next_sg(&sg, sglist);
+
+		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));
 		sg_set_page(sg, phys_to_page(vec.paddr), vec.len,
 				offset_in_page(vec.paddr));
 		segments++;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..b61ec62b0ec6 100644
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


