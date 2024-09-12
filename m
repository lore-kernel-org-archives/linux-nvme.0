Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4EDEEB594
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mr0G1m8SROsZ7tCbvxfUWydjf4YRJTndQwy2lASZe5A=; b=Q3R31drb9050BFG2BbHrVJ/3lP
	rZ8W5swX2r9ECw3F2irivmzxnrCoSqsaYrARdLgZlox5vEobHipegCUmYI367r8iUoCVyVf7UBKL+
	Uz2klXdjoA8R9DWD3gv2+h6snEWqr0amgixpckI17ydEankUR1em0Bi254Hv1RDf9/eMWj99xCFjV
	5e8+zu0yhj9ivHTNd4owrMtQOafPF0STug82rNhWH7IhtKGJYMGLdPFUjGf1vMqGo/Xh5y2itoprm
	h6u/a8S9Eg2dsx49z7S9owOfkly98hOIRYdGDqDi2WY7IcDrxflhsAyQ8qt/3qfvc8UBw8o11shPB
	FApORzWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohpN-0000000CoNx-3aFX;
	Thu, 12 Sep 2024 11:17:33 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohpH-0000000CoIo-1oU5
	for linux-nvme@bombadil.infradead.org;
	Thu, 12 Sep 2024 11:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Mr0G1m8SROsZ7tCbvxfUWydjf4YRJTndQwy2lASZe5A=; b=UVNck8N4qj543BEfPNtBkPHqiG
	uPnd4kSpaeFHSE2uT9m35nsqe22lPtJlsxN7YayyNgGqNMjqdto0k35fss6vCrDtXxi7ix4jdaaz4
	deuUZAcfcNagyOwB93mR1EtrLvyXNlfKVp4Glr0SrxR3J0LnamNcazzVh7Ea2U09GR+JyJHXqvK+7
	bT7vZR4QnGZ5u/6c2wPlh54tGr5dkxLdkHUmjlz1EEBV4dJU/ztAvzZMaEx+o0PLlYEjY0bg5HmWo
	oqRv4/igVBN9CjOEVkxex9LWRtM//wGxowcAPo4NOZk2n5TgqxtRRZ7DEnTtpwETWwN0mJc93Qrjl
	bK0v4XQw==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sohpD-000000071YJ-33bC
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:17:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 788325C5AAC;
	Thu, 12 Sep 2024 11:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BF2C4CEC3;
	Thu, 12 Sep 2024 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139837;
	bh=wkFj1cXNmX5ZlhYlYscU+J0rWGL2pg30iH0xC9v8VVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFWaxyYpYfe2FFX+K0p+Goy6dyaOFgOpyojuT6rJgqucu1wtXJ7Ko6B4Z9/VXe95S
	 2I3S4vrw+Ff5zb5nynL5Vh4Yw/g8+uv0ZNC87b03g7DhVrmV3YivYg7uBbwVNe/GZG
	 +MBvLijRXvMiwL3ZM84io5kv0P8Wbcp45n4DIbM7CtyDWAAQlTWkB20jUCGxLF406f
	 CPRu/FtyIHE0iWOhGGjqbS+ZeLgoViJvPDk3twLQyYGb5FUYjNquCd5o/JMVAX1ObX
	 p/Oa3w5s2HlnKu34VY+AD80OkZOKYp43R+53dQV6GuLtLI/rUJqwRY2wXjSwusplbM
	 Yvypy/0K4VPSA==
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
Subject: [RFC v2 13/21] RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
Date: Thu, 12 Sep 2024 14:15:48 +0300
Message-ID: <aea35c71f773eb6925dd1fcd9a8f6ac5fd87a4c5.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726138681.git.leon@kernel.org>
References: <cover.1726138681.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_121724_049679_DCD7A267 
X-CRM114-Status: GOOD (  15.88  )
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

RDMA UMEM never supported DMA addresses returned from SWIOTLB, as these
addresses should be programmed to the hardware which is not aware that
it is bounce buffers and not real ones.

