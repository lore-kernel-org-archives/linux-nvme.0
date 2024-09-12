Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD76EEB593
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GPZuS5wvsAjn9FDbEhcpirCEsYojcDK3lhW1ODMTRzw=; b=bXUd9oNXW8yxN7PirwG6HVu/+k
	97d9dRYrZbQPlQ0EX6GyLen+CZDbYMFbM/SKa6TmHnorofqWtM+OTtHErMNvmvfwj8ZjO2eVUKbcC
	utTYga/NTDc73kFedcVjC2LkD1oU2irkPAXNqe97eWC7OWkcHvfvsqRfWkXJUFAlMYi8HCeN70LqP
	yMDlaOnAVWQPNy9sTsZg2/u5BYpbVjHFXn3R/h/x0uMvPnKYzg285zM1Q5LrTvOAPjnMIQhQ9yZTx
	rDCou31F8PLKTnRwAXp1071lcpVqb0ecl+Z9/9YEf7j0w4zHe+DJ9KUa7TjK+YJGvya6IelXwU3QD
	4o0Hn5DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoG-0000000CnPP-3R1I;
	Thu, 12 Sep 2024 11:16:24 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohoD-0000000CnMM-2Q8j
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 351C3A451EC;
	Thu, 12 Sep 2024 11:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF5FC4CED2;
	Thu, 12 Sep 2024 11:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139780;
	bh=li4T+ci0miq/Ck6TZvJSh35TTfQLVZ3ez/sogkVEAqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DW0EiOBLWTdXdcYL7iQeO1KEagJUzhnYtnawH9XAOccSvNYhDqCr0kKYfQM7BvY7U
	 Z/wF8BB04Og3VC/8rARWoLu32FUWjBo1rIeCC7O48BCmC1v7BqOLzPGtwScbzU+jh5
	 yM16QVL6oJS9fqiYwrvdfeNXuOWuirfNAINa2A9ynEvi8yQyOZcl7Q5AiJF1Psq1wq
	 BlV0gczTOznpsch1Z/NwAxSedcftaMBui/NE1/LqZ1tIhEFQpGA/yfhVm5TfMyPZyn
	 iwopoujIQGMD6QhZFyOHnnS0zH8X4MT/j6CzTSHEFKa//fWWK8/8tzQhXDftpbBb7j
	 3hFBAtVG640fQ==
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
Subject: [RFC v2 05/21] dma-mapping: provide an interface to allocate IOVA
Date: Thu, 12 Sep 2024 14:15:40 +0300
Message-ID: <dd5ac6c0fdf89ee0e0eb4580309253dcb225e726.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041621_780422_B2F90B6B 
X-CRM114-Status: GOOD (  14.46  )
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

Existing .map_page() callback provides two things at the same time:
allocates IOVA and links DMA pages. That combination works great for
most of the callers who use it in control paths, but less effective
in fast paths.

These advanced callers already manage their data in some sort of
database and can perform IOVA allocation in advance, leaving range
linkage operation to be in fast path.

Provide an interface to allocate/deallocate IOVA and next patch
link/unlink DMA ranges to that specific IOVA.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h | 18 ++++++++++++++++++
 kernel/dma/mapping.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 285075873077..6a51d8e96a9d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -78,6 +78,8 @@
 
 struct dma_iova_state {
 	struct device *dev;
+	dma_addr_t addr;
+	size_t size;
 	enum dma_data_direction dir;
 };
 
@@ -115,6 +117,10 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+int dma_alloc_iova_unaligned(struct dma_iova_state *state, phys_addr_t phys,
+			     size_t size);
+void dma_free_iova(struct dma_iova_state *state);
+
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		size_t offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs);
@@ -164,6 +170,14 @@ void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
 #else /* CONFIG_HAS_DMA */
+static inline int dma_alloc_iova_unaligned(struct dma_iova_state *state,
+					   phys_addr_t phys, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+static inline void dma_free_iova(struct dma_iova_state *state)
+{
+}
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -370,6 +384,10 @@ static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 	return false;
 }
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
+static inline int dma_alloc_iova(struct dma_iova_state *state, size_t size)
+{
+	return dma_alloc_iova_unaligned(state, 0, size);
+}
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index fd9ecff8beee..4cd910f27dee 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -951,3 +951,38 @@ unsigned long dma_get_merge_boundary(struct device *dev)
 	return ops->get_merge_boundary(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_merge_boundary);
+
+/**
+ * dma_alloc_iova_unaligned - Allocate an IOVA space
+ * @state: IOVA state
+ * @phys: physical address
+ * @size: IOVA size
+ *
+ * Allocate an IOVA space for the given IOVA state and size. The IOVA space
+ * is allocated to the worst case when whole range is going to be used.
+ */
+int dma_alloc_iova_unaligned(struct dma_iova_state *state, phys_addr_t phys,
+			     size_t size)
+{
+	if (!use_dma_iommu(state->dev))
+		return 0;
+
+	WARN_ON_ONCE(!size);
+	return iommu_dma_alloc_iova(state, phys, size);
+}
+EXPORT_SYMBOL_GPL(dma_alloc_iova_unaligned);
+
+/**
+ * dma_free_iova - Free an IOVA space
+ * @state: IOVA state
+ *
+ * Free an IOVA space for the given IOVA attributes.
+ */
+void dma_free_iova(struct dma_iova_state *state)
+{
+	if (!use_dma_iommu(state->dev))
+		return;
+
+	iommu_dma_free_iova(state);
+}
+EXPORT_SYMBOL_GPL(dma_free_iova);
-- 
2.46.0


