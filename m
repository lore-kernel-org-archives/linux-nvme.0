Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE42DC54E5C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HKiBA5pChvNa/3Hb57ymTpQo3knVfTVpUxU8WZumb7Y=; b=SR2lyOMU5n7aW+He8zKY7iZ1zt
	W+VCL7ORlmzg26VGGcHXrYQi1kqG4vOyDWIfz6CRBhq4OtmITEfs4HbhcgrCfiLbfPzRacW3z2acv
	ULCyio9x/5WHB4x2IPuvR2IYt8vg90r/JUEFrybrHTZDK2B3rOYZ3nKruxJgd0uRk1srVg+AUg5in
	BZ15Km0KtkYb0r/YFaA5mJb1sc+1wlmgqnBNYGwdKQsr6N3DhgRympAJ2lzHHusLVmrplnUej4Jt1
	jaINgCXadTOwgTFqUCJTDbXH/u0Ro6G1QOtfarGjhRUOq3u/xeRjtTEKSc2pf5Uod/g2/5RqwLvCU
	+M4afo5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhW8S-0000000E7bQ-217Q;
	Tue, 05 Mar 2024 14:51:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSoy-0000000DIR7-45U2
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 11:18:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 99B7161335;
	Tue,  5 Mar 2024 11:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531A2C433F1;
	Tue,  5 Mar 2024 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709637534;
	bh=NxhQVbYsKSwyvGgGk5qfaF5a/Y1wAzitab7stbdLKEk=;
	h=From:To:Cc:Subject:Date:From;
	b=r002UdI01gg2rXuVaeOK/D1fhwvZco1HuVKXX0raiRp4PUfsfXV1wc5RAqWyZvJGK
	 mRH29l4+teuQlcz7MYEH/XOhAk5fjO/D/+ObXI96O5zHSMTDzcXW1equc4uEnI9Kre
	 2BcxvXeVYU69p4m+lD0jFj6BxZAVk5SYUzkfEQXMq9ZQADbWBmK/mOgQSEndSNXrmU
	 N0zqFP6N8iRdWJolF3xUwGboWwTM+WK03mm/r/4T6jt0HRL4N+JZfELJzmdMuRU5c2
	 3ntsHZLDUHj1RvDsUQibOL0qdzbtw4jvy9b1b8vryqWssRm+htmwj9BHKQEKphbBXH
	 1E2fwP28bIgFw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
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
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Date: Tue,  5 Mar 2024 13:18:31 +0200
Message-ID: <cover.1709635535.git.leon@kernel.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_031857_422114_5B7AF9D8 
X-CRM114-Status: GOOD (  16.23  )
X-Mailman-Approved-At: Tue, 05 Mar 2024 05:32:59 -0800
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

This is complimentary part to the proposed LSF/MM topic.
https://lore.kernel.org/linux-rdma/22df55f8-cf64-4aa8-8c0b-b556c867b926@linux.dev/T/#m85672c860539fdbbc8fe0f5ccabdc05b40269057

This is posted as RFC to get a feedback on proposed split, but RDMA, VFIO and
DMA patches are ready for review and inclusion, the NVMe patches are still in
progress as they require agreement on API first.

Thanks

-------------------------------------------------------------------------------
The DMA mapping operation performs two steps at one same time: allocates
IOVA space and actually maps DMA pages to that space. This one shot
operation works perfectly for non-complex scenarios, where callers use
that DMA API in control path when they setup hardware.

However in more complex scenarios, when DMA mapping is needed in data
path and especially when some sort of specific datatype is involved,
such one shot approach has its drawbacks.

That approach pushes developers to introduce new DMA APIs for specific
datatype. For example existing scatter-gather mapping functions, or
latest Chuck's RFC series to add biovec related DMA mapping [1] and
probably struct folio will need it too.

These advanced DMA mapping APIs are needed to calculate IOVA size to
allocate it as one chunk and some sort of offset calculations to know
which part of IOVA to map.

Instead of teaching DMA to know these specific datatypes, let's separate
existing DMA mapping routine to two steps and give an option to advanced
callers (subsystems) perform all calculations internally in advance and
map pages later when it is needed.

In this series, three users are converted and each of such conversion
presents different positive gain:
1. RDMA simplifies and speeds up its pagefault handling for
   on-demand-paging (ODP) mode.
2. VFIO PCI live migration code saves huge chunk of memory.
3. NVMe PCI avoids intermediate SG table manipulation and operates
   directly on BIOs.

Thanks

[1] https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net

Chaitanya Kulkarni (2):
  block: add dma_link_range() based API
  nvme-pci: use blk_rq_dma_map() for NVMe SGL

Leon Romanovsky (14):
  mm/hmm: let users to tag specific PFNs
  dma-mapping: provide an interface to allocate IOVA
  dma-mapping: provide callbacks to link/unlink pages to specific IOVA
  iommu/dma: Provide an interface to allow preallocate IOVA
  iommu/dma: Prepare map/unmap page functions to receive IOVA
  iommu/dma: Implement link/unlink page callbacks
  RDMA/umem: Preallocate and cache IOVA for UMEM ODP
  RDMA/umem: Store ODP access mask information in PFN
  RDMA/core: Separate DMA mapping to caching IOVA and page linkage
  RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
  vfio/mlx5: Explicitly use number of pages instead of allocated length
  vfio/mlx5: Rewrite create mkey flow to allow better code reuse
  vfio/mlx5: Explicitly store page list
  vfio/mlx5: Convert vfio to use DMA link API

 Documentation/core-api/dma-attributes.rst |   7 +
 block/blk-merge.c                         | 156 ++++++++++++++
 drivers/infiniband/core/umem_odp.c        | 219 +++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |   1 +
 drivers/infiniband/hw/mlx5/odp.c          |  59 +++--
 drivers/iommu/dma-iommu.c                 | 129 ++++++++---
 drivers/nvme/host/pci.c                   | 220 +++++--------------
 drivers/vfio/pci/mlx5/cmd.c               | 252 ++++++++++++----------
 drivers/vfio/pci/mlx5/cmd.h               |  22 +-
 drivers/vfio/pci/mlx5/main.c              | 136 +++++-------
 include/linux/blk-mq.h                    |   9 +
 include/linux/dma-map-ops.h               |  13 ++
 include/linux/dma-mapping.h               |  39 ++++
 include/linux/hmm.h                       |   3 +
 include/rdma/ib_umem_odp.h                |  22 +-
 include/rdma/ib_verbs.h                   |  54 +++++
 kernel/dma/debug.h                        |   2 +
 kernel/dma/direct.h                       |   7 +-
 kernel/dma/mapping.c                      |  91 ++++++++
 mm/hmm.c                                  |  34 +--
 20 files changed, 870 insertions(+), 605 deletions(-)

-- 
2.44.0


