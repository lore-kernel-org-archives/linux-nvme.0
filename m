Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691DEC35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Mar 2025 18:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=meG9ZA3MJCgBc8xoMq4fmTlRmYixqZc1cv6C0aMOIH4=; b=b75PjTW7wm1Tl4M+DjScUH6kJc
	nK2vJBqFzdlTahsMpej70coWajfKSKxMuSce7iCEb8xcPPE/yH1NBe55StKGJmWH+GExduL0Vca2U
	d4Kk3VbJDkRI+Kg2WoUqS/WOgLqNF2/8kPq3/P2x6ntlceijoRPDo8T48WMtwjWE3WgjwoQLATWVQ
	kF60ds7ss3mT/VuuXjIKXlqsxalPElVliiYBLrWE/vemJ5KkfuW18mHwWO8+dBd5YacBPfKKWLTjV
	OQlLI/GkWeBM8K9f1sGeVWP5/UpUp+QAi33a50aBoCniS3p7cjATyFW2TJtOQvxQfyJNq46W1scLt
	/StTvMaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ttA5v-0000000F3qE-3grn;
	Fri, 14 Mar 2025 18:49:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ttA5t-0000000F3pY-0akY
	for linux-nvme@lists.infradead.org;
	Fri, 14 Mar 2025 18:49:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A08A05C4C71;
	Fri, 14 Mar 2025 18:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4A3C4CEE9;
	Fri, 14 Mar 2025 18:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741978156;
	bh=O6TQHcNZOIDORUQUex99gbjkbXRSAsx+LziCN6QYCcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQVmjcjZhe/sj5yONxV2qVxL98CsQ/XLSI8I1aZI9aDjryLW+sVGMqcfI9Bca9bOS
	 BjeRuzyi8Km8hWOU7pWxLh0zSj3Q5xmQc8mdYFqkiDMoJN2jPM4GlDtxa49auZ9+wv
	 o4Atu8WInpcl8PAepC/fXyU6iiNJ15uue0LdQRbYK1nJzWh83j90x9tnoa0sRasVK1
	 38iJcCj/HUFJNu/wqR3UGB0O36uPS2R51CHZ5YoiakTWuHP1tXd0Pvob4wtZn293CI
	 sVep3kKdHjc3A4MK0/PKcdqXaMCX1hnu3s63bSmSw7dabMqNw6WwX2YJoxC1T+nsVF
	 6r+AVkQEbO0Yg==
Date: Fri, 14 Mar 2025 20:49:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250314184911.GR1322339@unreal>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250314_114917_268523_EF780900 
X-CRM114-Status: GOOD (  37.97  )
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

