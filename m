Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128ACC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 20:58:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE4B64E9E
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 20:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE4B64E9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a+oFV1Vt5azWKlX8g/VQsd776bkl4AYMJTUGv2Ptgj0=; b=1jGWYw9QY39LcrwJC1V8lNZCD
	9TnaoIm7s3NrOhQMzcoUN0ZpdS7YCUeB7E6jkeU3Euy7oCgH44cEHUvjTpOgZFshbYxseWEMtbD0C
	G+7rACN6k2metHpAkZ0jrhteWiR6K4bgwar3aXlHSDW+joLur8A6+o7cpaI/f/66Duiakcw1ScRGm
	Olce6P18FmQ0nWy4sp2GWkmQ+l/paGNqbdTPsWQ3QSaBnBCbIKEaKfmrtiHX3bGQJXyz/PQsbfD9z
	aigPobzD/7XLNHUr4p15WdA7kO1xQj/yeIrJd9MpbeCNGsFt1yaQnsgTIC3pXPZna3jv4RTjNQHic
	W5IRmWYAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6gGt-00012t-5g; Mon, 01 Feb 2021 20:58:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6gGq-000127-CE
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 20:58:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80C2564ECB;
 Mon,  1 Feb 2021 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612213083;
 bh=r/E49oyGnfm/yoB373RLEccYiXcRJsRAzM4O/KWNyro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MLNeG0uT1Jizxo/VSvEhaAFbENEPr3J3pVkEdTCXFnvp45+WXkRwuNYXZHiAbEQGL
 6r1vEHo72+yRV52MMdhEHETflCkFaA0zrY6YOtIl04a6LZyRIqgT+M6gFXjQhlqT0+
 iwxX1RGiP8hYyW8VCRNPNNSsxjw3AukWLTiVCLhELHR8drIrbmn0W4IznkIxMTD1Qv
 rVRNQqXpzLZJpU/B2IleHHNXcuUdZkteH6tzkEOMz21XK+6r1oGilNaArkXU7QYvFd
 8nX95YK7aByx+7b9Ch/nQO6Z17wJiZo6/g+UhrvQeL1WWPQQKtc362kVfMuZwVDoa2
 JqITgx85QiJfA==
Date: Mon, 1 Feb 2021 12:57:59 -0800
From: Keith Busch <kbusch@kernel.org>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-4-jxgao@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_155804_540410_B909A3FD 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me, saravanak@google.com,
 konrad.wilk@oracle.com, marcorr@google.com, gregkh@linuxfoundation.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de, erdemaktas@google.com,
 dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
 robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  	if (!iod->nents)
>  		goto out_free_sg;
>  
> +	offset_ret = dma_set_min_align_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_min_align_mask failed to set offset\n");
> +		goto out_free_sg;
> +	}
> +
>  	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>  		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>  				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>  	else
>  		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>  					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +
> +	offset_ret = dma_set_min_align_mask(dev->dev, 0);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
> +		goto out_free_sg;
> +	}
>  	if (!nr_mapped)
>  		goto out_free_sg;

Why is this setting being done and undone on each IO? Wouldn't it be
more efficient to set it once during device initialization?

And more importantly, this isn't thread safe: one CPU may be setting the
device's dma alignment mask to 0 while another CPU is expecting it to be
NVME_CTRL_PAGE_SIZE - 1.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
