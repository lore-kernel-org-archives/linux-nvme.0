Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A94C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hregpx8t1kAHRsj5KIbt4EVewflLpm3kB0Chk3MbBVo=; b=Y0tezqr9Z7llbLcvrOHt+2r+3i
	Ovaq3FFRnGreI1yo0cydxiokxRXXH9bjvrzElNKsPDqWLA9n70wG54M1TaSJbdipFaoopMHfGz76r
	le9H8SGkFI6/cd+QMU/xQ04Eo0Ef28YhMZDJKbIJASvwrRQkV1KwTgWyogxWwOT7/uhLiqDaRqFGx
	MZg/CMFO5WmbFGrl2S7vsRgn6PQbYtoJhCfMHAPigNckYqr+nKIHDpFzuVpgh4zoMGyEeL/9Km9Z2
	KXdoXIm731jrPmsZ/3/vwUYh1UiqtuAU/uWZR0UbiyTwlyQYXi08WwU32sAsy1End+smH/vXxfs+b
	iB2ydAUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiaaB-007w0b-3M; Wed, 12 Oct 2022 12:11:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiaZq-007vyN-EV
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 12:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665576665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hregpx8t1kAHRsj5KIbt4EVewflLpm3kB0Chk3MbBVo=;
	b=VTHDK4Wpn36zsDCA1C/bekpG0slGkz73fYr1Ognb+pB/NM3nT0FOLLw5IxJl4YU62/d6a4
	wwEKR/nX/XTZpSRFZdsoQLmD8EaNmjCupC2prLSnkpZd2ZhZrfwM7g1IA6tjZtR2Q2xN9M
	7dKK/ePRUWWqoUzmWfaHnoIzbJ6+LR4=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-JoKSvU3BPz-zFSklgvBO5Q-1; Wed, 12 Oct 2022 08:11:04 -0400
X-MC-Unique: JoKSvU3BPz-zFSklgvBO5Q-1
Received: by mail-ua1-f70.google.com with SMTP id k9-20020a9f30c9000000b003df15f05649so4981997uab.6
        for <linux-nvme@lists.infradead.org>; Wed, 12 Oct 2022 05:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hregpx8t1kAHRsj5KIbt4EVewflLpm3kB0Chk3MbBVo=;
        b=TCI1gDArUuFgJGJzwfxQBeOXjQonOH4JrjXtViBtSNe5SbitZwIeFAvQPj1XG0Ffir
         3BeNuucHqtXubueCiQIFvGbkE2NrvJigNguLuEOjipDvj+l7FfAFENTxMTVQC9NZKGWS
         wNm/EN8y76DLRPQxEkLKO4MdancKmTF71CLGGC6MYHU8H8xXsn9pxmC12ahi+RnoJIse
         4zwY5K6GhV3fIfA+sU9MkMcwosVRMiDCt2hcFGnjLR6foLd2QDAdtBj1l5leddo9aFNC
         Mj1gG+8jn6vuM+yQLg8qQyxoZpMjlBEEHtrJZefVHq3o9q/rwC/PUajTWnvndCVfyRhh
         fHwg==
X-Gm-Message-State: ACrzQf3jjzb+Txio+W3dWGK9MCl/jz9v/E6t/Nvehx3zT5Q+hpvJ3NGy
	oo4n4KqDvGnzprW26nCIgdtE3N+/a9/fim4gJZRYnMVgMDB2jR/2/ehjqcEOGzDv8SPs/+iw2Pv
	f14gA0+yqZyoTSPdoy1FQjjZjF92j1Y1qQFuN0qgSPRQ=
X-Received: by 2002:ab0:7c8f:0:b0:381:c81f:6152 with SMTP id v15-20020ab07c8f000000b00381c81f6152mr14996264uaw.58.1665576663446;
        Wed, 12 Oct 2022 05:11:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6BcAPMB0fOUebVBZrx75XmrZkHjxCDZuCbZ2MEbg+W3PfuUXuBgiCfdkdxsD5PMXfIc/kiYj+v9aXSxNwUOUI=
X-Received: by 2002:ab0:7c8f:0:b0:381:c81f:6152 with SMTP id
 v15-20020ab07c8f000000b00381c81f6152mr14996248uaw.58.1665576663179; Wed, 12
 Oct 2022 05:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <E1oiaBa-00Dz7S-SK@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1oiaBa-00Dz7S-SK@rmk-PC.armlinux.org.uk>
From: Eric Curtin <ecurtin@redhat.com>
Date: Wed, 12 Oct 2022 13:10:47 +0100
Message-ID: <CAOgh=FzyV4mVsEujkYKZyZ0m12cnDEuK9GadUqutSFk2Cfj5jQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-apple: fix DMA-API warning
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_051111_038232_5F621C4C 
X-CRM114-Status: GOOD (  18.70  )
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

On Wed, 12 Oct 2022 at 12:53, Russell King (Oracle)
<rmk+kernel@armlinux.org.uk> wrote:
>
> Fix the following DMA-API warning:
>
> DMA-API: nvme-apple 27bcc0000.nvme: mapping sg segment longer than device claims to support [len=69632] [max=65536]
> WARNING: CPU: 3 PID: 1 at kernel/dma/debug.c:1160 debug_dma_map_sg+0x310/0x3a0
> Modules linked in: tps6598x roles typec rtc_macsmc gpio_macsmc nvme_apple apple_mailbox apple_sart pcie_apple macsmc_rtkit macsmc pinctrl_apple_gpio i2c_apple
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

Seems reasonable, the same as nvme_reset_work, wouldn't be the worst
thing in the world if we duplicated the "Don't limit the IOMMU merged
segment size" comment from the generic driver for the apple version
also if there ends up being a v2.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>


> ---
>  drivers/nvme/host/apple.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 5fc5ea196b40..ff8b083dc5c6 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1039,6 +1039,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
>                                          dma_max_mapping_size(anv->dev) >> 9);
>         anv->ctrl.max_segments = NVME_MAX_SEGS;
>
> +       dma_set_max_seg_size(anv->dev, 0xffffffff);
> +
>         /*
>          * Enable NVMMU and linear submission queues.
>          * While we could keep those disabled and pretend this is slightly
> --
> 2.30.2
>
>


