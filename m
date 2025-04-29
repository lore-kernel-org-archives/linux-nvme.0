Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEC4C3ABAC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mkaMVF7EQuiZ/QiBjwDx/6oEIbz4vfvs86IlYe5Y4qs=; b=OJm3bnOZRtAOwovyobOMLPFTJj
	skLxz8MlhzUbTBWHv60gh2Io0cXR7dxAuKFh/0d1rRkoRn4qu8KuVUsKcV01GJqyOMwCidsWR5FlS
	kNIEIP702yALU6SzJWmHrRw5CrXYOm1kXHXC8ehjSKIB84S1bhOkvdszSTqmFg/Elf3tdBTQAS55v
	BOtmQ4fK5AjHO/aGZsL67ukim9XRN7OMbPPN8v/Lr+FH7l4+KZit4dlzNXkOMJxS043saG/aiZerV
	voEp3qdDHuaoJVEiIX2fyy1Ujg7feT36PXTd/J1HGilrvqeWKyD59+eWGpc+TnYQUE5W263+pxkRs
	vxWPut3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbi-0000000AWIo-2P1P;
	Tue, 29 Apr 2025 18:23:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9dua-00000008Rfz-0bUx
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 05:53:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5712F44FB4;
	Tue, 29 Apr 2025 05:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A3BC4CEE3;
	Tue, 29 Apr 2025 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745906023;
	bh=pjWT2YEBoo+aeNNdF/9OjGUMU99E00/qEdiP7XvrLnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnQWizAgROC7A8WUupkgx/RjNgOeZhcQXFHDDnOFmpAkDfulmJPJ3Ysno5xdYwaxf
	 34rmjPLe1vQWdYLvjawf4pTZa0H329xNF11gy9kInf5XYGloOwQ6Nhwg6LBxuy3nES
	 KXqpLcb5VXB1GXH03JwKI/YNp+C1ImMo97JAl1Kez1aO2YW1ovR1CZuGNH7JMEuOQ7
	 TR8B7CAv5HFPojVJP6F7jIDFFZst/yBljgdskoR27X0imt251RZVpEhOkBuV8L1dUJ
	 V7FHK2Owwv/FzLv2VB5DPC4mrBKKSM5BPaRsC+i3rNieRLL1uGuULFNX/S1RJ6aILC
	 1N3zXS+iMsY5A==
Date: Tue, 29 Apr 2025 08:53:39 +0300
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v10 06/24] iommu/dma: Factor out a iommu_dma_map_swiotlb
 helper
Message-ID: <20250429055339.GJ5848@unreal>
References: <cover.1745831017.git.leon@kernel.org>
 <f9a6a7874760a2919bea1f255bb3c81c6369ed1c.1745831017.git.leon@kernel.org>
 <8416e94f-171e-4956-b8fe-246ed12a2314@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8416e94f-171e-4956-b8fe-246ed12a2314@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_225344_233380_C115471D 
X-CRM114-Status: GOOD (  30.87  )
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

On Tue, Apr 29, 2025 at 12:58:18PM +0800, Baolu Lu wrote:
> On 4/28/25 17:22, Leon Romanovsky wrote:
> > From: Christoph Hellwig<hch@lst.de>
> > 
> > Split the iommu logic from iommu_dma_map_page into a separate helper.
> > This not only keeps the code neatly separated, but will also allow for
> > reuse in another caller.
> > 
> > Signed-off-by: Christoph Hellwig<hch@lst.de>
> > Tested-by: Jens Axboe<axboe@kernel.dk>
> > Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> > Signed-off-by: Leon Romanovsky<leonro@nvidia.com>
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> with a nit below ...
> 
> > ---
> >   drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++++++-----------------
> >   1 file changed, 41 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index d3211a8d755e..d7684024c439 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1138,6 +1138,43 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> >   			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
> >   }
> > +static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> > +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iova_domain *iovad = &domain->iova_cookie->iovad;
> > +
> > +	if (!is_swiotlb_active(dev)) {
> > +		dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
> > +		return (phys_addr_t)DMA_MAPPING_ERROR;
> > +	}
> > +
> > +	trace_swiotlb_bounced(dev, phys, size);
> > +
> > +	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
> > +			attrs);
> > +
> > +	/*
> > +	 * Untrusted devices should not see padding areas with random leftover
> > +	 * kernel data, so zero the pre- and post-padding.
> > +	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
> > +	 * the contents of the original memory buffer.
> > +	 */
> > +	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
> > +		size_t start, virt = (size_t)phys_to_virt(phys);
> > +
> > +		/* Pre-padding */
> > +		start = iova_align_down(iovad, virt);
> > +		memset((void *)start, 0, virt - start);
> > +
> > +		/* Post-padding */
> > +		start = virt + size;
> > +		memset((void *)start, 0, iova_align(iovad, start) - start);
> > +	}
> > +
> > +	return phys;
> > +}
> > +
> >   dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >   	      unsigned long offset, size_t size, enum dma_data_direction dir,
> >   	      unsigned long attrs)
> > @@ -1151,42 +1188,14 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >   	dma_addr_t iova, dma_mask = dma_get_mask(dev);
> >   	/*
> > -	 * If both the physical buffer start address and size are
> > -	 * page aligned, we don't need to use a bounce page.
> > +	 * If both the physical buffer start address and size are page aligned,
> > +	 * we don't need to use a bounce page.
> >   	 */
> >   	if (dev_use_swiotlb(dev, size, dir) &&
> >   	    iova_offset(iovad, phys | size)) {
> > -		if (!is_swiotlb_active(dev)) {
> 
> ... Is it better to move this check into the helper? Simply no-op if a
> bounce page is not needed:
> 
> 	if (!dev_use_swiotlb(dev, size, dir) ||
> 	    !iova_offset(iovad, phys | size))
> 		return phys;

Am I missing something? iommu_dma_map_page() has more code after this
check, so it is not correct to return immediately:

  1189 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
  1190               unsigned long offset, size_t size, enum dma_data_direction dir,
  1191               unsigned long attrs)
  1192 {

<...>

  1201         /*
  1202          * If both the physical buffer start address and size are page aligned,
  1203          * we don't need to use a bounce page.
  1204          */
  1205         if (dev_use_swiotlb(dev, size, dir) &&
  1206             iova_unaligned(iovad, phys, size)) {
  1207                 phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
  1208                 if (phys == (phys_addr_t)DMA_MAPPING_ERROR)
  1209                         return DMA_MAPPING_ERROR;
  1210         }
  1211
  1212         if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
  1213                 arch_sync_dma_for_device(phys, size, dir);
  1214
  1215         iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
  1216         if (iova == DMA_MAPPING_ERROR)
  1217                 swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
  1218         return iova;
  1219 }


> 
> Thanks,
> baolu
> 

