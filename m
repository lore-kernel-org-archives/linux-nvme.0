Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E5C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 21:58:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4665464EAE
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 21:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4665464EAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L6ZSZX+UEEVx0o7+0JY1+j/yaOaxU9qQ5WG3/CejvXs=; b=ZbdicA3LA+4i+tqQiw0ZvmBVT
	d7eOz6TEgS0/koGJv+TMOWbVM8Ilaci6Ci0aSoKypF6MfuUDNhX8fYbqv+T/2HPjP1+MCWJOV8H+r
	7Uv8CnE0RGtEdOdyVxT3T6AHSImO+/ikAGVHbOo3bsFXeE1CVCvNHYbEtvvagPDqscskrDB2yUe6z
	vM1h62iKTN5koH9s8tQVdB3+IYT21A+6PPyxXspPbmkcVQ/nxafKaI66Un+wlTu1Xb9YCpP+wYR/1
	BKYB5sQzUJhSwsfZ+xrb8cBWzxIdGJ7Dk0KaUSCw92AWxkW7O0AwouybdzQxexqgb8FBlNhEMPaP7
	7mtXZPjZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCrJL-0001CT-P6; Thu, 18 Feb 2021 21:58:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCrJH-0001Bh-Vb
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 21:58:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE7D564E38;
 Thu, 18 Feb 2021 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613685485;
 bh=etHdI7IiYWwbg0BOfOVNSpO5cUrRbQ9clTTcNdh3+3c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tykY4CLj3rypu027HwpFumTnTikjcbtNSXhFpXma1kjY3tgyqfr9aEAN4TBnyny4w
 OHTOYoyBaZFI4ZYMQvrF8ohduZ62FTsT4nZS6dLRFVBZjiee+f6JWEVFZ2sw5PryVO
 Zu8rkZBM7SfVht5lgU58haMKzuxR2CqsM78lZGhmSZfvR54vlWTFVeBp4G6hdN6wiF
 7szEO2II/iQchToQyoyO9HYCRzijwAHmfY4yTYlanC87G2GNH9JlGym/8YnwKTmF9U
 HowfQ1kiRUCN8svrcLnNttgXxdnyvHnZMms3VMyqXdGWyQhB+a+o1S7gJHcQRGIEab
 TD27JGUtPsjKw==
Date: Fri, 19 Feb 2021 06:57:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme: use lighter smp barriers in nvme_irq
Message-ID: <20210218215758.GB30146@redsun51.ssa.fujisawa.hgst.com>
References: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
 <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <be263cdf-19a2-05d6-1023-7d935d526663@gmail.com>
 <20210218032822.GA2711165@dhcp-10-100-145-180.wdc.com>
 <BYAPR04MB49659AADB83039BA9DC0041886859@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49659AADB83039BA9DC0041886859@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_165808_103282_45DED47C 
X-CRM114-Status: GOOD (  22.86  )
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Feb 18, 2021 at 04:06:35AM +0000, Chaitanya Kulkarni wrote:
> On 2/17/21 19:28, Keith Busch wrote:
> > The variables the driver was protecting no longer exist, so I also agree
> > the barriers should not be necessary.
> >
> 
> Are you saying something like following is needed ?

Right, I'm just saying the barriers don't appear to be necessary, so
they can go away as you've indicated below.
 
> From a3a73bd3943b479f82ff00582baf2c37c1afd8e8 Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Wed, 17 Feb 2021 20:01:37 -0800
> Subject: [PATCH] nvme-pci: remove the barriers
> 
> The variable which was protected by the barriers is removed in
> The commit f6c4d97b0d82 (" nvme/pci: Remove last_cq_head").
> 
> Remove the barriers which was protecting the variable.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/pci.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0045c5edf629..3729775f6a8a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1062,14 +1062,8 @@ static irqreturn_t nvme_irq(int irq, void *data)
>      struct nvme_queue *nvmeq = data;
>      irqreturn_t ret = IRQ_NONE;
>  
> -    /*
> -     * The rmb/wmb pair ensures we see all updates from a previous run of
> -     * the irq handler, even if that was on another CPU.
> -     */
> -    rmb();
>      if (nvme_process_cq(nvmeq))
>          ret = IRQ_HANDLED;
> -    wmb();
>  
>      return ret;
>  }
> -- 
> 2.22.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
