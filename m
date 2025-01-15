Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23EFC02185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dsiBNa4jmcXpNJmEILcR7ols7kbwqQXgDLiyk9mvB1E=; b=tCCPgJqOK+ZCG9p7v6ZjrHwL2s
	RkUznQqaEiTdc9Xqo3n57kIQA0986Pi049K4TzRXJfErW/br5dO8chXUzX9lM5aLhiiV9vXRjgZyG
	z0ad9s0xGjeX6t1+UXCs/emQqUA/HJBsgAZ4ntBqTvsmb+W5e+T+fwo0odiGQCVZ3QdZtpzMhv0bu
	Zfuvl6nCSDMFWUOylO8dD+7TUqmOEugOcrGB/aenjsYRADWbQIWbK5H8ViIDaEeJm+AOCvNyj754S
	ewO/QYJfru0TF5gQAYyiSLPiosf6OxRSMhB56xEwUiDDIufxROKLcGfwPfXS+931dULo678/NDwBi
	KKTKpBHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwtP-0000000Amte-3dEu;
	Wed, 15 Jan 2025 06:28:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwen-0000000AlCZ-3VLM
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 06:13:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F412068B05; Wed, 15 Jan 2025 07:13:26 +0100 (CET)
Date: Wed, 15 Jan 2025 07:13:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
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
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 05/17] dma-mapping: Provide an interface to allow
 allocate IOVA
Message-ID: <20250115061326.GA29643@lst.de>
References: <cover.1734436840.git.leon@kernel.org> <fac6bc6fdcf8e13bd5668386d36289ee38a8a95b.1734436840.git.leon@kernel.org> <ecb59036-b279-4412-9a09-40e05af3b9ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb59036-b279-4412-9a09-40e05af3b9ea@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_221338_015563_A9D9DD16 
X-CRM114-Status: GOOD (  23.77  )
X-Mailman-Approved-At: Tue, 14 Jan 2025 22:28:41 -0800
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

On Tue, Jan 14, 2025 at 08:50:28PM +0000, Robin Murphy wrote:
>> +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
>> +		phys_addr_t phys, size_t size)
>> +{
>> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>> +	struct iova_domain *iovad = &cookie->iovad;
>> +	size_t iova_off = iova_offset(iovad, phys);
>> +	dma_addr_t addr;
>> +
>> +	memset(state, 0, sizeof(*state));
>> +	if (!use_dma_iommu(dev))
>> +		return false;
>
> Can you guess why that return won't ever be taken?

It is regularly taken.  Now that it's quoted this way it would probably
good to split the thing up to not do the deferferences above, as they
might cause problems if the compiler wasn't smart enough to only
perform them after the check..

>> +	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>> +	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
>> +		return false;
>> +
>> +	if (WARN_ON_ONCE(!size))
>> +		return false;
>> +	if (WARN_ON_ONCE(size & DMA_IOVA_USE_SWIOTLB))
>
> This looks weird. Why would a caller ever set an effectively-private flag 
> in the first place? If it's actually supposed to be a maximum size check, 
> please make it look like a maximum size check.

As the person who added it - this is to catch a user passing in a value
that would set it.  To me this looks obvious, but should we add a
comment?

> (Which also makes me consider iommu_dma_max_mapping_size() returning 
> SIZE_MAX isn't strictly accurate, ho hum...)

You can still map SIZE_MAX, just not using this interface.  Assuming
no other real life limitations get in way, which I bet they will.

>> @@ -72,6 +74,21 @@
>>     #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>>   +struct dma_iova_state {
>> +	dma_addr_t addr;
>> +	size_t __size;
>> +};
>> +
>> +/*
>> + * Use the high bit to mark if we used swiotlb for one or more ranges.
>> + */
>> +#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
>
> This will give surprising results for 32-bit size_t (in fact I guess it 
> might fire some build warnings already).

Good point.  I guess __size should simply become a u64.


