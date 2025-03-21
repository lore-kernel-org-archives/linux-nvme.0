Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1626C36000
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtqChHAWb6GpwO6Y07a3c4UhP96hOZzby4c0ArdL7sU=; b=avLTJOEavn8vGe3EgFdEIDDqQ7
	dk1zNhno0TsFJP39Mo3guJmKwNxqtYFLh506Fh6PA6vVc218+VaiH81b9Z7w9NW5fx4MeuR4U7SMZ
	pPXAGevc/1kgrOcr0JYnzGWWRntm3vjbRq7LFYJ9crw6dxQM3gAvT37hXdWuWid14epgzGzRrm1HU
	mrcWq3tPXbjFPDYUiu+OP1OS5ameVDMrx6bgWJ0dSOlYCuCaX7JZ27k4oLVO9SnDfQtqBpKGJfQZL
	gyGkyWUxrodfWbmKwpKFrHIfQTMGwI+uuUrFpmo8Op+j5eaQ9gsLg3g2vgA/IvP+nQ1HgNfE2g9JH
	E42t9euQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvesI-0000000FPlL-00nQ;
	Fri, 21 Mar 2025 16:05:34 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvesF-0000000FPji-0S85
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 16:05:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAACF106F;
	Fri, 21 Mar 2025 09:05:34 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56D53F63F;
	Fri, 21 Mar 2025 09:05:23 -0700 (PDT)
Message-ID: <e024fe3d-bddf-4006-8535-656fd0a3fada@arm.com>
Date: Fri, 21 Mar 2025 16:05:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 Randy Dunlap <rdunlap@infradead.org>
References: <cover.1738765879.git.leonro@nvidia.com>
 <20250220124827.GR53094@unreal>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <20250302085717.GO53094@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250302085717.GO53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_090531_247039_99C61318 
X-CRM114-Status: GOOD (  44.82  )
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

On 02/03/2025 8:57 am, Leon Romanovsky wrote:
> On Fri, Feb 28, 2025 at 07:54:11PM +0000, Robin Murphy wrote:
>> On 20/02/2025 12:48 pm, Leon Romanovsky wrote:
>>> On Wed, Feb 05, 2025 at 04:40:20PM +0200, Leon Romanovsky wrote:
>>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>>
>>>> Changelog:
>>>> v7:
>>>>    * Rebased to v6.14-rc1
>>>
>>> <...>
>>>
>>>> Christoph Hellwig (6):
>>>>     PCI/P2PDMA: Refactor the p2pdma mapping helpers
>>>>     dma-mapping: move the PCI P2PDMA mapping helpers to pci-p2pdma.h
>>>>     iommu: generalize the batched sync after map interface
>>>>     iommu/dma: Factor out a iommu_dma_map_swiotlb helper
>>>>     dma-mapping: add a dma_need_unmap helper
>>>>     docs: core-api: document the IOVA-based API
>>>>
>>>> Leon Romanovsky (11):
>>>>     iommu: add kernel-doc for iommu_unmap and iommu_unmap_fast
>>>>     dma-mapping: Provide an interface to allow allocate IOVA
>>>>     dma-mapping: Implement link/unlink ranges API
>>>>     mm/hmm: let users to tag specific PFN with DMA mapped bit
>>>>     mm/hmm: provide generic DMA managing logic
>>>>     RDMA/umem: Store ODP access mask information in PFN
>>>>     RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page
>>>>       linkage
>>>>     RDMA/umem: Separate implicit ODP initialization from explicit ODP
>>>>     vfio/mlx5: Explicitly use number of pages instead of allocated length
>>>>     vfio/mlx5: Rewrite create mkey flow to allow better code reuse
>>>>     vfio/mlx5: Enable the DMA link API
>>>>
>>>>    Documentation/core-api/dma-api.rst   |  70 ++++
>>>    drivers/infiniband/core/umem_odp.c   | 250 +++++---------
>>>>    drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
>>>>    drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
>>>>    drivers/infiniband/hw/mlx5/umr.c     |  12 +-
>>>>    drivers/iommu/dma-iommu.c            | 468 +++++++++++++++++++++++----
>>>>    drivers/iommu/iommu.c                |  84 ++---
>>>>    drivers/pci/p2pdma.c                 |  38 +--
>>>>    drivers/vfio/pci/mlx5/cmd.c          | 375 +++++++++++----------
>>>>    drivers/vfio/pci/mlx5/cmd.h          |  35 +-
>>>>    drivers/vfio/pci/mlx5/main.c         |  87 +++--
>>>>    include/linux/dma-map-ops.h          |  54 ----
>>>>    include/linux/dma-mapping.h          |  85 +++++
>>>>    include/linux/hmm-dma.h              |  33 ++
>>>>    include/linux/hmm.h                  |  21 ++
>>>>    include/linux/iommu.h                |   4 +
>>>>    include/linux/pci-p2pdma.h           |  84 +++++
>>>>    include/rdma/ib_umem_odp.h           |  25 +-
>>>>    kernel/dma/direct.c                  |  44 +--
>>>>    kernel/dma/mapping.c                 |  18 ++
>>>>    mm/hmm.c                             | 264 +++++++++++++--
>>>>    21 files changed, 1435 insertions(+), 693 deletions(-)
>>>>    create mode 100644 include/linux/hmm-dma.h
>>>
>>> Kind reminder.
>>
>> ...that you've simply reposted the same thing again? Without doing anything
>> to address the bugs, inconsistencies, fundamental design flaws in claiming
>> to be something it cannot possibly be, the egregious abuse of
>> DMA_ATTR_SKIP_CPU_SYNC proudly highlighting how unfit-for-purpose the most
>> basic part of the whole idea is, nor *still* the complete lack of any
>> demonstrable justification of how callers who supposedly can't use the IOMMU
>> API actually benefit from adding all the complexity of using the IOMMU API
>> in a hat but also still the streaming DMA API as well?
> 
> Can you please provide concrete list of "the bugs, inconsistencies, fundamental
> design flaws", so we can address/fix them?
> 
> We are in v7 now and out of all postings you replied to v1 and v5 only with
> followups from three of us (Christoph, Jason and me).

