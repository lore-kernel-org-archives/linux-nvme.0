Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3434FC54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYb+zBT+l4bRumlZjw61WjNIKyLOpqGiPdeR0ak+ylo=; b=OoMS4SkaaZDqz2mnQJUIj1eFkL
	PKVwAFaYpliy7Wf9E1NLdwCz74vIkw9OOMg8m1GKzyZozQzvJCrr1WbLntaqCu2k5GHaom/Zsv813
	ZPlk7QtwBUQYu8IIC5VsEH8fm2yJXdpOyhlJ/kWOCqnYLPTl0w5GBS4F4uS0J6UNUWQGfwyUU7SUu
	MGW+CJSggHPTzOwufECJ/sT2aN638NRJLs+RtNisfqlwuQnwhQnalQZv5Vk6ZeFPMnGiKSuDb4ua8
	M5vV/Rp3nKqGOLhu7aka+RunU3s5tz8ZI5fPjL15IVbbEsCQ3/dXRB7pPpORRuHK+H+sXHFMElawf
	Fd13hOyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUz8-0000000Dp1G-1Hyp;
	Tue, 05 Mar 2024 13:37:34 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSpc-0000000DIrE-1gkN
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 11:19:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B88C0CE1870;
	Tue,  5 Mar 2024 11:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59047C43390;
	Tue,  5 Mar 2024 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637574;
	bh=inT0MN5YzB4Hs5AmOhFFcCz6zSy1Lq0FeGslm64Slg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEpa5Pm+Qqhj2EfkdTwTrAYyAvXIl0YrVxvx+DWKOg/8mx3vqZQn32kmJlhI1Jn5n
	 GkNRqePnBQ708Sr6/JNHoy038LyclUT7V9ppbAO8kM3l2Gld5oEnVCacbFXZ6lGe2x
	 8BOHhnFPUHmAF/ZNgkUh9zkKatGZOG1TSdpOKgPf8s6lDWYji4TtdmCdYu2MElxBbE
	 isrwPMzFErClEesG4gO7SMHRYcWtqsTO09CRwC5DnOQrJiJQcEenGg/0iPLenz8go1
	 a5fPge+AvbZx/ANhEW4V7LdpvOPRHNZyJ32k6pOXqocpU3f+5jaKdRBPtPTL+AfaFI
	 ckvCzL1UiaHcg==
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
Subject: [RFC RESEND 10/16] RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
Date: Tue,  5 Mar 2024 13:18:41 +0200
Message-ID: <8c6d5e7db2d1a01888cc7b9b9850b05e19c75c64.1709635535.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709635535.git.leon@kernel.org>
References: <cover.1709635535.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_031936_997070_0CFB8CC7 
X-CRM114-Status: GOOD (  23.66  )
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

From: Leon Romanovsky <leonro@nvidia.com>

RDMA UMEM never supported DMA addresses returned from SWIOTLB, as these
addresses should be programmed to the hardware which is not aware that
it is bounce buffers and not real ones.

Instead of silently leave broken system for the users who didn't
know it, let's be explicit and return an error to them.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-attributes.rst |  7 +++
 drivers/infiniband/core/umem_odp.c        | 77 +++++++++++------------
 include/linux/dma-mapping.h               |  6 ++
 kernel/dma/direct.h                       |  4 +-
 kernel/dma/mapping.c                      |  4 ++
 5 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 1887d92e8e92..b337ec65d506 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -130,3 +130,10 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
 subsystem that the buffer is fully accessible at the elevated privilege
 level (and ideally inaccessible or at least read-only at the
 lesser-privileged levels).
+
+DMA_ATTR_NO_TRANSLATION
+-----------------------
+
+This attribute is used to indicate to the DMA-mapping subsystem that the
+buffer is not subject to any address translation.  This is used for devices
+that doesn't need buffer bouncing or fixing DMA addresses.
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 1301009a6b78..57c56000f60e 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -50,51 +50,50 @@
 static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 				   const struct mmu_interval_notifier_ops *ops)
 {
+	size_t page_size = 1UL << umem_odp->page_shift;
 	struct ib_device *dev = umem_odp->umem.ibdev;
+	size_t ndmas, npfns;
+	unsigned long start;
+	unsigned long end;
 	int ret;
 
 	umem_odp->umem.is_odp = 1;
 	mutex_init(&umem_odp->umem_mutex);
 
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
-		ret = ib_dma_alloc_iova(dev, &umem_odp->iova);
-		if (ret)
-			goto out_pfn_list;
-
-		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
-						   umem_odp->umem.owning_mm,
-						   start, end - start, ops);
-		if (ret)
-			goto out_free_iova;
-	}
+	if (umem_odp->is_implicit_odp)
+		return 0;
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
+	umem_odp->iova.attrs = DMA_ATTR_NO_TRANSLATION;
+	ret = ib_dma_alloc_iova(dev, &umem_odp->iova);
+	if (ret)
+		goto out_pfn_list;
+
+	ret = mmu_interval_notifier_insert(&umem_odp->notifier,
+					   umem_odp->umem.owning_mm, start,
+					   end - start, ops);
+	if (ret)
+		goto out_free_iova;
 
 	return 0;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 91cc084adb53..89945e707a9b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -62,6 +62,12 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_NO_TRANSLATION: used to indicate that the buffer should not be mapped
+ * through address translation.
+ */
+#define DMA_ATTR_NO_TRANSLATION		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 1c30e1cd607a..1c9ec204c999 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -92,6 +92,8 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	if (is_swiotlb_force_bounce(dev)) {
 		if (is_pci_p2pdma_page(page))
 			return DMA_MAPPING_ERROR;
+		if (attrs & DMA_ATTR_NO_TRANSLATION)
+			return DMA_MAPPING_ERROR;
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
@@ -99,7 +101,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	    dma_kmalloc_needs_bounce(dev, size, dir)) {
 		if (is_pci_p2pdma_page(page))
 			return DMA_MAPPING_ERROR;
-		if (is_swiotlb_active(dev))
+		if (is_swiotlb_active(dev) && !(attrs & DMA_ATTR_NO_TRANSLATION))
 			return swiotlb_map(dev, phys, size, dir, attrs);
 
 		dev_WARN_ONCE(dev, 1,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f989c64622c2..49b1fde510c5 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -188,6 +188,10 @@ int dma_alloc_iova(struct dma_iova_attrs *iova)
 	struct device *dev = iova->dev;
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
+	if (dma_map_direct(dev, ops) && is_swiotlb_force_bounce(dev) &&
+	    iova->attrs & DMA_ATTR_NO_TRANSLATION)
+		return -EOPNOTSUPP;
+
 	if (dma_map_direct(dev, ops) || !ops->alloc_iova) {
 		iova->addr = 0;
 		return 0;
-- 
2.44.0


