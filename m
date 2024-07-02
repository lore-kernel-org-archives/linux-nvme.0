Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C34EC30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wlDjMGMoY5vmg8XP+VTRHx2+O1DZwsQWCcm7mjUpOdM=; b=t4J+Qg4tzTeskRKCyN9zeICT0r
	GAr4Y8GuL7xwyDkktFQuF+CW7jCH6fqT4nfSc4P9T/v2JYI2iFdivNCOTwncWjXXlMomje0mwI4ou
	nRXCAFKov8Vhex2zMWb//dSnPNRqcysNpQdE9O4NE757n8g8rxQV4gDR1SnhAwCRKW9s4+LmyLSwK
	LGRTSUOn0DWlvDzAOX8ERMAzOUMmlKgAaa3sI7/UAJT3UupvPkPq/0IhX3xl27j6KJvo0c7z+Sm0J
	eRvb3BpbpnNX5G9QcqNOrgOslsz7yc33md/voESIXlp74x5M55PJkZ5EzQBwl5amDSBe27gYhv/VQ
	l10enMSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaXs-00000006JJw-2uiW;
	Tue, 02 Jul 2024 10:15:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOZXC-000000065hZ-2mDJ
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 09:10:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0574461A24;
	Tue,  2 Jul 2024 09:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9F3C4AF0A;
	Tue,  2 Jul 2024 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719911445;
	bh=pdK7V9xHdNBFoHCz59AGR5WOTx5xl2Vj8twOHvengYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTz8NtUcFIGsDCeQDH+Db9PamT6/nlViuegQcsznIc+DF9srj7x240NEr4il//Xc/
	 8i6luwPgO0yiJWdOnRcYYR5NL7yfawxlEKbv7drJYa8B4a339djv3OvkkqYT8c8H3F
	 2fawWfN+3TdW5300DYyGBMMir31FVKME3Mb0rFDkEafNNmyz4K9325deM1XSwCqvmZ
	 j68Pmkr7YplRS9KcdrYMe4vUV3x2d5CnPCIdbVmN1wj2l59g8sgHeEOk1PKw3gUGEO
	 sLuttA9bzZDdVviGMe/UOzCvZZ/jZMpHBqkeBTmM9HISPNn+o452NCrh1hoAqBSCYz
	 dRKD1bcV6Pa7w==
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
Subject: [RFC PATCH v1 12/18] RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
Date: Tue,  2 Jul 2024 12:09:42 +0300
Message-ID: <d18c454636bf3cfdba9b66b7cc794d713eadc4a5.1719909395.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719909395.git.leon@kernel.org>
References: <cover.1719909395.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_021046_992855_9EC6BCBA 
X-CRM114-Status: GOOD (  15.63  )
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
 drivers/infiniband/core/umem_odp.c | 81 +++++++++++++++---------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 6e170cb5110c..12186717a892 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -42,7 +42,8 @@
 #include <linux/interval_tree.h>
 #include <linux/hmm.h>
 #include <linux/pagemap.h>
-
+#include <linux/dma-map-ops.h>
+#include <linux/swiotlb.h>
 #include <rdma/ib_umem_odp.h>
 
 #include "uverbs.h"
@@ -51,50 +52,50 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
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
+	if (dev_use_swiotlb(dev->dma_device, page_size, DMA_BIDIRECTIONAL) ||
+	    is_swiotlb_force_bounce(dev->dma_device))
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
+	umem_odp->iova.dev = dev->dma_device;
+	umem_odp->iova.size = end - start;
+	umem_odp->iova.dir = DMA_BIDIRECTIONAL;
+	ret = dma_alloc_iova(&umem_odp->iova);
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
-		umem_odp->iova.dev = dev->dma_device;
-		umem_odp->iova.size = end - start;
-		umem_odp->iova.dir = DMA_BIDIRECTIONAL;
-		ret = dma_alloc_iova(&umem_odp->iova);
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
 
-- 
2.45.2