Let's start with just the first 3 specific points from one patch in v1:

"If you really imagine this can support non-coherent operation and
DMA_ATTR_SKIP_CPU_SYNC, where are the corresponding explicit sync
operations? dma_sync_single_*() sure as heck aren't going to work..."

Still completely unaddressed in v7.

"In fact, same goes for SWIOTLB bouncing even in the coherent case."

Still completely unaddressed in v7.

"Plus if the aim is to pass P2P and whatever arbitrary physical 
addresses through here as well, how can we be sure this isn't going to 
explode?"

Still completely unaddressed in v7 for SWIOTLB; sort-of-addressed for 
cache coherency in v3 by egregious abuse of DMA_ATTR_SKIP_CPU_SYNC in 
callers, which when you pinged v5 I pointed out still cannot work in 
general for the way the API claims to be able to operate (even with a 
less-abusive dedicated attribute).

And I'm going to stop there because that's already more than enough to 
demonstrate that the whole thing is nowhere near what it claims to be.

>> Yeah, consider me reminded.
> 
> Silence means agreement.

No, silence means I already pointed out significant issues, and so until 
I see patches actually doing anything to attempt to address those issues 
I've got better things to do than repeat myself.

>> In case I need to make it any more explicit, NAK to this not-generic
>> not-DMA-mapping API, until you can come up with either something which *can*
>> actually work in any kind of vaguely generic manner as claimed, or instead
>> settle on a reasonable special-case solution for justifiable special cases.
>> Bikeshedding and rebasing through half a dozen versions, while ignoring
>> fundamental issues I've been pointing out from the very beginning, has not
>> somehow magically made this series mature and acceptable to merge.
> 
> You never responded to Christoph's answers, so please try your best and
> be professional, write down the list of things you want to see handled
> in next version and it will be done. It is impossible to guess what you
> want if you are not saying it clearly.

Do I really need to spell out that if these broken scenarios are not 
actually supposed to be supported, then there should not be dead code 
purporting to support them, and there should be input checks 
guaranteeing they can't happen.

However I have to say I'm not entirely convinced that mixing kernel 
memory and P2P won't happen, given the effort Logan went to to make sure 
it was supported in the scatterlist case...

> The main issue which we are trying to solve "abuse of SG lists for
> things without struct page", is not going to disappear by itself.

What everyone seems to have missed is that while it is technically true 
that the streaming DMA API doesn't need a literal struct page, it still 
very much depends on something which having a struct page makes it 
sufficiently safe to assume: that what it's being given is valid kernel 
memory that it can do things like phys_to_virt() or kmap_atomic() on. A 
completely generic DMA mapping API which could do the right thing for 
any old PFN on any system would be a very hard thing to achieve, and I 
suspect even harder to do efficiently. And pushing the complexity into 
every caller to encourage and normalise drivers calling virt_to_phys() 
all over (_so_ many bugs there...) and pass magic flags to influence 
internal behaviour of the API implementation clearly isn't scalable. 
Don't think I haven't seen the other thread where Christian had the same 
concern that this "sounds like an absolutely horrible design."

Yes, it's a hard problem. No, I can't give you the right answer. But 
that doesn't mean I have to accept a wrong answer either.

>>
>> Honestly, given certain other scenarios we may also end up having to deal
>> with, if by the time everything broken is taken away, it were to end up
>> stripped all the way back to something well-reasoned like:
>>
>> "Some drivers want more control of their DMA buffer layout than the
>> general-purpose IOVA allocator is able to provide though the DMA mapping
>> APIs, but also would rather not have to deal with managing an entire IOMMU
>> domain and address space, making MSIs work, etc. Expose
>> iommu_dma_alloc_iova() and some trivial IOMMU API wrappers to allow drivers
>> of coherent devices to claim regions of the default domain wherein they can
>> manage their own mappings directly."
>>
>> ...I wouldn't necessarily disagree.
> 
> Something like that was done in first RFC version, but the overall
> feeling was that it is layer violation with unclear path to support
> swiotlb for NVMe.

So what is it now, a layering violation in a hat with still no clear 
path to support SWIOTLB? What, are we going to suggest that non-IOMMU 
systems should reserve gigabytes of SWIOTLB space so that every DMA 
mapping can preallocate a DMA address (in PA space) and then be forcibly 
bounced? You do realise that the people who *really* care about DMA 
mapping performance above all else are putting the IOMMU in passthrough 
where iommu-dma is out of the picture, right?

Thanks,
Robin.

