Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0387C54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ubmPeJg46t3K7leg5ZeQN7O0CINWlIT7YUSXrdtujmc=; b=WJK45HGLlVnx7EtTtqMgxz4lar
	2GRDjJvqvJRxruqCP8BtI9XlT/P1C+gsEdq++KBrtLawEB8VqVzTPxCWjzWrzvXMNuIy29f3e/dnr
	5ErCF4ZhWs7ELNSpVrhw9bh1Gm09eqyNqrTeMuav1XeVeCkCjOtyg2aCPxQsSh5Ab0m2QJqH2/DYS
	y73twxEsP20UBVXlGQjrLrCGO+cQaMyrQP5nRmhcsvsjtKuKk3SMzjNXSRDGD9QMTGR62jfBkNCRw
	FKTUMJS0pd+WX8l/xuJyxnt6O7RazHZzLLX0/lxgkV34Eq4zEAfXFSU70317FVOPOwRUd6oFWAOOw
	zTkYtSEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtnC-00000000uoz-0znh;
	Wed, 06 Mar 2024 16:06:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsVL-00000000dBU-2XmD
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 14:44:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6727E68C4E; Wed,  6 Mar 2024 15:44:17 +0100 (CET)
Date: Wed, 6 Mar 2024 15:44:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240306144416.GB19711@lst.de>
References: <cover.1709635535.git.leon@kernel.org> <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com> <20240305122935.GB36868@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305122935.GB36868@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_064423_967731_D4F4784D 
X-CRM114-Status: GOOD (  36.76  )
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:06:47 -0800
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

On Tue, Mar 05, 2024 at 02:29:35PM +0200, Leon Romanovsky wrote:
> > > These advanced DMA mapping APIs are needed to calculate IOVA size to
> > > allocate it as one chunk and some sort of offset calculations to know
> > > which part of IOVA to map.
> > 
> > I don't follow this part at all - at *some* point, something must know a
> > range of memory addresses involved in a DMA transfer, so that's where it
> > should map that range for DMA. 
> 
> In all presented cases in this series, the overall DMA size is known in
> advance. In RDMA case, it is known when user registers the memory, in
> VFIO, when live migration is happening and in NVMe, when BIO is created.
> 
> So once we allocated IOVA, we will need to link ranges, which si the
> same as map but without IOVA allocation.

But above you say:

"These advanced DMA mapping APIs are needed to calculate IOVA size to
allocate it as one chunk and some sort of offset calculations to know
which part of IOVA to map."

this suggests you need helpers to calculate the len and offset.  I
can't see where that would ever make sense.  The total transfer
size should just be passed in by the callers and be known, and
there should be no offset.

> > > Instead of teaching DMA to know these specific datatypes, let's separate
> > > existing DMA mapping routine to two steps and give an option to advanced
> > > callers (subsystems) perform all calculations internally in advance and
> > > map pages later when it is needed.
> > 
> > From a brief look, this is clearly an awkward reinvention of the IOMMU API.
> > If IOMMU-aware drivers/subsystems want to explicitly manage IOMMU address
> > spaces then they can and should use the IOMMU API. Perhaps there's room for
> > some quality-of-life additions to the IOMMU API to help with common usage
> > patterns, but the generic DMA mapping API is absolutely not the place for
> > it.
> 
> DMA mapping gives nice abstraction from IOMMU, and allows us to have
> same flow for IOMMU and non-IOMMU flows without duplicating code, while
> you suggest to teach almost every part in the kernel to know about IOMMU.

Except that the flows are fundamentally different for the "can coalesce"
vs "can't coalesce" case.  In the former we have one dma_addr_t range,
and in the latter as many as there are input vectors (this is ignoring
the weird iommu merging case where we we coalesce some but not all
segments, but I'd rather not have that in a new API).

So if we want to efficiently be able to handle these cases we need
two APIs in the driver and a good framework to switch between them.
Robins makes a point here that the iommu API handles the can coalesce
case and he has a point as that's exactly how the IOMMU API works.
I'd still prefer to wrap it with dma callers to handle things like
swiotlb and maybe Xen grant tables and to avoid the type confusion
between dma_addr_t and then untyped iova in the iommu layer, but
having this layer or not is probably worth a discussion.

> 
> In this series, we changed RDMA, VFIO and NVMe, and in all cases we
> removed more code than added. From what I saw, VDPA and virito-blk will
> benefit from proposed API too.
> 
> Even in this RFC, where Chaitanya did partial job and didn't convert
> whole driver, the gain is pretty obvious:
> https://lore.kernel.org/linux-rdma/016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org/T/#u
> 

I have no idea how that nvme patch is even supposed to work.  It removes
the PRP path in nvme-pci, which not only is the most common I/O path
but actually required for the admin queue as NVMe doesn't support
SGLs for the admin queue.


