Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AEFD132A6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfUHL7XnScifBKXkauhDSwlfC4K+DOh7aGylcqNHAcI=; b=SohMREVw3XqKJqkPvc8zVf7mrF
	8l/QKHIDkv4F/ZCZfz5QhecNY0v9oHUi4D1t21B0NxsiUA6kI6zHfTZfVszee4htro9FMddliHgOD
	5VoP7vBPsREGIYYZEKHbGkdijQZxGl1ksxnbL4Von7J2PTxaojUGHAwKvJmz7iCmLgk3qfbUVLzrQ
	KS/dL6nnyPIaVtC4B8DFUFzyxJSERjiDGSBW0YEB7BqXwkKKMG/zmwKlsIDZKY+RulmfFg7eDwHlC
	irJ2lxvdXg0NOzv6uJuoHE4wuaT6n/3yAbzYdAvKKeikVPe66BBk5tRGvmdzfmMoCTdtr5+iHRrYB
	h/nUHvwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tzu-0000000DG77-1min;
	Mon, 04 Nov 2024 10:07:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7tr4-0000000DElA-33bg
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 09:58:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF664227AAD; Mon,  4 Nov 2024 10:58:31 +0100 (CET)
Date: Mon, 4 Nov 2024 10:58:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241104095831.GA28751@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_015839_088090_46BF7BAA 
X-CRM114-Status: GOOD (  36.46  )
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

On Thu, Oct 31, 2024 at 09:17:45PM +0000, Robin Murphy wrote:
> The hilarious amount of work that iommu_dma_map_sg() does is pretty much 
> entirely for the benefit of v4l2 and dma-buf importers who *depend* on 
> being able to linearise a scatterlist in DMA address space. TBH I doubt 
> there are many actual scatter-gather-capable devices with significant 
> enough limitations to meaningfully benefit from DMA segment combining these 
> days - I've often thought that by now it might be a good idea to turn that 
> behaviour off by default and add an attribute for callers to explicitly 
> request it.

Even when devices are not limited they often perform significantly better
when IOVA space is not completely fragmented.  While the dma_map_sg code
is a bit gross due to the fact that it has to deal with unaligned segments,
the coalescing itself often is a big win.

Note that dma_map_sg also has two other very useful features:  batching
of the iotlb flushing, and support for P2P, which to be efficient also
requires batching the lookups.

>> This uniqueness has been a long standing pain point as the scatterlist API
>> is mandatory, but expensive to use.
>
> Huh? When and where has anything ever called it mandatory? Nobody's getting 
> sent to DMA jail for open-coding:

You don't get sent to jail.  But you do not get batched iotlb sync, you
don't get properly working P2P, and you don't get IOVA coalescing.

>> Several approaches have been explored to expand the DMA API with additional
>> scatterlist-like structures (BIO, rlist), instead split up the DMA API
>> to allow callers to bring their own data structure.
>
> And this line of reasoning is still "2 + 2 = Thursday" - what is to say 
> those two notions in any way related? We literally already have one generic 
> DMA operation which doesn't operate on struct page, yet needed nothing 
> "split up" to be possible.

Yeah, I don't really get the struct page argument.  In fact if we look
at the nitty-gritty details of dma_map_page it doesn't really need a
page at all.  I've been looking at cleaning some of this up and providing
a dma_map_phys/paddr which would be quite handy in a few places.  Note
because we don't have a struct page for the memory, but because converting
to/from it all the time is not very efficient.

>>   2. VFIO PCI live migration code is building a very large "page list"
>>      for the device. Instead of allocating a scatter list entry per allocated
>>      page it can just allocate an array of 'struct page *', saving a large
>>      amount of memory.
>
> VFIO already assumes a coherent device with (realistically) an IOMMU which 
> it explicitly manages - why is it even pretending to need a generic DMA 
> API?

AFAIK that does isn't really vfio as we know it but the control device
for live migration.  But Leon or Jason might fill in more.

The point is that quite a few devices have these page list based APIs
(RDMA where mlx5 comes from, NVMe with PRPs, AHCI, GPUs).

>
>>   3. NVMe PCI demonstrates how a BIO can be converted to a HW scatter
>>      list without having to allocate then populate an intermediate SG table.
>
> As above, given that a bio_vec still deals in struct pages, that could 
> seemingly already be done by just mapping the pages, so how is it proving 
> any benefit of a fragile new interface?

Because we only need to preallocate the tiny constant sized dma_iova_state
as part of the request instead of an additional scatterlist that requires
sizeof(struct page *) + sizeof(dma_addr_t) + 3 * sizeof(unsigned int)
per segment, including a memory allocation per I/O for that.

> My big concern here is that a thin and vaguely-defined wrapper around the 
> IOMMU API is itself a step which smells strongly of "abuse and design 
> mistake", given that the basic notion of allocating DMA addresses in 
> advance clearly cannot generalise. Thus it really demands some considered 
> justification beyond "We must do something; This is something; Therefore we 
> must do this." to be convincing.

At least for the block code we have a nice little core wrapper that is
very easy to use, and provides a great reduction of memory use and
allocations.  The HMM use case I'll let others talk about.


