Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60646C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:27:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0143D64DED
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 17:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0143D64DED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FTg+h26gkthJYdXuMfVMPEDOnWcDcFEFt+KqOwUyJXw=; b=Y0M7R+c9hcaNi4uNUlgqoEzUw
	HlsOJVPXzu3NPMdYzE226tHHBmyVKteROB5ZcyBqR8bxP06wB9ZPHxkoEXX0UHlgvmED+6pOms6kw
	6nNc4H5+1mxtV4pPuYqeHpQnO1zHLOUKjdWERSm0UtL5UvRjDu2RUo23NN2da1pbwYTNvxRf+dGsR
	1szNzxqUHuyz22MFcyQCHy01sKuVdZVGRb1HaqHMsLgE3tznPEIzrgfGHs5k7s9HMFr9MBdPVMFcb
	zi+fgNGleUT9LhutJ6XjtR5IqHdIqsJrC5i7w2UqDrs/e4f51Vhwx8BMquCKiwW7MAE8/W4BkjuVb
	quVELwYaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5B50-0004GH-5J; Thu, 28 Jan 2021 17:27:38 +0000
Received: from foss.arm.com ([217.140.110.172])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5B4v-0004FK-Oi
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 17:27:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5065A13A1;
 Thu, 28 Jan 2021 09:27:29 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1EC3F7C3;
 Thu, 28 Jan 2021 09:27:26 -0800 (PST)
Subject: Re: [PATCH 1/3] Adding page_offset_mask to device_dma_parameters
To: Jianxiong Gao <jxgao@google.com>, erdemaktas@google.com,
 marcorr@google.com, hch@lst.de, m.szyprowski@samsung.com,
 gregkh@linuxfoundation.org, saravanak@google.com,
 heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
 andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
 bgolaszewski@baylibre.com, jroedel@suse.de,
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-2-jxgao@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2863b6d2-47f6-51fa-f60c-ba24904818e9@arm.com>
Date: Thu, 28 Jan 2021 17:27:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128003829.1892018-2-jxgao@google.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_122733_905621_AC21BC8C 
X-CRM114-Status: GOOD (  23.18  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-01-28 00:38, Jianxiong Gao wrote:
> Some devices rely on the address offset in a page to function
> correctly (NVMe driver as an example). These devices may use
> a different page size than the Linux kernel. The address offset
> has to be preserved upon mapping, and in order to do so, we
> need to record the page_offset_mask first.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>   include/linux/device.h      |  1 +
>   include/linux/dma-mapping.h | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1779f90eeb4c..f44e0659fc66 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -292,6 +292,7 @@ struct device_dma_parameters {
>   	 */
>   	unsigned int max_segment_size;
>   	unsigned long segment_boundary_mask;
> +	unsigned int page_offset_mask;

Could we call this something more like "min_align_mask" (sorry, I can't 
think of a name that's actually good and descriptive right now). 
Essentially I worry that having "page" in there is going to be too easy 
to misinterpret as having anything to do what "page" means almost 
everywhere else (even before you throw IOMMU pages into the mix).

Also note that of all the possible ways to pack two ints and a long, 
this one is the worst ;)

Robin.

>   };
>   
>   /**
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2e49996a8f39..5529a31fefba 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -500,6 +500,23 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>   	return -EIO;
>   }
>   
> +static inline unsigned int dma_get_page_offset_mask(struct device *dev)
> +{
> +	if (dev->dma_parms)
> +		return dev->dma_parms->page_offset_mask;
> +	return 0;
> +}
> +
> +static inline int dma_set_page_offset_mask(struct device *dev,
> +		unsigned int page_offset_mask)
> +{
> +	if (dev->dma_parms) {
> +		dev->dma_parms->page_offset_mask = page_offset_mask;
> +		return 0;
> +	}
> +	return -EIO;
> +}
> +
>   static inline int dma_get_cache_alignment(void)
>   {
>   #ifdef ARCH_DMA_MINALIGN
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