On Fri, Mar 14, 2025 at 11:52:58AM +0100, Marek Szyprowski wrote:
> On 12.03.2025 20:32, Leon Romanovsky wrote:
> > On Wed, Mar 12, 2025 at 10:28:32AM +0100, Marek Szyprowski wrote:
> >> Hi Robin
> >>
> >> On 28.02.2025 20:54, Robin Murphy wrote:
> >>> On 20/02/2025 12:48 pm, Leon Romanovsky wrote:
> >>>> On Wed, Feb 05, 2025 at 04:40:20PM +0200, Leon Romanovsky wrote:
> >>>>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>>>
> >>>>> Changelog:
> >>>>> v7:
> >>>>>    * Rebased to v6.14-rc1
> >>>> <...>
> >>>>
> >>>>> Christoph Hellwig (6):
> >>>>>     PCI/P2PDMA: Refactor the p2pdma mapping helpers
> >>>>>     dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
> >>>>>     iommu: generalize the batched sync after map interface
> >>>>>     iommu/dma: Factor out a iommu_dma_map_swiotlb helper
> >>>>>     dma-mapping: add a dma_need_unmap helper
> >>>>>     docs: core-api: document the IOVA-based API
> >>>>>
> >>>>> Leon Romanovsky (11):
> >>>>>     iommu: add kernel-doc for iommu_unmap and iommu_unmap_fast
> >>>>>     dma-mapping: Provide an interface to allow allocate IOVA
> >>>>>     dma-mapping: Implement link/unlink ranges API
> >>>>>     mm/hmm: let users to tag specific PFN with DMA mapped bit
> >>>>>     mm/hmm: provide generic DMA managing logic
> >>>>>     RDMA/umem: Store ODP access mask information in PFN
> >>>>>     RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
> >>>>>       linkage
> >>>>>     RDMA/umem: Separate implicit ODP initialization from explicit ODP
> >>>>>     vfio/mlx5: Explicitly use number of pages instead of allocated
> >>>>> length
> >>>>>     vfio/mlx5: Rewrite create mkey flow to allow better code reuse
> >>>>>     vfio/mlx5: Enable the DMA link API
> >>>>>
> >>>>>    Documentation/core-api/dma-api.rst   |  70 ++++
> >>>>    drivers/infiniband/core/umem_odp.c   | 250 +++++---------
> >>>>>    drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
> >>>>>    drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
> >>>>>    drivers/infiniband/hw/mlx5/umr.c     |  12 +-
> >>>>>    drivers/iommu/dma-iommu.c            | 468
> >>>>> +++++++++++++++++++++++----
> >>>>>    drivers/iommu/iommu.c                |  84 ++---
> >>>>>    drivers/pci/p2pdma.c                 |  38 +--
> >>>>>    drivers/vfio/pci/mlx5/cmd.c          | 375 +++++++++++----------
> >>>>>    drivers/vfio/pci/mlx5/cmd.h          |  35 +-
> >>>>>    drivers/vfio/pci/mlx5/main.c         |  87 +++--
> >>>>>    include/linux/dma-map-ops.h          |  54 ----
> >>>>>    include/linux/dma-mapping.h          |  85 +++++
> >>>>>    include/linux/hmm-dma.h              |  33 ++
> >>>>>    include/linux/hmm.h                  |  21 ++
> >>>>>    include/linux/iommu.h                |   4 +
> >>>>>    include/linux/pci-p2pdma.h           |  84 +++++
> >>>>>    include/rdma/ib_umem_odp.h           |  25 +-
> >>>>>    kernel/dma/direct.c                  |  44 +--
> >>>>>    kernel/dma/mapping.c                 |  18 ++
> >>>>>    mm/hmm.c                             | 264 +++++++++++++--
> >>>>>    21 files changed, 1435 insertions(+), 693 deletions(-)
> >>>>>    create mode 100644 include/linux/hmm-dma.h
> >>>> Kind reminder.
> > <...>
> >
> >> Removing the need for scatterlists was advertised as the main goal of
> >> this new API, but it looks that similar effects can be achieved with
> >> just iterating over the pages and calling page-based DMA API directly.
> > Such iteration can't be enough because P2P pages don't have struct pages,
> > so you can't use reliably and efficiently dma_map_page_attrs() call.
> >
> > The only way to do so is to use dma_map_sg_attrs(), which relies on SG
> > (the one that we want to remove) to map P2P pages.
> 
> That's something I don't get yet. How P2P pages can be used with 
> dma_map_sg_attrs(), but not with dma_map_page_attrs()? Both operate 
> internally on struct page pointer.

Yes, and no.
See users of is_pci_p2pdma_page(...) function. In dma_*_sg() APIs, there
is a real check and support for p2p. In dma_map_page_attrs() variants,
this support is missing (ignored, or error is returned).

> 
> >> Maybe I missed something. I still see some advantages in this DMA API
> >> extension, but I would also like to see the clear benefits from
> >> introducing it, like perf logs or other benchmark summary.
> > We didn't focus yet on performance, however Christoph mentioned in his
> > block RFC [1] that even simple conversion should improve performance as
> > we are performing one P2P lookup per-bio and not per-SG entry as was
> > before [2]. In addition it decreases memory [3] too.
> >
> > [1] https://lore.kernel.org/all/cover.1730037261.git.leon@kernel.org/
> > [2] https://lore.kernel.org/all/34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org/
> > [3] https://lore.kernel.org/all/383557d0fa1aa393dbab4e1daec94b6cced384ab.1730037261.git.leon@kernel.org/
> >
> > So clear benefits are:
> > 1. Ability to use native for subsystem structure, e.g. bio for block,
> > umem for RDMA, dmabuf for DRM, e.t.c. It removes current wasteful
> > conversions from and to SG in order to work with DMA API.
> > 2. Batched request and iotlb sync optimizations (perform only once).
> > 3. Avoid very expensive call to pgmap pointer.
> > 4. Expose MMIO over VFIO without hacks (PCI BAR doesn't have struct pages).
> > See this series for such a hack
> > https://lore.kernel.org/all/20250307052248.405803-1-vivek.kasireddy@intel.com/
> 
> I see those benefits and I admit that for typical DMA-with-IOMMU case it 
> would improve some things. I think that main concern from Robin was how 
> to handle it for the cases without an IOMMU.

In such case, we fallback to non-IOMMU flow (old, well-established one).
See this HMM patch as an example https://lore.kernel.org/all/a796da065fa8a9cb35d591ce6930400619572dcc.1738765879.git.leonro@nvidia.com/
+dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
+			   size_t idx,
+			   struct pci_p2pdma_map_state *p2pdma_state)
...
+	if (dma_use_iova(state)) {
...
+	} else {
...
+		dma_addr = dma_map_page(dev, page, 0, map->dma_entry_size,
+					DMA_BIDIRECTIONAL);

Thanks

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

