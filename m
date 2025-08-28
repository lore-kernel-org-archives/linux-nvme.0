Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA75CA0EED
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Aug 2025 04:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jBKvGDDakYGcFCOIMrtxoT/Y5g/H8pKchV2rdUCvrxw=; b=BIr7H1N43rNOz1Oh9Aep7hiEJ3
	QHJJZgwxjtpoFKD5ZSHDM4mvQID+Z0719NyKths1KZQiilcBYdxfzxn3DeDSjLNWL75JW0DAAo/R4
	U/LTuJxcjAt3tfqvOk0cQmIZ/DZK6a1UDNbRCTSU+2Fl5xUlMNDrKWWxTbR9WaKjJTXlPQ9gQiZS7
	ltpf8a7+Y2OxOCT9OF6/j90tAt8tPhF/QqZdf2X5kJ6kWB27jWr1sGV7nrKpdPqm52j0bopRqfc9M
	V30NkdZs/FwlBRY1mDlFIB+qMEPBU2a/qqm4v/V6pLmR+/RHx7HxLrjhBi+kOUvr3seyCoNgUtvdx
	si1JMhLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urqwJ-00000004M6K-0tpZ;
	Fri, 29 Aug 2025 04:42:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urbG3-00000001PvG-0VVn
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 11:57:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EABC440888;
	Thu, 28 Aug 2025 11:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94ADC4CEEB;
	Thu, 28 Aug 2025 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756382253;
	bh=n8QXY5YRm9nQQBYQQGaxgrl8XdTmVTKFna/oqVl/xhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqLtXq0gi9UBzAMP2wcXlT2cBb1dLghW49oEfniFZWmFDZ8XrTzjet3Se+cK+4Enz
	 bUcas58K9zqJYJO8K1xC/lojuRYXP35XvwWJ9XYIMcJRmRtfzd1ENQlyeWdM0r06Gk
	 0iGSQIedtJXaN5EXHSKxCaObLHf9f2/iEhzMO/91YHWTXC+kQV5HZRzX+s7pvZgTMs
	 /wX7b7wyAX9BAZbCT37OSLoaEdenWMo5h/NWko9aq0V1TzuE+BMc75vbwrCyO1DV2e
	 WdS++dKThCK37gVl5uHk3NBx12J9+O+GbVUmIbjagbvOKAeDIwhduPUosVAdqLdX7n
	 wfEu8DIXf5M5g==
Date: Thu, 28 Aug 2025 14:57:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 00/16] dma-mapping: migrate to physical address-based
 API
Message-ID: <20250828115729.GA10073@unreal>
References: <cover.1755624249.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755624249.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250828_045735_207488_EB482733 
X-CRM114-Status: GOOD (  33.93  )
X-Mailman-Approved-At: Thu, 28 Aug 2025 21:42:14 -0700
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

