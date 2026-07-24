Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A074AC531F9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 12:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUOvzC7S83CbLQhvj3xiT7aiXAMNmxd+qik7px81Tkg=; b=COPp0/SMoWx3iZZysKeGa07Au3
	Glp352HMDZ+Boox3HtWvpDmc0AXEcpD7i8jnFIAumdacVnCBaz7KY377ohs+u8HyH1zBiuoR80yaa
	OSbeUmly8hqYdS26B4/GL3zNWPo1P/yx3pSPtaOE5mYIvDDgWgvJNtLmwxkwr6i5hPBWib8fzFjRf
	2dknHi/EkkkHZm7BV5AwAh7Ps7BROVNn/LpKrjdgMfBKI07yhXif10K7ElshLzwt9fTWAvocejRRQ
	sGS8rAPdeeM8zmAdY8CUI3CKF/PTYjKzkLDPYerYTkpSfkMNCt0uhB8LHh6LXvx0hFCoVksI5uqQN
	K37e2sVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoY-0000000GFCb-1lnO;
	Fri, 24 Jul 2026 11:11:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoU-0000000GF7U-1vLt
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3ECC143C96;
	Fri, 24 Jul 2026 11:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 942FDC4FF74;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=BfgjSIHRduyFlHDKxF9kQTlbbOfb/JFgHX9Y+cGfFGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NXPxkQCrhBD/e1QNwcWn4hsJF91FL4JYL+cpzPBPgeE00S8tQsf2Zq1UMwAImb2pA
	 YTWa8C6rwuhffsGDPETXS8xGowJEJTOvF5SM02Hz0wbxGjNd89EULJ+GwPSx6DK+UN
	 ReGzdDyxgHC7CWrfJTd/bSQq/La/8jcB7j6WKiLGCL29Yia6BzoDiidjE7nIIU+l/0
	 a+j7KIZ4aa4mb9rRyiXVTiLBgiqsyXm7Ak+D09tA0TtQVyzZYsv1DsB0NorVH+minP
	 ti09R39B0MKMp97PU3kqn7g/sHa4/hEvvyGTnDtDoY60eVqK5bYyzJ3UZpYb8e/4/Q
	 Xjjqs/F0Q70dQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6EC53215;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:10:59 +0200
Subject: [PATCH RFC v2 05/14] nvme: Allocate CDQ backing memory from
 coherent DMA chunks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-5-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7457;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BfgjSIHRduyFlHDKxF9kQTlbbOfb/JFgHX9Y+cGfFGE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSFsugttGswnUgb/AhoTjEnse+H5+d9fv0
 cS+o/S1+KIeu4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0hbAAoJELqXzVK3
 lkFPvCsL/iUj4uWfffVoADCmyBI0xahIlL6NWoEzkz0+bptUmYTkBP7u8eai+BVU7cAHVpHtBiU
 ScGgsyrsJBNQctK6/3cKCUgjohoTxhZNErEgccM9GmiMqhXRJvQl0sYxlNrb5F+YJLHnOZlxRWE
 SLNcZSQ7eKWF2TcXt+4UYxh2ZEaoobND5ez+vMhfa/Vc97FNtH9OB+/CPohudh8NclBIaUNb+Uh
 K/a9bglCLCg4KBhMZ3tY9oCckhZnvMXRN4SGLTmKYXVvk4F1XPwr9NjkADD/QQJTLVl60uiJdkJ
 I/6a6hoH1ty/ZXXS9ybob6p0mDB5TUfw9/wadwmvIq3YWtY9Og42uw8vnZj1rhZwy9rc3ku9g/u
 IcOqJOb0zFpF0Yv6o9vcJVG0jV5iYQG/B+Dg/+LHucAa1LYNG8sPe6+Rpw8vEo5Yu+1KQ+Y2dHa
 rqaQ9wtybLXQvqZ7lWwNjgl4HLZ9svXa+vARcMyP8V8A4634BdTp+fNXgCt/FMeFAmTt0uYZ718
 nQ=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Back a Controller Data Queue with a set of dma_alloc_coherent() chunks.
This mem is portable to non-coherent archs and stays put for the life of
the CDQ. Splitting it into fixed-size chunks avoids the MAX_PAGE_ORDER
limit on the no-IOMMU path. A single chunk is handed over as PC_CONT;
multiple chunks are stitched together with a chained PRP list
(PC_DISCONT).

Since it is easier to handle 1 chunk (no prp list), try
dma_alloc_coherent with the totality of the CDQ size and fallback on the
chunk allocation only when it was not possible to have a contiguous
allocation. Build the prp list only when there is more than one chunk of
backing memory.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/cdq.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/cdq.h |  27 ++++++++
 2 files changed, 191 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/cdq.c b/drivers/nvme/host/cdq.c
