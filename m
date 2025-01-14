Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40174E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jan 2025 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPtE9uMv30rB1bHKR/a/9JJ7OoHjPuvqUCk6S++rXK0=; b=Tv7mRBlVSfFzyYglUKULeqWq3f
	HtlinZ1m4Gvfy/gfJsHqUFyAm8ReiEHxUZHl3506nAQkUkrnZPCPgKfJ9KZAf9juwiYwrxD6DIag+
	ft+mJOoG1VrZ56sKe59WEj9cdmC+YzHHHIuB1E9SUCE1izu8LcdS1o3fL6VbeparPPH0jGbFmFSED
	XYVtNYdRBqtWS2vjIMDU2AXp9WBsQ0FX9d+E0Hr7fDw0VfY1aqxw+yV2ng9WRT2nQbzl85C79fT0n
	oxoYkywH5HtSQomS2iWIPEl8Wyv2o2zQimRWMYE3130s+raaKTod/joUmxkg3cW7BF4Xb3yvPkFsM
	NhYGFjHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXcRv-00000007qfg-0ylT;
	Tue, 14 Jan 2025 08:38:59 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXcRs-00000007qdO-0sDp
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jan 2025 08:38:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AA9D7A40DCD;
	Tue, 14 Jan 2025 08:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3272C4CEDD;
	Tue, 14 Jan 2025 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736843934;
	bh=WCmlIJb/eJ3RtRwBL0vbXX0Y9UrynyAEdph0c+wowPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssv9xXhOL7JbMMQrzlaq27YWcIfBrJoOCeudEXG9TZo+CTwB4dvd5GSjmpavw7e45
	 mnFmWBsl8OxWd53GB8Ai3qRopj9qNOYzrIKnjN918usYV953p8Z71j8T9h8bRRgd80
	 mbGV/Q9H0WnXVRuMYHxZFQGgigZ6wJf8UrCX5GqCfJBdnZINfpgPJQrTxLzhlJg07Y
	 BIQWvXINHA2mvOIkrZyZDtdpZqKLm7qpvrTk+kx7XKDDXEu0pCnY7dzHvA1pZbR8yv
	 o9iPi8YszEl9iejfRQW/qe5KSfvou9DSiPIxxOEteYKg009tI7JHlqlu+nZukZHN0U
	 oaCRxAZ2exYjA==
Date: Tue, 14 Jan 2025 10:38:47 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
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
Subject: Re: [PATCH v5 00/17] Provide a new two step DMA mapping API
Message-ID: <20250114083847.GE3146852@unreal>
References: <cover.1734436840.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734436840.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_003856_373980_118FE33C 
X-CRM114-Status: GOOD (  16.81  )
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

On Tue, Dec 17, 2024 at 03:00:18PM +0200, Leon Romanovsky wrote:
> Changelog:

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
>  Documentation/core-api/dma-api.rst   |  70 +++++
>  drivers/infiniband/core/umem_odp.c   | 250 +++++----------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
>  drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +-
>  drivers/iommu/dma-iommu.c            | 454 +++++++++++++++++++++++----
>  drivers/iommu/iommu.c                |  84 ++---
>  drivers/pci/p2pdma.c                 |  38 +--
>  drivers/vfio/pci/mlx5/cmd.c          | 376 +++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h          |  35 ++-
>  drivers/vfio/pci/mlx5/main.c         |  87 +++--
>  include/linux/dma-map-ops.h          |  54 ----
>  include/linux/dma-mapping.h          |  86 +++++
>  include/linux/hmm-dma.h              |  33 ++
>  include/linux/hmm.h                  |  21 ++
>  include/linux/iommu.h                |   4 +
>  include/linux/pci-p2pdma.h           |  84 +++++
>  include/rdma/ib_umem_odp.h           |  25 +-
>  kernel/dma/direct.c                  |  44 +--
>  kernel/dma/mapping.c                 |  18 ++
>  mm/hmm.c                             | 264 ++++++++++++++--
>  21 files changed, 1423 insertions(+), 693 deletions(-)
>  create mode 100644 include/linux/hmm-dma.h

Hi Robin,

Can you please Ack the dma-iommu changes?

Thanks

> 
> -- 
> 2.47.0
> 
> 

