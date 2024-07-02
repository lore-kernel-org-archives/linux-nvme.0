Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878BAC3065C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4AbwGmGnj47IV1Y8hzENMzunZyP4axPgZfTlB+LSU4=; b=FCyWvDE7NHHeY5rZaBHE1sxQFP
	rARd1QSYcGCEUFzzONQ5/f6oW/1eIMC25Nnp3vdSXiMsjqgXCr9ZS+hj+6zZigY6y5LHNfcrSOV6c
	5cN1NIIEixpgy4fb2y6sw3H41ReZ3wGzh5LvTxaGPsFLmWsjpjzuWjUCKUnqzpKhgQY+28umqUMaJ
	NzrdXIc1ZFH7KvnfOsEPrNiZirPAqYaQT635DqUClJM6HVr0RWpiKLdtq7vaKQTabGe08x38pAOG2
	l6RafSfeHXluJQZzAp3n6eyyQJXzyvEYYB/acrTkcq6xW7YNVTYxSpifFzkfgKx9WBlGykNuwmjtO
	2AYOBOww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWc-000000065BR-0YMv;
	Tue, 02 Jul 2024 09:10:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWX-00000006593-1Wh4
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:10:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B00FE61A0C;
	Tue,  2 Jul 2024 09:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D44C116B1;
	Tue,  2 Jul 2024 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911404;
	bh=PsDcRtwRrZy3xcTFmq5V+v2aFvC1FX6fMcSIsPNIgJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdB+vVAS8uHPdPme4myJO22f4FbGRcG1dHDJHwEW7t+ki8CzsXtGbIJKrwNZzL+oN
	 HZhggaNWlUq2LDjYroZErlO93jF4y+zjRYe2QMVqmzz1MDxk1Rl8xeJex/5Q1jOGA8
	 kNM7rlYFNxKQypQjyLEv1W8ppPwmxff79s/KS7zpU97+5kGBVsrGR36Z/Ui8WyxfjN
	 +2WhW3GmeKGr7A5xpE0coC6WO/48R8aI2ccSdCQQ38AntHiLnCHjCF0ItXO1X8/fim
	 N1g17gLjq4qvdcY6NksGgFPtVrvn0kKJnJryFF33jW+ntCtDHOmI6RkHi12DWkTu0B
	 MTNXNHg+0HJIQ==
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
Subject: [RFC PATCH v1 01/18] dma-mapping: query DMA memory type
Date: Tue,  2 Jul 2024 12:09:31 +0300
Message-ID: <a7ec6658f74f1dfbe7bd0e96be5be2f1be945076.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_021005_567693_D240CCD3 
X-CRM114-Status: GOOD (  17.42  )
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

Provide an option to query and set DMA memory type so callers who supply
range of pages can perform it only once as the whole range is supposed
to have same memory type.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 20 ++++++++++++++++++++
 kernel/dma/mapping.c        | 30 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f693aafe221f..49b99c6e7ec5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -76,6 +76,20 @@
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
 
+enum dma_memory_types {
+	/* Normal memory without any extra properties like P2P, e.t.c */
+	DMA_MEMORY_TYPE_NORMAL,
+	/* Memory which is p2p capable */
+	DMA_MEMORY_TYPE_P2P,
+	/* Encrypted memory (TDX) */
+	DMA_MEMORY_TYPE_ENCRYPTED,
+};
+
+struct dma_memory_type {
+	enum dma_memory_types type;
+	struct dev_pagemap *p2p_pgmap;
+};
+
 #ifdef CONFIG_DMA_API_DEBUG
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
 void debug_dma_map_single(struct device *dev, const void *addr,
@@ -149,6 +163,8 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+
+void dma_get_memory_type(struct page *page, struct dma_memory_type *type);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -279,6 +295,10 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline void dma_get_memory_type(struct page *page,
+				       struct dma_memory_type *type)
+{
+}
 #endif /* CONFIG_HAS_DMA */
 
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 81de84318ccc..877e43b39c06 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
  */
 #include <linux/memblock.h> /* for max_pfn */
+#include <linux/memremap.h>
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/export.h>
@@ -14,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/cc_platform.h>
 #include "debug.h"
 #include "direct.h"
 
@@ -894,3 +896,31 @@ unsigned long dma_get_merge_boundary(struct device *dev)
 	return ops->get_merge_boundary(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
+
+/**
+ * dma_get_memory_type - get the DMA memory type of the page supplied
+ * @page: page to check
+ * @type: memory type of that page
+ *
+ * Return the DMA memory type for the struct page. Pages with the same
+ * memory type can be combined into the same IOVA mapping. Users of the
+ * dma_iova family of functions must seperate the memory they want to map
+ * into same-memory type ranges.
+ */
+void dma_get_memory_type(struct page *page, struct dma_memory_type *type)
+{
+	/* TODO: Rewrite this check to rely on specific struct page flags */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		type->type = DMA_MEMORY_TYPE_ENCRYPTED;
+		return;
+	}
+
+	if (is_pci_p2pdma_page(page)) {
+		type->type = DMA_MEMORY_TYPE_P2P;
+		type->p2p_pgmap = page->pgmap;
+		return;
+	}
+
+	type->type = DMA_MEMORY_TYPE_NORMAL;
+}
+EXPORT_SYMBOL_GPL(dma_get_memory_type);
-- 
2.45.2


