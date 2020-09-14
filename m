Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA6AC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 19:37:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87FF207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGF8BRDK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUI9Sg8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87FF207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8oTht5uwi1RvBDKC/4AODCxHkRYdLli6fziwcvfxTRM=; b=eGF8BRDKxkhYN1ceHMyWHhxRj
	Cjy2XEq4MyVU6s9RQtAhfDGyVbm+00zUjXy1XkcbGoZvY5WYW5uBgw9Ds97RtGT4G+qeYBAmjssdd
	jZkDbwOJ971OJjDUy6nw3uvHAL4BdnFgWR4L9lDbt8vLwI0I3o2areyKxMhkAKX0YvOkPIX7O1m+f
	VYWSh5FyJb37/i3+NR0FmUI3pyG7G9FnxA9RfHO6ioeGs3ZlANGCi1OZPAu6BBKPlyKjQoGfnvvos
	0xCNsrlhHDjHMbsEgG/WuXmGUF5fdttGQIR3pw6SyeQdGJipynMDYpyfjPWmyPjHCdDU+mPwaEqQ1
	bha8zbHEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHuI8-00029L-Ig; Mon, 14 Sep 2020 19:37:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHuI5-00028R-FO
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 19:37:30 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3A5FF207EA;
 Mon, 14 Sep 2020 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600112248;
 bh=Jj72k/U5f+BOute4+JFcf+L+S+W5zojr1sfTLS9KWAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RUI9Sg8y3TPa+KDSWXmUnD/ZJDl0YDppdr2aQGa0KjF0Wt1pPIZt1UyrhJkH70WCu
 TfNvt2Wz968Ad6ZRSQRlygBq5iZ+XfUdoOVDVkXY3ffmTrE7SKdAeQ/zU1aM55zhkW
 HMnleg0IFkpq2+wye9G2sNqJR9R0KIsbWJQ9YWxE=
Date: Tue, 15 Sep 2020 04:37:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] nvme-pci: Move enumeration by class to be last in the
 table
Message-ID: <20200914193721.GB10507@redsun51.ssa.fujisawa.hgst.com>
References: <20200818083530.18983-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818083530.18983-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_153729_624145_07E342DC 
X-CRM114-Status: GOOD (  22.06  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>
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

Everything below it uses a different class code, so the separation by
class sort of makes sense. But I agree it looks error prone if anyone
wants to append to it, so the change is okay with me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
 
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

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
