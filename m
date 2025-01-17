Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957CEC02188
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lwraZW+Tw1Glwth+C6jyWjH2ZrTYSGmmdIEvvd0sokY=; b=i+iC4zJlEp0SUq0LnROjSz55+Q
	8Psng1LivXfHb5jnB+XuNt6QTinSmHk+NnFzLb1TF8QD6fBCZUK3Ju9MWX9+AbveDA3mW7dLfOujh
	NMjBBKz8C9Bnep0aPVG3uMMHP9x3do2TQCU1cn2E+22OMgBLPxiHnuIkYm5GOomdKA+MTfn96oI3i
	DRhxPIDjNpcKkbrBYAPzMDJIMe7hhyT6lFfck/wrDHvD1rgDJSZbVWX8CTgngiHjULgM1ov9wl3Pt
	MOFfus5sWN9Rvehh133d1YPZnlLePf5M5B/fr/3IekTslpR1qGJ9SXsNh/VSAU3UFtJ7pHnP/hpEP
	J2kO1kRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYjCt-0000000HWku-2la2;
	Fri, 17 Jan 2025 10:04:03 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYjCq-0000000HWjU-2fNh
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 10:04:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CC6E3A42B23;
	Fri, 17 Jan 2025 10:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2605C4CEDD;
	Fri, 17 Jan 2025 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737108239;
	bh=eUJHLAcRf9cQUaYJFJ0wbkqB/9b2b7e4uWcSuRQSxew=;
	h=From:To:Cc:Subject:Date:From;
	b=kC2tRywNeYSqYqwuudIOLXHjfAF6p4XMag1gRVWnEUUmYgDClgpUZsXJ/RsV20a/K
	 FnYoYY0J+NI19Ho410XBsX71+9+Zgvtut6zqAPhWFtoOJZO+Qx4ht5VDW8aWpgUY9B
	 8HbtQRvuSRSR6v+p9c0uFztj/zpYa2fxDn1GOmkUdO14yGHvA+j0TJHMQcnJdW/CXi
	 i/m9xuxMlN1AjgYhF2qoNpT/zGixb9xc721M0MMYKax77Kbul35fHgNesTF5/G63O4
	 d9NwNOcZNjqORTKzB8IGnfKIcK1IPuRyUoLVCcODiyC3Hi+jpPnp5pNBhnn75BKQUU
	 s/pAP7axuSHLA==
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
Subject: [PATCH v6 00/17] Provide a new two step DMA mapping API
Date: Fri, 17 Jan 2025 12:03:31 +0200
Message-ID: <cover.1737106761.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_020400_801515_C3CD9D9E 
X-CRM114-Status: GOOD (  24.60  )
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

Changelog:
v6: 
 * Changed internal __size variable to u64 to properly set private flag
   in most significant bit.
 * Added comment about why we check DMA_IOVA_USE_SWIOTLB
 * Break unlink loop if phys is NULL, condition which we shouldn't get.
v5: https://lore.kernel.org/all/cover.1734436840.git.leon@kernel.org
 * Trimmed long lines in all patches.
 * Squashed "dma-mapping: Add check if IOVA can be used" into
   "dma: Provide an interface to allow allocate IOVA" patch.
 * Added tags from Christoph and Will.
 * Fixed spelling/grammar errors.
 * Change title from "dma: Provide an  ..." to be "dma-mapping: Provide
 * an ...".
 * Slightly changed hmm patch to set sticky flags in one place.
v4: https://lore.kernel.org/all/cover.1733398913.git.leon@kernel.org
 * Added extra patch to add kernel-doc for iommu_unmap and
 * iommu_unmap_fast
 * Rebased to v6.13-rc1
 * Added Will's tags
v3: https://lore.kernel.org/all/cover.1731244445.git.leon@kernel.org
 * Added DMA_ATTR_SKIP_CPU_SYNC to p2p pages in HMM.
 * Fixed error unwind if dma_iova_sync fails in HMM.
 * Clear all PFN flags which were set in map to make code.
   more clean, the callers anyway cleaned them.
 * Generalize sticky PFN flags logic in HMM.
 * Removed not-needed #ifdef-#endif section.
v2: https://lore.kernel.org/all/cover.1730892663.git.leon@kernel.org
 * Fixed docs file as Randy suggested
 * Fixed releases of memory in HMM path. It was allocated with kv..
   variants but released with kfree instead of kvfree.
 * Slightly changed commit message in VFIO patch.
