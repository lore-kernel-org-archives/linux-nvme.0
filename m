Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D22DD41D61
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 07:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1OMx3CzUE48Ymp5FIXnIDRoSMxzD43U0/NiqFxhCPMk=; b=PMr++FsvaYqDqK4emaufGi35+5
	vL95f8AmX1NbIaJkRSMpsiUxymi7AWTCXhkjmIdR74+j8wIM8r2iVHxXefZhxbG9kL+r+Ku9ezJ65
	nC4eWDvI2DwK0rPwuu8zLXt3cYYeNz9v75IPxzLVPNFK6+l73VuXmRRvKEs75TinpYBk8/xoUHzC8
	lnPkM29P3ohW4KC/R3GrBki4MsGTzsnD4Nw9MElY6feJI1WskJulaXqR89L1NwhmD1D5Rsps5gm/1
	e2SOPKYAYrWJfsIJr8gb+6RE4mVmVBppk8CcRVkT2R9AUMp/BYutOmhJ7HLSckt9SX9/Sz/dyUJ1I
	QBu7PGxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAlCm-00000002RwF-1T4u;
	Tue, 12 Nov 2024 07:20:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAlCi-00000002RvW-1sB2
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 07:20:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E13025C4B45;
	Tue, 12 Nov 2024 07:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7FFC4CED6;
	Tue, 12 Nov 2024 07:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731396047;
	bh=iebmt1JJ4nc2KqO33nu0BylpM0uwrbfzxJxK70i+S/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVmzKoMMLI1p5lld2AzbKA0OKhkaVTgahMbznY+ch5wqmWfYCEBoHJ5ZIQ8i4OEW7
	 y0SB4PSstnJw8hURXljSVh3nG8HHVe3dC7gqHVMQQXmgFoRfx3x8hsZ36yggo7YlVq
	 2q0lrQ8rdvyycCXVFgnX8tvivhS3iXRbVyFR1p3rkwOgGKPIQ2kftduBV0NwjkeMS6
	 +NoAmsvdHq/cRMRpCO7yQhqTp7kgXfnEETQD/OipD9b2Ni66FEyjDAneYRjzAw6sNL
	 U2vmfYx6TwAoyvedmOw9NUrF5kwpsNBTikX0r/vBN3EeyzUVC53eAjFgH0BRIJSoUB
	 HtyTui/+hEy9g==
Date: Tue, 12 Nov 2024 09:20:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>, ill Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
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
Subject: Re: [PATCH v3 00/17] Provide a new two step DMA mapping API
Message-ID: <20241112072040.GG71181@unreal>
References: <cover.1731244445.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731244445.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_232048_534688_7B912220 
X-CRM114-Status: GOOD (  14.07  )
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

On Sun, Nov 10, 2024 at 03:46:47PM +0200, Leon Romanovsky wrote:

<...>

> ----------------------------------------------------------------------------
> The code can be downloaded from:
> https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git tag:dma-split-nov-09

<...>

> 
> Christoph Hellwig (6):
>   PCI/P2PDMA: Refactor the p2pdma mapping helpers
>   dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
>   iommu: generalize the batched sync after map interface
>   iommu/dma: Factor out a iommu_dma_map_swiotlb helper
>   dma-mapping: add a dma_need_unmap helper
>   docs: core-api: document the IOVA-based API
> 
> Leon Romanovsky (11):
>   dma-mapping: Add check if IOVA can be used
>   dma: Provide an interface to allow allocate IOVA
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

Robin,

All technical concerns were handled and this series is ready to be merged.

Robin, can you please Ack the dma-iommu patches?

Thanks

