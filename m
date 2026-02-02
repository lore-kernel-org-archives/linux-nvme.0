Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E7E7DEF2
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+uswOk2E7U/Lbv6W6L0DnyT/DCPePbZjx8c0KJmD0f8=; b=zOsn6C9BNc2MflepMnSlN271Ez
	jcuCEM/ttU9k/9/Bmh6qDsr1OxVxh51x23dASoa07JRd3pSCwZyCVsDbsuAk6gwD5Dm5elBjD8RRp
	0DVg4XMf/5mSB3V3lGhwl2naI3MNldWEgTWoBp3GLhAzGDqeDpdAcPEP4iwZKxCKHDjOiCf9RpyPl
	cIBVZPx43axdOmD0gBGNZX5f9GmOFxsAVQs8+K23sWcT2CpvoyHY77Y84jeoZsLUshVlb61ByYvl6
	XYvwk+sTSmbtannJDoRK8J8CA1nENJKwS2FkYk2w8jeAidMYycjwXCJxvilmpqtUm3x/2kjHJ37vT
	uyJbEugw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvow-00000005Bdi-00tZ;
	Mon, 02 Feb 2026 15:26:34 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvot-00000005BdB-2BqZ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 15:26:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597E8339;
	Mon,  2 Feb 2026 07:26:23 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE12F3F740;
	Mon,  2 Feb 2026 07:26:27 -0800 (PST)
Message-ID: <d82514f1-4c9b-490c-b4db-e259337cd16f@arm.com>
Date: Mon, 2 Feb 2026 15:26:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>, kbusch@kernel.org,
 axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
 <20260202143548.GA19313@lst.de> <20260202152252.GM34749@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260202152252.GM34749@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_072631_882171_4C8BC448 
X-CRM114-Status: GOOD (  21.12  )
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

On 2026-02-02 3:22 pm, Leon Romanovsky wrote:
> On Mon, Feb 02, 2026 at 03:35:48PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
>>> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
>>> when SWIOTLB bounce buffering becomes active during runtime.
>>>
>>> The issue occurs when SWIOTLB activation changes the device's DMA
>>> mapping requirements at runtime,
>>>
>>> creating a mismatch between
>>> iod->dma_vecs allocation and access logic.
>>>
>>> The problem manifests when:
>>> 1. Device initially operates with dma_skip_sync=true
>>>     (coherent DMA assumed)
>>> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>>>     memory encryption, or IOMMU bounce buffering requirements
>>> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>>>     dma_skip_sync=false
>>> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>>>     iod->dma_vecs
>>
>> I think this patch just papers over the bug.
> 
> Agree
> 
>> If dma_need_unmap can't be trusted before the dma_map_* call, we've not saved
>> the unmap information and the unmap won't work properly.
>>
>> So we'll need to extend the core code to tell if a mapping
>> will set dma_skip_sync=false before doing the mapping.
> 
> There are two paths that lead to SWIOTLB in dma_direct_map_phys().
> The first is is_swiotlb_force_bounce(dev), which dma_need_unmap() can
> easily evaluate. The second is more problematic, as it depends on
> dma_addr and size, neither of which is available in dma_need_unmap():
> 
>    102                 if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>    103                     dma_kmalloc_needs_bounce(dev, size, dir)) {
>    104                         if (is_swiotlb_active(dev))
> 
> What about the following change?
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 37163eb49f9f..1510b93a8791 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -461,6 +461,8 @@ bool dma_need_unmap(struct device *dev)
>   {
>          if (!dma_map_direct(dev, get_dma_ops(dev)))
>                  return true;
> +       if (is_swiotlb_force_bounce(dev) || is_swiotlb_active(dev))
> +               return true;

This will always be true if a default SWIOTLB buffer exists at all, and 
thus pretty much defeat the point of whatever optimisation the caller is 
trying to make.

Thanks,
Robin.

>          if (!dev->dma_skip_sync)
>                  return true;
>          return IS_ENABLED(CONFIG_DMA_API_DEBUG);
> 