v1: https://lore.kernel.org/all/cover.1730298502.git.leon@kernel.org
 * Squashed two VFIO patches into one
 * Added Acked-by/Reviewed-by tags
 * Fix docs spelling errors
 * Simplified dma_iova_sync() API
 * Added extra check in dma_iova_destroy() if mapped size to make code
 * more clear
 * Fixed checkpatch warnings in p2p patch
 * Changed implementation of VFIO mlx5 mlx5vf_add_migration_pages() to
   be more general
 * Reduced the number of changes in VFIO patch
v0: https://lore.kernel.org/all/cover.1730037276.git.leon@kernel.org

----------------------------------------------------------------------------
 No changes in checks, documentation and naming as no suggestion was
 given. Everything like this can be improved in followup patches.
----------------------------------------------------------------------------
 LWN coverage:
Dancing the DMA two-step - https://lwn.net/Articles/997563/
----------------------------------------------------------------------------

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
scatterlist-like structures (BIO, rlist), instead split up the DMA API
to allow callers to bring their own data structure.

The API is split up into parts:
 - Allocate IOVA space:
    To do any pre-allocation required. This is done based on the caller
    supplying some details about how much IOMMU address space it would need
    in worst case.
 - Map and unmap relevant structures to pre-allocated IOVA space:
    Perform the actual mapping into the pre-allocated IOVA. This is very
    similar to dma_map_page().

In this and the next series [1], examples of three different users are converted
to the new API to show the benefits and its versatility. Each user has a unique
flow:
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

To make the use of the new API easier, HMM and block subsystems are extended
to hide the optimization details from the caller. Among these optimizations:
 * Memory reduction as in most real use cases there is no need to store mapped
   DMA addresses and unmap them.
 * Reducing the function call overhead by removing the need to call function
   pointers and use direct calls instead.

This step is first along a path to provide alternatives to scatterlist and
solve some of the abuses and design mistakes.

Thanks

[1] This still points to v0, as the change is just around handling dma_iova_sync()
and extra attribute flag provided to map/unmap:
https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org

Thanks

Christoph Hellwig (6):
  PCI/P2PDMA: Refactor the p2pdma mapping helpers
  dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
  iommu: generalize the batched sync after map interface
  iommu/dma: Factor out a iommu_dma_map_swiotlb helper
  dma-mapping: add a dma_need_unmap helper
  docs: core-api: document the IOVA-based API

Leon Romanovsky (11):
  iommu: add kernel-doc for iommu_unmap and iommu_unmap_fast
  dma-mapping: Provide an interface to allow allocate IOVA
  dma-mapping: Implement link/unlink ranges API
  mm/hmm: let users to tag specific PFN with DMA mapped bit
  mm/hmm: provide generic DMA managing logic
  RDMA/umem: Store ODP access mask information in PFN
  RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
    linkage
  RDMA/umem: Separate implicit ODP initialization from explicit ODP
  vfio/mlx5: Explicitly use number of pages instead of allocated length
  vfio/mlx5: Rewrite create mkey flow to allow better code reuse
  vfio/mlx5: Enable the DMA link API

 Documentation/core-api/dma-api.rst   |  70 ++++
 drivers/infiniband/core/umem_odp.c   | 250 +++++---------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
 drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
 drivers/infiniband/hw/mlx5/umr.c     |  12 +-
 drivers/iommu/dma-iommu.c            | 468 +++++++++++++++++++++++----
 drivers/iommu/iommu.c                |  84 ++---
 drivers/pci/p2pdma.c                 |  38 +--
 drivers/vfio/pci/mlx5/cmd.c          | 376 +++++++++++----------
 drivers/vfio/pci/mlx5/cmd.h          |  35 +-
 drivers/vfio/pci/mlx5/main.c         |  87 +++--
 include/linux/dma-map-ops.h          |  54 ----
 include/linux/dma-mapping.h          |  85 +++++
 include/linux/hmm-dma.h              |  33 ++
 include/linux/hmm.h                  |  21 ++
 include/linux/iommu.h                |   4 +
 include/linux/pci-p2pdma.h           |  84 +++++
 include/rdma/ib_umem_odp.h           |  25 +-
 kernel/dma/direct.c                  |  44 +--
 kernel/dma/mapping.c                 |  18 ++
 mm/hmm.c                             | 264 +++++++++++++--
 21 files changed, 1436 insertions(+), 693 deletions(-)
 create mode 100644 include/linux/hmm-dma.h

-- 
2.47.1


