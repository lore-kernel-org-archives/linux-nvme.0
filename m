Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BA1CA0FED
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Sep 2025 05:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8iG7pwhsLyN1oJdsR+XgmnjA/Fm8L+gfJ9NBOwj+hF4=; b=ouTpOTg0u8khIkoCIEaJNgUcSX
	Q9w1Qf3Zq0FgSBIXjU5K4lWFwFLrNiJ4d2J7yGLsGimVRnSltJnAKluBCpgZs4uE3JUlCluk0OK/Y
	7XIxEFLKvuGZdfsIbXcYp7Jzcqz5G8dYs6PAxfqXhgAjtb7oRwVxT643AD2+sK74DaxnPAsS1e0Cg
	nQ5SRpydMvMzM+dUAXxYCGBcvnnILLPblNB5B4uCaYfsKNljTOz8e/gY4mI7PkxyJOAkyv/h71If4
	qdNyVKy61xZG00baiZ8ZNo7FThppdnaRdhTa7cIDjqvrDvP/NJgCKpoeYMnOa4LQLQGtMPAQSyCaw
	UuLhaEug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwDMu-0000000C9Ei-2n9b;
	Wed, 10 Sep 2025 05:27:44 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvyOX-00000007N2p-0QTa
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 13:28:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2600A6021E;
	Tue,  9 Sep 2025 13:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD48C4CEF4;
	Tue,  9 Sep 2025 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424503;
	bh=LmA+5r2y6XpziEWAZNosju3G43mU5TfGKzS41p72Fok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ke4hsb0oLTPfHFWhWc4Tu1uf9YsEMIjSIvc5uG8GeGq7ZrmKRs3eEH4x3/XNxE63q
	 I8P3KLAOWemasIp0/JtzEJjq0Gq5BYdlQLtKtP7S8q66J0I6u6sMvYCPpEm6ssKVHY
	 90pjKxcoblQIxpLEvhej/ET5tEF4zRv9Dz0M2UyhkraPqoG9mxB04L+fZcESm7IsLy
	 2jgLMxUISDXt6aaaYuGkkb3kCJv07RaaXvA2RVy6VT5TlYk78Kn+irOXgEBcpDaxXd
	 hHkLj0RlB2AXvc+crVg3gfw2gatuw+pcwILlr/cKNJxEnGOaOvYDOa3vyXqxCn7N3p
	 bFUN02wQ98k0Q==
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
	David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH v6 03/16] dma-debug: refactor to use physical addresses for page mapping
Date: Tue,  9 Sep 2025 16:27:31 +0300
Message-ID: <56d1a6769b68dfcbf8b26a75a7329aeb8e3c3b6a.1757423202.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757423202.git.leonro@nvidia.com>
References: <cover.1757423202.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 09 Sep 2025 22:27:42 -0700
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

Convert the DMA debug infrastructure from page-based to physical address-based
mapping as a preparation to rely on physical address for DMA mapping routines.

The refactoring renames debug_dma_map_page() to debug_dma_map_phys() and
changes its signature to accept a phys_addr_t parameter instead of struct page
and offset. Similarly, debug_dma_unmap_page() becomes debug_dma_unmap_phys().
A new dma_debug_phy type is introduced to distinguish physical address mappings
from other debug entry types. All callers throughout the codebase are updated
to pass physical addresses directly, eliminating the need for page-to-physical
conversion in the debug layer.

This refactoring eliminates the need to convert between page pointers and
physical addresses in the debug layer, making the code more efficient and
consistent with the DMA mapping API's physical address focus.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/core-api/dma-api.rst |  4 +--
 include/linux/page-flags.h         |  1 +
 kernel/dma/debug.c                 | 39 +++++++++++++++---------------
 kernel/dma/debug.h                 | 16 ++++++------
 kernel/dma/mapping.c               | 10 ++++----
 5 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
