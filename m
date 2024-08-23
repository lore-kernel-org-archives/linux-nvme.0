Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5BFC531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3LorF1iYiKFCkPDfnFvmc496X0vNcOlfaEpxRvaltc=; b=PK9tI3hcu2tUveVAvLxSLYa3nc
	e4l36Bln9F/IVNkMDNUQX2DLm6cnFja7p5caR2bybmLjLKGFAoFfk25ackYa2dfqDztRpbbbEUN4r
	pzFNxUVcbPl0+PRndBRynZnXOeL3cwp0+6iHsVI749jBXx51SujtAcn/PL3CvYTODpRtNi9U7Bd+y
	maZ8elOGwq++qp/QqLkWm4WE983pa0edME3CANsAaXKz8WIvLb0cG2UqSk2FtvkKgSkuY/H3+2M4o
	zTN8exm3fhEOE+cGZV3wog1mnXasSIl2sN86shjjsJONm6C7DD4z2PO0ckbaskoMGZAAPbiCs6NNL
	Tz93oppg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPST-0000000FpEe-2t47;
	Fri, 23 Aug 2024 08:15:45 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shPKN-0000000FlrR-0M0c
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 08:07:24 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 392571F0D4A;
	Fri, 23 Aug 2024 10:07:21 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1724400441; bh=R3LorF1iYiKFCkPDfnFvmc496X0vNcOlfaEpxRvaltc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p+kw04hKxmhjtBi2ko7YOgdYbWCkiGrsvAijGSBMpQ1X290wHvgyzdW2MhitT7rAJ
	 1a14TS7thrt+wKbcGG3ymn+VF3O1+rgFn9ZwI+VTma+0lOEMEfKt2ccAMzTsCzigdo
	 +ej5BcxxowUMS0jo/CwksRwFhAATkl0HBjOXBnEN5hIZLCRImn/6j8fF0enYrrWs2x
	 qNQPTj7SwamNsKF9ablze7tx6bhhMBmnAHeHPqWk2XLyCTa8DHaB19Wxbq/SialwPY
	 u8DI9jGkONAC4YHiLfdVVQK2jaU5Q8dUT+TQyKYgVCh1ctFRgCbave3CovTdxUaWCE
	 HVzpdFbdAtgNQ==
Date: Fri, 23 Aug 2024 10:07:20 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-coco@lists.linux.dev
Subject: Re: [RFC 3/7] dma: Add function for drivers to know if allowing
 blocking is useful
Message-ID: <20240823100720.679a520f@meshulam.tesarici.cz>
In-Reply-To: <20240822183718.1234-4-mhklinux@outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
	<20240822183718.1234-4-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_010723_346429_ED1BD397 
X-CRM114-Status: GOOD (  22.68  )
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

On Thu, 22 Aug 2024 11:37:14 -0700
mhkelley58@gmail.com wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> 
> With the addition of swiotlb throttling functionality, storage
> device drivers may want to know whether using the DMA_ATTR_MAY_BLOCK
> attribute is useful. In a CoCo VM or environment where swiotlb=force
> is used, the MAY_BLOCK attribute enables swiotlb throttling. But if
> throttling is not enable or useful, storage device drivers probably
> do not want to set BLK_MQ_F_BLOCKING at the blk-mq request queue level.
> 
> Add function dma_recommend_may_block() that indicates whether
> the underlying implementation of the DMA map calls would benefit
> from allowing blocking. If the kernel was built with
> CONFIG_SWIOTLB_THROTTLE, and swiotlb=force is set (on the kernel
> command line or due to being a CoCo VM), this function returns
> true. Otherwise it returns false.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

LGTM.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  include/linux/dma-mapping.h |  5 +++++
>  kernel/dma/direct.c         |  6 ++++++
>  kernel/dma/direct.h         |  1 +
>  kernel/dma/mapping.c        | 10 ++++++++++
>  4 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 7b78294813be..ec2edf068218 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -145,6 +145,7 @@ int dma_set_mask(struct device *dev, u64 mask);
>  int dma_set_coherent_mask(struct device *dev, u64 mask);
>  u64 dma_get_required_mask(struct device *dev);
>  bool dma_addressing_limited(struct device *dev);
> +bool dma_recommend_may_block(struct device *dev);
>  size_t dma_max_mapping_size(struct device *dev);
>  size_t dma_opt_mapping_size(struct device *dev);
>  unsigned long dma_get_merge_boundary(struct device *dev);
> @@ -252,6 +253,10 @@ static inline bool dma_addressing_limited(struct device *dev)
>  {
>  	return false;
>  }
> +static inline bool dma_recommend_may_block(struct device *dev)
> +{
> +	return false;
> +}
>  static inline size_t dma_max_mapping_size(struct device *dev)
>  {
>  	return 0;
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 80e03c0838d4..34d14e4ace64 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -649,6 +649,12 @@ bool dma_direct_all_ram_mapped(struct device *dev)
>  				      check_ram_in_range_map);
>  }
>  
> +bool dma_direct_recommend_may_block(struct device *dev)
> +{
> +	return IS_ENABLED(CONFIG_SWIOTLB_THROTTLE) &&
> +			is_swiotlb_force_bounce(dev);
> +}
> +
>  size_t dma_direct_max_mapping_size(struct device *dev)
>  {
>  	/* If SWIOTLB is active, use its maximum mapping size */
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index d2c0b7e632fc..63516a540276 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -21,6 +21,7 @@ bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
>  int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  		enum dma_data_direction dir, unsigned long attrs);
>  bool dma_direct_all_ram_mapped(struct device *dev);
> +bool dma_direct_recommend_may_block(struct device *dev);
>  size_t dma_direct_max_mapping_size(struct device *dev);
>  
>  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b1c18058d55f..832982bafd5a 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -858,6 +858,16 @@ bool dma_addressing_limited(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dma_addressing_limited);
>  
> +bool dma_recommend_may_block(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	if (dma_map_direct(dev, ops))
> +		return dma_direct_recommend_may_block(dev);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(dma_recommend_may_block);
> +
>  size_t dma_max_mapping_size(struct device *dev)
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);


