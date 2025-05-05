Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CBBC369C2
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XxeOL2z+dkrG7hgdHauQg7zcQJT4lImhNGLe0VAqEjs=; b=eClFBWjB6u9gDO+1yjuC6xR+pR
	FR0g/5LqVrz2e7+pON8z7LI+XI0jpxCxB1KwonTnRBcVHJbMmZGCE8q1ayW400+ajLL2hnp90zsAD
	lMfJIMwcPf1IWZfUby++DA0hVRkWPssmfYncnPd3+ZGC7DXKuvDQfnWO+XLPd44fl/0rg5FKcjb5C
	BjSxmECcycW0xIrub1lUHJsBVCEypp4JVgilrtukhY8ezVwf6aawOvLTlkg3wsdzHPv9VrWX0CinD
	b/LlL12E4pGd6unUyOjo0lw0kX7o0Ck2gOhMy7V/+XqOjPdNEq3oZaI1fODcG1PdYQ6m7pOeUfyL4
	U+dNU4qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBq1G-00000006c09-2tQO;
	Mon, 05 May 2025 07:13:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBppu-00000006ZXW-0iIY
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 07:01:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EF94261126;
	Mon,  5 May 2025 07:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB0C4CEEE;
	Mon,  5 May 2025 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746428516;
	bh=xT7zmcLaDxNjztgbqu/uyKMo9S/0dNYou7SkX0euza4=;
	h=From:To:Cc:Subject:Date:From;
	b=GA5dQC7XRq//CWQ6lAF7tc/SwEPAaS6e6g6G1SFFsCM7Bhl60xAUuUllYlIS9U/H0
	 mS4U9roR2+Ld4LIa1Xs9MlZPlwL/jnZjY32ct9uYYDEk+/E345G1Lf/Y+weum3oyH+
	 Ef7SU8i+3jubM+WPRCtIDu8lBF1AVoWRg8IRUI9HUtDiVROInpg6jrsx6njP6VYI5m
	 gWteclMo7cg3QcLsWbzYARlHs+Tw9hZz7JsQ0vAQXAK9TDkpeUAbpR0vBeo6+UYHSQ
	 HcC0I5XnWp0MMVIqkzQHlX+YHqeXH1nCWDpPufNocoKOPujmpHaQ+2LXXwY9ePC7Qq
	 M39NGI9xwAPcA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
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
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v11 0/9] Provide a new two step DMA mapping API
Date: Mon,  5 May 2025 10:01:37 +0300
Message-ID: <cover.1746424934.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 May 2025 00:13:41 -0700
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

Hi Marek,

These are the DMA/IOMMU patches only, which have not seen functional
changes for a while.  They are tested and reviewed and ready to merge.

We will work with relevant subsystems to merge rest of the conversion
patches. At least some of them will be done in next cycle to reduce
merge conflicts.

Thanks

=========================================================================
Following recent on site LSF/MM 2025 [1] discussion, the overall
response was extremely positive with many people expressed their
desire to see this series merged, so they can base their work on it.

It includes, but not limited:
 * Luis's "nvme-pci: breaking the 512 KiB max IO boundary":
   https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
 * Chuck's NFS conversion to use one structure (bio_vec) for all types
   of RPC transports:
   https://lore.kernel.org/all/913df4b4-fc4a-409d-9007-088a3e2c8291@oracle.com
 * Matthew's vision for the world without struct page:
   https://lore.kernel.org/all/Z-WRQOYEvOWlI34w@casper.infradead.org/
 * Confidential computing roadmap from Dan:
   https://lore.kernel.org/all/6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch

This series is combination of effort of many people who contributed ideas,
code and testing and I'm gratefully thankful for them.

[1] https://lore.kernel.org/linux-rdma/20250122071600.GC10702@unreal/
-----------------------------------------------------------------------
Changelog:
v11:
 * Left only DMA/IOMMU patches to allow merge
 * Added Baolu's ROB tags
 * Fixed commit messages
v10: https://lore.kernel.org/all/cover.1745831017.git.leon@kernel.org
 * Rebased on top v6.15-rc3
 * Added Luis's tags
 * Addressed review comments from Luis about DMA patches
 * Removed segment size check from single-segment SGL optimization code
 * Changed NVMe unmap data code as was suggested by Christoph
v9: https://lore.kernel.org/all/cover.1745394536.git.leon@kernel.org/
 * Added tested-by from Jens.
 * Replaced is_pci_p2pdma_page(bv.bv_page) check with if
   "(IS_ENABLED(CONFIG_PCI_P2PDMA) && (req->cmd_flags & REQ_P2PDMA))"
   which is more aligned with the goal (do not access struct page) and
   more efficient. This is the one line only that was changed in Jens's
   performance testing flow, so I kept his tags as is.
 * Restored single-segment optimization for SGL path.
 * Added forgotten unmap of metdata SGL multi-segment flow.
 * Split and squashed optimization patch from Kanchan.
 * Converted "bool aborted" flag to use newly introduced flag variable.
v8: https://lore.kernel.org/all/cover.1744825142.git.leon@kernel.org/
 * Rebased to v6.15-rc1
 * Added NVMe patches which are now patches and not RFC. They were in
   RFC stage because block iterator caused to performance regression
   for very extreme case scenario (~100M IOPS), but after Kanchan fixed
   it, the code started to be ready for merging.
 * @Niklas, i didn't change naming in this series as it follows iommu
   naming format.
v7: https://lore.kernel.org/all/cover.1738765879.git.leonro@nvidia.com/
 * Rebased to v6.14-rc1
v6: https://lore.kernel.org/all/cover.1737106761.git.leon@kernel.org
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
   an ...".
 * Slightly changed hmm patch to set sticky flags in one place.
v4: https://lore.kernel.org/all/cover.1733398913.git.leon@kernel.org
 * Added extra patch to add kernel-doc for iommu_unmap and iommu_unmap_fast
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
 * Added extra check in dma_iova_destroy() if mapped size to make code more clear
 * Fixed checkpatch warnings in p2p patch
 * Changed implementation of VFIO mlx5 mlx5vf_add_migration_pages() to
   be more general
 * Reduced the number of changes in VFIO patch
v0: https://lore.kernel.org/all/cover.1730037276.git.leon@kernel.org

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

The whole series can be found here:
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git dma-split-May-5
There can be found examples of three different users are converted to the new API
to show the benefits and its versatility. Each user has a unique
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

Christoph Hellwig (6):
  PCI/P2PDMA: Refactor the p2pdma mapping helpers
  dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
  iommu: generalize the batched sync after map interface
  iommu/dma: Factor out a iommu_dma_map_swiotlb helper
  dma-mapping: add a dma_need_unmap helper
  docs: core-api: document the IOVA-based API

Leon Romanovsky (3):
  iommu: add kernel-doc for iommu_unmap_fast
  dma-mapping: Provide an interface to allow allocate IOVA
  dma-mapping: Implement link/unlink ranges API

 Documentation/core-api/dma-api.rst |  71 +++++
 drivers/iommu/dma-iommu.c          | 482 +++++++++++++++++++++++++----
 drivers/iommu/iommu.c              |  84 ++---
 drivers/pci/p2pdma.c               |  38 +--
 include/linux/dma-map-ops.h        |  54 ----
 include/linux/dma-mapping.h        |  85 +++++
 include/linux/iommu.h              |   4 +
 include/linux/pci-p2pdma.h         |  85 +++++
 kernel/dma/direct.c                |  44 +--
 kernel/dma/mapping.c               |  18 ++
 10 files changed, 764 insertions(+), 201 deletions(-)

-- 
2.49.0