index 3087bea715ed2..ca75b35416792 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -761,7 +761,7 @@ example warning message may look like this::
 	[<ffffffff80235177>] find_busiest_group+0x207/0x8a0
 	[<ffffffff8064784f>] _spin_lock_irqsave+0x1f/0x50
 	[<ffffffff803c7ea3>] check_unmap+0x203/0x490
-	[<ffffffff803c8259>] debug_dma_unmap_page+0x49/0x50
+	[<ffffffff803c8259>] debug_dma_unmap_phys+0x49/0x50
 	[<ffffffff80485f26>] nv_tx_done_optimized+0xc6/0x2c0
 	[<ffffffff80486c13>] nv_nic_irq_optimized+0x73/0x2b0
 	[<ffffffff8026df84>] handle_IRQ_event+0x34/0x70
@@ -855,7 +855,7 @@ that a driver may be leaking mappings.
 dma-debug interface debug_dma_mapping_error() to debug drivers that fail
 to check DMA mapping errors on addresses returned by dma_map_single() and
 dma_map_page() interfaces. This interface clears a flag set by
-debug_dma_map_page() to indicate that dma_mapping_error() has been called by
+debug_dma_map_phys() to indicate that dma_mapping_error() has been called by
 the driver. When driver does unmap, debug_dma_unmap() checks the flag and if
 this flag is still set, prints warning message that includes call trace that
 leads up to the unmap. This interface can be called from dma_mapping_error()
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce47..dfbc4ba86bba2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -614,6 +614,7 @@ FOLIO_FLAG(dropbehind, FOLIO_HEAD_PAGE)
  * available at this point.
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define PhysHighMem(__p) (PageHighMem(phys_to_page(__p)))
 #define folio_test_highmem(__f)	is_highmem_idx(folio_zonenum(__f))
 #else
 PAGEFLAG_FALSE(HighMem, highmem)
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index b82399437db03..b275db9ca6a03 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -40,6 +40,7 @@ enum {
 	dma_debug_coherent,
 	dma_debug_resource,
 	dma_debug_noncoherent,
+	dma_debug_phy,
 };
 
 enum map_err_types {
@@ -143,6 +144,7 @@ static const char *type2name[] = {
 	[dma_debug_coherent] = "coherent",
 	[dma_debug_resource] = "resource",
 	[dma_debug_noncoherent] = "noncoherent",
+	[dma_debug_phy] = "phy",
 };
 
 static const char *dir2name[] = {
@@ -1054,17 +1056,16 @@ static void check_unmap(struct dma_debug_entry *ref)
 	dma_entry_free(entry);
 }
 
-static void check_for_stack(struct device *dev,
-			    struct page *page, size_t offset)
+static void check_for_stack(struct device *dev, phys_addr_t phys)
 {
 	void *addr;
 	struct vm_struct *stack_vm_area = task_stack_vm_area(current);
 
 	if (!stack_vm_area) {
 		/* Stack is direct-mapped. */
-		if (PageHighMem(page))
+		if (PhysHighMem(phys))
 			return;
-		addr = page_address(page) + offset;
+		addr = phys_to_virt(phys);
 		if (object_is_on_stack(addr))
 			err_printk(dev, NULL, "device driver maps memory from stack [addr=%p]\n", addr);
 	} else {
@@ -1072,10 +1073,12 @@ static void check_for_stack(struct device *dev,
 		int i;
 
 		for (i = 0; i < stack_vm_area->nr_pages; i++) {
-			if (page != stack_vm_area->pages[i])
+			if (__phys_to_pfn(phys) !=
+			    page_to_pfn(stack_vm_area->pages[i]))
 				continue;
 
-			addr = (u8 *)current->stack + i * PAGE_SIZE + offset;
+			addr = (u8 *)current->stack + i * PAGE_SIZE +
+			       (phys % PAGE_SIZE);
 			err_printk(dev, NULL, "device driver maps memory from stack [probable addr=%p]\n", addr);
 			break;
 		}
@@ -1204,9 +1207,8 @@ void debug_dma_map_single(struct device *dev, const void *addr,
 }
 EXPORT_SYMBOL(debug_dma_map_single);
 
-void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
-			size_t size, int direction, dma_addr_t dma_addr,
-			unsigned long attrs)
+void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
+		int direction, dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1221,19 +1223,18 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 		return;
 
 	entry->dev       = dev;
-	entry->type      = dma_debug_single;
-	entry->paddr	 = page_to_phys(page) + offset;
+	entry->type      = dma_debug_phy;
+	entry->paddr	 = phys;
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
 	entry->map_err_type = MAP_ERR_NOT_CHECKED;
 
-	check_for_stack(dev, page, offset);
+	if (!(attrs & DMA_ATTR_MMIO)) {
+		check_for_stack(dev, phys);
 
-	if (!PageHighMem(page)) {
-		void *addr = page_address(page) + offset;
-
-		check_for_illegal_area(dev, addr, size);
+		if (!PhysHighMem(phys))
+			check_for_illegal_area(dev, phys_to_virt(phys), size);
 	}
 
 	add_dma_entry(entry, attrs);
@@ -1277,11 +1278,11 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 }
 EXPORT_SYMBOL(debug_dma_mapping_error);
 
-void debug_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
+void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
 			  size_t size, int direction)
 {
 	struct dma_debug_entry ref = {
-		.type           = dma_debug_single,
+		.type           = dma_debug_phy,
 		.dev            = dev,
 		.dev_addr       = dma_addr,
 		.size           = size,
@@ -1305,7 +1306,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		return;
 
 	for_each_sg(sg, s, nents, i) {
-		check_for_stack(dev, sg_page(s), s->offset);
+		check_for_stack(dev, sg_phys(s));
 		if (!PageHighMem(sg_page(s)))
 			check_for_illegal_area(dev, sg_virt(s), s->length);
 	}
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index 48757ca13f314..bedae973e725d 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -9,12 +9,11 @@
 #define _KERNEL_DMA_DEBUG_H
 
 #ifdef CONFIG_DMA_API_DEBUG
-extern void debug_dma_map_page(struct device *dev, struct page *page,
-			       size_t offset, size_t size,
-			       int direction, dma_addr_t dma_addr,
+extern void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
+			       size_t size, int direction, dma_addr_t dma_addr,
 			       unsigned long attrs);
 
-extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
+extern void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
 				 size_t size, int direction);
 
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
@@ -62,14 +61,13 @@ extern void debug_dma_free_pages(struct device *dev, struct page *page,
 				 size_t size, int direction,
 				 dma_addr_t dma_addr);
 #else /* CONFIG_DMA_API_DEBUG */
-static inline void debug_dma_map_page(struct device *dev, struct page *page,
-				      size_t offset, size_t size,
-				      int direction, dma_addr_t dma_addr,
-				      unsigned long attrs)
+static inline void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
+				      size_t size, int direction,
+				      dma_addr_t dma_addr, unsigned long attrs)
 {
 }
 
-static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
+static inline void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
 					size_t size, int direction)
 {
 }
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 56de28a3b1799..0b7e16c69bf18 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -157,6 +157,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
+	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -165,16 +166,15 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		return DMA_MAPPING_ERROR;
 
 	if (dma_map_direct(dev, ops) ||
-	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
+	    arch_dma_map_page_direct(dev, phys + size))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	kmsan_handle_dma(page, offset, size, dir);
-	trace_dma_map_page(dev, page_to_phys(page) + offset, addr, size, dir,
-			   attrs);
-	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
+	trace_dma_map_page(dev, phys, addr, size, dir, attrs);
+	debug_dma_map_phys(dev, phys, size, dir, addr, attrs);
 
 	return addr;
 }
@@ -194,7 +194,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	trace_dma_unmap_page(dev, addr, size, dir, attrs);
-	debug_dma_unmap_page(dev, addr, size, dir);
+	debug_dma_unmap_phys(dev, addr, size, dir);
 }
 EXPORT_SYMBOL(dma_unmap_page_attrs);
 
-- 
2.51.0


