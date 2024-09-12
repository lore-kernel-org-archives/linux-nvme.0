Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009E2EEB591
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 11:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2DBCbfeL/jE2jfZvszJijVINvgiceTkfL13b/c+h6dQ=; b=Gr+5XOYHvyMc0nWU+AOivAhEss
	dkTrtlZKZhdsw6J8XxzfbWYqTvViQKRdYxpWSMHbnTG1oMD6hyQaPVjuvJAscQ/ie/CqqT7wZH+ve
	LD1EZoosVgyCsOsBwhYGBotiHnux1OdlKk+2A7KtEriLl9SVbQqhwqY4HvNHjjv5t3TLFnRmI2NlF
	80WCkTvw3MSehYXKQF5uaoFvQnlzFPBgHOOuR1NVylvAh5S+z/CNn+RH/i31zHdnL96z4OlcRPMwR
	bkz6awFgeo3QD739IVjqn7yQ6j9rsrU8UPspn+vI10GW3DUwvme+i27TKgz7igUWPcmr99FYR/9tp
	1BD7It6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soho1-0000000CnCq-3Z0R;
	Thu, 12 Sep 2024 11:16:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sohnx-0000000CnBR-2gau
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 11:16:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 40588A451F7;
	Thu, 12 Sep 2024 11:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE95BC4CECC;
	Thu, 12 Sep 2024 11:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726139763;
	bh=xHiv+64ufjlfaZB+1birEmDSAEqJIKZbsr4qpKOqPrE=;
	h=From:To:Cc:Subject:Date:From;
	b=HnlDHW0aJOlZ/mQyNxg12Vfl1QyQgA+4ialoezfo+MkiMtzpo37W3A7XFZzNSS2gV
	 nCy6S4qzhyg3yiWGrpjkJ7XXOwsjJGLduW17gDQ2j01fra/JxTwTC8bIEzsO37Jy3O
	 tWtJI3x5KEzkYDPDEvpo4btQfTc/iM6jDN4b9cWi2x7dl8qZl6FekY1wFay7lNo6Ii
	 IJZ7rjlAzG15afy2OtWqIvnGmh3J6ojSrsIxH92HPrMct8haQWjgPUjLGLnJK+FdOA
	 egzwYBUFcoq09uv/i0x7cvVS0WkLeIYtdOhFJpeYR+kGOqMRlQvQJEwypNBVn2bnZB
	 jTk09N6hrZ0Fw==
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
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
Subject: [RFC v2 00/21] Provide a new two step DMA API mapping API
Date: Thu, 12 Sep 2024 14:15:35 +0300
Message-ID: <cover.1726138681.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_041605_849388_6C6BE1C2 
X-CRM114-Status: GOOD (  20.96  )
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

Instead of waiting and waiting when I finally fix NVMe patch which
doesn't work correctly in DMA direct mode (it causes to failures in
module reload), I decided to send the series as is to at least get
a feedback about API and the overall direction.

Thanks

-------------------------------------------------------------------------
Changelog:
v2:
 * Remove attr field from dma_iova_attrs
 * Added attr parameter to every new API call except alloc_iova
 * Embed use_iova boolean into struct dma_iova_state
 * Embed struct dma_memory_type into struct dma_iova_state
 * Changed function signatures and added new function to initialize state
 * Combined dma_set_memory_type() and dma_can_use_iova() to one function, they were used together anyway
 * Made dma_start_range/dma_end_range to be NOP for non-iommu case
 * Restructured the code to avoid inclusion of linux/pci.h in global header
 * Based on DMA static calls series
 * Changed iommu/dma functions to get parameters instead of dma_iova_state
 * Removed iommu domain pointer from dma_iova_state
 * dma_link_range now returns DMA address
 * Rewrote NVMe patch
v1: https://lore.kernel.org/all/cover.1719909395.git.leon@kernel.org
 * Rewrote cover letter
 * Changed to API as proposed
   https://lore.kernel.org/linux-rdma/20240322184330.GL66976@ziepe.ca/
 * Removed IB DMA wrappers and use DMA API directly
v0: https://lore.kernel.org/all/cover.1709635535.git.leon@kernel.org
-------------------------------------------------------------------------

Currently the only efficient way to map a complex memory description through
the DMA API is by using the scatterlist APIs. The SG APIs are unique in that
they efficiently combine the two fundamental operations of sizing and allocating
a large IOVA window from the IOMMU and processing all the per-address
swiotlb/flushing/p2p/map details.

