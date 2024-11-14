Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC798D68B12
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 13:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jFTl3hFYuyRSySoV5BYyPMWdu2M6HUxYsOoVjHl3og=; b=qj+La/oMTip66vc7TKJ8CTsuzS
	FXj0/KsphNYvgwxFKueIDudWXD6uJB9JQHM1xUaM7l4JdQ5OSBpjEutK1EtfLlRQhbtFgyJMoomdq
	7zPoF7YbTUv8+EHOJzbcn+8XS18clo9P1/N1outx2i0Y96qc4JVaCzVakucBxSBFGLE2oIJOtExo7
	JoDeootrYKgPAXbAfLzDtRxBNZd+ZDjJfz8mHKwCf56t0HN0JukPy1vvU6XKidJr03mP1cq62A84q
	rUibt28+wWl+2el+p3wyNP4NoVDksbpWeb1XrniHd0XRh/K4yr013MteaQnsZdw4PJiq/T+zT161U
	v/ofD9LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZvW-0000000A3bL-04KR;
	Thu, 14 Nov 2024 13:30:26 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBZvR-0000000A3Zv-2rBL
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 13:30:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 499C9A40ECF;
	Thu, 14 Nov 2024 13:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3201DC4CED4;
	Thu, 14 Nov 2024 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731591020;
	bh=9WziBDbWuCJavDfebCiGijovNr2dEkFb5dOslEqLDxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrph4l+r9SSW6Ri0yQO/ArvA5mrKpwgqxbiicodwQYX0FHUkW5FS5KI2v/78sx87r
	 p73mV8BzATegMAtr83CJrFyMrRrUdKqASvhJn+r/yI9rHIO/4m6KxV76EsYSPZym8j
	 VCUAgoN110ZQL9l00tP/BN7Gz6BdDwpinKAfJ5LBDL4OFafqxyWJ/CbeoUse2vhBTY
	 7r9HCx2mL1JQWljOWXFrKyW5/bkepvwmWx/DOITJk+lWy0E+U9MdlrCzr5QlTRbtNH
	 cX9+7de7U+/FfUqKiffWcA7DkZOnNhx55wm/AhHYvudtAa9MVpYv9xmRDGbaVy8rhH
	 0cpO1PSEk8NLA==
Date: Thu, 14 Nov 2024 15:30:11 +0200
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
Message-ID: <20241114133011.GA606631@unreal>
References: <cover.1731244445.git.leon@kernel.org>
 <20241112072040.GG71181@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112072040.GG71181@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_053021_875466_3D3D7848 
X-CRM114-Status: GOOD (  18.66  )
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

On Tue, Nov 12, 2024 at 09:20:40AM +0200, Leon Romanovsky wrote:
> On Sun, Nov 10, 2024 at 03:46:47PM +0200, Leon Romanovsky wrote:
> 
> <...>
> 
> > ----------------------------------------------------------------------------
> > The code can be downloaded from:
> > https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git tag:dma-split-nov-09
> 
> <...>
> 
> > 
> > Christoph Hellwig (6):
> >   PCI/P2PDMA: Refactor the p2pdma mapping helpers
> >   dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
> >   iommu: generalize the batched sync after map interface
> >   iommu/dma: Factor out a iommu_dma_map_swiotlb helper
> >   dma-mapping: add a dma_need_unmap helper
> >   docs: core-api: document the IOVA-based API
> > 
> > Leon Romanovsky (11):
> >   dma-mapping: Add check if IOVA can be used
> >   dma: Provide an interface to allow allocate IOVA
> >   dma-mapping: Implement link/unlink ranges API
> >   mm/hmm: let users to tag specific PFN with DMA mapped bit
> >   mm/hmm: provide generic DMA managing logic
> >   RDMA/umem: Store ODP access mask information in PFN
> >   RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
> >     linkage
> >   RDMA/umem: Separate implicit ODP initialization from explicit ODP
> >   vfio/mlx5: Explicitly use number of pages instead of allocated length
> >   vfio/mlx5: Rewrite create mkey flow to allow better code reuse
> >   vfio/mlx5: Enable the DMA link API
> 
> Robin,
> 
> All technical concerns were handled and this series is ready to be merged.
> 
> Robin, can you please Ack the dma-iommu patches?

I don't see any response, so my assumption is that this series is ready
to be merged. Let's do it this cycle and save from us the burden of
having dependencies between subsystems.

Thanks

> 
> Thanks
> 

