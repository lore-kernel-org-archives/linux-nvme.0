Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1845DF3382D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/F8cSafFme3iGHH5doOCwVfxZzVh5Q0phQHc/WjNSU=; b=c3P7tq/pAKAatdd2kKEgakXTmO
	jZCuJQOnrtM+rOHppDs+26YXf8Zank1FX98PUqMS0cyit9Fo2xR3K7TTqoND7CbYkK57FDNUjEjc5
	PZRvGu4LO+1MCo8f+oym1eUUXHIrzxyvprcBoToqLaS+Ag0MhcJr0nHnu7LNQ8R9znLO603/O2mJ6
	JQICsKxqFve9/Upt6Nh2xn5RPg/o2/ELGUdIeR5ZtnVD3JzFw4CrdpbOrKqE7DArP1N7Ztkgj1Sfp
	i2RVN8jPjxEMl4JRuyvtSggkEaYJxhZ+TE8xFDv67sVN72bOmvxUeF+mBXuF+d88EUAWyfqIf2RBX
	e6xtC3cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Qxv-00000005uki-2wnV;
	Tue, 17 Mar 2026 09:43:55 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Qxt-00000005ukJ-0ksE
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 09:43:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21CA71476;
	Tue, 17 Mar 2026 02:43:46 -0700 (PDT)
Received: from [10.57.60.199] (unknown [10.57.60.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EAB33F778;
	Tue, 17 Mar 2026 02:43:49 -0700 (PDT)
Message-ID: <d2e0fe45-31ae-4879-951e-7d0494d764e4@arm.com>
Date: Tue, 17 Mar 2026 09:43:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dma: return 0 from dma_opt_mapping_size() when no
 real hint exists
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me
Cc: martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
 john.g.garry@oracle.com, ahuang12@lenovo.com, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
 <20260316203956.64515-2-ionut.nechita@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260316203956.64515-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_024353_349150_CBF3A700 
X-CRM114-Status: GOOD (  26.01  )
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

On 2026-03-16 8:39 pm, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> dma_opt_mapping_size() currently initializes its local size to SIZE_MAX
> and, when neither an IOMMU nor a DMA ops opt_mapping_size callback is
> present, returns min(dma_max_mapping_size(dev), SIZE_MAX).  That value
> is a large but finite number that has nothing to do with an optimal
> transfer size — it is simply the maximum the DMA layer can map.

No, the current code is correct. dma_opt_mapping_size() represents the 
largest size that can be mapped without incurring any significant 
performance penalty (compared to smaller sizes). If the implementation 
has no such restriction, then the largest "efficient" size is quite 
obviously just the largest size in total.

> Callers such as scsi_transport_sas treat the return value as a genuine
> optimization hint and propagate it into Scsi_Host.opt_sectors, which in
> turn becomes the block device's optimal_io_size.  On SAS controllers
> like mpt3sas running with IOMMU in passthrough mode the bogus value
> (max_sectors << 9 = 16776704, rounded to 16773120) reaches mkfs.xfs,
> which computes swidth=4095 and sunit=2.  Because 4095 is not a multiple
> of 2, XFS rejects the geometry with "SB stripe unit sanity check
> failed", making it impossible to create filesystems during system
> bootstrap.

And that is obviously a bug. There has never been any guarantee offered 
about the values returned by either dma_max_mapping_size() or 
dma_opt_mapping_size() - they could be very large, very small, and 
certainly do not have to be powers of 2. Say an implementation has some 
internal data size optimisation that makes U32_MAX its largest 
"efficient" size, it's free to return that, and then you'll still have 
the same bug regardless of this bodge.

Fix the actual bug, don't break common code in an attempt to paper over 
it that doesn't even achieve that very well.

Thanks,
Robin.

> Fix this by returning 0 when no backend provides an optimal mapping size
> hint.  A return value of 0 unambiguously means "no preference" and lets
> callers that use min() or min_not_zero() do the right thing without
> special-casing.
> 
> The only other in-tree caller (nvme-pci) is adjusted in the next patch.
> 
> Fixes: a229cc14f339 ("dma-mapping: add dma_opt_mapping_size()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>   kernel/dma/mapping.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 78d8b4039c3e6..fffa6a3f191a3 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -984,14 +984,17 @@ EXPORT_SYMBOL_GPL(dma_max_mapping_size);
>   size_t dma_opt_mapping_size(struct device *dev)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
> -	size_t size = SIZE_MAX;
>   
>   	if (use_dma_iommu(dev))
> -		size = iommu_dma_opt_mapping_size();
> -	else if (ops && ops->opt_mapping_size)
> -		size = ops->opt_mapping_size();
> +		return iommu_dma_opt_mapping_size();
> +	if (ops && ops->opt_mapping_size)
> +		return ops->opt_mapping_size();
>   
> -	return min(dma_max_mapping_size(dev), size);
> +	/*
> +	 * No backend provided an optimal size hint. Return 0 so that
> +	 * callers can distinguish "no hint" from a real value.
> +	 */
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(dma_opt_mapping_size);
>   


