Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36580C3ABA4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 13:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaWDhC+o6t4QNumdRypAhbcIqTdOEcDVYPDxj5A29h4=; b=lj1ToOLevQzpjO0Ey4GArfuQi1
	l6CK4Gqy7KvCXxDPWlUanY402W/IqETMJfHs8pS+C7sYyOv7MkdcRaCiOqrehjr0OIClmgXAQkon5
	rRVhFbvR2/couaATnhV5bY/RGRVFLVJ1R4ygUdqvLj3C/7J8m0w4kY9UEp7kd86zPyQhLxZ5wqq3b
	hWVltVI/+9QKA6SILl/mTawFDKgC520eUiiF3XABnqqrZXhe/jBxSwRzpOtnnWUIHohnrOUlNDb+I
	fKZi7Rt0M+g1dLNYO6Ph8MvThKxrDkxiasXOsSLHxEIHr5nXOGIMXJjWvnKSIfM71fbsRD8yF4XyQ
	Rknv7YrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9O9m-00000006JfA-1vCH;
	Mon, 28 Apr 2025 13:04:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Khb-00000005aK9-2LA9
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 09:23:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 40AEA61156;
	Mon, 28 Apr 2025 09:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1CFC4CEE9;
	Mon, 28 Apr 2025 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745832182;
	bh=NSjvHXdN9Auhws02PZWMgoFw38+PyYsmwJSV2Mf4l+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkJSRLTHZU22u1UhQ67MPM9g63S7XvmwGzUbJuzqOOoixyYAyVfnA04t4wkZADAmT
	 Kp8RGfRAN5KkYQzvIv85m/MuedCEbIZLkadhGViQy0IoLd+Ybez+IHCgO2/uSYjZND
	 pr/fjH+IU4RZjijmZEtuma8QCzj/V5qs8RmmPj14QRRr0zIjZpIQy4fJvwiCfDn3hb
	 LHesU6Nn6nX3ydTqwP9xqMbEkv2CKn08JumCY+lk4i/fp1QJciqX9Y3b0H4KtHsEAv
	 OgC6Gcr8vk1MCui06+shS3RvU4kjjpK+rarol/LeBfDsV+Z4blbG4gtyfxLsC6nX+g
	 pwpQ+Io0zJd5w==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
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
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v10 03/24] iommu: generalize the batched sync after map interface
Date: Mon, 28 Apr 2025 12:22:09 +0300
Message-ID: <69da19d2cc5df0be5112f0cf2365a0337b00d873.1745831017.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745831017.git.leon@kernel.org>
References: <cover.1745831017.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 05:19:59 -0700
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

From: Christoph Hellwig <hch@lst.de>

For the upcoming IOVA-based DMA API we want to batch the
ops->iotlb_sync_map() call after mapping multiple IOVAs from
dma-iommu without having a scatterlist. Improve the API.

Add a wrapper for the map_sync as iommu_sync_map() so that callers
don't need to poke into the methods directly.

Formalize __iommu_map() into iommu_map_nosync() which requires the
caller to call iommu_sync_map() after all maps are completed.

Refactor the existing sanity checks from all the different layers
into iommu_map_nosync().

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Will Deacon <will@kernel.org>
Tested-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
 include/linux/iommu.h |  4 +++
 2 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..02960585b8d4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2443,8 +2443,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
 	return pgsize;
 }
 
-static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
-		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
+		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	const struct iommu_domain_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
@@ -2453,12 +2453,19 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
+	might_sleep_if(gfpflags_allow_blocking(gfp));
+
 	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
 		return -EINVAL;
 
 	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
+	/* Discourage passing strange GFP flags */
+	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
+				__GFP_HIGHMEM)))
+		return -EINVAL;
+
 	/* find out the minimum page size supported */
 	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
@@ -2506,31 +2513,27 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+int iommu_sync_map(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
 	const struct iommu_domain_ops *ops = domain->ops;
-	int ret;
-
-	might_sleep_if(gfpflags_allow_blocking(gfp));
 
-	/* Discourage passing strange GFP flags */
-	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
-				__GFP_HIGHMEM)))
-		return -EINVAL;
+	if (!ops->iotlb_sync_map)
+		return 0;
+	return ops->iotlb_sync_map(domain, iova, size);
+}
 
-	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
-	if (ret == 0 && ops->iotlb_sync_map) {
-		ret = ops->iotlb_sync_map(domain, iova, size);
-		if (ret)
-			goto out_err;
-	}
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+{
+	int ret;
 
-	return ret;
+	ret = iommu_map_nosync(domain, iova, paddr, size, prot, gfp);
+	if (ret)
+		return ret;
 
-out_err:
-	/* undo mappings already done */
-	iommu_unmap(domain, iova, size);
+	ret = iommu_sync_map(domain, iova, size);
+	if (ret)
+		iommu_unmap(domain, iova, size);
 
 	return ret;
 }
@@ -2630,26 +2633,17 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		     struct scatterlist *sg, unsigned int nents, int prot,
 		     gfp_t gfp)
 {
-	const struct iommu_domain_ops *ops = domain->ops;
 	size_t len = 0, mapped = 0;
 	phys_addr_t start;
 	unsigned int i = 0;
 	int ret;
 
-	might_sleep_if(gfpflags_allow_blocking(gfp));
-
-	/* Discourage passing strange GFP flags */
-	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
-				__GFP_HIGHMEM)))
-		return -EINVAL;
-
 	while (i <= nents) {
 		phys_addr_t s_phys = sg_phys(sg);
 
 		if (len && s_phys != start + len) {
-			ret = __iommu_map(domain, iova + mapped, start,
+			ret = iommu_map_nosync(domain, iova + mapped, start,
 					len, prot, gfp);
-
 			if (ret)
 				goto out_err;
 
@@ -2672,11 +2666,10 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
-	if (ops->iotlb_sync_map) {
-		ret = ops->iotlb_sync_map(domain, iova, mapped);
-		if (ret)
-			goto out_err;
-	}
+	ret = iommu_sync_map(domain, iova, mapped);
+	if (ret)
+		goto out_err;
+
 	return mapped;
 
 out_err:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ccce8a751e2a..ce472af8e9c3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -872,6 +872,10 @@ extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
+		phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
+int iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+		size_t size);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			  size_t size);
 extern size_t iommu_unmap_fast(struct iommu_domain *domain,
-- 
2.49.0


