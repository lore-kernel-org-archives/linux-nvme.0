Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064D4C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Aug 2025 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rGuRtbHmiVjjoyecHucW808Sk+vwQ2t58s6Fmx6aNN0=; b=azbh1U18SGFsCNddym3vGz09I1
	SAZAaoZBDu8nurmKdrZglrQpT6FK6lNmXavQ9nySne1xMbEXLbj81mp1m/QZghNR1TBu4P78NuD6M
	EdmDSTiJmVn7H5/0NXLx9GnGicuDa7JnsylibduN3MxE1L0SkulVVUCrLwn6okGAZWoaK25Q7jP54
	G40Ug08T0v/kOv0szU+TF89RVVP2we0F1udl9q4Yn2N5/P9g8psYdc37hb+zaV/6cHpKksEnNXDr8
	8mEFZfcs+DFmwSybfe2Q+sviugGTe7siHBGgh9OTf9ul0dnD/la3T97dR1B2KFiI7KxYoLyXNcpZi
	8pNN6avQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uk25x-00000000u6I-1Sy4;
	Thu, 07 Aug 2025 14:59:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiuXo-0000000AP0d-0P7U
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 12:44:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BB55A43C23;
	Mon,  4 Aug 2025 12:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82117C4CEF8;
	Mon,  4 Aug 2025 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754311439;
	bh=KD5XpS99kfAtzNwNr0G2cKeknKa6uIV3HkFwkgt52Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REzkJIVPP9gFnq006IpzWA33deEBq3gq/L07hYxS4b9Co9lY/j51ovFGlZKxGO1e5
	 4+8sYBN0i9v9K0mgKzmZ/QHCuA9Q46V87wtCzHKFC0ANzBr9PuysZxQhOrNozb4Qyk
	 VihVy8omfI8O2IRdV4Tyl6d0KjHEM3acEvXoNbj8+O8OXRRPHQMKadb9piVN0E1Wap
	 K/UpRFgSWAcvtvvkCiTXu1nv84wDzdAsa9r8/C/wTH34YjDjAVJPlKm4jsTlVi+zRC
	 U+eUEQKpw0KzkD87pD1mxwxAbEEaEpX1KJV4/DAHcK3vw7alfBmL84qIH19KHyRx/5
	 kND7FSCrGya4g==
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
Subject: [PATCH v1 08/16] kmsan: convert kmsan_handle_dma to use physical addresses
Date: Mon,  4 Aug 2025 15:42:42 +0300
Message-ID: <5b40377b621e49ff4107fa10646c828ccc94e53e.1754292567.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754292567.git.leon@kernel.org>
References: <cover.1754292567.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_054400_197269_712D0D72 
X-CRM114-Status: GOOD (  23.38  )
X-Mailman-Approved-At: Thu, 07 Aug 2025 07:59:41 -0700
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

Convert the KMSAN DMA handling function from page-based to physical
address-based interface.

The refactoring renames kmsan_handle_dma() parameters from accepting
(struct page *page, size_t offset, size_t size) to (phys_addr_t phys,
size_t size). A PFN_VALID check is added to prevent KMSAN operations
on non-page memory, preventing from non struct page backed address,

As part of this change, support for highmem addresses is implemented
using kmap_local_page() to handle both lowmem and highmem regions
properly. All callers throughout the codebase are updated to use the
new phys_addr_t based interface.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/virtio/virtio_ring.c |  4 ++--
 include/linux/kmsan.h        | 12 +++++++-----
 kernel/dma/mapping.c         |  2 +-
 mm/kmsan/hooks.c             | 36 +++++++++++++++++++++++++++++-------
 tools/virtio/linux/kmsan.h   |  2 +-
 5 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f5062061c4084..c147145a65930 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -378,7 +378,7 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 		 * is initialized by the hardware. Explicitly check/unpoison it
 		 * depending on the direction.
 		 */
-		kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, direction);
+		kmsan_handle_dma(sg_phys(sg), sg->length, direction);
 		*addr = (dma_addr_t)sg_phys(sg);
 		return 0;
 	}