This uniqueness has been a long standing pain point as the scatterlist API
is mandatory, but expensive to use. It prevents any kind of optimization or
feature improvement (such as avoiding struct page for P2P) due to the
impossibility of improving the scatterlist.

Several approaches have been explored to expand the DMA API with additional
scatterlist-like structures (BIO[1], rlist[2]), instead split up the DMAAPI
to allow callers to bring their own data structure.

The API is split up into parts:
 - dma_alloc_iova() / dma_free_iova()
   To do any pre-allocation required. This is done based on the caller
   supplying some details about how much IOMMU address space it would need
   in worst case.
 - dma_link_range() / dma_unlink_range()
   Perform the actual mapping into the pre-allocated IOVA. This is very
   similar to dma_map_page().

A driver will extent its mapping size using its own data structure, such as
BIO, to request the required IOVA. Then it will iterate directly over it's
data structure to DMA map each range. The result can then be stored directly
into the HW specific DMA list. No intermediate scatterlist is required.

In this series, examples of three users are converted to the new API to show
the benefits. Each user has a unique flow:
 1. RDMA ODP is an example of "SVA mirroring" using HMM that needs to
    dynamically map/unmap large numbers of single pages. This becomes
    significantly faster in the IOMMU case as the map/unmap is now just
    a page table walk, the IOVA allocation is pre-computed once. Significant
    amounts of memory are saved as there is no longer a need to store the
    dma_addr_t of each page.
 2. VFIO PCI live migration code is building a very large "page list"
    for the device. Instead of allocating a scatter list entry per allocated
    page it can just allocate an array of 'struct page *', saving a large
    amount of memory.
 3. NVMe PCI demonstrates how a BIO can be converted to a HW scatter
    list without having to allocate then populate an intermediate SG table.

This step is first along a path to provide alternatives to scatterlist
and solve some of the abuses and design mistakes, for instance in DMABUF's
P2P support.

The ODP and VFIO versions are complete and fully tested, they can be the
users of the new API to merge it. The NVMe requires more work.

[1] https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net/
[2] https://lore.kernel.org/all/ZD2lMvprVxu23BXZ@ziepe.ca/

Thanks

Leon Romanovsky (21):
  iommu/dma: Provide an interface to allow preallocate IOVA
  iommu/dma: Implement link/unlink ranges callbacks
  iommu/dma: Add check if IOVA can be used
  dma-mapping: initialize IOVA state struct
  dma-mapping: provide an interface to allocate IOVA
  dma-mapping: set and query DMA IOVA state
  dma-mapping: implement link range API
  mm/hmm: let users to tag specific PFN with DMA mapped bit
  dma-mapping: provide callbacks to link/unlink HMM PFNs to specific
    IOVA
  RDMA/umem: Preallocate and cache IOVA for UMEM ODP
  RDMA/umem: Store ODP access mask information in PFN
  RDMA/core: Separate DMA mapping to caching IOVA and page linkage
  RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
  vfio/mlx5: Explicitly use number of pages instead of allocated length
  vfio/mlx5: Rewrite create mkey flow to allow better code reuse
  vfio/mlx5: Explicitly store page list
  vfio/mlx5: Convert vfio to use DMA link API
  nvme-pci: remove optimizations for single DMA entry
  nvme-pci: precalculate number of DMA entries for each command
  nvme-pci: use new dma API
  nvme-pci: don't allow mapping of bvecs with offset

 drivers/infiniband/core/umem_odp.c   | 216 +++++---------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 +
 drivers/infiniband/hw/mlx5/odp.c     |  44 +--
 drivers/iommu/dma-iommu.c            | 165 ++++++++++-
 drivers/nvme/host/pci.c              | 428 ++++++++++++++-------------
 drivers/pci/p2pdma.c                 |   4 +-
 drivers/vfio/pci/mlx5/cmd.c          | 312 ++++++++++---------
 drivers/vfio/pci/mlx5/cmd.h          |  23 +-
 drivers/vfio/pci/mlx5/main.c         |  89 +++---
 include/linux/dma-map-ops.h          |   7 +
 include/linux/dma-mapping.h          |  85 ++++++
 include/linux/hmm.h                  |   4 +
 include/linux/iommu-dma.h            |  43 +++
 include/rdma/ib_umem_odp.h           |  23 +-
 kernel/dma/mapping.c                 | 232 +++++++++++++++
 mm/hmm.c                             |  34 ++-
 16 files changed, 1096 insertions(+), 614 deletions(-)

-- 
2.46.0


