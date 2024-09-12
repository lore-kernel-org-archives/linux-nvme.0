Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D43EEB595
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRHSz0R1VwTi0dYb+LlH3KG5wXGf6fhQy9+v7ADWjGg=; b=OJO/UWtWqeXR/DXNVXEB6RLbEv
	/bK5fkPOe4HYYU8jBQBKpEQ9pCjWddG6fZFZfjjcy1F1kP5N1HJEPL7g4TothqPNv7WRQTGE0tGV1
	pYyfFGbE5+axSxygyhIbRCMHIUZfsWvUm9dXeR5H/omWpbxvlNz+aAVhpgY2rBHyR3mYERSFRaR5c
	AaM0fsxWyYzETg5H9znolTm1eie1GDzo4P9WhUoC7YwHe/s6x3CoiSCM5MkN6VZQ0tJXrcC/42OrV
	Ffd9ZL9asizNHhoGRvfksPMKZb37zLnpjgLHFF5BRYPhE5OokJgcT9oq89IJL5luw4jlO+1gU9or+
	rZPuU4gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soho4-0000000CnEo-3hdd;
	Thu, 12 Sep 2024 11:16:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soho0-0000000CnCF-2zl9
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5B36CA4523B;
	Thu, 12 Sep 2024 11:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77C3C4CEC3;
	Thu, 12 Sep 2024 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139767;
	bh=VWjabdNWVPsGz8JpMutT65B9uF9Uo/BpJGgpfDUTVak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmLlNz91vs6SxK07DPB0FeRsNdYraG/8/aqHCC+3yK4unyOBTigWl3dgYpL2FkZvP
	 G00341+DXFortwi5A0DRM0oHHJqqoS7g8LSRwclecTKFOR6jCplrCR/SZdrKvwQrep
	 5phR03LaxkxKfznDtpK311Npqk+LqTE1hfaGrQzheteDVBW+0npQPavVlKK53ZaCZV
	 jUwtCJrepSK/qZzM0l46iOZh5zC7lj4U1Ro+C1FrUtN0yi1ZAX+AUZ4QhVVi/LHgnS
	 9a/vmDOidRNoehzzXg/ZzBt24/4beQiO6/rnc2z0BUmysAh3pMoMNwdyfrAPJ0MonP
	 a9CIwLBnLrSxw==
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
Subject: [RFC v2 02/21] iommu/dma: Implement link/unlink ranges callbacks
Date: Thu, 12 Sep 2024 14:15:37 +0300
Message-ID: <e3a8350baeaad544010c65dc62db53cf92ff2be1.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041608_907942_CE688F09 
X-CRM114-Status: GOOD (  15.49  )
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

Add an implementation of link/unlink interface to perform in map/unmap
pages in fast patch for pre-allocated IOVA.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 86 +++++++++++++++++++++++++++++++++++++++
 include/linux/iommu-dma.h | 25 ++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09deea2fc86b..72763f76b712 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1743,6 +1743,92 @@ void iommu_dma_free_iova(struct dma_iova_state *state)
 			      &iotlb_gather);
 }
 
+int iommu_dma_start_range(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled))
+		return iommu_deferred_attach(dev, domain);
+
+	return 0;
+}
+
+void iommu_dma_end_range(struct device *dev)
+{
+	/* TODO: Factor out ops->iotlb_sync_map(..) call from iommu_map()
+	 * and put it here to provide batched iotlb sync for the range.
+	 */
+}
+
+dma_addr_t iommu_dma_link_range(struct dma_iova_state *state, phys_addr_t phys,
+				size_t size, unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(state->dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t iova_off = iova_offset(iovad, phys);
+	bool coherent = dev_is_dma_coherent(state->dev);
+	int prot = dma_info_to_prot(state->dir, coherent, attrs);
+	dma_addr_t addr = state->addr + state->range_size;
+	int ret;
+
+	WARN_ON_ONCE(iova_off && state->range_size > 0);
+
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, size, state->dir);
+
+	size = iova_align(iovad, size + iova_off);
+	ret = iommu_map(domain, addr, phys - iova_off, size, prot, GFP_ATOMIC);
+	if (ret)
+		return ret;
+
+	state->range_size += size;
+	return addr + iova_off;
+}
+
+static void iommu_sync_dma_for_cpu(struct iommu_domain *domain,
+				   dma_addr_t start, size_t size,
+				   enum dma_data_direction dir)
+{
+	size_t sync_size, unmapped = 0;
+	phys_addr_t phys;
+
+	do {
+		phys = iommu_iova_to_phys(domain, start + unmapped);
+		if (WARN_ON(!phys))
+			continue;
+
+		sync_size = (unmapped + PAGE_SIZE > size) ? size % PAGE_SIZE :
+							    PAGE_SIZE;
+		arch_sync_dma_for_cpu(phys, sync_size, dir);
+		unmapped += sync_size;
+	} while (unmapped < size);
+}
+
+void iommu_dma_unlink_range(struct device *dev, dma_addr_t start, size_t size,
+			    enum dma_data_direction dir, unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iommu_iotlb_gather iotlb_gather;
+	bool coherent = dev_is_dma_coherent(dev);
+	size_t unmapped;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !coherent)
+		iommu_sync_dma_for_cpu(domain, start, size, dir);
+
+	size = iova_align(iovad, size);
+	unmapped = iommu_unmap_fast(domain, start, size, &iotlb_gather);
+	WARN_ON(unmapped != size);
+
+	if (!iotlb_gather.queued)
+		iommu_iotlb_sync(domain, &iotlb_gather);
+}
+
 void iommu_setup_dma_ops(struct device *dev)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
diff --git a/include/linux/iommu-dma.h b/include/linux/iommu-dma.h
index 698df67b152a..21b0341f52b8 100644
--- a/include/linux/iommu-dma.h
+++ b/include/linux/iommu-dma.h
@@ -60,6 +60,12 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 int iommu_dma_alloc_iova(struct dma_iova_state *state, phys_addr_t phys,
 			 size_t size);
 void iommu_dma_free_iova(struct dma_iova_state *state);
+int iommu_dma_start_range(struct device *dev);
+void iommu_dma_end_range(struct device *dev);
+dma_addr_t iommu_dma_link_range(struct dma_iova_state *state, phys_addr_t phys,
+				size_t size, unsigned long attrs);
+void iommu_dma_unlink_range(struct device *dev, dma_addr_t start, size_t size,
+			    enum dma_data_direction dir, unsigned long attrs);
 #else
 static inline bool use_dma_iommu(struct device *dev)
 {
@@ -184,5 +190,24 @@ static inline int iommu_dma_alloc_iova(struct dma_iova_state *state,
 static inline void iommu_dma_free_iova(struct dma_iova_state *state)
 {
 }
+static inline int iommu_dma_start_range(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+static inline void iommu_dma_end_range(struct device *dev)
+{
+}
+static inline dma_addr_t iommu_dma_link_range(struct dma_iova_state *state,
+					      phys_addr_t phys, size_t size,
+					      unsigned long attrs)
+{
+	return DMA_MAPPING_ERROR;
+}
+static inline void iommu_dma_unlink_range(struct device *dev, dma_addr_t start,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  unsigned long attrs)
+{
+}
 #endif /* CONFIG_IOMMU_DMA */
 #endif /* _LINUX_IOMMU_DMA_H */
-- 
2.46.0


