Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39823C02185
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Irhj2QQiTBNUb9SSTzF7SWHwxYmY67f2A+u8b3gQU54=; b=xAKnB4ql6UTDqesQbfbfP3+TSU
	0gd2y4DFDHHBNxpqqtiykMtGnAGJ8KCCSeCK62SNlDOholucHe9dfAHttR6iKzhxABcJ64G+9F39m
	ai0BP9DyZY+NiXkmfrToR9XKExyOpcGroDmTfIqwWfEmOOyDilMoTmuxL0H+kE2zpvaC6SB2ViTnh
	Hm/ZPoGiakeDeBfFCUDoDSHZULex+WYvknIJKjm9Gb4okJyMBWi7hvlx31PBrTsJANX6WK9CQmSHp
	wHMro4PKG4i1D14f+62qj6MrpYhETGiUs7fv/rSghN9BjoZ2VJDizU28VJdcJTq8vgrouEs6/1xO9
	2weAZnhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYkMI-000000007Fm-0joT;
	Fri, 17 Jan 2025 11:17:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYjDu-0000000HXUd-1QkJ
	for linux-nvme@bombadil.infradead.org;
	Fri, 17 Jan 2025 10:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Irhj2QQiTBNUb9SSTzF7SWHwxYmY67f2A+u8b3gQU54=; b=KEp+lr0C5kW/nPSE9SlRZEJNHf
	EdLmSs2TIFcNV3E+xqUBMfniAiYSbGhXTsHWmIrCWxQjCbm2zM4pyDZSLUA9WL1udMs6tvBpzeu0D
	PfKSUiqKX1xi+SFAQ1w/im2ZzVw3b3EOcGnX7FOh7A1sa15g1VaD17qaUSB8+JOYZWqxw9CAE4aWt
	zWfmG9HlWMNlBSD8WejF8FjE9iragXi460Fwqjumghce2FlL/HYCxwH7FtGrMtl+tCC4h4c/9+Cth
	BlHNBc04dLtBb18ogGkfzc0zLP8lZXFP4HhONxCigYOyovfwzrFcuoRvMZq9rRVgwg8Y8XdAsKIdA
	fHhbbBSA==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYjDY-0000000BOpl-1AnU
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 10:05:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CF07FA42B32;
	Fri, 17 Jan 2025 10:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8323C4CEDD;
	Fri, 17 Jan 2025 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737108279;
	bh=FJYQ7qR9hcBLpRhiPHcPvV9HvqBheLEfsFGqvBAMLaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vExohzXD6Ujd7i5ylWAXIQ8r+KiHahR4ugS8NzRN12jXXWg6XpFDS0Az2kDJdGS3b
	 r2P83zACaoMN4Wm74N2ASzU3RY5SHuQvegOGleRrgJR0ewKZNF1R7rYaprTdiqfZta
	 qHAONZp/pjWD0Exsf2wMAG5W74kZ9llv+fixzaMpWuVhexQbaRl57Q96SppjOh8KaZ
	 UB7ck8uR8pWleUg587r5ORtXxR7k4/8yK6Oa7z3askZexI38iaJksqiskbye1+z2jM
	 yfRbYsVQg1Ux+DbZ9S99dgY9nJvxXEfXBrI8xyOVSpm8JiF79noUc1A75KueNPzS9U
	 QWTZ4Ku7NpBiA==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Keith Busch" <kbusch@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Logan Gunthorpe" <logang@deltatee.com>,
	"Yishai Hadas" <yishaih@nvidia.com>,
	"Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
	"Kevin Tian" <kevin.tian@intel.com>,
	"Alex Williamson" <alex.williamson@redhat.com>,
	"Marek Szyprowski" <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	"Randy Dunlap" <rdunlap@infradead.org>
Subject: [PATCH v6 08/17] dma-mapping: add a dma_need_unmap helper
Date: Fri, 17 Jan 2025 12:03:39 +0200
Message-ID: <9458f681274f4f0e5dd3bf3959e0b8a1ac9a4e7b.1737106761.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737106761.git.leon@kernel.org>
References: <cover.1737106761.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_100457_977276_49FC3A9C 
X-CRM114-Status: GOOD (  13.44  )
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

Add helper that allows a driver to skip calling dma_unmap_*
if the DMA layer can guarantee that they are no-nops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/dma-mapping.h |  5 +++++
 kernel/dma/mapping.c        | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a71e110f1e9d..d2f358c5a25d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -406,6 +406,7 @@ static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_dev_need_sync(dev) ? __dma_need_sync(dev, dma_addr) : false;
 }
+bool dma_need_unmap(struct device *dev);
 #else /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 static inline bool dma_dev_need_sync(const struct device *dev)
 {
@@ -431,6 +432,10 @@ static inline bool dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return false;
 }
+static inline bool dma_need_unmap(struct device *dev)
+{
+	return false;
+}
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index cda127027e48..3c3204ad2839 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -443,6 +443,24 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
 }
 EXPORT_SYMBOL_GPL(__dma_need_sync);
 
+/**
+ * dma_need_unmap - does this device need dma_unmap_* operations
+ * @dev: device to check
+ *
+ * If this function returns %false, drivers can skip calling dma_unmap_* after
+ * finishing an I/O.  This function must be called after all mappings that might
+ * need to be unmapped have been performed.
+ */
+bool dma_need_unmap(struct device *dev)
+{
+	if (!dma_map_direct(dev, get_dma_ops(dev)))
+		return true;
+	if (!dev->dma_skip_sync)
+		return true;
+	return IS_ENABLED(CONFIG_DMA_API_DEBUG);
+}
+EXPORT_SYMBOL_GPL(dma_need_unmap);
+
 static void dma_setup_need_sync(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-- 
2.47.1


