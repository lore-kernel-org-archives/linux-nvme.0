Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B1C54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJ5iE+LWxcrer1v/M54isoTyRWcTu5SpNDLz6j/UZx0=; b=uiqrtNMwVOrdQIxbRx1ogT1xZ3
	3jcZqLtedzMZWiYEFL+cmP9aXJMEZAROtH0SMC1X7PFbmSETqnjWUGXFnNvK8ACoc4JneDeVR/Bav
	lHviKyZSqops8IK7lUdZbt5CtW5LeUx99yHID7/hrdJHEF3ZM9oEP7XHam8IepRcKuaqOGulEyLP0
	E1+cT8Nj7vjSpnC9qFA1/XzOnNBmAmulLTph14m8QpU0i5xURLRAyXi5e9QUdd/wVGuA133qsuBp/
	4agFssDb7sEy0mdpR7wpVW+rOwcol2NZToiw3pQ9cU56Hujf43FEeDpMYGDCtOjTdwT3DEaDTceXe
	/O3/fmzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhUzV-0000000DpIl-0ptT;
	Tue, 05 Mar 2024 13:37:57 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhTvS-0000000DZtK-3DqB
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 12:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0E94BCE02BD;
	Tue,  5 Mar 2024 12:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE6CC43394;
	Tue,  5 Mar 2024 12:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709641780;
	bh=P93hlccw+xdxdbFmx+6Lr6WNHOyANq8FCYqtCUP40hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edE9W4exQ/mLyQoFZ0ecW6HlLDr9Z099WMeUuaFujQg2FZTZLAQnGDjK498JWa0ni
	 hqFMO5hIGroOgoA/TTNGplduxItE+LvgFwOBWjD33xVKfmTFkJ5U+9CtOOpdfL7udr
	 qhAc/itUetIkKuPj6Jv0+bNurWlOja/yk+vF05wSc8ytz4RcHmc2Kw2jU+9t5qdqtK
	 2MmLJphfTq56uO+Iq2YwNgSXMY5Hs5aBypVWlDYoEFPocQlvJgPL/m9HUD+GamQVTE
	 DFv6scJ4w1oMC0aHDm5eYXuKeZW4m+eUbOnkHeJ/XxbIduCTrPWiF//VLFhaMH4KXv
	 NmAjytaBBw2hw==
Date: Tue, 5 Mar 2024 14:29:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240305122935.GB36868@unreal>
References: <cover.1709635535.git.leon@kernel.org>
 <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_042943_185252_FCA2E249 
X-CRM114-Status: GOOD (  42.75  )
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

On Tue, Mar 05, 2024 at 12:05:23PM +0000, Robin Murphy wrote:
> On 2024-03-05 11:18 am, Leon Romanovsky wrote:
> > This is complimentary part to the proposed LSF/MM topic.
> > https://lore.kernel.org/linux-rdma/22df55f8-cf64-4aa8-8c0b-b556c867b926@linux.dev/T/#m85672c860539fdbbc8fe0f5ccabdc05b40269057
> > 
> > This is posted as RFC to get a feedback on proposed split, but RDMA, VFIO and
> > DMA patches are ready for review and inclusion, the NVMe patches are still in
> > progress as they require agreement on API first.
> > 
> > Thanks
> > 
> > -------------------------------------------------------------------------------
> > The DMA mapping operation performs two steps at one same time: allocates
> > IOVA space and actually maps DMA pages to that space. This one shot
> > operation works perfectly for non-complex scenarios, where callers use
> > that DMA API in control path when they setup hardware.
> > 
> > However in more complex scenarios, when DMA mapping is needed in data
> > path and especially when some sort of specific datatype is involved,
> > such one shot approach has its drawbacks.
> > 
> > That approach pushes developers to introduce new DMA APIs for specific
> > datatype. For example existing scatter-gather mapping functions, or
> > latest Chuck's RFC series to add biovec related DMA mapping [1] and
> > probably struct folio will need it too.
> > 
> > These advanced DMA mapping APIs are needed to calculate IOVA size to
> > allocate it as one chunk and some sort of offset calculations to know
> > which part of IOVA to map.
> 
> I don't follow this part at all - at *some* point, something must know a
> range of memory addresses involved in a DMA transfer, so that's where it
> should map that range for DMA. 

In all presented cases in this series, the overall DMA size is known in
advance. In RDMA case, it is known when user registers the memory, in
VFIO, when live migration is happening and in NVMe, when BIO is created.

So once we allocated IOVA, we will need to link ranges, which si the
same as map but without IOVA allocation.

