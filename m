Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1320C369D7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZiauGp3t3Y5wyzlZDuhCItT1kNHTvnQlRo4eHOpOvFo=; b=49BEpAp1ZiIm0T91zuhqygtPp5
	OaEdnL8S36udokIkbiosIfnHJOSRoehmIlHU1LZL4JCzxRJL7L4BXVAzVGzzL4sbSP4LxoY3HHnqw
	5Tp2SsF4ciaRqoAAYOmY6VOBH6hfB1cdxp59kLGIyh3ppYyCLV/quwojEUfKxIXD4LbDQcjiWCltK
	kbZtNDIP5ebTr5dDXtlNIydaNsQIPgBFarqXYnvFg0Zt9Lp7JLe89KMfFRWmBVYBxmAG4L+/RqYaP
	cugRH2NLyBgEhgg7gGX806gzfY+3ZcrfOgXSTRWapFwf29cGFAGzvyFC2/cvYlx4TCMN8j3tjK4d2
	mD+T/l/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7rFT-0000000DE9N-3gpg;
	Thu, 24 Apr 2025 07:43:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7qUQ-0000000D3sS-20o8
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 06:55:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A4C85A41AA1;
	Thu, 24 Apr 2025 06:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A31C4CEE3;
	Thu, 24 Apr 2025 06:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745477717;
	bh=O2NhhAxby4h2wdAG9lotXu0r8Mq+CnbUeKJ51V9RGiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBMG74Uf2ayBsAyXOsGDu/Pky6ixNS1c4BDJHd4lwbNECLO5LrTPDLt1r0eNUPLy0
	 ynut6BgnWakwJKSAx+8FK+EGFCkITnvLnelLONPxIjuG0tdC90cdj3pniHXtHm9Fxa
	 wl45/ZTtb8BKv0iNv76Ij9tfHUWh6rTMYx7CAUO3rppkqiaLH7xleBCQXesauRPbp2
	 FUUzSE+hvgKs3WwAsv1qWr/zBPK1T2EbndRkbynGnImy0ZnvZycZXxoAzu4XEX+teR
	 a2VWk0rzolhjEPmNfygA5hJqIMt43/HcuEsUyDD2XFjdC06yV7sioUDVdESF6SAvcW
	 F+H5S2kqGr5vg==
Date: Thu, 24 Apr 2025 09:55:11 +0300
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
Subject: Re: [PATCH v9 03/24] iommu: generalize the batched sync after map
 interface
Message-ID: <20250424065511.GL48485@unreal>
References: <cover.1745394536.git.leon@kernel.org>
 <2ce6a74ddf5e13a7fdb731984aa781a15f17749d.1745394536.git.leon@kernel.org>
 <20250423171537.GJ1213339@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423171537.GJ1213339@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_235518_649138_3C061629 
X-CRM114-Status: GOOD (  22.31  )
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

On Wed, Apr 23, 2025 at 02:15:37PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 11:12:54AM +0300, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > For the upcoming IOVA-based DMA API we want to use the interface batch the
> > sync after mapping multiple entries from dma-iommu without having a
> > scatterlist.
> 
> Grammer:
> 
>  For the upcoming IOVA-based DMA API we want to batch the
>  ops->iotlb_sync_map() call after mapping multiple IOVAs from
>  dma-iommu without having a scatterlist. Improve the API.
> 
>  Add a wrapper for the map_sync as iommu_sync_map() so that callers don't
>  need to poke into the methods directly.
> 
>  Formalize __iommu_map() into iommu_map_nosync() which requires the
>  caller to call iommu_sync_map() after all maps are completed.
> 
>  Refactor the existing sanity checks from all the different layers
>  into iommu_map_nosync().
> 
> >  drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
> >  include/linux/iommu.h |  4 +++
> >  2 files changed, 33 insertions(+), 36 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +	/* Discourage passing strange GFP flags */
> > +	if (WARN_ON_ONCE(gfp & (__GFP_COMP | __GFP_DMA | __GFP_DMA32 |
> > +				__GFP_HIGHMEM)))
> > +		return -EINVAL;
> 
> There is some kind of overlap with the new iommu_alloc_pages_node()
> here that does a similar check, nothing that can be addressed in this
> series but maybe a TBD for later..

This series is based on pure -rc1 to allow creation of shared branch,
while you removed iommu_alloc_pages_node() in IOMMU tree. So we must
merge it first and tidy the code after that.

Thanks

> 
> Jason
> 