Instead of silently leave broken system for the users who didn't
know it, let's be explicit and return an error to them.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 78 +++++++++++++++---------------
 drivers/iommu/dma-iommu.c          |  1 +
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 7bfa1e54454c..58fc3d4bfb73 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -42,7 +42,7 @@
 #include <linux/interval_tree.h>
 #include <linux/hmm.h>
 #include <linux/pagemap.h>
-
+#include <linux/iommu-dma.h>
 #include <rdma/ib_umem_odp.h>
 
 #include "uverbs.h"
@@ -51,49 +51,49 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 				   const struct mmu_interval_notifier_ops *ops)
 {
 	struct ib_device *dev = umem_odp->umem.ibdev;
+	size_t page_size = 1UL << umem_odp->page_shift;
+	unsigned long start, end;
+	size_t ndmas, npfns;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
 	mutex_init(&umem_odp->umem_mutex);
+	if (umem_odp->is_implicit_odp)
+		return 0;
+
+	if (!iommu_can_use_iova(dev->dma_device, NULL, page_size,
+				DMA_BIDIRECTIONAL))
+		return -EOPNOTSUPP;
+
+	start = ALIGN_DOWN(umem_odp->umem.address, page_size);
+	if (check_add_overflow(umem_odp->umem.address,
+			       (unsigned long)umem_odp->umem.length, &end))
+		return -EOVERFLOW;
+	end = ALIGN(end, page_size);
+	if (unlikely(end < page_size))
+		return -EOVERFLOW;
+
+	ndmas = (end - start) >> umem_odp->page_shift;
+	if (!ndmas)
+		return -EINVAL;
+
+	npfns = (end - start) >> PAGE_SHIFT;
+	umem_odp->pfn_list =
+		kvcalloc(npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
+	if (!umem_odp->pfn_list)
+		return -ENOMEM;
+
+	dma_init_iova_state(&umem_odp->state, dev->dma_device,
+			    DMA_BIDIRECTIONAL);
+	ret = dma_alloc_iova(&umem_odp->state, end - start);
+	if (ret)
+		goto out_pfn_list;
 
-	if (!umem_odp->is_implicit_odp) {
-		size_t page_size = 1UL << umem_odp->page_shift;
-		unsigned long start;
-		unsigned long end;
-		size_t ndmas, npfns;
-
-		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
-		if (check_add_overflow(umem_odp->umem.address,
-				       (unsigned long)umem_odp->umem.length,
-				       &end))
-			return -EOVERFLOW;
-		end = ALIGN(end, page_size);
-		if (unlikely(end < page_size))
-			return -EOVERFLOW;
-
-		ndmas = (end - start) >> umem_odp->page_shift;
-		if (!ndmas)
-			return -EINVAL;
-
-		npfns = (end - start) >> PAGE_SHIFT;
-		umem_odp->pfn_list = kvcalloc(
-			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
-		if (!umem_odp->pfn_list)
-			return -ENOMEM;
-
-
-		dma_init_iova_state(&umem_odp->state, dev->dma_device,
-				    DMA_BIDIRECTIONAL);
-		ret = dma_alloc_iova(&umem_odp->state, end - start);
-		if (ret)
-			goto out_pfn_list;
-
-		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
-						   umem_odp->umem.owning_mm,
-						   start, end - start, ops);
-		if (ret)
-			goto out_free_iova;
-	}
+	ret = mmu_interval_notifier_insert(&umem_odp->notifier,
+					   umem_odp->umem.owning_mm, start,
+					   end - start, ops);
+	if (ret)
+		goto out_free_iova;
 
 	return 0;
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3e2e382bb502..af3428ae150d 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1849,6 +1849,7 @@ bool iommu_can_use_iova(struct device *dev, struct page *page, size_t size,
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(iommu_can_use_iova);
 
 void iommu_setup_dma_ops(struct device *dev)
 {
-- 
2.46.0


