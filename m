Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD32C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:56:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4641A64DDF
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 18:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4641A64DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tnwxAEU+RStcPxoJoqTsUJSmt/mQfEZLl0xcD4E1IqE=; b=UstXsQHguX1mnWE3ldb/k3KqS
	k4KIDcTfdbJfbHCTaWaJkstNHhVDRtTDtPzMVJkhypXjzm8305pwyKv6ilCnA2mOZrbsL6+ND1hw2
	OnmAlAY7fA1Wbnfvj9qUi6zEy07AwtTnOem3Pzh91tfXHwWVdV7uZztt50bZp9XrfJH8hMKj4ptE3
	mZV+P52fwStKujOqoZGhcGbGuMOeMEX3kpJjThtjuBKbWJR7U2Tpg1Mhs1yqTQoP0pwi3tFavCtcj
	TSCVC3mc5WXKQl8cFeMBvkajXpk65NcIDACvmsMIc+qdw+K125ZJFmT70s9zLGowXOdwIAUgL3FXn
	9Bk4AKMmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6eMg-00045p-89; Mon, 01 Feb 2021 18:55:58 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6eMd-00044n-MB
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 18:55:56 +0000
IronPort-SDR: bIj1Wu+Nq8nLWfowz6wOB9CgGq+1JmlTZPFFeUiowUuBwmUP5Z5bRVnFMl/janEwMYihdhbXP8
 isaFwzRDq2Fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="177226885"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="177226885"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:55:48 -0800
IronPort-SDR: bO/77yFnFXEOvVyCwMRy9yRPe9Z8Uz08vIlmz+yDqMAbErP+xmmIjp8vozdpxGVV29C+RLOqEn
 iFkP5v0/f/hQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="405865932"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 10:55:44 -0800
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1l6eMO-001Czv-JO; Mon, 01 Feb 2021 20:55:40 +0200
Date: Mon, 1 Feb 2021 20:55:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jianxiong Gao <jxgao@google.com>
Subject: Re: [PATCH V2 3/3] Adding
 device_dma_parameters->offset_preserve_mask to NVMe driver.
Message-ID: <YBhOrK+kea7PNmXn@smile.fi.intel.com>
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201183017.3339130-4-jxgao@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_135555_875980_CE04A075 
X-CRM114-Status: GOOD (  16.41  )
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
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org,
 jroedel@suse.de, erdemaktas@google.com, dan.j.williams@intel.com,
 robin.murphy@arm.com, hch@lst.de, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> NVMe driver relies on the address offset to function properly.
> This patch adds the offset preserve mask to NVMe driver when mapping
> via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> depends on the page size defined by CC.MPS register of NVMe
> controller.

...

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

Seems like rebasing effect which makes empty line goes in the middle of some
other group of code lines.

>  	if (!nr_mapped)
>  		goto out_free_sg;

Perhaps it should be here?

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
