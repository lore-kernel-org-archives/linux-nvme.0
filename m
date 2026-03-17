Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA18FD8777
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=d51xCwusY4rYLhaYWrBzROjmOu12nCPzn3gqRmzmFyM=; b=FqWtvvKUUaeEaDU2zA1etxgzuz
	JkN1WYMA5UltX8+dzKznsg5U6XVXVLLSVl9JFmhnuhja6eLj+6F6hKfhpUh+FIVCmzzwpkg7ElznQ
	lI6gvUcjdkwZIPexvg4UQME8VAMh7Tnab3FHA9Zwww8vyAjHHLC4yUl0HESuanUku0zFVCP62euYj
	T6kWuYU+9/z5WFpd19EiLl0RQnRTZ3pEj4IB18rveRPq5E/gyGXDfMH9PidT68oMpH3GWOhtGDBMT
	ZZ8pHj8IQI4F2NIIH3QXdtYvfvQObVGf8ivAESpBt4NxXAWaP6vfTdiNslxmrLr1xheh8VsFCjQkH
	8FQ0EsSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VGn-00000006YcS-2o6u;
	Tue, 17 Mar 2026 14:19:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VGl-00000006Ybq-3qpC
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 14:19:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69E1968BEB; Tue, 17 Mar 2026 15:19:35 +0100 (CET)
Date: Tue, 17 Mar 2026 15:19:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, martin.petersen@oracle.com,
	damien.lemoal@opensource.wdc.com, john.g.garry@oracle.com,
	ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 1/2] dma: return 0 from dma_opt_mapping_size() when
 no real hint exists
Message-ID: <20260317141935.GB3539@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e0fe45-31ae-4879-951e-7d0494d764e4@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_071940_245037_0C3B664E 
X-CRM114-Status: GOOD (  31.84  )
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

On Tue, Mar 17, 2026 at 09:43:46AM +0000, Robin Murphy wrote:
> On 2026-03-16 8:39 pm, Ionut Nechita (Wind River) wrote:
>> From: Ionut Nechita <ionut.nechita@windriver.com>
>>
>> dma_opt_mapping_size() currently initializes its local size to SIZE_MAX
>> and, when neither an IOMMU nor a DMA ops opt_mapping_size callback is
>> present, returns min(dma_max_mapping_size(dev), SIZE_MAX).  That value
>> is a large but finite number that has nothing to do with an optimal
>> transfer size — it is simply the maximum the DMA layer can map.
>
> No, the current code is correct. dma_opt_mapping_size() represents the 
> largest size that can be mapped without incurring any significant 
> performance penalty (compared to smaller sizes). If the implementation has 
> no such restriction, then the largest "efficient" size is quite obviously 
> just the largest size in total.

Yes.

>> Callers such as scsi_transport_sas treat the return value as a genuine
>> optimization hint and propagate it into Scsi_Host.opt_sectors, which in
>> turn becomes the block device's optimal_io_size.  On SAS controllers
>> like mpt3sas running with IOMMU in passthrough mode the bogus value
>> (max_sectors << 9 = 16776704, rounded to 16773120) reaches mkfs.xfs,
>> which computes swidth=4095 and sunit=2.  Because 4095 is not a multiple
>> of 2, XFS rejects the geometry with "SB stripe unit sanity check
>> failed", making it impossible to create filesystems during system
>> bootstrap.
>
> And that is obviously a bug. There has never been any guarantee offered 
> about the values returned by either dma_max_mapping_size() or 
> dma_opt_mapping_size() - they could be very large, very small, and 
> certainly do not have to be powers of 2. Say an implementation has some 
> internal data size optimisation that makes U32_MAX its largest "efficient" 
> size, it's free to return that, and then you'll still have the same bug 
> regardless of this bodge.

Yes, the SCSI/SAS code needs to properly round the value.

But we might also need to split the values up a bit, as tools just
assign too much value to the I/O opt value.  I.e. the file system
geometry really should not be affected by the IOMMU details.
>
> Fix the actual bug, don't break common code in an attempt to paper over it 
> that doesn't even achieve that very well.
>
> Thanks,
> Robin.
>
>> Fix this by returning 0 when no backend provides an optimal mapping size
>> hint.  A return value of 0 unambiguously means "no preference" and lets
>> callers that use min() or min_not_zero() do the right thing without
>> special-casing.
>>
>> The only other in-tree caller (nvme-pci) is adjusted in the next patch.
>>
>> Fixes: a229cc14f339 ("dma-mapping: add dma_opt_mapping_size()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
>> ---
>>   kernel/dma/mapping.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index 78d8b4039c3e6..fffa6a3f191a3 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -984,14 +984,17 @@ EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>>   size_t dma_opt_mapping_size(struct device *dev)
>>   {
>>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>> -	size_t size = SIZE_MAX;
>>     	if (use_dma_iommu(dev))
>> -		size = iommu_dma_opt_mapping_size();
>> -	else if (ops && ops->opt_mapping_size)
>> -		size = ops->opt_mapping_size();
>> +		return iommu_dma_opt_mapping_size();
>> +	if (ops && ops->opt_mapping_size)
>> +		return ops->opt_mapping_size();
>>   -	return min(dma_max_mapping_size(dev), size);
>> +	/*
>> +	 * No backend provided an optimal size hint. Return 0 so that
>> +	 * callers can distinguish "no hint" from a real value.
>> +	 */
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
>>   
---end quoted text---

