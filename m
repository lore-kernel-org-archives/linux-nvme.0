Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F7CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 15:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Date:References:In-Reply-To:Message-Id:Mime-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TG0zS+/AD8OWXajAcLqKBeQQIZNNEfxrwqAkL+1Qq6Q=; b=omd6YCcGZOEI9S758482MRuCgn
	TghnHdydqKHtfCYHmI5KrlaPEGanyH9nF9nJZLlspOsiaHWNCLvQhOBEag2EFg/zHAcENJtRS9rHd
	/bED0+dcy2fzTbTah/zsGZ7S2ZehITR+FhKYOAo7dS7LkyzSXGJwrn6YdcMZofndEcAd3ebk9b60/
	wLtMUuJamz6VuimEw933eWDzfI2+Yt9HSjQTPYlZ/oenoFLIzAIYh9XMOA6YVo1wnJgl75a6fERP/
	jWzq2T78x/jGzijMC2cDbTXpz1w+NaTcuf1WjsM8zWR/0sKIFM1HIX7ss5iHr37EJqTKA6RqIa8xm
	NFIztehg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oidOT-008Trd-V0; Wed, 12 Oct 2022 15:11:37 +0000
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oidOI-008ToZ-63; Wed, 12 Oct 2022 15:11:27 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A432A5C00D4;
	Wed, 12 Oct 2022 11:11:20 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Wed, 12 Oct 2022 11:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1665587480; x=1665673880; bh=TG
	0zS+/AD8OWXajAcLqKBeQQIZNNEfxrwqAkL+1Qq6Q=; b=EOIOxvQ9x9XSxkUcKE
	To1oq79r289pMPOpGeiyg8rl/Vl0Xo9JPeLyAc8Kh8+mAdobU4omq7tuBTOhZK7V
	UJhluo19E6EcVxkdyCcPislqKQbbbS2g+EAvvFWzB8v85aF6fphjPWtREhniF2ny
	O/YT51clMW77Z6Y4gde+5QMY3EipnIkZvxEuj2Pb2DBgpZ4qPMStLeS2C3Efs+Hv
	7C2UufiyQZMvxvoyBD8SCplI4YIp5rfj8ybVRpcBAUJ+sMAHhfywpYWLy/WRwX54
	cPpuEMPFGZzaQi+iIE/VK7qVqG/+ypvn2Gy9NW0DSadrWN2En0eGpCdG5N0WY4ru
	U77g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1665587480; x=1665673880; bh=TG0zS+/AD8OWXajAcLqKBeQQIZNN
	EfxrwqAkL+1Qq6Q=; b=AByNme9KVvOVvRwQdd0s0QITQED1uc/WwhtzFc7TIOJv
	eMsXYlDLsOP6mR5VIm5PopFZvPVgpePN0/X3Kh+m8bB+TZjTpT2QzO5fPmxoKS9X
	ZttWTx0fDVQ7vYU62rFaMHMbuulsFLxHCGLNc3VI9ApQOB6z0qPWCv/9vNfO71dY
	0cFqgnFv6eUq0C7PoibAQiz27xHoUYyifXuWC/ZwYyiknuuvmrjD4qsp/lxbLmLu
	bSOdWO1Ygr4gWOz2CXjSNbV/8EjUq5NYY4XuGh3tHe4A3rE7Guz0J2R2OpneZU3c
	2vMdtw2nXPyAV0y5XF4Zz6NPkCq5HZUel/LbuW69AA==
X-ME-Sender: <xms:F9lGY0gvvMJ7aiLizsHnkCyNQ4DDXgc-zvf4ghOrlnL21Z4TzxRTPQ>
    <xme:F9lGY9Dt8ErEzi_ZBySad-xPet36f0vqu6141-_2xe-_lcigXl1ko4v81qhjQeWC5
    FHeW14Zv6DKLkIAc9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejkedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:F9lGY8F5XvHyn3wlGvq-R8FYAlGxZnzSHTjois2cWuigS6sCZl_RCg>
    <xmx:F9lGY1SpbIfZrEAHo5qb3-Pgebi7gOVXKHBmOIqyiBhr8v7FbUtjbA>
    <xmx:F9lGYxxVGXeMSBqVrBq-r3CGw-W66zY6VkCCKdY-Cl__3N24ce5rGQ>
    <xmx:GNlGYwyMsZ3C1PaMes_Tsffuw7r14YLsLQi-emiuhZYf2HuTLDCyTQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6117CA6007C; Wed, 12 Oct 2022 11:11:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <1419687c-c58b-4eb8-8f37-523f6a367f26@app.fastmail.com>
