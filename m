Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C417E7DEF4
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DynYSwYv31hiuMFliQAMMoCEqAS72b5Om3yA+iSC6YE=; b=j2Hm+1s+4ZDRGOOAFDdYq7O6KI
	Cj4Tm9D209khf0xw8sXDzz4Js+udm1KthKWUXtC4VkJ3qBsVSLd4F8ey8LDULeZZed+Wctenvowqz
	DriZHtpo6NG+8xrEgDfPI4F91SgED5XnKIXj3UL9rOkiq0ML83Pcghlq70rvk2NBjsACH1V0KZbG+
	x5I2/tH4ST/h82kNHLJvo2lQQnWZUxKhrtwn83ivCtBmoWmq0ZyhzhWjN7RofFzyy4HnxsUHtxla+
	VcJ7erhk3Kw1dOI7xD8USHre9Vjah1v5OzAvwXYoHg6n8qqwf6gckRAGT6y2LcULtUpz+fgRAOmjF
	CrA2ZSOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvfh-00000005AtX-1Khv;
	Mon, 02 Feb 2026 15:17:01 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvfd-00000005Asy-3eEg
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 15:16:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24DC339;
	Mon,  2 Feb 2026 07:16:48 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518813F740;
	Mon,  2 Feb 2026 07:16:53 -0800 (PST)
Message-ID: <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com>
Date: Mon, 2 Feb 2026 15:16:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Christoph Hellwig <hch@lst.de>,
 Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260202143548.GA19313@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_071658_015056_3BC04E6E 
X-CRM114-Status: GOOD (  17.18  )
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

On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
>> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
>> when SWIOTLB bounce buffering becomes active during runtime.
>>
>> The issue occurs when SWIOTLB activation changes the device's DMA
>> mapping requirements at runtime,
>>
>> creating a mismatch between
>> iod->dma_vecs allocation and access logic.
>>
>> The problem manifests when:
>> 1. Device initially operates with dma_skip_sync=true
>>     (coherent DMA assumed)
>> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>>     memory encryption, or IOMMU bounce buffering requirements
>> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>>     dma_skip_sync=false
>> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>>     iod->dma_vecs
> 
> I think this patch just papers over the bug.  If dma_need_unmap
> can't be trusted before the dma_map_* call, we've not saved
> the unmap information and the unmap won't work properly.

The dma_need_unmap() kerneldoc says:

"This function must be called after all mappings that might
  need to be unmapped have been performed."

Trying to infer anything from it beforehand is definitely a bug in the 
caller.

> So we'll need to extend the core code to tell if a mapping
> will set dma_skip_sync=false before doing the mapping.

I don't see that being possible - at best we could reasonably infer that 
a fully-coherent system with no sync ops, no SWIOTLB and no DMA_DEBUG 
shouldn't ever set it to true, but as for the other way round, by the 
time you've run through all the SWIOTLB logic to guess whether a 
particular mapping would be bounced or not, you've basically performed 
the mapping anyway. Thus at best, such an API to potentially do a whole 
dry-run mapping before every actual mapping would seem like a pretty 
pointless anti-optimisation.

Thanks,
Robin.

