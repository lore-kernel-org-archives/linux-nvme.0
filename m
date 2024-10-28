Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63560D13595
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 06:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=64HvQqcLdLdKZFwtkgeyQYhtkebvmps8WRfA00nTT0k=; b=SVEcX519/ST4xgdKZBVzc1hc2P
	pm25pANoH9Tc+9/E3T+9DFXrF6PBJFLi2+6u/yiY/RWuo47p5MQSr4mylAWHALKcD42IVyU5es9A1
	eowd3+6RLA4n/bKY5LdyJZIOssKKgnrldXJgS2/xqHO6VELDbMPCtdNvyC1/k/LFNitTrpKHEktfP
	bKTvNHQgp+mx6z2c6dD3PTQb/+fJmb2GxtJ4lXR4UgxFYNghcsd6ZnJgJFacd8kfHN2wcNSBzBaXz
	Hl7+y4dkqkmo11EEpNUbG2dWOyup5Xv5C2sQVe2aj+Z5Izr3xoS7okek36RbHSvNvdtCDrnlbLRbn
	/A7FmgRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5J9a-00000009iKH-0zpV;
	Mon, 28 Oct 2024 06:23:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5J9W-00000009iJR-3lIx
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 06:23:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A04325C56B9;
	Mon, 28 Oct 2024 06:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E16C4CEC3;
	Mon, 28 Oct 2024 06:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730096577;
	bh=Jk5IbqRh4vCRoUbHWTgVvsfDpi3BO4pWidLR8NsFZ9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDs6atF8lGVkOSu8PR/Zeze3PGZeuSNAwBS1wCvfCB64zduIV8EVNQLYrGRITgsOX
	 m4HZ8igBY57cpFEdhFNUBm8dkFqVcwLIZJNyD3FxqvF/X6ketbJhvrbBPr+u6WZxZ3
	 w11mQnvuMXHiPD97WTOWcp1gf7Qn8YL4dM5TPF8cGuddYW1HkSqRGukSUz9O+9rzqF
	 KLngHHPHYjOu7rL222u8QMXoukG9r55bOcTa7Rw2qnhI04sopB/+K6VdPCEVj61xlv
	 ViLwDGbr7PuiCkXsEHb96dqrPmRCahF5OFg843XZ1f+zK0SivcsINr8cHzq8IxXcnI
	 li8XZp6ad0yXA==
Date: Mon, 28 Oct 2024 08:22:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
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
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/18] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241028062252.GC1615717@unreal>
References: <cover.1730037276.git.leon@kernel.org>
 <b434f2f6d3c601649c9b6973a2ec3ec2149bba37.1730037276.git.leon@kernel.org>
 <6a9366a5-7c5b-449c-b259-8e2492aae2a1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9366a5-7c5b-449c-b259-8e2492aae2a1@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_232259_046468_9961842F 
X-CRM114-Status: GOOD (  21.35  )
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

On Mon, Oct 28, 2024 at 10:00:25AM +0800, Baolu Lu wrote:
> On 2024/10/27 22:21, Leon Romanovsky wrote:
> > +/**
> > + * dma_iova_sync - Sync IOTLB
> > + * @dev: DMA device
> > + * @state: IOVA state
> > + * @offset: offset into the IOVA state to sync
> > + * @size: size of the buffer
> > + * @ret: return value from the last IOVA operation
> > + *
> > + * Sync IOTLB for the given IOVA state. This function should be called on
> > + * the IOVA-contigous range created by one ore more dma_iova_link() calls
> > + * to sync the IOTLB.
> > + */
> > +int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
> > +		size_t offset, size_t size, int ret)
> > +{
> > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > +	struct iova_domain *iovad = &cookie->iovad;
> > +	dma_addr_t addr = state->addr + offset;
> > +	size_t iova_start_pad = iova_offset(iovad, addr);
> > +
> > +	addr -= iova_start_pad;
> > +	size = iova_align(iovad, size + iova_start_pad);
> > +
> > +	if (!ret)
> > +		ret = iommu_sync_map(domain, addr, size);
> > +	if (ret)
> > +		iommu_unmap(domain, addr, size);
> 
> It appears strange that mapping is not done in this helper, but
> unmapping is added in the failure path. Perhaps I overlooked anything?

Like iommu_sync_map() is performed on whole continuous range, the iommu_unmap()
should be done on the same range. So, technically you can unmap only part of
the range which called to dma_iova_link() and failed, but you will need
to make sure that iommu_sync_map() is still called for "successful" part of
iommu_map().

In that case, you will need to undo everything anyway and it means that
you will call to iommu_unmap() on the successful part of the range
anyway.

dma_iova_sync() is single operation for the whole range and
iommu_unmap() too, so they are bound together.

> To my understanding, it should like below:
> 
> 	return iommu_sync_map(domain, addr, size);
> 
> In the drivers that make use of this interface should do something like
> below:
> 
> 	ret = dma_iova_sync(...);
> 	if (ret)
> 		dma_iova_destroy(...)

It is actually what is happening in the code, but in less direct way due
to unwinding of the code.

As an simple example, see VFIO patch https://lore.kernel.org/all/0a517ddff099c14fac1ceb0e75f2f50ed183d09c.1730037276.git.leon@kernel.org/
where failed in dma_iova_sync() will trigger call to unregister_dma_pages() and that will call to dma_iova_destroy().

> 
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dma_iova_sync);
> 
> Thanks,
> baolu
> 

