Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F6C30653
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jul 2024 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y8AEY5lA+MZmzwGM36tvs1ckUOq60I0Ox48ZQlTQkKw=; b=pRy857+yjhHcjGF+HbrhR2KOw3
	0+sHp3ON+M55HebfBDDMJqyB2y2QKtXu0dh/xj1IIM8wMKcH+kIluchFEqrP2YQLVZh+zFDRSnBCB
	b1riMciHJN3aqM0c0BZ+WkW2wYNtlfQ90QfJHsn+8/JQ2Y+f8+5wGu0npTJ9/I86XDuhKcYm5PgpB
	gmjAcDxzcAw4iYsh+K41oN5Wz0Oi7xzS/6WiT37M/0hVTcer5vyjopHrTkOcT/ooPA81q9jPKoE2a
	F7inRYJ1cxH4UGTDombbgF1tXyrDl8i+A+setnhnmfdMII5GZUwKgzQ0J87KdD4vFZuH2K1nmqVzd
	X27F91gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQOSw-00000001be7-3LRe;
	Sun, 07 Jul 2024 09:45:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQOSu-00000001bdi-1Lnu
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jul 2024 09:45:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4060060304;
	Sun,  7 Jul 2024 09:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EC2C3277B;
	Sun,  7 Jul 2024 09:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720345551;
	bh=hNUGTH1mhz5l+9in2/mMOpiVJOQXuWh1yP0g+veKSK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahYHGAFDjGl7i/GWARbP/F9pDYyXX3XPYRGN0PWvpQdcU2oQHDkZ0wJcKKuvKfVJc
	 2hfX7AU3v42PzHu7U07l94/7jkm9EFmW+xrBKRB9eDQL/pCqX7ppg1lIWwvq0cAt12
	 ws9vXfMuNdLl8/xOvdEnMeKv6DQwPHTR15Yrh/qHFshtGrrKFVHE9kBTQbipArpx8K
	 wc/TrHCQ/V42wsh6YAjiO0iQcvH9jBnOC/2CaPidj7zVz1Q39pONyD0/HWnskSVPlF
	 rm6kA2bjmL1Nqo+OJR+bSkx51dK+h7UENltUEUKGo6rfQ6jQG8sKmmFbrh13JTZ9gV
	 WrZ4agy073JUw==
Date: Sun, 7 Jul 2024 12:45:46 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240707094546.GI6695@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705063910.GA12337@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_024552_470695_820350C5 
X-CRM114-Status: GOOD (  41.30  )
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

On Fri, Jul 05, 2024 at 08:39:10AM +0200, Christoph Hellwig wrote:
> Review from the NVMe driver consumer perspective.  I think if all these
> were implement we'd probably end up with less code than before the
> conversion.

Thanks for the review, I will try to address all the comments in the next version.

> 
> The split between dma_iova_attrs, dma_memory_type and dma_iova_state is
> odd.  I would have expected them to just be just a single object.  While
> talking about this I think the domain field in dma_iova_state should
> probably be a private pointer instead of being tied to the iommu.
> 
> Also do we need the attrs member in the iova_attrs structure?  The
> "attrs" really are flags passed to the mapping routines that are
> per-operation and not persistent, so I'd expect them to be passed
> per-call and not stored in a structure.

It is left-over from my not-send version where I added new attribute
to indicate that dma_alloc_iova() can't support SWIOTLB to avoid
dev_use_swiotlb() mess. I will remove it.

> 
> I'd also expect that the use_iova field to be in the mapping state
> and not separately provided by the driver.
> 
> For nvme specific data structures I would have expected a dma_add/
> len pair in struct iod_dma_map, maybe even using a common type.
> 
> Also the data structure split seems odd - I'd expect the actual
> mapping state and a small number (at least one) dma_addr/len pair
> to be inside the nvme_iod structure, and then only do the dynamic
> allocation if we need more of them because there are more segments
> and we are not using the iommu.
> 
> If we had a common data structure for the dma_addr/len pairs
> dma_unlink_range could just take care of the unmap for the non-iommu
> case as well, which would be neat.  I'd also expect that
> dma_free_iova would be covered by it.

Internally Jason asked for the same thing, but I didn't want to produce
asymmetric API where drivers have a call to dma_alloc_iova() but don't
have a call to dma_free_iova(). However, now, it is 2 versus 1, so I will
change it.

> 
> I would have expected dma_link_range to return the dma_addr_t instead
> of poking into the iova structure in the callers.
> 
> In __nvme_rq_dma_map the <= PAGE_SIZE case is pointless.  In the
> existing code the reason for it is to avoid allocating and mapping the
> sg_table, but that code is still left before we even get to this code.
> 
> My suggestion above to only allocate the dma_addr/len pairs when there
> is more than 1 or a few of it would allow to trivially implement that
> suggestion using the normal API without having to keep that special
> case and the dma_len parameter around.
> 
> If this addes a version of dma_map_page_atttrs that directly took
> the physical address as a prep patch the callers would not have to
> bother with page pointer manipulations and just work on physical
> addresses for both the iommu and no-iommu cases.  It would also help
> a little bit with the eventualy switch to store the physical address
> instead of page+offset in the bio_vec.  Talking about that, I've
> been wanting to add a bvec_phys helper for to convert the
> page_phys(bv.bv_page) + bv.bv_offset calculations.  This is becoming
> more urgent with more callers needing to that, I'll try to get it out
> to Jens ASAP so that it can make the 6.11 merge window.
> 
> Can we make dma_start_range / dma_end_range simple no-ops for the
> non-iommu code to avoid boilerplate code in the callers to avoid
> boilerplate code in the callers to deal with the two cases?

Yes, sure.

Thanks

