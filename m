Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1643ACA0EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eUWODOYu7xl20YNi/5H7WavDXD5EiHAIElpuMjzztLk=; b=FPF6VkN+RgrXTCKmxM2/B01BRN
	QfyMMHPh2ZDFFqeBUtXQXwSOC1gkXcyjv5lbd/YJb/V4RpcmmuZBd530qAW6NIY4Y3HTymWgzkR+k
	2TbtqrAGOzxe6I6XxLgPMhWPG4BdkKPCRtjlejLoSWyinPqZgRyMxGjO64y/HYt3oUZE6j2Ozox52
	11ArYoy5Fzvfc3EOHelhhy6+NRG0W/wTUoYivERAaiB7J+i45vej/6EMGVGvkKG5O8VZfLp6PAP9B
	X1BqwPJELyFnXzN8oWaOn24NUYdQB4rGTUBQhHOlFG3Xjh6dA95JM0yt/mnz6jCdQewAZAvHU08k5
	gW13yc0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unbNO-00000005aU1-2BwF;
	Sun, 17 Aug 2025 11:16:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umcA4-00000000FUN-0hFo
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 17:54:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AD63A5C721E;
	Thu, 14 Aug 2025 17:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F749C4CEF6;
	Thu, 14 Aug 2025 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755194087;
	bh=6kQRc8M4kSTN6oNlv6UupesxmLI8KrU+a1TL4nhd0iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6w4ugQYiUdcIBDBap/wpiQAIwZla3sL70dXT7fdDwlS8iAo7WkvllaYcXF4QU2M9
	 kt4WEnzYrIn4ZDZURbuikMUlP1Qp9CxkQOq+obTZHosuKzmVJJ0AF/lK9fQSX5YtoJ
	 kzMxjlyIoIy5MaeVth9MfY0uS93UJW4vr922gEZKEo2egnsKAq7kg8ZgHQF2XBxqCZ
	 F1uVGjeU46DFgcCqPy+lW15qydDCb2UvhK7t93bEVpZBLmZ+yVMS129GxQ41QBkFWL
	 CFslA3zPU9Peu4BjTd3+d/0rvdaudAz+bJ7W9WzhuA5hIM9mliO10n+CPNH4ALRsGy
	 OQQa8odedrzVg==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-nvme@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 09/16] dma-mapping: handle MMIO flow in dma_map|unmap_page
Date: Thu, 14 Aug 2025 20:54:00 +0300
Message-ID: <ae473ed08a384bd70e3816cc74e11513213d71f4.1755193625.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755193625.git.leon@kernel.org>
References: <cover.1755193625.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_105448_282886_BEBF16F9 
X-CRM114-Status: GOOD (  14.42  )
X-Mailman-Approved-At: Sun, 17 Aug 2025 04:16:29 -0700
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

Extend base DMA page API to handle MMIO flow and follow
existing dma_map_resource() implementation to rely on dma_map_direct()
only to take DMA direct path.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/mapping.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 891e1fc3e582..fdabfdaeff1d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -158,6 +158,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	phys_addr_t phys = page_to_phys(page) + offset;
+	bool is_mmio = attrs & DMA_ATTR_MMIO;
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -166,14 +167,25 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	if (dma_map_direct(dev, ops) ||
-	    arch_dma_map_phys_direct(dev, phys + size))
+	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
-	else
+	else if (is_mmio) {
+		if (!ops->map_resource)
+			return DMA_MAPPING_ERROR;
+
+		addr = ops->map_resource(dev, phys, size, dir, attrs);
+	} else {
+		/*
+		 * The dma_ops API contract for ops->map_page() requires
+		 * kmappable memory, while ops->map_resource() does not.
+		 */
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	}
 
-	kmsan_handle_dma(phys, size, dir);
+	if (!is_mmio)
+		kmsan_handle_dma(phys, size, dir);
 	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
 	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
 
@@ -185,14 +197,18 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	bool is_mmio = attrs & DMA_ATTR_MMIO;
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (dma_map_direct(dev, ops) ||
-	    arch_dma_unmap_phys_direct(dev, addr + size))
+	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
-	else
+	else if (is_mmio) {
+		if (ops->unmap_resource)
+			ops->unmap_resource(dev, addr, size, dir, attrs);
+	} else
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
 	debug_dma_unmap_phys(dev, addr, size, dir);
-- 
2.50.1


