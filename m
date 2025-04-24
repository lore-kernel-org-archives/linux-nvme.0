Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAEBC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5g/riJXF/W/LjvW+uNmrD4nHxvKNcoliLJmax2mb0M=; b=eyBKM5/2PQTER9Hb3GESM0B4uP
	cLKynavCJ2pwydlGIXYj/eHT/AFUIxFEtuTW88rNmksFbCtpWH/beV3d7e6VeHFfCbVQuHpS2qj5X
	2NuFz5plEIyp/DOvRXe5AjewHILQZSXjUTyADCSbOGwXi9Jd/nfsGxvamtSfhGZW9DRbYChsj+DV2
	EjBPimiL+Y2ZzzMX2MRAM3nIBbFBCEJECPndae0dOM6BhAiwhmvWH3HmuvX1i4mQ7ColUvSkuQCdM
	pHNSzDqwaVeK7Z9jbtm5EIkU+fuf2o8gHhAic40bmCJp4xveY40ZSNN2VunucP2wtBQ/oyYjLvla4
	FvAdaahQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7vSA-0000000DzOd-2U94;
	Thu, 24 Apr 2025 12:13:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rQo-0000000DGB3-2L4D
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 07:55:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EC8915C62EB;
	Thu, 24 Apr 2025 07:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7605C4CEE3;
	Thu, 24 Apr 2025 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745481337;
	bh=eZB03wlWn20hlMjq44G4y2WHS0oF7M3JiBoS6ve+Nmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NosDI+x4cvbYgNU24M08GNHc6d7pJ4hl5/qxuZCxf+xwL2RBZRrJJUhOnFprAFHAp
	 uMXuNxDsAPF8h8GL3TMV0/p3zy00XpDJUj1Mc5rlsuJvcv+Nh4bTlPohNQGuUY4EuN
	 YdeQRGTfUzW8sL2ypAalBBGrL4iwWbiNeslamejqORQdHrhgX8L3E8sStLGQsqijej
	 pyQJVsd0fCj3iAMLYy/oXTlGqfTe/wKosof0Q4BTawzUGoCVJidUnxK+0FFEnz2fZ7
	 9cHCcUgloCY9p7vNTJA50fE41QpG2My1P6zfNwh4v++zjtZTJG0F4JLP9YIeCN29iU
	 73C7zFzzL2JzQ==
Date: Thu, 24 Apr 2025 10:55:32 +0300
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
Subject: Re: [PATCH v9 17/24] vfio/mlx5: Enable the DMA link API
Message-ID: <20250424075532.GO48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>
 <20250423180941.GS1213339@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423180941.GS1213339@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_005538_687007_C66E2ABF 
X-CRM114-Status: GOOD (  26.64  )
X-Mailman-Approved-At: Thu, 24 Apr 2025 04:18:00 -0700
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

On Wed, Apr 23, 2025 at 03:09:41PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 11:13:08AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Remove intermediate scatter-gather table completely and
> > enable new DMA link API.
> > 
> > Tested-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/vfio/pci/mlx5/cmd.c  | 298 ++++++++++++++++-------------------
> >  drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
> >  drivers/vfio/pci/mlx5/main.c |  31 ----
> >  3 files changed, 147 insertions(+), 203 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
> > +			      struct page **page_list, u32 *mkey_in,
> > +			      struct dma_iova_state *state,
> > +			      enum dma_data_direction dir)
> > +{
> > +	dma_addr_t addr;
> > +	size_t mapped = 0;
> > +	__be64 *mtt;
> > +	int i, err;
> >  
> > -	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
> > +	WARN_ON_ONCE(dir == DMA_NONE);
> > +
> > +	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
> > +
> > +	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
> > +		addr = state->addr;
> > +		for (i = 0; i < npages; i++) {
> > +			err = dma_iova_link(mdev->device, state,
> > +					    page_to_phys(page_list[i]), mapped,
> > +					    PAGE_SIZE, dir, 0);
> > +			if (err)
> > +				goto error;
> > +			*mtt++ = cpu_to_be64(addr);
> > +			addr += PAGE_SIZE;
> > +			mapped += PAGE_SIZE;
> > +		}
> 
> This is an area I'd like to see improvement on as a follow up.
> 
> Given we know we are allocating contiguous IOVA we should be able to
> request a certain alignment so we can know that it can be put into the
> mkey as single mtt. That would eliminate the double translation cost in
> the HW.
> 
> The RDMA mkey builder is able to do this from the scatterlist but the
> logic to do that was too complex to copy into vfio. This is close to
> being simple enough, just the alignment is the only problem.

I saw this improvement as well, but there is a need to generalize this 
"if (dma_iova_try_alloc) ... else ..." code first, as it will be used
by all vfio HW drivers.

So the plan is:
1. Merge the code as is.
2. Convert second vfio HW to the new API.
3. Propose something like dma_map_pages(..., struct page **page_list, ...)
   to map array of pages.
4. Optimize mlx5 vfio MTT creation.

Thanks

> 
> Jason
> 

