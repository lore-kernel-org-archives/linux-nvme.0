Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608C2C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 15:33:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E11D20756
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 15:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yibDPfBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E11D20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Mkv3OZQmka9dFvB/Jkf+3A+ZEqT7VndkaxxKXof99l0=; b=yibDPfBpC7NiYma+8wNP+0dNC
	l9jElLTaR5TrhyCf8HQ4rh+1JTzJGYCB+7dhpK/8M9VEHfW2wWe3B6SjYFUTNio4PtM+65y2F6cX3
	HV0zOeqmb29hxa8NmASP51Uzg6NfkF3EwTRuWkihh7JgX+hSJ5wbkTNbq8598tVdlmaxw2yKnSU0q
	u07+fALhrqUpI1ohL6t+SA4wc1iTh6Mzor8HSjseP8jJd7LBBPTvWBn0bOMaTOEJLRTJXJLuV4CqN
	WsXkdTIdcRO99n2S4j6xm7b8PPCNxdF06qFo2jai5RmM5dcImVZlPYVqTPnA91Qy2oZbK6vZiDw+8
	tIbgZlJTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHqU3-0002Hf-Kb; Mon, 14 Sep 2020 15:33:35 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHqTy-0002HA-Ja
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 15:33:31 +0000
IronPort-SDR: 4svBr5rYwc8kNININowZHwIs0NB369ZyyGEkfWZfFRKSOrgwffjkCJZ5RkNdjiaXaSmPEwlQDA
 bNtC8ZCcar2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="160028008"
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="160028008"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2020 08:33:27 -0700
IronPort-SDR: Y/xVtjLWPhhmkbP/s3w2vFt6oAg5qKVluTNKgCwGOL9/yZnhUHtxfIq5k1UGeJ9Yo5MlU0AnR4
 ltPf1jN6XQgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; d="scan'208";a="335318304"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 14 Sep 2020 08:33:25 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kHqTq-00GdDl-Jz; Mon, 14 Sep 2020 18:33:22 +0300
Date: Mon, 14 Sep 2020 18:33:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme-pci: Move enumeration by class to be last in the
 table
Message-ID: <20200914153322.GK3956970@smile.fi.intel.com>
References: <20200818083530.18983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818083530.18983-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_113330_863478_95B8E477 
X-CRM114-Status: GOOD (  23.28  )
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 11:35:30AM +0300, Andy Shevchenko wrote:
> It's unusual that we have enumeration by class in the middle of the table.
> It might potentially be problematic in the future if we add another entry
> after it.
> 
> So, move class matching entry to be the last in the ID table.

Is it good enough?

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> v2: appended tags and rebased on top of v5.9-rc1
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ba725ae47305..95ea671e5c9e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3185,7 +3185,6 @@ static const struct pci_device_id nvme_id_table[] = {
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> -	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
>  		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> @@ -3193,6 +3192,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
>  				NVME_QUIRK_128_BYTES_SQES |
>  				NVME_QUIRK_SHARED_TAGS },
> +
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, nvme_id_table);
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
