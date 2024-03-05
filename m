Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B726C54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1hoDfpdTddpyu+zr+83f9Hrpbyga7AGgUx+JQQjpEk=; b=PmjkPQkrNDvypB+uH6M5Q2Qt1l
	ltd+sOUFWlRtq3Q7K9LDImr3AMvgA2dXN8PAb8u0G8IbBIZqdmcv37P2eQlrU4w9vJZ7tqnYFDxrU
	V+NkIt63Ze2WqJeF8yzf06TGR49LBTYtZ3Q5ZzbDVPg+AsLai8vPJ0mFbKimRREDVQjVnErY2lfoc
	f55OW2HL7hGhma2jPlh0YYhARAKRq5uSyv4IQPWvvJ0pkC1WyPNs8lF1bwPtoJ9fiGitJoxyDJn4V
	4xX+g0Qooux8ZitjpMtynH1cKmosKnanWCiu0XGVO/AsTuX9k+c/KBdLeF9AMJZoeqnz0YMyQ4NKi
	CxK+8Lrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUxq-0000000DoAq-2AWq;
	Tue, 05 Mar 2024 13:36:14 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhRwY-0000000D0pa-0mDq
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 10:22:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 669D9CE19BF;
	Tue,  5 Mar 2024 10:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FC0C43394;
	Tue,  5 Mar 2024 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634159;
	bh=qAJEud8zSEtY+UaYfguXl0FuNLhyjwr4jvzS2H85FiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKkfs5K6bbKu2QVdVHjPDjmXgHNBNCMOyLW0Y6jg4rVH1rLeeNs1fvf/qtvkpJFsl
	 emNFc5PsisGcGAdsQAmrneaf4WN6IZljPhm+EBmPmF7JdC8jYLF6mvaxwZXzgxUPWw
	 YE2Wrgnkji7uT1y4mek2atAgLLNV/tk/9x5KWRPwqJQxGACLGPgvvsFnapU9eIU+hm
	 4i5aXoDmIo/akYoP74kx20fjjwmkwcV2Bjf7Dk2nV9SUDMS/FkMXVtj4XkSp5Nf5bY
	 rqx0YxGea1dHuPCy0StUnXsQ5aIfjD7PbI41Rh2zj3nza69crWqmZ8qgBqbNIXZipP
	 SmSqxTbBq548g==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC 03/16] dma-mapping: provide callbacks to link/unlink pages to specific IOVA
Date: Tue,  5 Mar 2024 12:22:04 +0200
Message-ID: <f1049f0fc280288ae2f0c1e02388cde91b0f7876.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_022242_662993_ED9B2F58 
X-CRM114-Status: GOOD (  19.70  )
X-Mailman-Approved-At: Tue, 05 Mar 2024 05:32:59 -0800
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
Message-ID: <20240305102204.2id6lEnkDmQpnkk31MOt0e7v9Ryk_ltpeNIwQ8SAcYU@z>

From: Leon Romanovsky <leonro@nvidia.com>

Introduce new DMA link/unlink API to provide a way for advanced users
to directly map/unmap pages without ned to allocate IOVA on every map
call.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-map-ops.h | 10 +++++++
 include/linux/dma-mapping.h | 13 +++++++++
 kernel/dma/debug.h          |  2 ++
 kernel/dma/direct.h         |  3 ++
 kernel/dma/mapping.c        | 57 +++++++++++++++++++++++++++++++++++++
 5 files changed, 85 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index bd605b44bb57..fd03a080df1e 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -86,6 +86,13 @@ struct dma_map_ops {
 
 	dma_addr_t (*alloc_iova)(struct device *dev, size_t size);
 	void (*free_iova)(struct device *dev, dma_addr_t dma_addr, size_t size);
+	dma_addr_t (*link_range)(struct device *dev, struct page *page,
+				 unsigned long offset, dma_addr_t addr,
+				 size_t size, enum dma_data_direction dir,
+				 unsigned long attrs);
+	void (*unlink_range)(struct device *dev, dma_addr_t dma_handle,
+			     size_t size, enum dma_data_direction dir,
+			     unsigned long attrs);
 };
 
 #ifdef CONFIG_DMA_OPS
@@ -428,6 +435,9 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 #define arch_dma_unmap_sg_direct(d, s, n)	(false)
 #endif
 