In-Reply-To: <E1oiaBa-00Dz7S-SK@rmk-PC.armlinux.org.uk>
References: <E1oiaBa-00Dz7S-SK@rmk-PC.armlinux.org.uk>
Date: Wed, 12 Oct 2022 17:10:59 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Russell King" <rmk+kernel@armlinux.org.uk>
Cc: "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Keith Busch" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-apple: fix DMA-API warning
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_081126_495793_58A6AD77 
X-CRM114-Status: GOOD (  17.69  )
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

On Wed, Oct 12, 2022, at 13:46, Russell King (Oracle) wrote:
> Fix the following DMA-API warning:

Thanks for fixing this!

I'd probably use something like "Communicate unlimited segment size support to DMA mapping code"
as the title since that's the actual change which then happens to fix the warning and
maybe also mention that this is done in pci.c and was dropped by mistake when
apple.c was forked from there.

This could also use a Fixes tag to reference the commit that introduced this driver.

With those things addressed,

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Thanks,


Sven


>
> DMA-API: nvme-apple 27bcc0000.nvme: mapping sg segment longer than 
> device claims to support [len=69632] [max=65536]
> WARNING: CPU: 3 PID: 1 at kernel/dma/debug.c:1160 
> debug_dma_map_sg+0x310/0x3a0
> Modules linked in: tps6598x roles typec rtc_macsmc gpio_macsmc 
> nvme_apple apple_mailbox apple_sart pcie_apple macsmc_rtkit macsmc 
> pinctrl_apple_gpio i2c_apple
> CPU: 3 PID: 1 Comm: init Not tainted 6.0.0+ #1081
> Hardware name: Apple Mac mini (M1, 2020) (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : debug_dma_map_sg+0x310/0x3a0
> lr : debug_dma_map_sg+0x310/0x3a0
> ...
> Call trace:
>  debug_dma_map_sg+0x310/0x3a0
>  __dma_map_sg_attrs+0x98/0xf4
>  dma_map_sg_attrs+0xc/0x1c
>  apple_nvme_queue_rq+0x218/0x67c [nvme_apple]
>  blk_mq_dispatch_rq_list+0x198/0x81c
>  blk_mq_do_dispatch_sched+0x2b0/0x340
>  __blk_mq_sched_dispatch_requests+0x104/0x154
>  blk_mq_sched_dispatch_requests+0x38/0x70
>  __blk_mq_run_hw_queue+0x80/0x130
>  __blk_mq_delay_run_hw_queue+0x84/0x90
>  blk_mq_run_hw_queue+0x134/0x170
>  blk_mq_sched_insert_requests+0xec/0x300
>  blk_mq_flush_plug_list+0x104/0x430
>  __blk_flush_plug+0xe8/0x130
>  blk_finish_plug+0x30/0x1f0
>  read_pages+0x1ec/0x334
>  page_cache_ra_unbounded+0x158/0x1bc
>  page_cache_ra_order+0x80/0x2c0
>  filemap_fault+0x4bc/0x970
>  __do_fault+0x38/0x144
>  __handle_mm_fault+0x7c4/0xc60
>  handle_mm_fault+0x120/0x2a0
>  do_page_fault+0x130/0x47c
>  do_translation_fault+0xa0/0xb0
>  do_mem_abort+0x40/0x90
>  el0_da+0x2c/0x80
>  el0t_64_sync_handler+0x60/0xb4
>  el0t_64_sync+0x168/0x16c
> ---[ end trace 0000000000000000 ]---
>
> Suggested-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/nvme/host/apple.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 5fc5ea196b40..ff8b083dc5c6 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1039,6 +1039,8 @@ static void apple_nvme_reset_work(struct 
> work_struct *work)
>  					 dma_max_mapping_size(anv->dev) >> 9);
>  	anv->ctrl.max_segments = NVME_MAX_SEGS;
> 
> +	dma_set_max_seg_size(anv->dev, 0xffffffff);
> +
>  	/*
>  	 * Enable NVMMU and linear submission queues.
>  	 * While we could keep those disabled and pretend this is slightly
> -- 
> 2.30.2

