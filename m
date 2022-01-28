Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA4C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Nkw55joMKiqDgie+VfxMcVCT7GpR0RSmwW2xRLO+tno=; b=vO9fyXgVUFTQ6l
	UAR+1fgJkA4hnIX3CRVqiz9h2Ob28VVYFMCC/pg/kqqZH7dS9REkiFxH49BeG5eA8QOTDly3tVnHH
	rcw+B1viUTlmbY0NGRPzOUb8N9e+dwCLgh4Rwru6E9pZVy2TZESPr42WNrPvjIvCM1toRPZX5nG+6
	Wtsp+t8NoX0xP/e7zZ1E2QpqyWyNc84oxRA+5ej7xglnW7xK7GfFdMUWnQ2uBQKop/Rnf9nGzweBj
	AgrZNt1P2MDWrn5SwgyqHO7jIOugiD1yg5ipPOnNzKf+0ey9k/6CzRuRLgAtmd/GjpfJ7Zqd9hrT4
	UDnqEiRv9+Ve9VbAZnZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDF9F-00HTh1-5A; Fri, 28 Jan 2022 00:29:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDF5v-00HRvw-BO
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 00:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
 :references:content-disposition:in-reply-to;
 bh=Nkw55joMKiqDgie+VfxMcVCT7GpR0RSmwW2xRLO+tno=; b=t2yLq7BIUQ4EFSH2LFcsoa2tP4
 V0ye62oByQ8Q2ExVdzyYACVbmPz8nA8wIvQTo82I0fY+monLOYjsS8MlfXMe88UsRBJm9A3NIAOow
 bL9reKbtQoe9snv0O0Du/HIq2ZZLtZl9gbkcUj4Xk2NQweGNKcIUx1uRwmtUNoTZH418Bz/uk+ZmB
 mov+5DnEau10n2G7Gcvq5mDttrSctPJkpschajnJtQT7C9YcD1mLmFsSVCd/5zbZ8kpztJWt5AXiH
 5hpUkM+oZPbN9WJaO6MYRCbBvkQ1WyOn3rsQzo2uEMeHqFvTLBUX2EgAqpKnfhFtIH8hCGcRr+SAJ
 WsD5RsYg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5p-005OcV-La; Thu, 27 Jan 2022 17:26:23 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5j-0001cA-Ki; Thu, 27 Jan 2022 17:26:15 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 27 Jan 2022 17:25:50 -0700
Message-Id: <20220128002614.6136-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 00/24] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_162627_509490_FBFC27CF 
X-CRM114-Status: GOOD (  28.37  )
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

Hi,

This patchset continues my work to add userspace P2PDMA access using
O_DIRECT NVMe devices. This posting fixes a lot of issues that were
addresed in the last posting, which is here[1].

The patchset is rebased onto v5.17-rc1 as well as a rebased version of
Ralph Campbell's patches to drop the ZONE_DEVICE page ref count offset.
My understanding is this patch has some problems that are yet to be
resolved but this will be the direction taken going forward and is
included here to show that it is compatible with this patchset.

The patchset enables userspace P2PDMA by allowing userspace to mmap()
allocated chunks of the CMB. The resulting VMA can be passed only
to O_DIRECT IO on NVMe backed files or block devices. A flag is added
to GUP() in Patch 16, then Patches 17 through 21 wire this flag up based
on whether the block queue indicates P2PDMA support. Patches 22
through 24 enable the CMB to be mapped into userspace by mmaping
the nvme char device.

This is relatively straightforward, however the one significant
problem is that, presently, pci_p2pdma_map_sg() requires a homogeneous
SGL with all P2PDMA pages or all regular pages. Enhancing GUP to
support enforcing this rule would require a huge hack that I don't
expect would be all that pallatable. So patches 3 to 16 add
support for P2PDMA pages to dma_map_sg[table]() to the dma-direct
and dma-iommu implementations. Thus systems without an IOMMU plus
Intel and AMD IOMMUs are supported. (Other IOMMU implementations would
then be unsupported, notably ARM and PowerPC but support would be added
when they convert to dma-iommu).

dma_map_sgtable() is preferred when dealing with P2PDMA memory as it
will return -EREMOTEIO when the DMA device cannot map specific P2PDMA
pages based on the existing rules in calc_map_type_and_dist().

The other issue is dma_unmap_sg() needs a flag to determine whether a
given dma_addr_t was mapped regularly or as a PCI bus address. To allow
this, a third flag is added to the page_link field in struct
scatterlist. This effectively means support for P2PDMA will now depend
on CONFIG_64BIT.

Feedback welcome.

This series is based on v5.17-rc1. A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v5

Thanks,

Logan

[1] https://lore.kernel.org/all/20211117215410.3695-1-logang@deltatee.com/T/#u

--