+#define arch_dma_link_range_direct arch_dma_map_page_direct
+#define arch_dma_unlink_range_direct arch_dma_unmap_page_direct
+
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		bool coherent);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 176fb8a86d63..91cc084adb53 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -113,6 +113,9 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 
 int dma_alloc_iova(struct dma_iova_attrs *iova);
 void dma_free_iova(struct dma_iova_attrs *iova);
+dma_addr_t dma_link_range(struct page *page, unsigned long offset,
+			  struct dma_iova_attrs *iova, dma_addr_t dma_offset);
+void dma_unlink_range(struct dma_iova_attrs *iova, dma_addr_t dma_offset);
 
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		size_t offset, size_t size, enum dma_data_direction dir,
@@ -179,6 +182,16 @@ static inline int dma_alloc_iova(struct dma_iova_attrs *iova)
 static inline void dma_free_iova(struct dma_iova_attrs *iova)
 {
 }
+static inline dma_addr_t dma_link_range(struct page *page, unsigned long offset,
+					struct dma_iova_attrs *iova,
+					dma_addr_t dma_offset)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void dma_unlink_range(struct dma_iova_attrs *iova,
+				    dma_addr_t dma_offset)
+{
+}
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index f525197d3cae..3d529f355c6d 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -127,4 +127,6 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
 {
 }
 #endif /* CONFIG_DMA_API_DEBUG */
+#define debug_dma_link_range debug_dma_map_page
+#define debug_dma_unlink_range debug_dma_unmap_page
 #endif /* _KERNEL_DMA_DEBUG_H */
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 18d346118fe8..1c30e1cd607a 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -125,4 +125,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
+
+#define dma_direct_link_range dma_direct_map_page
+#define dma_direct_unlink_range dma_direct_unmap_page
 #endif /* _KERNEL_DMA_DIRECT_H */
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b6b27bab90f3..f989c64622c2 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -213,6 +213,63 @@ void dma_free_iova(struct dma_iova_attrs *iova)
 }
 EXPORT_SYMBOL(dma_free_iova);
 
+/**
+ * dma_link_range - Link a physical page to DMA address
+ * @page: The page to be mapped
+ * @offset: The offset within the page
+ * @iova: Preallocated IOVA attributes
+ * @dma_offset: DMA offset form which this page needs to be linked
+ *
+ * dma_alloc_iova() allocates IOVA based on the size specified by ther user in
+ * iova->size. Call this function after IOVA allocation to link @page from
+ * @offset to get the DMA address. Note that very first call to this function
+ * will have @dma_offset set to 0 in the IOVA space allocated from
+ * dma_alloc_iova(). For subsequent calls to this function on same @iova,
+ * @dma_offset needs to be advanced by the caller with the size of previous
+ * page that was linked + DMA address returned for the previous page that was
+ * linked by this function.
+ */
+dma_addr_t dma_link_range(struct page *page, unsigned long offset,
+			  struct dma_iova_attrs *iova, dma_addr_t dma_offset)
+{
+	struct device *dev = iova->dev;
+	size_t size = iova->size;
+	enum dma_data_direction dir = iova->dir;
+	unsigned long attrs = iova->attrs;
+	dma_addr_t addr = iova->addr + dma_offset;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_link_range_direct(dev, page_to_phys(page) + offset + size))
+		addr = dma_direct_link_range(dev, page, offset, size, dir, attrs);
+	else if (ops->link_range)
+		addr = ops->link_range(dev, page, offset, addr, size, dir, attrs);
+
+	kmsan_handle_dma(page, offset, size, dir);
+	debug_dma_link_range(dev, page, offset, size, dir, addr, attrs);
+	return addr;
+}
+EXPORT_SYMBOL(dma_link_range);
+
+void dma_unlink_range(struct dma_iova_attrs *iova, dma_addr_t dma_offset)
+{
+	struct device *dev = iova->dev;
+	size_t size = iova->size;
+	enum dma_data_direction dir = iova->dir;
+	unsigned long attrs = iova->attrs;
+	dma_addr_t addr = iova->addr + dma_offset;
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_unlink_range_direct(dev, addr + size))
+		dma_direct_unlink_range(dev, addr, size, dir, attrs);
+	else if (ops->unlink_range)
+		ops->unlink_range(dev, addr, size, dir, attrs);
+
+	debug_dma_unlink_range(dev, addr, size, dir);
+}
+EXPORT_SYMBOL(dma_unlink_range);
+
 static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	 int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.44.0


