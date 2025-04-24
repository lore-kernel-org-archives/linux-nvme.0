Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E22BC369D1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 07:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ZAQxJmOsFsTTi0D+tSRQfOw+J2rVVKEfb31WKljAbA=; b=cXOqLAn3H68np7aa4kcKuA7rDy
	0Elu1Aql3QJfMmQf/ZeUhZpMCuJGeGoXc7ANfnq3026IraKhK3L6MszQGk9zXggTPB58v5oTgS8hH
	qo7F5YCJYs+Uh28mKLXyZ049qnD7C4xVllQ9t0d7oYTFkpPUaPrA8f7Cc+6DlowhkLtaDFoqKaOpt
	q6Nt8994/Vm/e4pmk2fVkQMuWv5QhNxQBdNEFjuSsOrXruECdBYADd2HT/NE9Nqd+nhy72eKwKcHY
	m12Clclqc3SagWadcyId7iQnaqepDWVQked43AR32/5Ob79CsgBqGX4uQZN4jiXlIsXg5nt/ckUOp
	+O4SpB5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rFU-0000000DE9V-24xB;
	Thu, 24 Apr 2025 07:43:56 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7qoJ-0000000D6uV-2xUp
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 07:15:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF48E44CBE;
	Thu, 24 Apr 2025 07:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E3C4CEE3;
	Thu, 24 Apr 2025 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745478951;
	bh=pTkF/OxNxP3a5nhNTZxPZtH9LiokbdzIPY4lcClh0Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBTgU71uDQ76gGQRWfJMAVuYX3A0QbPaLJvEVuFRBRrxPSIlRhqbBqclL9MgN42Mz
	 mOyKpbfujbO9d4jcdRZl8T1Go5m+UqQxIRaX0tVYAWP8gY0N23/sDzG80Ns8/xrjOx
	 yRFGVRmXxsj5fmUE6A3mSSt4ikS5jl7uqbR1Q9jdp7zW3uELJvckJZvlrjbWQLAFMI
	 rlKfp1i/mcS2aG+fPOR4bIoU7h9FpaLggeY2LHT/xOyqKlGS/6YJVHuNgwdRNVVRsH
	 wu0LFFiidEyDynwIeD0OFcSLI8I/quvZGtTqBj02iqPtvdHAUsLiUcS2TnnGA7c1LM
	 7VSAaFBMPFnUw==
Date: Thu, 24 Apr 2025 10:15:45 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 11/24] mm/hmm: provide generic DMA managing logic
Message-ID: <20250424071545.GM48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <3abc42885831f841dd5dfe78d7c4e56c620670ea.1745394536.git.leon@kernel.org>
 <20250423172856.GM1213339@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423172856.GM1213339@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_001551_789844_15B76851 
X-CRM114-Status: GOOD (  27.48  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 00:42:45 -0700
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

On Wed, Apr 23, 2025 at 02:28:56PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 11:13:02AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > HMM callers use PFN list to populate range while calling
> > to hmm_range_fault(), the conversion from PFN to DMA address
> > is done by the callers with help of another DMA list. However,
> > it is wasteful on any modern platform and by doing the right
> > logic, that DMA list can be avoided.
> > 
> > Provide generic logic to manage these lists and gave an interface
> > to map/unmap PFNs to DMA addresses, without requiring from the callers
> > to be an experts in DMA core API.
> > 
> > Tested-by: Jens Axboe <axboe@kernel.dk>
> 
> I don't think Jens tested the RDMA and hmm parts :)

I know, but he posted his Tested-by tag on cover letter and b4 picked it
for whole series. I decided to keep it as is.

> 
> > +	/*
> > +	 * The HMM API violates our normal DMA buffer ownership rules and can't
> > +	 * transfer buffer ownership.  The dma_addressing_limited() check is a
> > +	 * best approximation to ensure no swiotlb buffering happens.
> > +	 */
> 
> This is a bit unclear, HMM inherently can't do cache flushing or
> swiotlb bounce buffering because its entire purpose is to DMA directly
> and coherently to a mm_struct's page tables. There are no sensible
> points we could put the required flushing that wouldn't break the
> entire model.
> 
> FWIW I view that fact that we now fail back to userspace in these
> cases instead of quietly malfunction to be a big improvement.
> 
> > +bool hmm_dma_unmap_pfn(struct device *dev, struct hmm_dma_map *map, size_t idx)
> > +{
> > +	struct dma_iova_state *state = &map->state;
> > +	dma_addr_t *dma_addrs = map->dma_list;
> > +	unsigned long *pfns = map->pfn_list;
> > +	unsigned long attrs = 0;
> > +
> > +#define HMM_PFN_VALID_DMA (HMM_PFN_VALID | HMM_PFN_DMA_MAPPED)
> > +	if ((pfns[idx] & HMM_PFN_VALID_DMA) != HMM_PFN_VALID_DMA)
> > +		return false;
> > +#undef HMM_PFN_VALID_DMA
> 
> If a v10 comes I'd put this in a const function level variable:
> 
>           const unsigned int HMM_PFN_VALID_DMA = HMM_PFN_VALID | HMM_PFN_DMA_MAPPED;
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

I have no idea if v10 is needed. DMA API is stable for a long time and
only DMA part should go in shared branch. Everything else will need to
go through relevant subsystems anyway.

Thanks

> 
> Jason