> Even in a badly-designed system where the
> point it's most practical to make the mapping is further out and only knows
> that DMA will touch some subset of a buffer, but doesn't know exactly what
> subset yet, you'd usually just map the whole buffer. I don't see why the DMA
> API would ever need to know about anything other than pages/PFNs and
> dma_addr_ts (yes, it does also accept them being wrapped together in
> scatterlists; yes, scatterlists are awful and it would be nice to replace
> them with a better general DMA descriptor; that is a whole other subject of
> its own).

This is exactly what was done here, we got rid of scatterlists.

> 
> > Instead of teaching DMA to know these specific datatypes, let's separate
> > existing DMA mapping routine to two steps and give an option to advanced
> > callers (subsystems) perform all calculations internally in advance and
> > map pages later when it is needed.
> 
> From a brief look, this is clearly an awkward reinvention of the IOMMU API.
> If IOMMU-aware drivers/subsystems want to explicitly manage IOMMU address
> spaces then they can and should use the IOMMU API. Perhaps there's room for
> some quality-of-life additions to the IOMMU API to help with common usage
> patterns, but the generic DMA mapping API is absolutely not the place for
> it.

DMA mapping gives nice abstraction from IOMMU, and allows us to have
same flow for IOMMU and non-IOMMU flows without duplicating code, while
you suggest to teach almost every part in the kernel to know about IOMMU.

In this series, we changed RDMA, VFIO and NVMe, and in all cases we
removed more code than added. From what I saw, VDPA and virito-blk will
benefit from proposed API too.

Even in this RFC, where Chaitanya did partial job and didn't convert
whole driver, the gain is pretty obvious:
https://lore.kernel.org/linux-rdma/016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org/T/#u

 drivers/nvme/host/pci.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------------------------------------------------------------
 1 file changed, 49 insertions(+), 171 deletions(-)


Thanks

> 
> Thanks,
> Robin.
> 
> > In this series, three users are converted and each of such conversion
> > presents different positive gain:
> > 1. RDMA simplifies and speeds up its pagefault handling for
> >     on-demand-paging (ODP) mode.
> > 2. VFIO PCI live migration code saves huge chunk of memory.
> > 3. NVMe PCI avoids intermediate SG table manipulation and operates
> >     directly on BIOs.
> > 
> > Thanks
> > 
> > [1] https://lore.kernel.org/all/169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net
> > 
> > Chaitanya Kulkarni (2):
> >    block: add dma_link_range() based API
> >    nvme-pci: use blk_rq_dma_map() for NVMe SGL
> > 
> > Leon Romanovsky (14):
> >    mm/hmm: let users to tag specific PFNs
> >    dma-mapping: provide an interface to allocate IOVA
> >    dma-mapping: provide callbacks to link/unlink pages to specific IOVA
> >    iommu/dma: Provide an interface to allow preallocate IOVA
> >    iommu/dma: Prepare map/unmap page functions to receive IOVA
> >    iommu/dma: Implement link/unlink page callbacks
> >    RDMA/umem: Preallocate and cache IOVA for UMEM ODP
> >    RDMA/umem: Store ODP access mask information in PFN
> >    RDMA/core: Separate DMA mapping to caching IOVA and page linkage
> >    RDMA/umem: Prevent UMEM ODP creation with SWIOTLB
> >    vfio/mlx5: Explicitly use number of pages instead of allocated length
> >    vfio/mlx5: Rewrite create mkey flow to allow better code reuse
> >    vfio/mlx5: Explicitly store page list
> >    vfio/mlx5: Convert vfio to use DMA link API
> > 
> >   Documentation/core-api/dma-attributes.rst |   7 +
> >   block/blk-merge.c                         | 156 ++++++++++++++
> >   drivers/infiniband/core/umem_odp.c        | 219 +++++++------------
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h      |   1 +
> >   drivers/infiniband/hw/mlx5/odp.c          |  59 +++--
> >   drivers/iommu/dma-iommu.c                 | 129 ++++++++---
> >   drivers/nvme/host/pci.c                   | 220 +++++--------------
> >   drivers/vfio/pci/mlx5/cmd.c               | 252 ++++++++++++----------
> >   drivers/vfio/pci/mlx5/cmd.h               |  22 +-
> >   drivers/vfio/pci/mlx5/main.c              | 136 +++++-------
> >   include/linux/blk-mq.h                    |   9 +
> >   include/linux/dma-map-ops.h               |  13 ++
> >   include/linux/dma-mapping.h               |  39 ++++
> >   include/linux/hmm.h                       |   3 +
> >   include/rdma/ib_umem_odp.h                |  22 +-
> >   include/rdma/ib_verbs.h                   |  54 +++++
> >   kernel/dma/debug.h                        |   2 +
> >   kernel/dma/direct.h                       |   7 +-
> >   kernel/dma/mapping.c                      |  91 ++++++++
> >   mm/hmm.c                                  |  34 +--
> >   20 files changed, 870 insertions(+), 605 deletions(-)
> > 