Changes since v4:
  - Rebase onto v5.17-rc1.
  - Included Ralph Cambell's patches which removes the ZONE_DEVICE page
    reference count offset. This is just to demonstrate that this
    series is compatible with that direction.
  - Added a comment in pci_p2pdma_map_sg_attrs(), per Chaitanya and
    included his Reviewed-by tags.
  - Patch 1 in the last series which cleaned up scatterlist.h
    has been upstreamed.
  - Dropped NEED_SG_DMA_BUS_ADDR_FLAG seeing depends on doesn't
    work with selected symbols, per Christoph.
  - Switched iov_iter_get_pages_[alloc_]flags to be exported with
    EXPORT_SYMBOL_GPL, per Christoph.
  - Renamed zone_device_pages_are_mergeable() to
    zone_device_pages_have_same_pgmap(), per Christoph.
  - Renamed .mmap_file_open operation in nvme_ctrl_ops to
    cdev_file_open(), per Christoph.

Changes since v3:
  - Add some comment and commit message cleanups I had missed for v3,
    also moved the prototypes for some of the p2pdma helpers to
    dma-map-ops.h (which I missed in v3 and was suggested in v2).
  - Add separate cleanup patch for scatterlist.h and change the macros
    to functions. (Suggested by Chaitanya and Jason, respectively)
  - Rename sg_dma_mark_pci_p2pdma() and sg_is_dma_pci_p2pdma() to
    sg_dma_mark_bus_address() and sg_is_dma_bus_address() which
    is a more generic name (As requested by Jason)
  - Fixes to some comments and commit messages as suggested by Bjorn
    and Jason.
  - Ensure swiotlb is not used with P2PDMA pages. (Per Jason)
  - The sgtable coversion in RDMA was split out and sent upstream
    separately, the new patch is only the removal. (Per Jason)
  - Moved the FOLL_PCI_P2PDMA check outside of get_dev_pagemap() as
    Jason suggested this will be removed in the near term.
  - Add two patches to ensure that zone device pages with different
    pgmaps are never merged in the block layer or
    sg_alloc_append_table_from_pages() (Per Jason)
  - Ensure synchronize_rcu() or call_rcu() is used before returning
    pages to the genalloc. (Jason pointed out that pages are not
    gauranteed to be unused in all architectures until at least
    after an RCU grace period, and that synchronize_rcu() was likely
    too slow to use in the vma close operation.
  - Collected Acks and Reviews by Bjorn, Jason and Max.

Logan Gunthorpe (22):
  lib/scatterlist: add flag for indicating P2PDMA segments in an SGL
  PCI/P2PDMA: Attempt to set map_type if it has not been set
  PCI/P2PDMA: Expose pci_p2pdma_map_type()
  PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
  dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
  dma-direct: support PCI P2PDMA pages in dma-direct map_sg
  dma-mapping: add flags to dma_map_ops to indicate PCI P2PDMA support
  iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg
  nvme-pci: check DMA ops when indicating support for PCI P2PDMA
  nvme-pci: convert to using dma_map_sgtable()
  RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
  RDMA/rw: drop pci_p2pdma_[un]map_sg()
  PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
  mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
  block: add check when merging zone device pages
  lib/scatterlist: add check when merging zone device pages
  block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
  mm: use custom page_free for P2PDMA pages
  PCI/P2PDMA: Introduce pci_mmap_p2pmem()
  nvme-pci: allow mmaping the CMB in userspace

Ralph Campbell (2):
  ext4/xfs: add page refcount helper
  mm: remove extra ZONE_DEVICE struct page refcount

 arch/powerpc/kvm/book3s_hv_uvmem.c     |   2 +-
 block/bio.c                            |  10 +-
 block/blk-map.c                        |   7 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c |   2 +-
 drivers/infiniband/core/rw.c           |  45 +--
 drivers/iommu/dma-iommu.c              |  67 +++-
 drivers/nvme/host/core.c               |  18 +-
 drivers/nvme/host/nvme.h               |   4 +-
 drivers/nvme/host/pci.c                |  97 +++---
 drivers/nvme/target/rdma.c             |   2 +-
 drivers/pci/Kconfig                    |   5 +
 drivers/pci/p2pdma.c                   | 441 +++++++++++++++++++++----
 fs/dax.c                               |   8 +-
 fs/ext4/inode.c                        |   5 +-
 fs/fuse/dax.c                          |   4 +-
 fs/xfs/xfs_file.c                      |   4 +-
 include/linux/dax.h                    |  10 +
 include/linux/dma-map-ops.h            |  76 +++++
 include/linux/dma-mapping.h            |   5 +
 include/linux/memremap.h               |   7 +-
 include/linux/mm.h                     |  68 ++--
 include/linux/pci-p2pdma.h             |  38 +--
 include/linux/scatterlist.h            |  44 ++-
 include/linux/uio.h                    |   6 +
 include/rdma/ib_verbs.h                |  11 +
 include/uapi/linux/magic.h             |   1 +
 kernel/dma/direct.c                    |  43 ++-
 kernel/dma/direct.h                    |   7 +-
 kernel/dma/mapping.c                   |  22 +-
 lib/iov_iter.c                         |  25 +-
 lib/scatterlist.c                      |  25 +-
 lib/test_hmm.c                         |   2 +-
 mm/gup.c                               |  22 +-
 mm/internal.h                          |   8 +
 mm/memcontrol.c                        |   6 +-
 mm/memremap.c                          |  75 ++---
 mm/migrate.c                           |   5 -
 mm/page_alloc.c                        |   3 +
 mm/swap.c                              |  45 +--
 39 files changed, 904 insertions(+), 371 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
--
2.30.2

