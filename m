Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77615C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Nov 2022 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7EOwVb6hg0ITCHQCrmlpvbMYM6rKSmpoLU1rts9DtVw=; b=IkM0CsHpZ0DL/eHhSN4lo+HSmm
	nsxiEiHUrBBwBjdYZVX11POhlnqOZLfCKp8GE5OEGaHBW9K2SGNIg/95R5WKuapAkP96ps/UJEskp
	C8IYDR3NRqWXI3BJanFm3ccC9pTnjWVRrwJE2+2bbWl4Y5R3v290Z+81w5Ao6bsC9xmHJJJ4D663c
	3OzNHHqQ7+9lJ3D5YfZCbbOQEzhJut6ia541eovNRG6Rm5Z3dYEn9XyLMDHKXah1pKD8MRUka3tnE
	T10S48fwGSWxiNfYUF4lNiqvk1m6WZs3FWC/QAfP4GSbWtRUJ/SA8ydKmIoFgD8s/wIwN76jYbHC2
	EHc1iF5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owiz7-0048xR-TS; Sun, 20 Nov 2022 11:59:41 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owiz5-0048wT-LS
	for linux-nvme@lists.infradead.org; Sun, 20 Nov 2022 11:59:41 +0000
Received: by mail-wm1-f43.google.com with SMTP id 84-20020a1c0257000000b003cfe48519a6so4650931wmc.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Nov 2022 03:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EOwVb6hg0ITCHQCrmlpvbMYM6rKSmpoLU1rts9DtVw=;
        b=fusnMpq2W3CAntWJYNLwHt6s5IGPTaSRu/aGugKmXHibQOvd1uXGAwWJKJDMpF+YEn
         0PAt/L2XHRKkNM2XFrUoQL+xWjs+i+yUI17HSQqOp9QIcL7tKGiEkCXPUiQ0kycQhftl
         4CYTObd/LeL8Od2EiLgEj7UIIX22nBuZ1o38bHY2AnY80x2DDuKWFj8huzz9iGhax7I2
         l8k2Iicyog5noCGMw3UcuZP2FRmA2REH0YdyuC8lndcJ4T7+PWIyO3gFh9u6f+R/XRF7
         rOemQHYWUJQhx1yogdpi9wUAlQXLnBT0Slj5MulHPRbcttg7/ywHF3lf1k7yIEggj252
         v1lw==
X-Gm-Message-State: ANoB5pm/S8+N6VfAiTeRxRPNNXB45ejkzV7a66ZMe6KK6zJAgAA51snM
	v+MjcLowH8xUaof1WXqzXQU=
X-Google-Smtp-Source: AA0mqf77aznsBr+0Lh37ByERplEeZFlVMBlMIy0o+pJ7U/wLM/26ksWwUxmw75DQLTsUTHwxpLdo+Q==
X-Received: by 2002:a05:600c:4916:b0:3cf:85e7:7b40 with SMTP id f22-20020a05600c491600b003cf85e77b40mr9679264wmp.63.1668945577840;
        Sun, 20 Nov 2022 03:59:37 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003cfc02ab8basm15466568wmb.33.2022.11.20.03.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:59:37 -0800 (PST)
Message-ID: <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
Date: Sun, 20 Nov 2022 13:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Content-Language: en-US
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_035939_734719_B49D52A9 
X-CRM114-Status: GOOD (  15.80  )
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


> From: Amit Engel <Amit.Engel@dell.com>
> 
> This provides additional details about the rq/cmd that is timed out

Please add an example print of the timeout log msg.

> 
> Signed-off-by: Amit Engel <Amit.Engel@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1eed0fc26b3a..5abaff5d6f6e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2277,8 +2277,11 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
>   	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
>   
>   	dev_warn(ctrl->device,
> -		"queue %d: timeout request %#x type %d\n",
> -		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
> +		"queue %d: cntlid %u timeout request %#x type %d cid %u opcode %#x "
> +		"start time %lluns io start time %lluns request timeout %ums\n",
> +		nvme_tcp_queue_id(req->queue), ctrl->cntlid, rq->tag, pdu->hdr.type,
> +		pdu->cmd.common.command_id, pdu->cmd.common.opcode,
> +		ktime_sub_ns(ktime_get(), rq->start_time_ns), ktime_sub_ns(ktime_get(), rq->io_start_time_ns), jiffies_to_msecs(rq->timeout));

You can get the cntlid from the controller device name which appears in
dev_warn, no need for it here.

Why are you printing the timeout value (in ktime)? What info does it
add? You can see the relative time in the log and you know what the
io timeout is (30 seconds before by default)...

You can also easily retrieve the cid from the tag (lower 12 bits).

The nvme opcode is fine to add...

>   
>   	if (ctrl->state != NVME_CTRL_LIVE) {
>   		/*