On Tue, Aug 19, 2025 at 08:36:44PM +0300, Leon Romanovsky wrote:
> Changelog:
> v4:
>  * Fixed kbuild error with mismatch in kmsan function declaration due to
>    rebase error.
> v3: https://lore.kernel.org/all/cover.1755193625.git.leon@kernel.org
>  * Fixed typo in "cacheable" word
>  * Simplified kmsan patch a lot to be simple argument refactoring
> v2: https://lore.kernel.org/all/cover.1755153054.git.leon@kernel.org
>  * Used commit messages and cover letter from Jason
>  * Moved setting IOMMU_MMIO flag to dma_info_to_prot function
>  * Micro-optimized the code
>  * Rebased code on v6.17-rc1
> v1: https://lore.kernel.org/all/cover.1754292567.git.leon@kernel.org
>  * Added new DMA_ATTR_MMIO attribute to indicate
>    PCI_P2PDMA_MAP_THRU_HOST_BRIDGE path.
>  * Rewrote dma_map_* functions to use thus new attribute
> v0: https://lore.kernel.org/all/cover.1750854543.git.leon@kernel.org/
> ------------------------------------------------------------------------
> 
> This series refactors the DMA mapping to use physical addresses
> as the primary interface instead of page+offset parameters. This
> change aligns the DMA API with the underlying hardware reality where
> DMA operations work with physical addresses, not page structures.
> 
> The series maintains export symbol backward compatibility by keeping
> the old page-based API as wrapper functions around the new physical
> address-based implementations.
> 
> This series refactors the DMA mapping API to provide a phys_addr_t
> based, and struct-page free, external API that can handle all the
> mapping cases we want in modern systems:
> 
>  - struct page based cachable DRAM
>  - struct page MEMORY_DEVICE_PCI_P2PDMA PCI peer to peer non-cachable
>    MMIO
>  - struct page-less PCI peer to peer non-cachable MMIO
>  - struct page-less "resource" MMIO
> 
> Overall this gets much closer to Matthew's long term wish for
> struct-pageless IO to cachable DRAM. The remaining primary work would
> be in the mm side to allow kmap_local_pfn()/phys_to_virt() to work on
> phys_addr_t without a struct page.
> 
> The general design is to remove struct page usage entirely from the
> DMA API inner layers. For flows that need to have a KVA for the
> physical address they can use kmap_local_pfn() or phys_to_virt(). This
> isolates the struct page requirements to MM code only. Long term all
> removals of struct page usage are supporting Matthew's memdesc
> project which seeks to substantially transform how struct page works.
> 
> Instead make the DMA API internals work on phys_addr_t. Internally
> there are still dedicated 'page' and 'resource' flows, except they are
> now distinguished by a new DMA_ATTR_MMIO instead of by callchain. Both
> flows use the same phys_addr_t.
> 
> When DMA_ATTR_MMIO is specified things work similar to the existing
> 'resource' flow. kmap_local_pfn(), phys_to_virt(), phys_to_page(),
> pfn_valid(), etc are never called on the phys_addr_t. This requires
> rejecting any configuration that would need swiotlb. CPU cache
> flushing is not required, and avoided, as ATTR_MMIO also indicates the
> address have no cachable mappings. This effectively removes any
> DMA API side requirement to have struct page when DMA_ATTR_MMIO is
> used.
> 
> In the !DMA_ATTR_MMIO mode things work similarly to the 'page' flow,
> except on the common path of no cache flush, no swiotlb it never
> touches a struct page. When cache flushing or swiotlb copying
> kmap_local_pfn()/phys_to_virt() are used to get a KVA for CPU
> usage. This was already the case on the unmap side, now the map side
> is symmetric.
> 
> Callers are adjusted to set DMA_ATTR_MMIO. Existing 'resource' users
> must set it. The existing struct page based MEMORY_DEVICE_PCI_P2PDMA
> path must also set it. This corrects some existing bugs where iommu
> mappings for P2P MMIO were improperly marked IOMMU_CACHE.
> 
> Since ATTR_MMIO is made to work with all the existing DMA map entry
> points, particularly dma_iova_link(), this finally allows a way to use
> the new DMA API to map PCI P2P MMIO without creating struct page. The
> VFIO DMABUF series demonstrates how this works. This is intended to
> replace the incorrect driver use of dma_map_resource() on PCI BAR
> addresses.
> 
> This series does the core code and modern flows. A followup series
> will give the same treatment to the legacy dma_ops implementation.
> 
> Thanks
> 
> Leon Romanovsky (16):
>   dma-mapping: introduce new DMA attribute to indicate MMIO memory
>   iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().
>   dma-debug: refactor to use physical addresses for page mapping
>   dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
>   iommu/dma: rename iommu_dma_*map_page to iommu_dma_*map_phys
>   iommu/dma: extend iommu_dma_*map_phys API to handle MMIO memory
>   dma-mapping: convert dma_direct_*map_page to be phys_addr_t based
>   kmsan: convert kmsan_handle_dma to use physical addresses
>   dma-mapping: handle MMIO flow in dma_map|unmap_page
>   xen: swiotlb: Open code map_resource callback
>   dma-mapping: export new dma_*map_phys() interface
>   mm/hmm: migrate to physical address-based DMA mapping API
>   mm/hmm: properly take MMIO path
>   block-dma: migrate to dma_map_phys instead of map_page
>   block-dma: properly take MMIO path
>   nvme-pci: unmap MMIO pages with appropriate interface
> 
>  Documentation/core-api/dma-api.rst        |   4 +-
>  Documentation/core-api/dma-attributes.rst |  18 ++++
>  arch/powerpc/kernel/dma-iommu.c           |   4 +-
>  block/blk-mq-dma.c                        |  15 ++-
>  drivers/iommu/dma-iommu.c                 |  61 +++++------
>  drivers/nvme/host/pci.c                   |  18 +++-
>  drivers/virtio/virtio_ring.c              |   4 +-
>  drivers/xen/swiotlb-xen.c                 |  21 +++-
>  include/linux/blk-mq-dma.h                |   6 +-
>  include/linux/blk_types.h                 |   2 +
>  include/linux/dma-direct.h                |   2 -
>  include/linux/dma-map-ops.h               |   8 +-
>  include/linux/dma-mapping.h               |  33 ++++++
>  include/linux/iommu-dma.h                 |  11 +-
>  include/linux/kmsan.h                     |   9 +-
>  include/trace/events/dma.h                |   9 +-
>  kernel/dma/debug.c                        |  71 ++++---------
>  kernel/dma/debug.h                        |  37 ++-----
>  kernel/dma/direct.c                       |  22 +---
>  kernel/dma/direct.h                       |  52 ++++++----
>  kernel/dma/mapping.c                      | 117 +++++++++++++---------
>  kernel/dma/ops_helpers.c                  |   6 +-
>  mm/hmm.c                                  |  19 ++--
>  mm/kmsan/hooks.c                          |   5 +-
>  rust/kernel/dma.rs                        |   3 +
>  tools/virtio/linux/kmsan.h                |   2 +-
>  26 files changed, 305 insertions(+), 254 deletions(-)

Marek,

So what are the next steps here? This series is pre-requirement for the
VFIO MMIO patches.

Thanks

> 
> -- 
> 2.50.1
> 
> 

