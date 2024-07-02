Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA43C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gy+X4jxy6GcXu5cpZnf0rnb3egcZsh/8Gh8+BiJ9zA=; b=dOjpJik1x17YQhbZpSE2q1/Jly
	tukdc4yLA/An8IOGQyZ4Yqs3NOUIkisui1f6vs9Jp3viOW+x6RDOnoOJVLO9XN2IGOEnLAGnhpvbb
	RgSSRUBzMFgHT0/OifLM7AjRYG8bqAud7K40TUQIfKoX1xkZgfRd9lGkQDd8kMkfZOjG4fYUdq7Rw
	LJgoc+OxBCI1rQs6kONYgYmIjDzrOfLreyLTQXgrdSoz031cO5INCE3skxBt1p7P5eHplNk5ap+Xn
	7t7DibKL4sfdlGyUeW6oK9yhjkn2JtiBUKAwYlG0begto0fcw38XDy4lH7XLmx9j1Yv5KlLqVxy+n
	9zZ+0N1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaXr-00000006JJl-3bBh;
	Tue, 02 Jul 2024 10:15:31 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZWz-000000065UJ-0HOo
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:10:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E4D27CE1CF0;
	Tue,  2 Jul 2024 09:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADDBC116B1;
	Tue,  2 Jul 2024 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911429;
	bh=suT8AWgnm6GBnp/JyhIgcl0q4xx7OPR0g7KMmtGZr9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rq4OARQmYhfiLIiz6G9wms51urucovfps8babGp4qOGPRB4+5JYgUHLAf6DLfrqPT
	 hJXfo5keL4ouKe9Y4EGQdEL9StrtH1y0FoD0WIEG6+W6CO3MX++fPmfQii7hxJRJux
	 fusUTN23YcTMGW6P7yhGGqD1y1aMsDmtGmRN8YuzUAp5T8XEoteErwwnKbH0sieTGn
	 NDceqME/1xe7SEg4mP6v20tLeGjQsiNWxolnzJ+VOCoSlueXx8IZMPwdetZjLTcW8K
	 X/5eBD/D3Zv08vRmpy+naCb5TKMeQuI9m5F7mEmHjHwRQltCAQDN/qS030U5hOEtlB
	 dKCPiM7uI6ZuQ==
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
Subject: [RFC PATCH v1 08/18] iommu/dma: Implement link/unlink ranges callbacks
Date: Tue,  2 Jul 2024 12:09:38 +0300
Message-ID: <c336d1535d0a7201af08b1c63cde4b9346187a2b.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_021033_605230_A28C8CFB 
X-CRM114-Status: GOOD (  14.30  )
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
 drivers/iommu/dma-iommu.c | 79 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0b5ca6961940..7425d155a14e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1731,6 +1731,82 @@ static void iommu_dma_free_iova(struct device *dev, dma_addr_t iova,
 	__iommu_dma_free_iova(cookie, iova, size, &iotlb_gather);
 }
 
+static int iommu_dma_start_range(struct dma_iova_state *state)
+{
+	struct device *dev = state->iova->dev;
+
+	state->domain = iommu_get_dma_domain(dev);
+
+	if (static_branch_unlikely(&iommu_deferred_attach_enabled))
+		return iommu_deferred_attach(dev, state->domain);
+
+	return 0;
+}
+
+static int iommu_dma_link_range(struct dma_iova_state *state, phys_addr_t phys,
+				dma_addr_t addr, size_t size)
+{
+	struct iommu_domain *domain = state->domain;
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	struct device *dev = state->iova->dev;
+	enum dma_data_direction dir = state->iova->dir;
+	bool coherent = dev_is_dma_coherent(dev);
+	unsigned long attrs = state->iova->attrs;
+	int prot = dma_info_to_prot(dir, coherent, attrs);
+
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, size, dir);
+
+	size = iova_align(iovad, size);
+	return iommu_map(domain, addr, phys, size, prot, GFP_ATOMIC);
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
+static void iommu_dma_unlink_range(struct dma_iova_state *state,
+				   dma_addr_t start, size_t size)
+{
+	struct device *dev = state->iova->dev;
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iommu_iotlb_gather iotlb_gather;
+	bool coherent = dev_is_dma_coherent(dev);
+	unsigned long attrs = state->iova->attrs;
+	size_t unmapped;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !coherent)
+		iommu_sync_dma_for_cpu(domain, start, size, state->iova->dir);
+
+	size = iova_align(iovad, size);
+	unmapped = iommu_unmap_fast(domain, start, size, &iotlb_gather);
+	WARN_ON(unmapped != size);
+
+	if (!iotlb_gather.queued)
+		iommu_iotlb_sync(domain, &iotlb_gather);
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED |
 				  DMA_F_CAN_SKIP_SYNC,
@@ -1757,6 +1833,9 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.max_mapping_size       = iommu_dma_max_mapping_size,
 	.alloc_iova		= iommu_dma_alloc_iova,
 	.free_iova		= iommu_dma_free_iova,
+	.link_range		= iommu_dma_link_range,
+	.unlink_range		= iommu_dma_unlink_range,
+	.start_range		= iommu_dma_start_range,
 };
 
 void iommu_setup_dma_ops(struct device *dev)
-- 
2.45.2


