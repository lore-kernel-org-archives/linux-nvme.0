Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5410C02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UEtqWmZnkkmJQ8Gt5KtEQ/SLZwf8ufb8M7nJ1GLm6xY=; b=EyFoiApT1skdSmL65WuQqtJ7ZW
	rOIWMuJy+j729i4zl+xIhxT7rz9suq98gzEHO/sE54k5JU7ErGTiFxlj4HTkysT8c6A4ujL/TOrWp
	mVoJ/54hwfZOeWO3M4qIMmTKU6tpX2wYgK59PegfUT/UfLnJLsQ33gutr5rsg6tpRRYplmge9ZHUQ
	UB0gB42hF6AuPBWumQE+Yu40MvtyIerVUedcKhef+Pk6YayJMqIZreUMG2ku+jgoFaUx0B6nu7XvD
	0XWXcyVysZc8il56s4wolhD1Eb1MzsoqQSWnbv4NcH9Z+wotalr5F/xHvXzrmzYYn3o37TnkQ8oq7
	L5LWCPgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXxoE-0000000AvvX-2Y97;
	Wed, 15 Jan 2025 07:27:26 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXxoB-0000000Avuc-3qu5
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 07:27:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 15F36A41729;
	Wed, 15 Jan 2025 07:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD41C4CEDF;
	Wed, 15 Jan 2025 07:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736926042;
	bh=W+JWGoU6jLFwbe+ZoYGQcxjcZ17AGd0C8/odV+o/TLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlEsLImCwnYqAoqms0P20DW62uLfIgjKyzptCpjG5UVIUXYCrzVmwk7m0oi/eJDWg
	 i7D1HOkxJZnKKnh0C+5xD+1X+uFQNGWJ1iZOiw1yU9Qcb7+5dh8ogtNN/k0QCZgCZJ
	 TyKE1gNFh1Eh9kiL7Z6WnV63cZKl9hwNUc02tBxWp3qPFnFGIDvADP4ssiUBQEzGog
	 BSgaFn4z3ohejNw+thnAgwWyLPajfW6rH21UYgVzsz5O38cma/CfLRJS2ZPPOsw53e
	 j7/TVSSizkDLGNS26gONx2q0vAi+LG3NkSnHwl81L1TUxhDeOkKbBvsH1CHdaPabMt
	 mR77nKXe/gODQ==
Date: Wed, 15 Jan 2025 09:27:18 +0200
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250115072718.GJ3146852@unreal>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
 <20250115062628.GA29782@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115062628.GA29782@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_232724_085164_ECB1F1D4 
X-CRM114-Status: GOOD (  26.60  )
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

On Wed, Jan 15, 2025 at 07:26:28AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 14, 2025 at 08:50:35PM +0000, Robin Murphy wrote:

<...>

> >> +	if (dev_use_swiotlb(dev, size, dir) && iova_offset(iovad, phys | size))
> >
> > Again, why are we supporting non-granule-aligned mappings in the middle of 
> > a range when the documentation explicitly says not to?
> 
> It's not trying to support that, but checking that this is guaranteed
> to be the last one is harder than handling it like this.  If you have
> a suggestion for better checks that would be very welcome.
> 
> >> +		if (!dev_is_dma_coherent(dev) &&
> >> +		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> >> +			arch_sync_dma_for_cpu(phys, len, dir);
> >
> > Hmm, how do attrs even work for a bulk unlink/destroy when the individual 
> > mappings could have been linked with different values?
> 
> They shouldn't.  Just like randomly mixing flags doesn't work for the
> existing APIs.
> 
> > (So no, irrespective of how conceptually horrid it is, clearly it's not 
> > even functionally viable to open-code abuse of DMA_ATTR_SKIP_CPU_SYNC in 
> > callers to attempt to work around P2P mappings...)
> 
> What do you mean with "work around"?  I guess Leon added it to the hmm
> code based on previous feedback, but I still don't think any of our P2P
> infrastructure works reliably with non-coherent devices as
> iommu_dma_map_sg gets this wrong.  So despite the earlier comments I
> suspect this should stick to the state of the art even if that is broken.

Right, I was asked to set DMA_ATTR_SKIP_CPU_SYNC for PCI_P2PDMA_MAP_THRU_HOST_BRIDGE case.
...
  752         case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
  753                 attrs |= DMA_ATTR_SKIP_CPU_SYNC;
  754                 pfns[idx] |= HMM_PFN_P2PDMA;
  755                 break;

At this stage, we didn't change DMA/IOMMU previous behaviour and if it
was broken for certain flows, it stays to be broken after this series
too.

Thanks

