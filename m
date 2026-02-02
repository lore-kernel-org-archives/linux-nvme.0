Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F9BE7DF13
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCWgZfDSxWXfqdaCXMFhz+OowfM9vkU3rP7dxQx7eUo=; b=OEsBo/6AKxDxC3dMgZBehEHzb3
	GGs9ZBDbsMKMLRlVHpA4ul515VweCfx3fLxkq1txDlqEViMRHnV+v3Rz+Ugkhfv9cKkW53pHdDBhH
	MLLGbSZgS3uTqjFpyaBLiOS/S64kTQWUPdG/X2LTyXs49je5hjUBhpSU79vfLt1akqk9I1r1g0QDY
	vQivqkBJJFYFSqoc3tXhr7jxgMMnvY068LJ/V2dunSx7OudwoZ9DPjaO1rO4XfOcA8WBlcutrnfbE
	+kMyH9kGshkRmUZDusKo7jqPHDDyyFGX51i6Gt9wZylHGYlFsz9X2GTq1baHoFtL1fEVkuWSK7w4p
	/hdQ1nIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxtT-00000005N9A-3RYF;
	Mon, 02 Feb 2026 17:39:23 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxtR-00000005N7I-1ZyF
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:39:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B45339;
	Mon,  2 Feb 2026 09:39:12 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E95413F740;
	Mon,  2 Feb 2026 09:39:16 -0800 (PST)
Message-ID: <5a3f03e8-89bc-4b46-b125-e08f8297647f@arm.com>
Date: Mon, 2 Feb 2026 17:39:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>, axboe@kernel.dk,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
 Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aYDbNC1z81D3lZ2r@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_093921_779889_A4E889B0 
X-CRM114-Status: GOOD (  20.25  )
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

On 2026-02-02 5:13 pm, Keith Busch wrote:
> On Mon, Feb 02, 2026 at 03:16:50PM +0000, Robin Murphy wrote:
>> On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
>>> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
>>>> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
>>>> when SWIOTLB bounce buffering becomes active during runtime.
>>>>
>>>> The issue occurs when SWIOTLB activation changes the device's DMA
>>>> mapping requirements at runtime,
>>>>
>>>> creating a mismatch between
>>>> iod->dma_vecs allocation and access logic.
>>>>
>>>> The problem manifests when:
>>>> 1. Device initially operates with dma_skip_sync=true
>>>>      (coherent DMA assumed)
>>>> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>>>>      memory encryption, or IOMMU bounce buffering requirements
>>>> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>>>>      dma_skip_sync=false
>>>> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>>>>      iod->dma_vecs
>>>
>>> I think this patch just papers over the bug.  If dma_need_unmap
>>> can't be trusted before the dma_map_* call, we've not saved
>>> the unmap information and the unmap won't work properly.
>>
>> The dma_need_unmap() kerneldoc says:
>>
>> "This function must be called after all mappings that might
>>   need to be unmapped have been performed."
>>
>> Trying to infer anything from it beforehand is definitely a bug in the
>> caller.
> 
> Well that doesn't really make sense. No matter how many mappings the
> driver has done, there will always be more. ?

But equally the fact that none of the mappings made so far happened to 
not need bouncing still doesn't mean that future ones won't. This is not 
guaranteed to be a static property of the device, but nor is it really a 
property of the *device* at all; it's a property of a set of one or more 
DMA mappings with the same lifetime, there's just no suitable generic 
notion of that temporal context in the DMA API to carry around and pass 
as an explicit argument, so it's left implicit in the usage model.

Whatever higher-level thing it's doing, the driver must have some 
context, so within "operation A" it makes some DMA mappings, checks 
dma_need_unmap() and sees it's false, so can conclude that "operation A" 
does not need to preserve DMA unmap state. However it may then start 
"operation B", do some more mappings, check dma_need_unmap() and see 
it's now returned true, so "operation B" *does* need to keep the DMA 
data and explicitly unmap it when it finishes.

This is essentially the point I made at the time about it not 
necessarily being as useful a thing as it seems, since if an "operation" 
involves multiple mappings, it must still store the full state of those 
mappings for at least long enough to finish them all and then call 
dma_need_unmap(), to only then see if it might be OK to throw that state 
away again.

Thanks,
Robin.

