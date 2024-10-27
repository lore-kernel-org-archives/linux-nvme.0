Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D75D13562
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8QMN8oIbXWRme5fliVoE/X24sm1xxZ0f0rjPuVHN3wY=; b=pyh2f/hHfDdH5y0aBMqSoDRrJW
	f9P9OCTGLUZPsZX9fobVxqwB9MtN2XgmKrrKnIp4/x/EdgqDf4BsYzbCCao3uL7pxTR0unCZLKBaG
	TyUPyRYb2AdZkU4dipXulGm4UTEryiWBxWdHj1boXJJbpnmJRLPvgSUW8fmx1EIplN1GwsbQjIMtk
	bhmnVX7DpaoWhpC2HER43l4qdxcX5U7lVRTJNA0G9QJczdA8tosMy+V6K5NP01Bzvy1eei5EFXJGY
	m0uR4l7uk9t6ko3rBsiwSWt2Ckfo+D2zTwXeI7BBzCovKJsN+uHeeVwN7Sr9Toz7x2mSwPRqxaL3/
	G6r48b/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t549D-00000008Jpg-4Bp3;
	Sun, 27 Oct 2024 14:21:40 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5496-00000008Jow-2ePT
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 14:21:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0E9F6A40072;
	Sun, 27 Oct 2024 14:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F722C4CEC3;
	Sun, 27 Oct 2024 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730038890;
	bh=yiDPGTeRo6kkrCL424ml+10YMw3MQYm4nZaRw+o9Rl8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJXLcikUOitybN0hao1J9Vd9spDMODBJQHEviT465Ah4u+MoxB1mFmOHyANGxw5ia
	 30Bf6ThOTtlNMLBOOP2eKx/OtxsF4ACyy/E63V76kw9Srz48Q+zMmvzZyawo1/qkIF
	 ddiJk3UvCTr8eaD8xPC0CphXPMhx/Whg8Z0IO0OafvVuzrewN0MLYdQN+RBLSAbr8z
	 VMS/1jV+I/kno/tx99UhrFjJNGeo0dYa7Y+hdSQM6izl1RSW9fc5m7kTTZj0mvvo7r
	 fzojmNtZXvaZxwQaqY0r08vfE+KjCx3P8dfFhVwisgJsul2XoWFiwIpfHubMYxtPPG
	 kk7H9CbqENKHA==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 00/18] Provide a new two step DMA mapping API
Date: Sun, 27 Oct 2024 16:21:00 +0200
Message-ID: <cover.1730037276.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_072132_935000_F73D6045 
X-CRM114-Status: GOOD (  20.63  )
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

Currently the only efficient way to map a complex memory description through
the DMA API is by using the scatterlist APIs. The SG APIs are unique in that
they efficiently combine the two fundamental operations of sizing and allocating
a large IOVA window from the IOMMU and processing all the per-address
swiotlb/flushing/p2p/map details.

This uniqueness has been a long standing pain point as the scatterlist API
is mandatory, but expensive to use. It prevents any kind of optimization or
feature improvement (such as avoiding struct page for P2P) due to the impossibility
of improving the scatterlist.

Several approaches have been explored to expand the DMA API with additional
scatterlist-like structures (BIO[1], rlist[2]), instead split up the DMA API
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
solve some of the abuses and design mistakes, for instance in DMABUF's P2P
support.

Thanks

[1] https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org

Christoph Hellwig (6):
  PCI/P2PDMA: refactor the p2pdma mapping helpers
  dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
  iommu: generalize the batched sync after map interface
  iommu/dma: Factor out a iommu_dma_map_swiotlb helper
  dma-mapping: add a dma_need_unmap helper
  docs: core-api: document the IOVA-based API

Leon Romanovsky (12):
  dma-mapping: Add check if IOVA can be used
  dma: Provide an interface to allow allocate IOVA
  dma-mapping: Implement link/unlink ranges API
  mm/hmm: let users to tag specific PFN with DMA mapped bit
  mm/hmm: provide generic DMA managing logic
  RDMA/umem: Store ODP access mask information in PFN
  RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
    linkage
  RDMA/umem: Separate implicit ODP initialization from explicit ODP
  vfio/mlx5: Explicitly use number of pages instead of allocated length
  vfio/mlx5: Rewrite create mkey flow to allow better code reuse
  vfio/mlx5: Explicitly store page list
  vfio/mlx5: Convert vfio to use DMA link API

 Documentation/core-api/dma-api.rst   |  70 +++++
 drivers/infiniband/core/umem_odp.c   | 250 +++++----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
 drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
 drivers/infiniband/hw/mlx5/umr.c     |  12 +-
 drivers/iommu/dma-iommu.c            | 455 +++++++++++++++++++++++----
 drivers/iommu/iommu.c                |  65 ++--
 drivers/pci/p2pdma.c                 |  38 +--
 drivers/vfio/pci/mlx5/cmd.c          | 312 +++++++++---------
 drivers/vfio/pci/mlx5/cmd.h          |  24 +-
 drivers/vfio/pci/mlx5/main.c         |  87 +++--
 include/linux/dma-map-ops.h          |  54 ----
 include/linux/dma-mapping.h          |  84 +++++
 include/linux/hmm-dma.h              |  32 ++
 include/linux/hmm.h                  |  16 +
 include/linux/iommu.h                |   4 +
 include/linux/pci-p2pdma.h           |  84 +++++
 include/rdma/ib_umem_odp.h           |  25 +-
 kernel/dma/direct.c                  |  43 ++-
 kernel/dma/mapping.c                 |  20 ++
 mm/hmm.c                             | 229 +++++++++++++-
 21 files changed, 1345 insertions(+), 636 deletions(-)
 create mode 100644 include/linux/hmm-dma.h

-- 
2.46.2


