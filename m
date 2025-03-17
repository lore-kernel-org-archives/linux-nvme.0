Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665DDC28B30
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e6VvJGMoHaQ/7+tlz8AsQMqYqoDcq3BWKhvW6SNdsfA=; b=MPsIpwW64noHpCz9087f5wrH8N
	8GyduqpPRYOgwwdlb24M2SlVOsktZdvxe4nODKGJx5QhZ8tzwIIiDNN2S8a0v5TYE+yE/2kfPJOh9
	HNoEDbDIM1mtdGrmM2Sovp47qOyWYxdWv/DVWAdn3VyORWh+OuE2PVZwqT6AOV6QrmGjaAdN6vJG8
	Qn2kLE/xqj1pqqRBHCkNJH5iSTfIgSqT+jrcH3btDjakVhhIYCMBw9yPfLXnCl9Jj65bqgxAVQ9/H
	yDqcBYrD2DBx+eCKbI8ZgzV9F/Ev2Ise8+gLj7qMiw2MALup0P7Bgm2H6zhvBlbuCi95Mnu1IhizK
	15/bxu1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuB8f-00000002qzR-4BnY;
	Mon, 17 Mar 2025 14:08:22 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuAlp-00000002moF-0Bfc
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 13:44:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 494C0A429E5;
	Mon, 17 Mar 2025 13:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2E6C4CEE3;
	Mon, 17 Mar 2025 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742219083;
	bh=Nivyt0eviFTvQGhEOEf8ZZpxVSrnlmwhnY5tRfaE3Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILjGPW3OLQcmOrkMv5AH8aq1hrAnpRAPMTAQgLR7RHFsJF2bLoRw3BTOgmHBq56Li
	 RCNNwy/ccowtgdxyVVPCv0ACNvWo78Z/Cvu5jcsLgefi4PUDEch8eU1Oviz3EuYzg5
	 XUIEGSx2UA3cLHJWgIltL+b6l4V15ww+2bB6RDXFXhGG+65hftuhRbA0B/Wi3ffTrq
	 1vQsHc29chbUvptRWKtzZwyE1x1581v27MnBNJCKTXUw8791ZidkW0v3U8o4LXMJS3
	 W5yBnsLldEWaxyxVsmdLLyDaZrnHRHhHavJ+TGx31Iv9mQtnnuwHaY0Ofdxp9EFxBU
	 dA3ZPdJHhLs9A==
Date: Mon, 17 Mar 2025 15:44:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 03/17] iommu: generalize the batched sync after map
 interface
Message-ID: <20250317134439.GX1322339@unreal>
References: <cover.1738765879.git.leonro@nvidia.com>
 <ad8b0dc927ea21238457a47537d39cd746751f4b.1738765879.git.leonro@nvidia.com>
 <d83afae060351f49fe0ba661f69c1d0b00538a35.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d83afae060351f49fe0ba661f69c1d0b00538a35.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_064445_209951_5BDFAC5C 
X-CRM114-Status: GOOD (  23.92  )
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

On Mon, Mar 17, 2025 at 10:52:11AM +0100, Niklas Schnelle wrote:
> On Wed, 2025-02-05 at 16:40 +0200, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > For the upcoming IOVA-based DMA API we want to use the interface batch the
> > sync after mapping multiple entries from dma-iommu without having a
> > scatterlist.
> > 
> > For that move more sanity checks from the callers into __iommu_map and
> > make that function available outside of iommu.c as iommu_map_nosync.
> > 
> > Add a wrapper for the map_sync as iommu_sync_map so that callers don't
> > need to poke into the methods directly.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 65 +++++++++++++++++++------------------------
> >  include/linux/iommu.h |  4 +++
> >  2 files changed, 33 insertions(+), 36 deletions(-)
> > 
> > 
> --- snip ---
> > +
> >  	return mapped;
> >  
> >  out_err:
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 38c65e92ecd0..7ae9aa3a1894 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -857,6 +857,10 @@ extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> >  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
> >  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> >  		     phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> > +int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
> > +		phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> > +int iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
> > +		size_t size);
> 
> There are two different word orders in the function names.
> iommu_sync_map() vs iommu_map_nosync(). I'd prefer to be consistent
> with e.g. iommu_map_sync() vs iommu_map_nosync().

The naming came from refactoring different functions, one was simple *_map() and
another was iotlb_*_sync(), but yes we can name it consistently.

Thanks

> 
> >  extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> >  			  size_t size);
> >  extern size_t iommu_unmap_fast(struct iommu_domain *domain,
> 

