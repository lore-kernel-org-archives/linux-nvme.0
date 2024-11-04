Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CB7D132B5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=38bY0Z9kxbshcWx0RtML+ki3pPEY5OxNydCiOSEC1Fg=; b=UvDDeqy6Avz89A5HKAO7L+FFEp
	hwIrDZ+KdgCikI6MYIAA6VsmN98YzQc+63Q6zvBuxX3MNl5UjXfWNUQR6hpheH3Xeod7c6lM/pHQi
	wRst9Kruu7GYPG9qohyXRCwK1c9K/TibXI2k4VqPQshYRFZhuCEGqMPvFBvOnrB62ruP/MFid2Qzh
	DEj+982dDKK173Ce1EXk9TBSlt4FOamHYRkfm5SBYSm7dIZCl4XC6+/0xGOskGtea1wpqzc79tboM
	BM6zGicFk4cxfZveMW8Ied48Dq0pZmiXmchCxC4zRrG58RlZ1kqd4lho2Sb2KSZKmU3UFHBio+o7C
	Z7o48XJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vYr-0000000Dahq-1foH;
	Mon, 04 Nov 2024 11:47:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vQd-0000000DZBN-1c97
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 11:39:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11CC95C490E;
	Mon,  4 Nov 2024 11:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E43EC4CECE;
	Mon,  4 Nov 2024 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720366;
	bh=NEDVbMitndD/iK6JWHs2o1S6pn7h57zEQ83wRjOGbwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCNZl80yEk5l8SaYaoCBd/ngvAnMVCC2ZjSDbwZfQ8mrGoQAQHq0KZ0YySad2w6iD
	 bhKUdk2VJPuLxk2n0zNkeYqVTjWimCe0KY+EoWT4fqvV1+YLhQUvABpjnzxQEgdqFM
	 2BpPxg0LwBCTYbhkxkUYZgp3KkOsOZRDo+BKC3lH3JeAsOEk2fzj8ARLQQ14RhFnrX
	 uXWBkNGPfoaMl6N4kDz6OiMk0Mf/BwrYcYvvPP+t71xWn1ZjQA3Q6lgcGNVObYG5Gq
	 GbS2qup3wwHfcN9yIP+AIN4pioJI5Luew6aYTY7gCJ1DnGQC9xzlf55e02PVxyG0ae
	 QwBznLzmgrROQ==
Date: Mon, 4 Nov 2024 13:39:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241104113920.GD99170@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <3567312e-5942-4037-93dc-587f25f0778c@arm.com>
 <20241104095831.GA28751@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104095831.GA28751@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_033927_541796_248DA2C1 
X-CRM114-Status: GOOD (  29.48  )
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

On Mon, Nov 04, 2024 at 10:58:31AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 31, 2024 at 09:17:45PM +0000, Robin Murphy wrote:

<...>

> >>   2. VFIO PCI live migration code is building a very large "page list"
> >>      for the device. Instead of allocating a scatter list entry per allocated
> >>      page it can just allocate an array of 'struct page *', saving a large
> >>      amount of memory.
> >
> > VFIO already assumes a coherent device with (realistically) an IOMMU which 
> > it explicitly manages - why is it even pretending to need a generic DMA 
> > API?
> 
> AFAIK that does isn't really vfio as we know it but the control device
> for live migration.  But Leon or Jason might fill in more.

Yes, you are right, as it is written above "VFIO PCI live migration ...".
That piece of code directly connected to the underlying real HW device
and uses DMA API to provide live migration functionality to/from that
device.

> 
> The point is that quite a few devices have these page list based APIs
> (RDMA where mlx5 comes from, NVMe with PRPs, AHCI, GPUs).
> 
> >
> >>   3. NVMe PCI demonstrates how a BIO can be converted to a HW scatter
> >>      list without having to allocate then populate an intermediate SG table.
> >
> > As above, given that a bio_vec still deals in struct pages, that could 
> > seemingly already be done by just mapping the pages, so how is it proving 
> > any benefit of a fragile new interface?
> 
> Because we only need to preallocate the tiny constant sized dma_iova_state
> as part of the request instead of an additional scatterlist that requires
> sizeof(struct page *) + sizeof(dma_addr_t) + 3 * sizeof(unsigned int)
> per segment, including a memory allocation per I/O for that.
> 
> > My big concern here is that a thin and vaguely-defined wrapper around the 
> > IOMMU API is itself a step which smells strongly of "abuse and design 
> > mistake", given that the basic notion of allocating DMA addresses in 
> > advance clearly cannot generalise. Thus it really demands some considered 
> > justification beyond "We must do something; This is something; Therefore we 
> > must do this." to be convincing.
> 
> At least for the block code we have a nice little core wrapper that is
> very easy to use, and provides a great reduction of memory use and
> allocations.  The HMM use case I'll let others talk about.

I'm not sure about which wrappers Robin talks, but if we are talking
about HMM wrappers, they gave us perfect combination of usability,
performance and maintenance. All HMM users use same pattern, same
structures and don't need to worry about internal DMA/IOMMU details.

Thanks