index 0e9ac88a054f6630c1eea73ae4140f124b6bb31f..73dd6af42055687bec62ad0350c67736c9c047c2 100644
--- a/drivers/nvme/host/cdq.c
+++ b/drivers/nvme/host/cdq.c
@@ -6,6 +6,166 @@
 #include "nvme.h"
 #include "cdq.h"
 
+static inline void nvme_free_cdqmem_chunks(struct cdq_nvme_queue *cdq)
+{
+	struct device *dev = cdq->ctrl->dev;
+	unsigned int i;
+
+	if (!cdq->chunks)
+		return;
+	for (i = 0; i < cdq->nr_chunks; i++) {
+		if (cdq->chunks[i].vaddr)
+			dma_free_coherent(dev, cdq->chunks[i].size,
+					  cdq->chunks[i].vaddr,
+					  cdq->chunks[i].dma_addr);
+	}
+	kfree(cdq->chunks);
+	cdq->chunks = NULL;
+	cdq->nr_chunks = 0;
+}
+
+static inline int nvme_alloc_cdqmem_chunks(struct cdq_nvme_queue *cdq)
+{
+	struct device *dev = cdq->ctrl->dev;
+	unsigned int i, nr = 1;
+
+	/*
+	 * Try to get a single pointer to the whole cdq, it will take
+	 * the iommu path within the dma_alloc_coherent call
+	 */
+	cdq->chunks = kcalloc(nr, sizeof(*cdq->chunks), GFP_KERNEL);
+	if (!cdq->chunks)
+		return -ENOMEM;
+
+	cdq->chunks[0].vaddr = dma_alloc_coherent(dev, cdq->size_nbyte,
+			&cdq->chunks[0].dma_addr, GFP_KERNEL);
+	if (cdq->chunks[0].vaddr)
+		goto out;
+
+	/* Fall back to allocating several chunks */
+	nr = DIV_ROUND_UP(cdq->size_nbyte, NVME_CDQ_CHUNK_SIZE);
+
+	cdq->chunks = krealloc_array(cdq->chunks, nr, sizeof(*cdq->chunks), GFP_KERNEL);
+	if (!cdq->chunks)
+		return -ENOMEM;
+
+	for (i = 0; i < nr; i++) {
+		cdq->chunks[i].vaddr = dma_alloc_coherent(dev,
+				NVME_CDQ_CHUNK_SIZE, &cdq->chunks[i].dma_addr,
+				GFP_KERNEL);
+		if (!cdq->chunks[i].vaddr) {
+			nvme_free_cdqmem_chunks(cdq);
+			return -ENOMEM;
+		}
+		cdq->chunks[i].size = NVME_CDQ_CHUNK_SIZE;
+	}
+
+out:
+	cdq->nr_chunks = nr;
+	return 0;
+}
+
+static inline void nvme_free_cdqmem_prp_lists(struct cdq_nvme_queue *cdq)
+{
+	struct device *dev = cdq->ctrl->dev;
+	unsigned int prp_idx;
+
+	for (prp_idx = 0; prp_idx < cdq->nr_prp_lists; prp_idx++)
+		dma_free_coherent(dev, PAGE_SIZE, cdq->prp_lists[prp_idx],
+				  cdq->prp_lists_dma[prp_idx]);
+	cdq->nr_prp_lists = 0;
+}
+
+static inline dma_addr_t nvme_get_cdq_pagedma(struct cdq_nvme_queue *cdq,
+					      unsigned int page_idx)
+{
+	return cdq->chunks[page_idx / NVME_CDQ_PAGES_PER_CHUNK].dma_addr +
+		(page_idx % NVME_CDQ_PAGES_PER_CHUNK) * NVME_CTRL_PAGE_SIZE;
+}
+
+static inline int nvme_build_cdqmem_prp_list(struct cdq_nvme_queue *cdq)
+{
+	struct device *dev = cdq->ctrl->dev;
+	const unsigned int prps_per_page = PAGE_SIZE >> 3;
+	unsigned int total_pages =
+		DIV_ROUND_UP(cdq->size_nbyte, NVME_CTRL_PAGE_SIZE);
+	dma_addr_t prp_list_dma;
+	__le64 *prp_list;
+	unsigned int prp_idx, page_idx;
+
+	prp_list = dma_alloc_coherent(dev, PAGE_SIZE, &prp_list_dma, GFP_KERNEL);
+	if (!prp_list)
+		return -ENOMEM;
+	cdq->prp_lists[0] = prp_list;
+	cdq->prp_lists_dma[0] = prp_list_dma;
+	cdq->nr_prp_lists = 1;
+
+	for (page_idx = 0, prp_idx = 0; page_idx < total_pages; page_idx++) {
+		dma_addr_t page_dma = nvme_get_cdq_pagedma(cdq, page_idx);
+
+		/* Current prp_list page full with entries still to place: chain. */
+		if (prp_idx == prps_per_page) {
+			__le64 *old = prp_list;
+
+			if (cdq->nr_prp_lists == MAX_NR_CDQ_PRPS)
+				goto err;
+			prp_list = dma_alloc_coherent(dev, PAGE_SIZE, &prp_list_dma,
+						      GFP_KERNEL);
+			if (!prp_list)
+				goto err;
+			cdq->prp_lists[cdq->nr_prp_lists] = prp_list;
+			cdq->prp_lists_dma[cdq->nr_prp_lists++] = prp_list_dma;
+
+			/* Chain from old to new prp_list */
+			prp_list[0] = old[prps_per_page - 1];
+			old[prps_per_page - 1] = cpu_to_le64(prp_list_dma);
+			prp_idx = 1;
+		}
+		prp_list[prp_idx++] = cpu_to_le64(page_dma);
+	}
+	return 0;
+err:
+	nvme_free_cdqmem_prp_lists(cdq);
+	return -ENOMEM;
+}
+
+/*
+ * Allocate the coherent store and prps for a CDQ.
+ * Expects cdq with size_nbytes and ctrl set.
+ */
+static inline int nvme_create_cdq_backing(struct cdq_nvme_queue *cdq)
+{
+	int ret;
+
+	if (!cdq->size_nbyte)
+		return -EINVAL;
+
+	ret = nvme_alloc_cdqmem_chunks(cdq);
+	if (ret)
+		return ret;
+
+	/* We pass cdq->chunks[0].dma_addr when cdq->nr_chunks == 1 */
+	if (cdq->nr_chunks > 1) {
+		ret = nvme_build_cdqmem_prp_list(cdq);
+		if (ret)
+			goto err_chunks;
+	}
+
+	return 0;
+
+err_chunks:
+	nvme_free_cdqmem_chunks(cdq);
+
+	return ret;
+}
+
+/* Release the coherent DMA backing allocated by nvme_create_cdq_backing(). */
+static inline void nvme_release_cdq_backing(struct cdq_nvme_queue *cdq)
+{
+	nvme_free_cdqmem_prp_lists(cdq);
+	nvme_free_cdqmem_chunks(cdq);
+}
+
 static int nvme_submit_delete_cdq_cmd(const struct cdq_nvme_queue *cdq)
 {
 	struct nvme_command c = {
@@ -27,10 +187,12 @@ static void nvme_delete_cdq_ctrl(struct cdq_nvme_queue *cdq)
 /* Does NOT send a CDQ delete NVMe cmd */
 static void nvme_delete_cdq_host(struct cdq_nvme_queue *cdq)
 {
-	u16 cdq_id = cdq->id;
 	struct nvme_ctrl *ctrl = cdq->ctrl;
 
-	xa_erase(&ctrl->cdqs, cdq_id);
+	if (xa_erase(&ctrl->cdqs, cdq->id) != cdq)
+		return;
+
+	nvme_release_cdq_backing(cdq);
 }
 
 void nvme_delete_cdq(struct cdq_nvme_queue *cdq)
diff --git a/drivers/nvme/host/cdq.h b/drivers/nvme/host/cdq.h
index 4378f97553ce2e649d8998eb168f82039dc762b1..5deaf3705c65250ea9fdc69e2e973987c8f084c1 100644
--- a/drivers/nvme/host/cdq.h
+++ b/drivers/nvme/host/cdq.h
@@ -8,9 +8,36 @@
 
 #include "nvme.h"
 
+/*
+ * The CDQ backing is a set of coherent DMA chunks. Chunk size expressed in
+ * host pages to match dma_alloc_coherency granularity.
+ */
+#define NVME_CDQ_CHUNK_ORDER		2
+#define NVME_CDQ_CHUNK_SIZE		(PAGE_SIZE << NVME_CDQ_CHUNK_ORDER)
+#define NVME_CDQ_PAGES_PER_CHUNK	(NVME_CDQ_CHUNK_SIZE / NVME_CTRL_PAGE_SIZE)
+
+/* Max PRP List pages we are willing to chain to describe a discontiguous CDQ. */
+#define MAX_NR_CDQ_PRPS		20
+
+struct nvme_cdq_chunk {
+	void		*vaddr;
+	dma_addr_t	dma_addr;
+	size_t		size;
+};
+
 struct cdq_nvme_queue {
 	u16 id;
 	struct nvme_ctrl *ctrl;
+	u32 size_nbyte;
+
+	/* Coherent backing store. */
+	struct nvme_cdq_chunk *chunks;
+	unsigned int nr_chunks;
+
+	/* PRP List pages describing the chunks to the controller (PC_DISCONT). */
+	__le64 *prp_lists[MAX_NR_CDQ_PRPS];
+	dma_addr_t prp_lists_dma[MAX_NR_CDQ_PRPS];
+	unsigned int nr_prp_lists;
 };
 
 void nvme_delete_cdq(struct cdq_nvme_queue *cdq);

-- 
2.50.1



