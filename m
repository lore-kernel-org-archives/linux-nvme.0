Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42E8E77187
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LXA8EtJqSt8YMcKAoZw1K1ZsXmQZSiBKF7dQgkzXx1s=; b=4daGWgr8PDqpoHmNA9KhOzxCwd
	tWU0/iGCnxLR8KrwUT2jwR6O6vpy8XBrS6f1f5Zo4RhEumc/Y+45P0xfYUvS31ATXqYsqAF6M//4X
	lf7m3kEeMYDBXzlpn6Ys8B9Ont5mBWKb9gxhRRWyoqjPTCPwMsKAUl3YLs6ofxTGvYBYM0vGsVBMb
	I3kHc77k6pOVnjvcqbhhFegA7H9QogPh8ZQVvO1pFmYgueVb6pPZBYoKtats7hKuKBOAlHQy0U5+i
	Sa3zNF3jmMzpxhD8G7vemobsqAXda9F9smvV1sFUFdtcpc7TcUI2I+05aV7XBMIyqrLCgA3Ky3b0y
	a1buUVGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNXD6-0000000DScb-3d3r;
	Tue, 17 Dec 2024 13:02:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNXC9-0000000DSAK-3Vxo
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 13:01:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7103AA40FDD;
	Tue, 17 Dec 2024 12:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E42C4CED3;
	Tue, 17 Dec 2024 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440459;
	bh=WUcPWFcOfeUf/sio4O36o8I8jrOpMF9pl2t7YRV1K7c=;
	h=From:To:Cc:Subject:Date:From;
	b=W2+t6vZC3dFZWGD+hxEMeEPE1EEKt40fCuWrdg3SEm/26SFd4QEg0tiIvT2/Wek19
	 ipbNsM3RLXl0RvFJrTnmhBFYT5MAx6OqnZ/oOKDrKGf32XUg477wAJn6V2jcBjZO/8
	 Ii8+JaZkyyMGebvolPyBm40JjRdZQhIhr9H3yf5kaiaiXVcPFmwe/C4LJJ4P6impvd
	 8/hR+n5YTMhKvuP9ew3PL2463hfk0ZudfO9HpYVaOpExaxG4v5E7GWf3f90dIP2oBV
	 GHJCkATLPfGc2ofcLdQ0kQuhsYKz0DBm7jEilkgCea7JLERhDeOtEVUaSSk2h/iHeZ
	 SwmUwQ1h0ckQQ==
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
	linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 00/17] Provide a new two step DMA mapping API
Date: Tue, 17 Dec 2024 15:00:18 +0200
Message-ID: <cover.1734436840.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_050102_016958_FCE620C3 
X-CRM114-Status: GOOD (  15.61  )
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
v5:
 * Trimmed long lines in all patches.
 * Squashed "dma-mapping: Add check if IOVA can be used" into
   "dma: Provide an interface to allow allocate IOVA" patch.
 * Added tags from Christoph and Will.
 * Fixed spelling/grammar errors.
 * Change title from "dma: Provide an  ..." to be "dma-mapping: Provide an ...".
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

 Documentation/core-api/dma-api.rst   |  70 +++++
 drivers/infiniband/core/umem_odp.c   | 250 +++++----------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
 drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
 drivers/infiniband/hw/mlx5/umr.c     |  12 +-
 drivers/iommu/dma-iommu.c            | 454 +++++++++++++++++++++++----
 drivers/iommu/iommu.c                |  84 ++---
 drivers/pci/p2pdma.c                 |  38 +--
 drivers/vfio/pci/mlx5/cmd.c          | 376 +++++++++++-----------
 drivers/vfio/pci/mlx5/cmd.h          |  35 ++-
 drivers/vfio/pci/mlx5/main.c         |  87 +++--
 include/linux/dma-map-ops.h          |  54 ----
 include/linux/dma-mapping.h          |  86 +++++
 include/linux/hmm-dma.h              |  33 ++
 include/linux/hmm.h                  |  21 ++
 include/linux/iommu.h                |   4 +
 include/linux/pci-p2pdma.h           |  84 +++++
 include/rdma/ib_umem_odp.h           |  25 +-
 kernel/dma/direct.c                  |  44 +--
 kernel/dma/mapping.c                 |  18 ++
 mm/hmm.c                             | 264 ++++++++++++++--
 21 files changed, 1423 insertions(+), 693 deletions(-)
 create mode 100644 include/linux/hmm-dma.h

-- 
2.47.0


