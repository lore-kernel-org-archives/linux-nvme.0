Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E439C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jni0hvcjt0Ult8Hrwijcs86k+kYBriZ28Ypo0GTv5SA=; b=bZU1V2eJe6PS0chVn6oNujFOQM
	PIHR5xZcQoHXUAQoToYsWiIWzEt2+TrjEpQPyqmfnxVsoD9azGWWELJt/3zLqjL2L5bqpnCWQurOr
	6B0wmnPGftFuVxv16xg6nNyr5hBhYzvURn+dpQa7TXBVj1m+XDJG3kadgWT66P4c6Kya8itMJTlnU
	74sT/WpkuKVfVo459Kic3CrYPXqLfRRKmqjumHdd2XW7MZPIkbu4o8hxMrGlQp/QAA5R2FSGWRaAP
	vL1Vl4PHflIUyfPONvctCbMpekeo0y6GIpPsZJAV1gJEsh2znuSQDzzrWT5jMeSpvKmK/kOiD7lt2
	YI68Yo1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl6E1-00000000wrF-1Mcx;
	Thu, 20 Feb 2025 13:04:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl5yi-00000000sct-25eD
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 12:48:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A4BB55C5D82;
	Thu, 20 Feb 2025 12:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C882DC4CED1;
	Thu, 20 Feb 2025 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740055711;
	bh=1Iv3ATubl6AG/lSG1TPOh5GEc+mnunYnUNognONLHrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhH3Rxw/fU4NMM8JUKPDYre9d9LQaru2HtlbuSSUNzkHB8eWhqMM23vtegnTWn+BS
	 9+H0GOfdzn1LNx9IHcWfvcpB8EXNSp57Achx+q1U7ozbfXzho3FO9ENmdtK+fnEJTx
	 1mX2B9KcxOTwRBNfDJoEWHPpCPDk48cyZC7xwNx3D4HZ/eDzhk1UYs1ByD6cWBCggg
	 PbJi1s5B2/FkYeMMfisRgyehbN8fd3in3TvHNeTh17NIjIy8rndGPwyK8hEYOJ4woC
	 z5Pq6b+6BoM66BA9VpnFOLzal49GAHK/nFhBZx9kerNsCt2/b4psBlXL8nvsynNOoP
	 upH4tKmvy4K+A==
Date: Thu, 20 Feb 2025 14:48:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250220124827.GR53094@unreal>
References: <cover.1738765879.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1738765879.git.leonro@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_044832_646343_9FE96914 
X-CRM114-Status: GOOD (  17.14  )
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

On Wed, Feb 05, 2025 at 04:40:20PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v7:
>  * Rebased to v6.14-rc1

<...>

> Christoph Hellwig (6):
>   PCI/P2PDMA: Refactor the p2pdma mapping helpers
>   dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
>   iommu: generalize the batched sync after map interface
>   iommu/dma: Factor out a iommu_dma_map_swiotlb helper
>   dma-mapping: add a dma_need_unmap helper
>   docs: core-api: document the IOVA-based API
> 
> Leon Romanovsky (11):
>   iommu: add kernel-doc for iommu_unmap and iommu_unmap_fast
>   dma-mapping: Provide an interface to allow allocate IOVA
>   dma-mapping: Implement link/unlink ranges API
>   mm/hmm: let users to tag specific PFN with DMA mapped bit
>   mm/hmm: provide generic DMA managing logic
>   RDMA/umem: Store ODP access mask information in PFN
>   RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
>     linkage
>   RDMA/umem: Separate implicit ODP initialization from explicit ODP
>   vfio/mlx5: Explicitly use number of pages instead of allocated length
>   vfio/mlx5: Rewrite create mkey flow to allow better code reuse
>   vfio/mlx5: Enable the DMA link API
> 
>  Documentation/core-api/dma-api.rst   |  70 ++++
>  drivers/infiniband/core/umem_odp.c   | 250 +++++---------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
>  drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +-
>  drivers/iommu/dma-iommu.c            | 468 +++++++++++++++++++++++----
>  drivers/iommu/iommu.c                |  84 ++---
>  drivers/pci/p2pdma.c                 |  38 +--
>  drivers/vfio/pci/mlx5/cmd.c          | 375 +++++++++++----------
>  drivers/vfio/pci/mlx5/cmd.h          |  35 +-
>  drivers/vfio/pci/mlx5/main.c         |  87 +++--
>  include/linux/dma-map-ops.h          |  54 ----
>  include/linux/dma-mapping.h          |  85 +++++
>  include/linux/hmm-dma.h              |  33 ++
>  include/linux/hmm.h                  |  21 ++
>  include/linux/iommu.h                |   4 +
>  include/linux/pci-p2pdma.h           |  84 +++++
>  include/rdma/ib_umem_odp.h           |  25 +-
>  kernel/dma/direct.c                  |  44 +--
>  kernel/dma/mapping.c                 |  18 ++
>  mm/hmm.c                             | 264 +++++++++++++--
>  21 files changed, 1435 insertions(+), 693 deletions(-)
>  create mode 100644 include/linux/hmm-dma.h

Kind reminder.

Thanks

> 
> -- 
> 2.48.1
> 
> 

