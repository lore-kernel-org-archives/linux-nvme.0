Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482EEC5321E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 08:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRTzmGH8Edt4It/nnZnAE/Z0SjT1m2XsmYBkDYyPYSQ=; b=JUFXqRRl2JoltgqBKdJPFA06FR
	Q5GjS6oNYIwAp94MVsaOSftucYBIcUoz0mWcDmuSIaSk8MFKGHPtCFoLpvoQNkYg/ctvj9lCSeY5R
	0z5uVTox7lGUce7ryrbahYPHxVYxiNkOKOQh0F6a3Ny0ffLmHY2I3DGHH5aoo+Yh3wxnU5BHSqgRs
	7t3KKWjxC+5La/PFx1iJNn8rsQrcMsqpltAxR1PdqCjei0wvB+xj2nWgqPd5Qtwwe9H5VhGA/TaIo
	oUs5hqQrUj+uM5GBW0fAmqfsTiUVYpoFHqquZMjFJKD/GlboofgvXpyDSHlMv60VaYzh+pc2BAlPP
	3crAzbJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si8cL-00000003y8w-3fZU;
	Sun, 25 Aug 2024 08:28:57 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si8cJ-00000003y7e-1Msj
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 08:28:56 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso36908255e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 01:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724574534; x=1725179334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRTzmGH8Edt4It/nnZnAE/Z0SjT1m2XsmYBkDYyPYSQ=;
        b=pXdyuNl3PddWW7UXRoTKA77loIke87tkDxQ9M02vkbyPWxUgFf2a1nQ45IrCKspc1f
         GyAysTu1k0kXiMD9W92RTK+jQkPPA5zdmVUts6eU4E5pd8atwi6gEWYBzw/oBgy0TqGu
         9E+jjgdPwc3YYzoJPexYJQGDy4kRMjtb7UM/oPZkiBBM+TepG4KccUPsscNdLql1CuXT
         l4tHvW3Iuw5GJccyscXHWEI6noEL1ES1VrI7HXiH/Nxsz/yddP+hNf0689YxCRvC5Ui7
         l4a9b6TJnEM4GrJVr1p89FM0JmOimobVGlaAKrd0UWIRTbMc4SxWNi8CCbbpgUbF/Y17
         k5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU4M97Heds1Ove86wUlIEBGJwb4cub/u2sgMa+oQBcsXurjpylNwH2DpQm5CWJhoywRVhOA5NSA+4jH@lists.infradead.org
X-Gm-Message-State: AOJu0YwNrM8/hzTg5/Z29EGFI5YbFZv3QGfGFwcGdRcDWrNp9TgpZ2U/
	oNIRv3JujHB1mgasBBYMOftM32pOBrB9gEEEeZur9PjNfRNbpqfI
X-Google-Smtp-Source: AGHT+IERQ9xKCy2WvDgco04Z4TNPxx1qfiffT72ehzs/veS4vTIIVSH+HaS2u45hvhrJ6sf/ckmBAA==
X-Received: by 2002:adf:b317:0:b0:368:4489:8efb with SMTP id ffacd0b85a97d-373118c84eemr5984690f8f.40.1724574533189;
        Sun, 25 Aug 2024 01:28:53 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730826196bsm8138232f8f.102.2024.08.25.01.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 01:28:52 -0700 (PDT)
Message-ID: <d0f0feb4-9f0e-4c62-8ef3-2080e4b53be5@grimberg.me>
Date: Sun, 25 Aug 2024 11:28:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: core: freeze multipath queue early in
 nvme_update_ns_info()
To: Martin Wilck <martin.wilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org
References: <20240822201413.112268-1-mwilck@suse.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822201413.112268-1-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_012855_385819_5B597358 
X-CRM114-Status: GOOD (  23.30  )
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


The patch title should explain what it is fixing, i.e.  the reason of 
its existence.
Perhaps something like:
nvme: shorten multipath ns update duration

On 22/08/2024 23:14, Martin Wilck wrote:
> For multipath devices, nvme_update_ns_info() needs to freeze both
> the queue of the path and the queue of the multipath device. For
> both operations, it waits for one RCU grace period to pass, ~25ms
> on my test system. By calling blk_freeze_queue_start() for the
> multipath queue early, we avoid waiting twice; tests using ftrace
> have shown that the second blk_mq_freeze_queue_wait() call finishes
> in just a few microseconds. The path queue is unfrozen before
> calling blk_mq_freeze_queue_wait() on the multipath queue, so that
> possibly outstanding IO in the multipath queue can be flushed.
>
> I tested this using the "controller rescan under I/O load" test
> I submitted recently [1].
>
> [1] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/T/#u
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   drivers/nvme/host/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 33fa01c599ad..e2454398c660 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2217,6 +2217,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	bool unsupported = false;
>   	int ret;
>   
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_freeze_queue_start(ns->head->disk->queue);

Lets add a small comment here.

> +
>   	switch (info->ids.csi) {
>   	case NVME_CSI_ZNS:
>   		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> @@ -2254,7 +2257,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		struct queue_limits *ns_lim = &ns->disk->queue->limits;
>   		struct queue_limits lim;
>   
> -		blk_mq_freeze_queue(ns->head->disk->queue);
> +		blk_mq_freeze_queue_wait(ns->head->disk->queue);
>   		/*
>   		 * queue_limits mixes values that are the hardware limitations
>   		 * for bio splitting with what is the device configuration.
> @@ -2288,7 +2291,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		nvme_mpath_revalidate_paths(ns);
>   
>   		blk_mq_unfreeze_queue(ns->head->disk->queue);
> -	}
> +	} else if (nvme_ns_head_multipath(ns->head))
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);

Right now if ret!=0 you are unfreezing without waiting, you need to wait 
for the freeze to
complete before unfreezing.

You should restructure the code to make it so that the freeze_start, 
freeze_wait, unfreeze are
paired regardless of the code flows.