@@ -3157,7 +3157,7 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (!vq->use_dma_api) {
-		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
+		kmsan_handle_dma(virt_to_phys(ptr), size, dir);
 		return (dma_addr_t)virt_to_phys(ptr);
 	}
 
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 2b1432cc16d59..6f27b9824ef77 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -182,8 +182,7 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
 
 /**
  * kmsan_handle_dma() - Handle a DMA data transfer.
- * @page:   first page of the buffer.
- * @offset: offset of the buffer within the first page.
+ * @phys:   physical address of the buffer.
  * @size:   buffer size.
  * @dir:    one of possible dma_data_direction values.
  *
@@ -191,8 +190,11 @@ void kmsan_iounmap_page_range(unsigned long start, unsigned long end);
  * * checks the buffer, if it is copied to device;
  * * initializes the buffer, if it is copied from device;
  * * does both, if this is a DMA_BIDIRECTIONAL transfer.
+ *
+ * The function handles page lookup internally and supports both lowmem
+ * and highmem addresses.
  */
-void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+void kmsan_handle_dma(phys_addr_t phys, size_t size,
 		      enum dma_data_direction dir);
 
 /**
@@ -372,8 +374,8 @@ static inline void kmsan_iounmap_page_range(unsigned long start,
 {
 }
 
-static inline void kmsan_handle_dma(struct page *page, size_t offset,
-				    size_t size, enum dma_data_direction dir)
+static inline void kmsan_handle_dma(phys_addr_t phys, size_t size,
+				    enum dma_data_direction dir)
 {
 }
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 80481a873340a..709405d46b2b4 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -172,7 +172,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
-	kmsan_handle_dma(page, offset, size, dir);
+	kmsan_handle_dma(phys, size, dir);
 	trace_dma_map_phys(dev, phys, addr, size, dir, attrs);
 	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 97de3d6194f07..eab7912a3bf05 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -336,25 +336,48 @@ static void kmsan_handle_dma_page(const void *addr, size_t size,
 }
 
 /* Helper function to handle DMA data transfers. */
-void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+void kmsan_handle_dma(phys_addr_t phys, size_t size,
 		      enum dma_data_direction dir)
 {
 	u64 page_offset, to_go, addr;
+	struct page *page;
+	void *kaddr;
 
-	if (PageHighMem(page))
+	if (!pfn_valid(PHYS_PFN(phys)))
 		return;
-	addr = (u64)page_address(page) + offset;
+
+	page = phys_to_page(phys);
+	page_offset = offset_in_page(phys);
+
 	/*
 	 * The kernel may occasionally give us adjacent DMA pages not belonging
 	 * to the same allocation. Process them separately to avoid triggering
 	 * internal KMSAN checks.
 	 */
 	while (size > 0) {
-		page_offset = offset_in_page(addr);
 		to_go = min(PAGE_SIZE - page_offset, (u64)size);
+
+		if (PageHighMem(page))
+			/* Handle highmem pages using kmap */
+			kaddr = kmap_local_page(page);
+		else
+			/* Lowmem pages can be accessed directly */
+			kaddr = page_address(page);
+
+		addr = (u64)kaddr + page_offset;
 		kmsan_handle_dma_page((void *)addr, to_go, dir);
-		addr += to_go;
+
+		if (PageHighMem(page))
+			kunmap_local(page);
+
+		phys += to_go;
 		size -= to_go;
+
+		/* Move to next page if needed */
+		if (size > 0) {
+			page = phys_to_page(phys);
+			page_offset = offset_in_page(phys);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(kmsan_handle_dma);
@@ -366,8 +389,7 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 	int i;
 
 	for_each_sg(sg, item, nents, i)
-		kmsan_handle_dma(sg_page(item), item->offset, item->length,
-				 dir);
+		kmsan_handle_dma(sg_phys(item), item->length, dir);
 }
 
 /* Functions from kmsan-checks.h follow. */
diff --git a/tools/virtio/linux/kmsan.h b/tools/virtio/linux/kmsan.h
index 272b5aa285d5a..6cd2e3efd03dc 100644
--- a/tools/virtio/linux/kmsan.h
+++ b/tools/virtio/linux/kmsan.h
@@ -4,7 +4,7 @@
 
 #include <linux/gfp.h>
 
-inline void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
+inline void kmsan_handle_dma(phys_addr_t phys, size_t size,
 			     enum dma_data_direction dir)
 {
 }
-- 
2.50.1


