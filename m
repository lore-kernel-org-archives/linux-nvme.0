Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020A5C30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 09:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sg8VrrbO63E4vxe03RzTRxr3bmVdW29o9ynUGItU87Y=; b=LkabikRqb3BMFxsXJxJw6ULL4L
	RaqwHtFougWKMpMlRsAM/AmRIS8W11469XCMz0pbF3epPXCbS2uL5TOrWHDbfNSTuw1n815cQ3ubH
	JDHyjCe8vTQdrR2nyTBQmR0b5ptBTbutD/2A4FYKUjZqXyGZIhrXNoeB+O3vJcscmQeoJP2g8WOmg
	3VkofE0EtYxCXroiuihVNTmXTsBm0jiaS+lzjdcIAkjG51GwvhWBsx3eds11XxS53rPTg7gGyylRL
	7HaGtyfNsj7O2L23slWIvBY9pN5Q1X5H1GMX2piyXnJ2X9G3IbO5GyXKIoGKZvr4uzfAe9tAlo1l6
	CC8JjPGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZX7-000000065dN-0d2Y;
	Tue, 02 Jul 2024 09:10:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZX0-000000065Wf-3U1d
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:10:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C632061A0C;
	Tue,  2 Jul 2024 09:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD899C4AF0A;
	Tue,  2 Jul 2024 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911433;
	bh=0ck5rd5jPLMOP1nHX+50lNZNnmmRrxabk/SQIbsa6U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYKS1Ot/toIO1bChF3hjNIXQnLRGAFZW60cYZGmLLcwlJGabkFTKyyB9S4UjzMRw4
	 OWdB+gcPZfiFupAaORoIq2eLPt1FH+wTYrENPy5qAeVHARSxgi1nIntNE+I24Dz9VP
	 HGwRhb2VAiNoV6XRMQ24UVg2ee/gd+HohgenhbH1Ffqm3bb0/puHq59LU7IGpEL/vk
	 sVPeLGHK/A9Eqt9VnWOf9HrTGNvjmQUyWmuLi3tGXthIBjVPGtIFwFF4zX749XQYhs
	 NGGEjZMQlBISbiHromVsoVz6nukh5hle9SkHC3Rj4ksdesgD1SzycXc0OVeUTNAhcG
	 ADXWSXiEd0N1A==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 04/18] dma-mapping: implement link range API
Date: Tue,  2 Jul 2024 12:09:34 +0300
Message-ID: <8944a1211b243fed1234a56bc8004a11dbf85a87.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_021035_083597_C8BA9050 
X-CRM114-Status: GOOD (  17.33  )
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

Introduce new DMA APIs to perform DMA linkage of buffers
in layers higher than DMA.

In proposed API, the callers will perform the following steps:
dma_alloc_iova()
if (dma_can_use_iova(...))
  dma_start_range(...)
  for (page in range)
     dma_link_range(...)
  dma_end_range(...)
else
  /* Fallback to legacy map pages */
  dma_map_page(...)

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-map-ops.h |  6 +++
 include/linux/dma-mapping.h | 22 +++++++++++
 kernel/dma/mapping.c        | 78 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index b52e9c8db241..4868586b015e 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -90,6 +90,12 @@ struct dma_map_ops {
 
 	dma_addr_t (*alloc_iova)(struct device *dev, size_t size);
 	void (*free_iova)(struct device *dev, dma_addr_t dma_addr, size_t size);
+	int (*link_range)(struct dma_iova_state *state, phys_addr_t phys,
+			  dma_addr_t addr, size_t size);
+	void (*unlink_range)(struct dma_iova_state *state,
+			     dma_addr_t dma_handle, size_t size);
+	int (*start_range)(struct dma_iova_state *state);
+	void (*end_range)(struct dma_iova_state *state);
 };
 
 #ifdef CONFIG_DMA_OPS
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9d1e020869a6..c530095ff232 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -11,6 +11,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bug.h>
 #include <linux/mem_encrypt.h>
