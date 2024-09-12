Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489CAEEB591
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2JnuJBl7580UzNRE/N3KmM4LmreoZWhWzDO4jU/MMb0=; b=t3162WKG6b05N0trGPBs0u1PQl
	SxoUEJJpWkB9RRlVcMi2YSVVrGRHbbxt9scA/Qt38h+cwSOiVimbF11hN0L6oaP/YWRcsXw7WUj0x
	GSLy1oc8c5Y8pOWxxK/oL1nbx9yoHVnMWgHVpqQbfaoPfWnlu1ZyX40kEgawXmsExWkEVIFWGdPvO
	kJHPe0rhqU2Fwrv6zJu+Ob0pSjNtjDa50EYnT9p0pnHhNw11/smQ03r4RSq8+GOwlwf12dZX9hai8
	m/7ckBHMlo6zcha9r5BIOA6sd8HLPddLNLy8T6RrUxTLC1SlIT5q2+cRoa0lPmsljic0sgzObfJj6
	48FCPnMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoL-0000000CnTQ-1OPV;
	Thu, 12 Sep 2024 11:16:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoI-0000000CnQH-1Gk8
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C5354A45257;
	Thu, 12 Sep 2024 11:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499D0C4CECF;
	Thu, 12 Sep 2024 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139785;
	bh=VvpomHjn0PXFDu7e/jW7/gfUbs21DN2RjkYJAyY9I0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aLB45VxSAnSX1Omnd4tNbgxYwGvlO0vlHzxS5XRXs3Jf+H6Sv4g2apXm3/BjzYZcU
	 jJat8T1BsFMxKIbvmMGDI3d2Wav68reJ0E3LN7sVO+ms1PwvbS5VCjz/Zp+6dn0u38
	 Hjyfj6EN+qrGYfmm8UXj6bzSoYbXvDIEBCuKATHLVp+eKVznmpDYlgEn6mEfIV25ac
	 CluAye/X57cQXU1+3AFoTAvO2BnVfHu3mTsIsvPd7Y8II6FIRfLqDJj5jqYb3qQCuB
	 HoFkBLlicit7oilmLRe8VOlKBnHex2vD837rA3akUkz25QskU2jzMySkDTK/0QW30m
	 CBd4EkuZoW2Aw==
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
Subject: [RFC v2 06/21] dma-mapping: set and query DMA IOVA state
Date: Thu, 12 Sep 2024 14:15:41 +0300
Message-ID: <818f2fbdb80f07297ca2abe5d04443d3b665f445.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041626_648801_54216BB1 
X-CRM114-Status: GOOD (  16.79  )
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

Provide an option to query and set if IOMMU path can be taken.
Callers who supply range of pages can perform it only once as
the whole range is supposed to have same memory type.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 12 ++++++++++++
 kernel/dma/mapping.c        | 38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6a51d8e96a9d..2c74e68b0567 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -81,6 +81,7 @@ struct dma_iova_state {
 	dma_addr_t addr;
 	size_t size;
 	enum dma_data_direction dir;
+	u8 use_iova : 1;
 };
 
 static inline void dma_init_iova_state(struct dma_iova_state *state,
@@ -169,6 +170,9 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+void dma_set_iova_state(struct dma_iova_state *state, struct page *page,
+			size_t size);
+bool dma_can_use_iova(struct dma_iova_state *state);
 #else /* CONFIG_HAS_DMA */
 static inline int dma_alloc_iova_unaligned(struct dma_iova_state *state,
 					   phys_addr_t phys, size_t size)
@@ -307,6 +311,14 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline void dma_set_iova_state(struct dma_iova_state *state,
+				      struct page *page, size_t size)
+{
+}
+static inline bool dma_can_use_iova(struct dma_iova_state *state)
+{
+	return false;
+}
 #endif /* CONFIG_HAS_DMA */
 
 #if defined(CONFIG_HAS_DMA) && defined(CONFIG_DMA_NEED_SYNC)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 4cd910f27dee..16cb03d5d87d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -6,6 +6,7 @@
  * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
  */
 #include <linux/memblock.h> /* for max_pfn */
+#include <linux/memremap.h>
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
 #include <linux/iommu-dma.h>
@@ -15,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/cc_platform.h>
 #include "debug.h"
 #include "direct.h"
 
@@ -986,3 +988,39 @@ void dma_free_iova(struct dma_iova_state *state)
 	iommu_dma_free_iova(state);
 }
 EXPORT_SYMBOL_GPL(dma_free_iova);
+
+/**
+ * dma_set_iova_state - Set the IOVA state for the given page and size
+ * @state: IOVA state
+ * @page: page to check
+ * @size: size of the page
+ *
+ * Set the IOVA state for the given page and size. The IOVA state is set
+ * based on the device and the page.
+ */
+void dma_set_iova_state(struct dma_iova_state *state, struct page *page,
+			size_t size)
+{
+	if (!use_dma_iommu(state->dev))
+		return;
+
+	state->use_iova = iommu_can_use_iova(state->dev, page, size, state->dir);
+}
+EXPORT_SYMBOL_GPL(dma_set_iova_state);
+
+/**
+ * dma_can_use_iova - check if the device type is valid
+ *                    and won't take SWIOTLB path
+ * @state: IOVA state
+ *
+ * Return %true if the device should use swiotlb for the given buffer, else
+ * %false.
+ */
+bool dma_can_use_iova(struct dma_iova_state *state)
+{
+	if (!use_dma_iommu(state->dev))
+		return false;
+
+	return state->use_iova;
+}
+EXPORT_SYMBOL_GPL(dma_can_use_iova);
-- 
2.46.0


