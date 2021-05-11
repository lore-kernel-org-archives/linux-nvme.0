Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E877C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:10:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C9161154
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C9161154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5RUOhwYy00tA7A4tqBN2lVlzmA62IrCiTSPb1euxnwM=; b=cDxQuWDmm8brBkhiOtd7NS8qO
	mUez2MpcHCIvtZOKUHb7EvPhMUH9MXn3PM5NGN0+1P6APNP6EM7MXY26isqhSJld8TqDW8ey+mwpp
	Nj3nMnb0TEo9xhI1qTxDIm1KGJnRbWUjct3iTtLSGDwYeEAW9Z9+rNCLjWKdK8FqrzP2DdX9pKDUR
	BlYhwf2jwiLXJcGY1yw91ryexkL5n2nVE/DkBLURteBNa+9egwbYEgZ5zc8NsE9IOT7P8tSvRNvsC
	90bNZH3ORQLQgLMFBnpQOwh/qKeuA5v03EJNV7V3UPd9iSs/rQkOjN/uYBFfhrBjdw3aogvtGiDeF
	WYpFwCYIw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgUxL-000gAS-1f; Tue, 11 May 2021 16:09:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUv1-000fgu-MH
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:07:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=AYzMm9vNy1mQ7xlxpQxo7ktyLZlBtsEnRv4GpKCQ6cM=; b=b5TM/n19jewAuupRCUD6ERsV3c
 W5KBEBVonZJSLI5hW4Vn4UDnf79656wbwGFQzhh17/xRguwwSlKMmI9QRrFt9/GH96Oy5pYMGbRA3
 xjQheFjgy3SlhsfQvuKTsiIr1vshke3uhxdoW6qSlGy2UnUtwczm7HnCX9jtU5UDEJNo2gH2nMJ/u
 IY0HsF9m9N3uGK5a903b97mdZ9lbmz/QfjN+3QOQWV41L7dH71n5xWj5HTueq4Uc/okGzsrUx6knA
 VMkl+BSlrapHpHSefoFqItJn9HjXCmC/YKb8Cy4toMJLICM30h1cpMdAt6lz9YueCm9qY42A47Mho
 ThsfGhBw==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgUux-009k09-LC
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:07:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYzMm9vNy1mQ7xlxpQxo7ktyLZlBtsEnRv4GpKCQ6cM=;
 b=LItdka86qSQN+uG9wQl2YE+TS7CofD2T5lwKtFge5RKc5F7PSoJZz9OOrHdO4EGYFS0EyN
 IEwgS35d05nVsMpdw3zojYm2Y9yh+xEZFoXkUAUxOwiRFr+3WdrRj8dsh7SiBvioWP+UES
 x+dKOCvFEHpJpHEmU+R02qNsC0r1lXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-mqNbg_zrPqi8D2Qovi2qcA-1; Tue, 11 May 2021 12:06:05 -0400
X-MC-Unique: mqNbg_zrPqi8D2Qovi2qcA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 006E2FC8E;
 Tue, 11 May 2021 16:06:01 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FBB95C232;
 Tue, 11 May 2021 16:05:56 +0000 (UTC)
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <a59daad2-31eb-b7b6-d68f-f42d717dbc2c@redhat.com>
Date: Tue, 11 May 2021 12:05:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_090731_898576_BFB7A861 
X-CRM114-Status: GOOD (  37.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
>
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
s/weather/whether/
> is safe.
>
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
>
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
>
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
John caught any other comment I had (and more).
-dd

> ---
>   include/linux/dma-mapping.h | 15 +++++++++++
>   kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2a984cb4d1e0..50b8f586cf59 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -60,6 +60,12 @@
>    * at least read-only at lesser-privileged levels).
>    */
>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
> +/*
> + * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
> + * dma_map_sg_p2pdma() instead. Used internally to indicate that the
> + * caller is using the dma_map_sg_p2pdma() interface.
> + */
> +#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
>   
>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> @@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs);
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs);
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs);
> @@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	return 0;
>   }
> +static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
> +		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	return 0;
> +}
>   static inline void dma_unmap_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)
> @@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
>   #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>   #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> +#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)
>   #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>   #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
>   #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..923089c4267b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   }
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
> -/*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> - */
> -int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	int ents;
> @@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> +
> +	return ents;
> +}
> +
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */
> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	BUG_ON(ents < 0);
>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
> @@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   }
>   EXPORT_SYMBOL(dma_map_sg_attrs);
>   
> +/*
> + * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
> + * on success). This function must be used if PCI P2PDMA pages might
> + * be in the scatterlist.
> + *
> + * On error this function may return:
> + *    -ENOMEM indicating that there was not enough resources available and
> + *      the transfer may be retried later
> + *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
> + *      be mapped by the specified device, retries will always fail
> + *
> + * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().
> + */
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir,
> +				  attrs | __DMA_ATTR_PCI_P2PDMA);
> +	if (!ents)
> +		ents = -ENOMEM;
> +
> +	if (ents > 0)
> +		debug_dma_map_sg(dev, sg, nents, ents, dir);
> +
> +	return ents;
> +}
> +EXPORT_SYMBOL_GPL(dma_map_sg_p2pdma_attrs);
> +
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
