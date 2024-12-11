Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF0BE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NFm6TEc4bDsgccsGt1PrHoJ7kZc8ZvLb1gZZTByj/Vs=; b=BgtNPm4LKDPycupoEZcmbH6dMU
	wGtlQtQgpfig8Wm2rpkNX7uj8EvKrijKL38Jy81BJ7dCgSBmndBy3PvWlUASBLxOOnAkMzuI1RSAl
	fT3SAE0GaIVM7WpqRQvNyKwHYQwbJ4Mpz/5jFh0ahe6n5yVfutmyvD7oLRcO+d20uMLCY1IjibrQ9
	HXRQdFPPhff8ON8s4SMWCdvpxQsPiEGb9S0IuHSunLs3xhcC9UFe1NKrmEoHpWOPkp+P+0nqAt0SN
	6RcPbSgZyc+GCae/D7KutOFws+CHKoHx5G/Lt2WDenckS103aXF5cfH0uEc7nuGW+AxbYpuiWtUEW
	GPwyYQ2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLaVx-0000000GrRa-3GEo;
	Thu, 12 Dec 2024 04:09:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLV3y-0000000GIT1-1e3K
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 22:20:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 16B9E5C67B9;
	Wed, 11 Dec 2024 22:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4576FC4CED2;
	Wed, 11 Dec 2024 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733955609;
	bh=VLhIlSr54TL2QmDP8JRM72GWULbrO+1dbQF3pJw1ea8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBNirnu6kCr1d7gsDMgZrNuAXLYpD8uzILmzzbrNO1Mnk09f4n481Cndxfrau3+jJ
	 FpLkwRUeISCmz/SpemPgohhlQ3XgJzMdmIoVZ+IhBa91qhgYo51NaglvZU5BDtIZwB
	 //WGIgbYueq/MY8+Vmm6UVkGftTY+5cuZd/vROmxV6NP1K5rtWTWqMiA7gXfNGL2rJ
	 x8QxUc2OB1rxoUChWT6mPdO+zhCO+RaRL8TgtaiQ2BKywx4s0f0kj5Ngw6pkMs+dfE
	 zgxHiHxwQbMNfdTxhMs7Xm5RVvG80KHa9zyTwAQzCJbyWkRaNGRYrBbAH41l/rU6DO
	 Lf0Zf/ATio7bQ==
Date: Wed, 11 Dec 2024 22:20:00 +0000
From: Will Deacon <will@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 04/18] iommu: add kernel-doc for iommu_unmap and
 iommu_unmap_fast
Message-ID: <20241211222000.GH17486@willie-the-truck>
References: <cover.1733398913.git.leon@kernel.org>
 <da4827fda833e69dbe487ef404a9333c51d8ed2e.1733398913.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4827fda833e69dbe487ef404a9333c51d8ed2e.1733398913.git.leon@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_142010_509353_A81FC61A 
X-CRM114-Status: GOOD (  20.24  )
X-Mailman-Approved-At: Wed, 11 Dec 2024 20:09:24 -0800
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

On Thu, Dec 05, 2024 at 03:21:03PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap and iommu_unmap_fast to document
> existing limitation of underlying functions which can't split individual
> ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ec75d14497bf..9eb7c7d7aa70 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2590,6 +2590,24 @@ size_t iommu_unmap(struct iommu_domain *domain,
>  }
>  EXPORT_SYMBOL_GPL(iommu_unmap);
>  
> +/**
> + * iommu_unmap_fast() - Remove mappings from a range of IOVA without IOTLB sync
> + * @domain: Domain to manipulate
> + * @iova: IO virtual address to start
> + * @size: Length of the range starting from @iova
> + * @iotlb_gather: range information for a pending IOTLB flush
> + *
> + * iommu_unmap_fast() will remove a translation created by iommu_map(). It cannot
> + * subdivide a mapping created by iommu_map(), so it should be called with IOVA
> + * ranges that match what was passed to iommu_map(). The range can aggregate
> + * contiguous iommu_map() calls so long as no individual range is split.
> + *
> + * Basicly iommu_unmap_fast() as the same as iommu_unmap() but for callers

Typo: s/Basicly/Basically/
Typo: s/as the same/is the same/

> + * which manage IOTLB flush range externaly to perform batched sync.

Grammar: s/manage IOTLB flush range/manage the IOTLB flushing/
Typo: s/externaly/externally/
Grammar: s/to perform batched sync/to perform a batched sync/

With those:

Acked-by: Will Deacon <will@kernel.org>

Thank you for doing this!

Will

