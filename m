Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E324C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxmQw53Z0EJlqww5DRrq4bo00XaglkJeBnX3/YLuqYE=; b=LHeGWVLN+ICpdKf7wJnwQTG7aQ
	SCmvIwA5wY653TRSmCfnp6FoLwlF+auUnJ6Kitii+AeJXUHX3PFRx0kekQfMAAyc09z5eigRSEm8/
	zAo23jRbRTLFWnvFLwRNsTPxVYbGUBK822DfYC+tGdxakI8rX8+qIxMYoTnI71LtNG3IAzZgm/3ZT
	YlskkyxGN1cnOnDz2H18iKT+ZelW1Vuuu5Scrl60+9gMNdoTudCTk4OIHE0GoKIJDtQ7Rop35hnY7
	Krp1vGx36FMLisypU57aEWOy0yfqX7l2j5sAWB3tHDuunpwgStq+hmEKGSySyHW0QwNIeUJPGk+hO
	LdfG2dgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbl-0000000AWN2-1VO4;
	Tue, 29 Apr 2025 18:23:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9eAE-00000008UmQ-3LrC
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 06:09:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 77FC661166;
	Tue, 29 Apr 2025 06:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B524AC4CEE3;
	Tue, 29 Apr 2025 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745906963;
	bh=PNH//cVkWbnB2fS1ezNe4WtvGXzhnSIV29jcs1sTleU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDWNet5k2IklSXyclsdy71tc6aXagAuOzOP5Z1vsPDPEw1xByvYmxH/7R8kedffmR
	 K3ASHl60pRtDMWg9p0JxFzxO/3aGKB98mGU3GQziALdCRkObg3CMNM8boWhkMNq5Fb
	 SoRi+onUpbh4+8C7egZp68jWH9bVq8JE2GNbbjKqgOv4PvtvgZAdPdF4XvW8+i2Vac
	 6q6ESVLxxn8p2qJcdlZLSSecESrOtQeA31phlOs3O0ew9tbbYj38i+QlIYTLHGum0F
	 nK+XngMnFMQRY8/5XFAQ7Xguljv3BaQDuFiBtITTOynS0B/PtXC5n3GH/3WSmM3hcr
	 NiVEF7HYK25Ng==
Date: Tue, 29 Apr 2025 09:09:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <20250429060918.GK5848@unreal>
References: <cover.1745831017.git.leon@kernel.org>
 <69da19d2cc5df0be5112f0cf2365a0337b00d873.1745831017.git.leon@kernel.org>
 <f8d86cde-d485-4e5a-a693-e9323679474f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d86cde-d485-4e5a-a693-e9323679474f@linux.intel.com>
X-Mailman-Approved-At: Tue, 29 Apr 2025 11:22:51 -0700
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

On Tue, Apr 29, 2025 at 10:19:46AM +0800, Baolu Lu wrote:
> On 4/28/25 17:22, Leon Romanovsky wrote:
> > From: Christoph Hellwig<hch@lst.de>
> > 
> > For the upcoming IOVA-based DMA API we want to batch the
> > ops->iotlb_sync_map() call after mapping multiple IOVAs from
> > dma-iommu without having a scatterlist. Improve the API.
> > 
> > Add a wrapper for the map_sync as iommu_sync_map() so that callers
> > don't need to poke into the methods directly.
> > 
> > Formalize __iommu_map() into iommu_map_nosync() which requires the
> > caller to call iommu_sync_map() after all maps are completed.
> > 
> > Refactor the existing sanity checks from all the different layers
> > into iommu_map_nosync().
> > 
> > Signed-off-by: Christoph Hellwig<hch@lst.de>
> > Acked-by: Will Deacon<will@kernel.org>
> > Tested-by: Jens Axboe<axboe@kernel.dk>
> > Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> > Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> > Signed-off-by: Leon Romanovsky<leonro@nvidia.com>
> > ---
> >   drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
> >   include/linux/iommu.h |  4 +++
> >   2 files changed, 33 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 4f91a740c15f..02960585b8d4 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2443,8 +2443,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
> >   	return pgsize;
> >   }
> > -static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
> > -		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> > +int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> > +		phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> >   {
> >   	const struct iommu_domain_ops *ops = domain->ops;
> >   	unsigned long orig_iova = iova;
> > @@ -2453,12 +2453,19 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
> >   	phys_addr_t orig_paddr = paddr;
> >   	int ret = 0;
> > +	might_sleep_if(gfpflags_allow_blocking(gfp));
> > +
> >   	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
> >   		return -EINVAL;
> >   	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> >   		return -ENODEV;
> > +	/* Discourage passing strange GFP flags */
> > +	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> > +				__GFP_HIGHMEM)))
> > +		return -EINVAL;
> > +
> >   	/* find out the minimum page size supported */
> >   	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
> > @@ -2506,31 +2513,27 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
> >   	return ret;
> >   }
> > -int iommu_map(struct iommu_domain *domain, unsigned long iova,
> > -	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> > +int iommu_sync_map(struct iommu_domain *domain, unsigned long iova, size_t size)
> >   {
> >   	const struct iommu_domain_ops *ops = domain->ops;
> > -	int ret;
> > -
> > -	might_sleep_if(gfpflags_allow_blocking(gfp));
> > -	/* Discourage passing strange GFP flags */
> > -	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> > -				__GFP_HIGHMEM)))
> > -		return -EINVAL;
> > +	if (!ops->iotlb_sync_map)
> > +		return 0;
> > +	return ops->iotlb_sync_map(domain, iova, size);
> > +}
> 
> I am wondering whether iommu_sync_map() needs a return value. The
> purpose of this callback is just to sync the TLB cache after new
> mappings are created, which should effectively be a no-fail operation.
> 
> The definition of iotlb_sync_map in struct iommu_domain_ops seems
> unnecessary:
> 
> struct iommu_domain_ops {
> ...
>         int (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long
> iova,
>                               size_t size);
> ...
> };
> 
> Furthermore, currently no iommu driver implements this callback in a way
> that returns a failure. We could clean up the iommu definition in a
> subsequent patch series, but for this driver-facing interface, it's
> better to get it right from the beginning.

I see that s390 is relying on return values:

  569 static int s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
  570                                      unsigned long iova, size_t size)
  571 {

<...>

  581                 ret = zpci_refresh_trans((u64)zdev->fh << 32,
  582                                          iova, size);
  583                 /*
  584                  * let the hypervisor discover invalidated entries
  585                  * allowing it to free IOVAs and unpin pages
  586                  */
  587                 if (ret == -ENOMEM) {
  588                         ret = zpci_refresh_all(zdev);
  589                         if (ret)
  590                                 break;
  591                 }

<...>

  595         return ret;
  596 }

> 
> Thanks,
> baolu