+#include <linux/iommu.h>
 
 /**
  * List of possible attributes associated with a DMA mapping. The semantics
@@ -103,6 +104,8 @@ struct dma_iova_attrs {
 struct dma_iova_state {
 	struct dma_iova_attrs *iova;
 	struct dma_memory_type *type;
+	struct iommu_domain *domain;
+	size_t range_size;
 };
 
 #ifdef CONFIG_DMA_API_DEBUG
@@ -184,6 +187,10 @@ int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 
 void dma_get_memory_type(struct page *page, struct dma_memory_type *type);
 bool dma_can_use_iova(struct dma_iova_state *state, size_t size);
+int dma_start_range(struct dma_iova_state *state);
+void dma_end_range(struct dma_iova_state *state);
+int dma_link_range(struct dma_iova_state *state, phys_addr_t phys, size_t size);
+void dma_unlink_range(struct dma_iova_state *state);
 #else /* CONFIG_HAS_DMA */
 static inline int dma_alloc_iova(struct dma_iova_attrs *iova)
 {
@@ -329,6 +336,21 @@ static inline bool dma_can_use_iova(struct dma_iova_state *state, size_t size)
 {
 	return false;
 }
+static inline int dma_start_range(struct dma_iova_state *state)
+{
+	return -EOPNOTSUPP;
+}
+static inline void dma_end_range(struct dma_iova_state *state)
+{
+}
+static inline int dma_link_range(struct dma_iova_state *state, phys_addr_t phys,
+				 size_t size)
+{
+	return -EOPNOTSUPP;
+}
+static inline void dma_unlink_range(struct dma_iova_state *state)
+{
+}
 #endif /* CONFIG_HAS_DMA */
 
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 9044ee525fdb..089b4a977bab 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -989,7 +989,8 @@ bool dma_can_use_iova(struct dma_iova_state *state, size_t size)
 	    dev_use_swiotlb(dev, size, state->iova->dir))
 		return false;
 
-	if (dma_map_direct(dev, ops) || !ops->alloc_iova)
+	if (dma_map_direct(dev, ops) || !ops->alloc_iova || !ops->link_range ||
+	    !ops->start_range)
 		return false;
 
 	if (type->type == DMA_MEMORY_TYPE_P2P) {
@@ -1000,3 +1001,78 @@ bool dma_can_use_iova(struct dma_iova_state *state, size_t size)
 	return type->type == DMA_MEMORY_TYPE_NORMAL;
 }
 EXPORT_SYMBOL_GPL(dma_can_use_iova);
+
+/**
+ * dma_start_range - Start a range of IOVA space
+ * @state: IOVA state
+ *
+ * Start a range of IOVA space for the given IOVA state.
+ */
+int dma_start_range(struct dma_iova_state *state)
+{
+	struct device *dev = state->iova->dev;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (!ops->start_range)
+		return 0;
+
+	return ops->start_range(state);
+}
+EXPORT_SYMBOL_GPL(dma_start_range);
+
+/**
+ * dma_end_range - End a range of IOVA space
+ * @state: IOVA state
+ *
+ * End a range of IOVA space for the given IOVA state.
+ */
+void dma_end_range(struct dma_iova_state *state)
+{
+	struct device *dev = state->iova->dev;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (!ops->end_range)
+		return;
+
+	ops->end_range(state);
+}
+EXPORT_SYMBOL_GPL(dma_end_range);
+
+/**
+ * dma_link_range - Link a range of IOVA space
+ * @state: IOVA state
+ * @phys: physical address to link
+ * @size: size of the buffer
+ *
+ * Link a range of IOVA space for the given IOVA state.
+ */
+int dma_link_range(struct dma_iova_state *state, phys_addr_t phys, size_t size)
+{
+	struct device *dev = state->iova->dev;
+	dma_addr_t addr = state->iova->addr + state->range_size;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	int ret;
+
+	ret = ops->link_range(state, phys, addr, size);
+	if (ret)
+		return ret;
+
+	state->range_size += size;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_link_range);
+
+/**
+ * dma_unlink_range - Unlink a range of IOVA space
+ * @state: IOVA state
+ *
+ * Unlink a range of IOVA space for the given IOVA state.
+ */
+void dma_unlink_range(struct dma_iova_state *state)
+{
+	struct device *dev = state->iova->dev;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	ops->unlink_range(state, state->iova->addr, state->range_size);
+}
+EXPORT_SYMBOL_GPL(dma_unlink_range);
-- 
2.45.2


