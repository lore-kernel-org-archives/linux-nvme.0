Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9010C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 10:34:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D818D64F3B
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 10:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D818D64F3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ghgaa1VpY8Rmf94EpPC7OXAbutYswmwCF9IVh5ULg/M=; b=UkhIUXN0JuHh0gIFNNOSLnkYD
	RX+PZMpO2uSphQF05+pS2pPH1gRzgYqPr6SxgGXp10XWs3ninFYDlw6iD2IKBuyWP9KhzqCwbq6jN
	XIr4A76zpYwnD632sGeRF/4pkP0UHbiZgylwOI7nJJNxc73OCTJmqXQDxhINvGfGja1O32bKqqw+Z
	0Cb0OtoVRtLWpxngtx7BGfVmS/XREh0dGz8NfieYBSjLItFeRY5hNq2GdpBQqEZ31gLsBCYhnei4K
	yA7nWl/YtbHn4LYP1M+JFWPXHytt/ZRIuvpBFtoLzL8kJVVx7SA7sVZ9F34AymOg13ebvj9N9Dfie
	OF0mQezYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7yRX-00017Z-NC; Fri, 05 Feb 2021 10:34:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7yRV-00016x-0B
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 10:34:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 53C6A68AFE; Fri,  5 Feb 2021 11:34:18 +0100 (CET)
Date: Fri, 5 Feb 2021 11:34:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 7/8] swiotlb: respect min_align_mask
Message-ID: <20210205103417.GA6694@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-8-hch@lst.de>
 <2e51481c-1591-034c-3476-1a1f8891506a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e51481c-1591-034c-3476-1a1f8891506a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_053425_206012_19C0878E 
X-CRM114-Status: GOOD (  20.85  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com,
 m.szyprowski@samsung.com, Christoph Hellwig <hch@lst.de>, jxgao@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 04, 2021 at 11:13:45PM +0000, Robin Murphy wrote:
>> + */
>> +static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
>> +{
>> +	unsigned min_align_mask = dma_get_min_align_mask(dev);
>> +
>> +	if (!min_align_mask)
>> +		return 0;
>
> I doubt that's beneficial - even if the compiler can convert it into a 
> csel, it'll then be doing unnecessary work to throw away a 
> cheaply-calculated 0 in favour of hard-coded 0 in the one case it matters 

True, I'll drop the checks.

> ;)
>
>> +	return addr & min_align_mask & ((1 << IO_TLB_SHIFT) - 1);
>
> (BTW, for readability throughout, "#define IO_TLB_SIZE (1 << IO_TLB_SHIFT)" 
> sure wouldn't go amiss...)

I actually had a patch doing just that, but as it is the only patch
touching swiotlb.h it caused endless rebuilds for me, so I dropped it
as it only had a few uses anyway.  But I've added it back.

>> -	if (alloc_size >= PAGE_SIZE)
>> +	if (min_align_mask)
>> +		stride = (min_align_mask + 1) >> IO_TLB_SHIFT;
>
> So this can't underflow because "min_align_mask" is actually just the 
> high-order bits representing the number of iotlb slots needed to meet the 
> requirement, right? (It took a good 5 minutes to realise this wasn't doing 
> what I initially thought it did...)

Yes.

> In that case, a) could the local var be called something like 
> iotlb_align_mask to clarify that it's *not* just a copy of the device's 
> min_align_mask,

Ok.

> and b) maybe just have an unconditional initialisation that 
> works either way:
>
> 	stride = (min_align_mask >> IO_TLB_SHIFT) + 1;

Sure.

> In fact with that, I think could just mask orig_addr with ~IO_TLB_SIZE in 
> the call to check_alignment() below, or shift everything down by 
> IO_TLB_SHIFT in check_alignment() itself, instead of mangling 
> min_align_mask at all (I'm assuming we do need to ignore the low-order bits 
> of orig_addr at this point).

Yes, we do need to ignore the low bits as they won't ever be set in
tlb_dma_addr.  Not sure the shift helps as we need to mask first.

I ended up killing check_alignment entirely, in favor of a new
slot_addr helper that calculates the address based off the base and index
and which can be used in a few other places as this one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
