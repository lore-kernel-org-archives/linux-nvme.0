Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AF0E674A3
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 04:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4IQm20OEPihH0CH9ND8tWLNuHZnaPL75SMNHTIsvjY=; b=gau3WAOGwBa3xkzlypY6cWmcIa
	vvO7avabi/q3tDWyw4/3k7Nb5WkIRJ2jhl+U74i4JFTx61wMzDI1rCS08hQyWe9cJCHDRQ+/lhJNM
	y3gui1mn7+AzJiE2B1p4I8hO+HKGN6vIjr/IYbWuZV6w5SifC/peQUzyWwO+fFWy5Qx2pHmsxz6Z/
	Brok90DuRgY70NU00x60Kp+cAEgSN0OHeWe3V+IKnXyaqLjxI/oKP43q+Tn3OUwq148k75ih89n1R
	QfogKB2h5ClQCvK2mrha7DBNOZ3srh+3kNo8DzD54I7Hj58nDY2VafG5al6D/8HKh1+nXnKcLcib/
	FgAvLo/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6jSV-00000005ld7-2ACG;
	Fri, 01 Nov 2024 04:40:27 +0000
Received: from 2a02-8389-2341-5b80-5ae8-ad80-e9c6-3f1e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ae8:ad80:e9c6:3f1e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6jSS-00000005lc9-3xUL;
	Fri, 01 Nov 2024 04:40:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-pci: use dma_alloc_noncontigous if possible
Date: Fri,  1 Nov 2024 05:40:05 +0100
Message-ID: <20241101044016.405265-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101044016.405265-1-hch@lst.de>
References: <20241101044016.405265-1-hch@lst.de>
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

Use dma_alloc_noncontigous to allocate a single IOVA-contigous segment
when backed by an IOMMU.  This allow to easily use bigger segments and
avoids running into segment limits if we can avoid it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 58 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 34daf6d8db07..0aa26a33f231 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -141,6 +141,7 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
 	bool hmb;
+	struct sg_table *hmb_sgt;
 
 	mempool_t *iod_mempool;
 
@@ -1952,7 +1953,7 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
 	return ret;
 }
 
-static void nvme_free_host_mem(struct nvme_dev *dev)
+static void nvme_free_host_mem_multi(struct nvme_dev *dev)
 {
 	int i;
 
@@ -1967,6 +1968,16 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 
 	kfree(dev->host_mem_desc_bufs);
 	dev->host_mem_desc_bufs = NULL;
+}
+
+static void nvme_free_host_mem(struct nvme_dev *dev)
+{
+	if (dev->hmb_sgt)
+		dma_free_noncontiguous(dev->dev, dev->host_mem_size,
+				dev->hmb_sgt, DMA_BIDIRECTIONAL);
+	else
+		nvme_free_host_mem_multi(dev);
+
 	dma_free_coherent(dev->dev, dev->host_mem_descs_size,
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
@@ -1974,7 +1985,33 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 	dev->nr_host_mem_descs = 0;
 }
 
-static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
+static int nvme_alloc_host_mem_single(struct nvme_dev *dev, u64 size)
+{
+	dev->hmb_sgt = dma_alloc_noncontiguous(dev->dev, size,
+				DMA_BIDIRECTIONAL, GFP_KERNEL, 0);
+	if (!dev->hmb_sgt)
+		return -ENOMEM;
+
+	dev->host_mem_descs = dma_alloc_coherent(dev->dev,
+			sizeof(*dev->host_mem_descs), &dev->host_mem_descs_dma,
+			GFP_KERNEL);
+	if (!dev->host_mem_descs) {
+		dma_free_noncontiguous(dev->dev, dev->host_mem_size,
+				dev->hmb_sgt, DMA_BIDIRECTIONAL);
+		dev->hmb_sgt = NULL;
+		return -ENOMEM;
+	}
+	dev->host_mem_size = size;
+	dev->host_mem_descs_size = sizeof(*dev->host_mem_descs);
+	dev->nr_host_mem_descs = 1;
+
+	dev->host_mem_descs[0].addr =
+		cpu_to_le64(dev->hmb_sgt->sgl->dma_address);
+	dev->host_mem_descs[0].size = cpu_to_le32(size / NVME_CTRL_PAGE_SIZE);
+	return 0;
+}
+
+static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
 		u32 chunk_size)
 {
 	struct nvme_host_mem_buf_desc *descs;
@@ -2049,9 +2086,18 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 	u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
 	u64 chunk_size;
 
+	/*
+	 * If there is an IOMMU that can merge pages, try a virtually
+	 * non-contiguous allocation for a single segment first.
+	 */
+	if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
+		if (!nvme_alloc_host_mem_single(dev, preferred))
+			return 0;
+	}
+
 	/* start big and work our way down */
 	for (chunk_size = min_chunk; chunk_size >= hmminds; chunk_size /= 2) {
-		if (!__nvme_alloc_host_mem(dev, preferred, chunk_size)) {
+		if (!nvme_alloc_host_mem_multi(dev, preferred, chunk_size)) {
 			if (!min || dev->host_mem_size >= min)
 				return 0;
 			nvme_free_host_mem(dev);
@@ -2099,8 +2145,10 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 		}
 
 		dev_info(dev->ctrl.device,
-			"allocated %lld MiB host memory buffer.\n",
-			dev->host_mem_size >> ilog2(SZ_1M));
+			"allocated %lld MiB host memory buffer (%u segment%s).\n",
+			dev->host_mem_size >> ilog2(SZ_1M),
+			dev->nr_host_mem_descs,
+			str_plural(dev->nr_host_mem_descs));
 	}
 
 	ret = nvme_set_host_mem(dev, enable_bits);
-- 
2.45.2


