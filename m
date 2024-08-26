Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E329C5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XeMB4VSnNdhxF9gLv2pSQsZS5MdB1P77c3b3g/5Afz8=; b=GrThfmdRMvv1UIm4gFypZBNIQ6
	Jd22MsxarqKzFKdbLFl2DAJx9ah3lZS61D4JNHtXH/puk0FfjN8ydyFtCFFwvQGCuNKSdMmVYyjTW
	5qr3u5VSBJMvhAhq87acrviQEtuUM8fZjbEFJ4Qf3efFl4RfXRAfY+Hc8uuAti9cNLRPDY+8Y8bGL
	VbrayW760faww6OUe5TgQ0vjYY3rxxgPJiPnaKdbbuDDON2sunC5n1MOBehU9tv2tJkrlcwwC3Djc
	4E1KcEdawpopltEcZAsUteU/EF8JL/Do6p38+nb1/CxOf/VThl1wnRFPH9lT9TQM34I4q4IdDxBbU
	c6tn5iGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siaku-00000007fGR-0qdL;
	Mon, 26 Aug 2024 14:31:40 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siajP-00000007f1x-2t3l
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 14:30:16 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42819654737so37945735e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 07:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682606; x=1725287406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeMB4VSnNdhxF9gLv2pSQsZS5MdB1P77c3b3g/5Afz8=;
        b=vPHo8dItDFwCPlrLWa0g2cd54+I6TpcutdGj1vKlv8WzYKUo9WLqo3DKEwuKII9EpN
         r6pKCuhPjGm0QKJb4gAJ/y3JPAtCrf+mu2pbd8HmIvpmkQx/2RYroL1DeFW4+kuL2+24
         a72W5JQ2S1eo/QSJvjIxTmu+lzKmjH2Ns/309Y4tW5Z8btwKSpb0CJhyJOpgnlwEVLwA
         R0iJXBmiZAifjg0j6IbS7scIL+0NVPxWPtjWqbyWIp4+tSjUCXj9nwsagxzUJKOjSrTO
         Ls0Oo+TKnkM+iCLQte6rT/9QzGa9uKAEWXSpXDsiCtQCvGrx6ED2GLkp4cNqdU5g9wX3
         susw==
X-Forwarded-Encrypted: i=1; AJvYcCWSi7Yv/jrwLr+SwdWTFHLRGoHJENwkaQQRae7mhbw0qpG2rlZwAGKGFeUqzR3vhxfkz35JDMmXoKM/@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5b5glufeBIGtxPGPgUDGyB3uQ5ma5FVYVo789ET8G9Ebu2xOk
	ze60SemefS6XSKwMMTgPajB+CklM7MvvReDISKtifL/RRjAQ5Qsi
X-Google-Smtp-Source: AGHT+IEYHrFMRw8z0bZm3/mV0ZWgcrAUmZwXse0kYIE7VyhNDGZYGX1BIZF/Y4Js19wJmE6lHQTQOA==
X-Received: by 2002:adf:f7d2:0:b0:368:77f9:fb34 with SMTP id ffacd0b85a97d-37311857bf9mr5908877f8f.15.1724682605198;
        Mon, 26 Aug 2024 07:30:05 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a076sm10869533f8f.60.2024.08.26.07.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 07:30:04 -0700 (PDT)
Message-ID: <3d52c916-a152-4f1e-8b44-6c4c1ca34747@grimberg.me>
Date: Mon, 26 Aug 2024 17:30:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: core: shorten duration of multipath namespace
 rescan
To: Martin Wilck <martin.wilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <dwagner@suse.de>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
References: <20240826142241.53601-1-mwilck@suse.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240826142241.53601-1-mwilck@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_073007_753750_58CC42EB 
X-CRM114-Status: GOOD (  30.28  )
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




On 26/08/2024 17:22, Martin Wilck wrote:
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
> v2: (all changes suggested by Sagi Grimberg)
>   - patch subject changed from "nvme: core: freeze multipath queue early in
>     nvme_update_ns_info()" to "nvme: core: shorten duration of multipath
>     namespace rescan"
>   - inserted comment explaining why blk_freeze_queue_start() is called early
>   - wait for queue to be frozen even if ret != 0
>   - make code structure more obvious vs. freeze_start / freeze_wait / unfreeze

This looks a lot better, thanks.

>
> Hannes and Daniel had already added Reviewed-by: tags to the v1 patch, but
> I didn't add them above, because the patch looks quite different now.
>
> ---
>   drivers/nvme/host/core.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0dc8bcc664f2..1ea052450846 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2217,6 +2217,16 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   	bool unsupported = false;
>   	int ret;
>   
> +	/*
> +	 * The controller queue is going to be frozen in
> +	 * nvme_update_ns_info_{generic,block}(). Every freeze implies waiting
> +	 * for an RCU grace period to pass. For multipath devices, we
> +	 * need to freeze the multipath queue, too. Start freezing the
> +	 * multipath queue now, lest we need to wait for two grace periods.
> +	 */
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_freeze_queue_start(ns->head->disk->queue);
> +
>   	switch (info->ids.csi) {
>   	case NVME_CSI_ZNS:
>   		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> @@ -2250,11 +2260,13 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		ret = 0;
>   	}
>   
> -	if (!ret && nvme_ns_head_multipath(ns->head)) {
> +	if (!nvme_ns_head_multipath(ns->head))
> +		return ret;
> +
> +	blk_mq_freeze_queue_wait(ns->head->disk->queue);
> +	if (!ret) {
>   		struct queue_limits *ns_lim = &ns->disk->queue->limits;
>   		struct queue_limits lim;
> -
> -		blk_mq_freeze_queue(ns->head->disk->queue);
>   		/*
>   		 * queue_limits mixes values that are the hardware limitations
>   		 * for bio splitting with what is the device configuration.
> @@ -2286,9 +2298,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
>   		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>   		nvme_mpath_revalidate_paths(ns);
> -
> -		blk_mq_unfreeze_queue(ns->head->disk->queue);
>   	}
> +	blk_mq_unfreeze_queue(ns->head->disk->queue);

I'd even make it nicer with adding an out label and reverse the ret 
condition polarity.
--
blk_mq_freeze_queue_wait(ns->head->disk->queue); if (ret) goto out; ... 
... out: blk_mq_unfreeze_queue(ns->head->disk->queue);
         return ret;
--

