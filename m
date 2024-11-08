Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2101BD64085
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8p7Q7CYdBjfz96jsaO/SDBo6pHY05EDQsb0/ueSpFTw=; b=sOhiTyfrSwmrJVep4JLpcOoKmb
	ne2glpA2QmvZ3S6vPitAnLlebbCi+g57SMb86iEv91kxMLSVa1Hvhb2FSv/24+536QXP0ey1Bvd1O
	SOQRkpu1d136eTVZQ76A5Cx/bWxWTQPofnWkIV6GrmWK2nFfhbDpbjp2ckvCYshTNFl38Euf/XIGf
	AX88/7VntQlJLZISdNiTZJ9lh3vDHTRniAlUjvMsMjlwSLLQ5ISw5sf1JIfVToiZVqA3PHLDKHIB9
	0UGJ/3LEpsQyKmNVUixmCloazq+IVv5zKhyJgstdAsYexS9JZilnPVquyT7NhNWeXra2l8GryUzYp
	Fh+Msw8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VE5-0000000Bp5b-1mly;
	Fri, 08 Nov 2024 20:05:01 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VDA-0000000BosM-1sFs
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 20:04:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 76429A44D13;
	Fri,  8 Nov 2024 20:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88D7C4CECD;
	Fri,  8 Nov 2024 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096242;
	bh=j8/ZMD+Bu1h+adtk4kPnyTobfWGqg8JYd1SKbmkjXD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMRxE4R5dWVG/OvIS2VimVBlKeyDxFEF2K9D6swzKr75NtaOQPu3u1HzWpTwu+lSo
	 85SYMuWjDivh9mgJoWRmt7qwMovoZY3cNUlErSjiFU7xfzhO3L0mkCgYRIYpsXvOde
	 6bLpgXaPXrxvzY26yN0MVKUAc8tmb6/1to+m2Nu5CHHjLY2bKaY0s9yo80iAgyhCBS
	 kpsv+ejCFSu6JJBaNiBYzlklGoRr29zyiIOS6p6yBFIJGxlp5B+VEhP9FbUdyO7D/F
	 /3dZB82/joZZJZEPux6XkULpk+j2C6IsM2ZaXvYGa+K33lGdnm6E5zYBcY73gUMPBa
	 AdQERFF7Kq6pg==
Date: Fri, 8 Nov 2024 22:03:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
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
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
Message-ID: <20241108200355.GC189042@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttchwmde.fsf@trenco.lwn.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_120404_636714_849F50A1 
X-CRM114-Status: GOOD (  24.09  )
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

On Fri, Nov 08, 2024 at 12:34:21PM -0700, Jonathan Corbet wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> 
> > From: Christoph Hellwig <hch@lst.de>
> >
> > Add an explanation of the newly added IOVA-based mapping API.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
> > index 8e3cce3d0a23..6095696a65a7 100644
> > --- a/Documentation/core-api/dma-api.rst
> > +++ b/Documentation/core-api/dma-api.rst
> > @@ -530,6 +530,76 @@ routines, e.g.:::
> >  		....
> >  	}
> >  
> > +Part Ie - IOVA-based DMA mappings
> > +---------------------------------
> > +
> > +These APIs allow a very efficient mapping when using an IOMMU.  They are an
> > +optional path that requires extra code and are only recommended for drivers
> > +where DMA mapping performance, or the space usage for storing the DMA addresses
> > +matter.  All the consideration from the previous section apply here as well.
> > +
> > +::
> > +
> > +    bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
> > +		phys_addr_t phys, size_t size);
> > +
> > +Is used to try to allocate IOVA space for mapping operation.  If it returns
> > +false this API can't be used for the given device and the normal streaming
> > +DMA mapping API should be used.  The ``struct dma_iova_state`` is allocated
> > +by the driver and must be kept around until unmap time.
> 
> So, I see that you have nice kernel-doc comments for these; why not just
> pull them in here with a kernel-doc directive rather than duplicating
> the information?

Can I you please point me to commit/lore link/documentation with example
of such directive and I will do it?

Thanks

> 
> Thanks,
> 
> jon

