Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7322C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DGOWTpc0mK7AvFB2rfCYarTy/YnOa82zBOZKlzEOfvY=; b=AEZNAgwlLlXSzTA1wsdMCxDOww
	Q9DcWoHnQWLgsndi6wYj+tV4di7nFo0SXV8q3vIEKImbf6qSbKYlmZh30zY/S/q61tdD7j1wbq3Om
	2m7NJMt7n3Hfgrz7vahVlzk5muaJepWn+LJjtZoGZ6TbhTPY5qT8ySFuGxU8fMTnf5iYr+YCJWleG
	5zJjq+AWCNBn69OhowS9JiChSOi8uq0VvPXTAveAxPUsNZ7PA32FNC92OOGoolfBxN/yoqBn9OJCX
	T5aBkJ1JWZWwbD/vhYt1xUHHASwanmce6DsnO0etSIwurmsSN0vbNo9jNvLmI4Dr0wTlqIYPbr1nk
	/Wg9R28Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUxw-0000000DoEW-0FEN;
	Tue, 05 Mar 2024 13:36:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhRwc-0000000D0rp-16BH
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 10:22:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6ADA4CE19DD;
	Tue,  5 Mar 2024 10:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D92C433F1;
	Tue,  5 Mar 2024 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634163;
	bh=W6hmByMbviZow30AysrbmdCiStk7NPI/+8Qeoey1JY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJY3Cs6hl4Xyiy72UOBb36BBQES0tf2UyuIkZqN3zk2QMVL6VZ1r1ZL1bFH3ozG3P
	 5VrQJCwX96mJl651aGVoS6sb3Q/RHhZj+G03f7OM39qsZDs0xSmhgciEKkPmEOuG9v
	 wXJT9T/W6Ns8h9LonwMY/i6iJMWL44XqUkr4OJGJplIF4xc26usfc10rpE5C+xcDb/
	 TdpGb7e9aZHebhPTlz4SjZCcOElLbhKh21/SJQAb6sU4Cjd/bj0OmGdmILSjNU88fA
	 ptQmmFPbzQ681LIvARYDHdn4bdOX7/AG9vGeS8VEZoDFfVqidpSJl1IFUBlipPAPxA
	 LLo2Q0npbcszA==
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
Subject: [RFC 04/16] iommu/dma: Provide an interface to allow preallocate IOVA
Date: Tue,  5 Mar 2024 12:22:05 +0200
Message-ID: <e580473eb571d56c8e3952ebcdab05151a7efe7c.1709631413.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709631800.git.leon@kernel.org>
References: <cover.1709631800.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_022246_707275_7A65A2F8 
X-CRM114-Status: GOOD (  15.48  )
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
Message-ID: <20240305102205.fnrm-X2hfplJgZy9x7qzc-jRmYZlP30X5yq2nhydl2M@z>

From: Leon Romanovsky <leonro@nvidia.com>

Separate IOVA allocation to dedicated callback so it will allow
cache of IOVA and reuse it in fast paths for devices which support
ODP (on-demand-paging) mechanism.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 50 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..e55726783501 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -356,7 +356,7 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	atomic_set(&cookie->fq_timer_on, 0);
 	/*
 	 * Prevent incomplete fq state being observable. Pairs with path from
-	 * __iommu_dma_unmap() through iommu_dma_free_iova() to queue_iova()
+	 * __iommu_dma_unmap() through __iommu_dma_free_iova() to queue_iova()
 	 */
 	smp_wmb();
 	WRITE_ONCE(cookie->fq_domain, domain);
@@ -760,7 +760,7 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
-static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
+static dma_addr_t __iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -806,7 +806,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	return (dma_addr_t)iova << shift;
 }
 
-static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
+static void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 		dma_addr_t iova, size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &cookie->iovad;
@@ -843,7 +843,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
+	__iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -861,12 +861,12 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	size = iova_align(iovad, size + iova_off);
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dma_mask, dev);
 	if (!iova)
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map(domain, iova, phys - iova_off, size, prot, GFP_ATOMIC)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+		__iommu_dma_free_iova(cookie, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -970,7 +970,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 		return NULL;
 
 	size = iova_align(iovad, size);
-	iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
 	if (!iova)
 		goto out_free_pages;
 
@@ -1004,7 +1004,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 out_free_sg:
 	sg_free_table(sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	__iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -1436,7 +1436,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (!iova_len)
 		return __finalise_sg(dev, sg, nents, 0);
 
-	iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+	iova = __iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
 	if (!iova) {
 		ret = -ENOMEM;
 		goto out_restore_sg;
@@ -1453,7 +1453,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
+	__iommu_dma_free_iova(cookie, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 out:
@@ -1706,6 +1706,30 @@ static size_t iommu_dma_opt_mapping_size(void)
 	return iova_rcache_range();
 }
 
+static dma_addr_t iommu_dma_alloc_iova(struct device *dev, size_t size)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	dma_addr_t dma_mask = dma_get_mask(dev);
+
+	size = iova_align(iovad, size);
+	return __iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+}
+
+static void iommu_dma_free_iova(struct device *dev, dma_addr_t iova,
+				size_t size)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	struct iommu_iotlb_gather iotlb_gather;
+
+	size = iova_align(iovad, size);
+	iommu_iotlb_gather_init(&iotlb_gather);
+	__iommu_dma_free_iova(cookie, iova, size, &iotlb_gather);
+}
+
 static const struct dma_map_ops iommu_dma_ops = {
 	.flags			= DMA_F_PCI_P2PDMA_SUPPORTED,
 	.alloc			= iommu_dma_alloc,
@@ -1728,6 +1752,8 @@ static const struct dma_map_ops iommu_dma_ops = {
 	.unmap_resource		= iommu_dma_unmap_resource,
 	.get_merge_boundary	= iommu_dma_get_merge_boundary,
 	.opt_mapping_size	= iommu_dma_opt_mapping_size,
+	.alloc_iova		= iommu_dma_alloc_iova,
+	.free_iova		= iommu_dma_free_iova,
 };
 
 /*
@@ -1776,7 +1802,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	if (!msi_page)
 		return NULL;
 
-	iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+	iova = __iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
 	if (!iova)
 		goto out_free_page;
 
@@ -1790,7 +1816,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	__iommu_dma_free_iova(cookie, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
-- 
2.44.0


