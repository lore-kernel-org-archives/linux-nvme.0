Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250ACECAAD2
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Aug 2022 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3N8gqpGeYYDapMLdRBf4TLqlyHMcJXX+ITxg8fYXLr8=; b=go4JEMzzM9ND8tEvNsm+CGqmPO
	SB7EIFwnjlNdu3mJ1sgkgjEp1XhEN5nEM7lsZsN4XbZowCpy0Mp0qYqLCAU54jsQMjqyZy3TuPTFr
	nKSp5H2r/8x5FDbj+HBSdNAbtJ+TKhynSR68+VteTRvcjYcaUFF5TUv2SbTwXjQDZdBMuio1Zh/25
	PQWobo5sD5SD4rn/MG6zqqjwOLCmu0uHxWRshnCZNTMzgtG7nLYCkzjotudls1utfRDo0VKRlrfWT
	VyPti4vXeuwkQry7fm3lrHiZD39YlnXuB1FzsAlMiqg7YCbJGZ0iSc5wgjQ3nDmt856gHlhUjRHu0
	liCRD/fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSHM1-00GkW7-ML; Sun, 28 Aug 2022 12:25:29 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSHLv-00GkTe-UF
	for linux-nvme@lists.infradead.org; Sun, 28 Aug 2022 12:25:26 +0000
Received: by mail-wr1-f42.google.com with SMTP id bs25so7022603wrb.2
        for <linux-nvme@lists.infradead.org>; Sun, 28 Aug 2022 05:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3N8gqpGeYYDapMLdRBf4TLqlyHMcJXX+ITxg8fYXLr8=;
        b=nmC6lMGuHb7cvaBigg/Lo7Y1+arpeonTRQ7SuZKK2X0tsntTA8p3LINk/6yGRq8sRM
         4143X0I1pIYVInOcwwgurqgmlXdaQ6yKtDhraLyNwB98je9Y0KVjb1bldLCxLhmAPClr
         pz2Yc/62IZrvEc6bsCqhljyjk0jenLj+P4Tjig72YBrfY/1/d2Y7FYoshx2zqkFg6Rth
         ceY/XFKLPC26ea+joNKJBVsTk9p0AiI4NXPj5Wdhw/nGuqsawyEet5HNOw2hXwCCaCgT
         40f1VCrQToyplOLu9aJCSCzYcGeVW/Z8pwWCdparFBeEj5x7t9JKUy9oSgm2gERa0c/r
         /jbw==
X-Gm-Message-State: ACgBeo3oeINfNlUOy/GygdK+cQBQxv9vPXIjYl0xQH0EPQUyrLo30eTm
	puFxnGaS5HmtzyDPPmazsGr61oWXgQIqCg==
X-Google-Smtp-Source: AA6agR4KYLSAtC0C2D5CoNFJuWk0AprXa5UfAv7P7rAdiVOfcSXAoqnhUf7njb4Tiy36WV5rvJqnVg==
X-Received: by 2002:a5d:6da8:0:b0:226:d53f:dff4 with SMTP id u8-20020a5d6da8000000b00226d53fdff4mr2103464wrs.715.1661689521016;
        Sun, 28 Aug 2022 05:25:21 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003a5f783abb8sm5770627wma.30.2022.08.28.05.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 05:25:13 -0700 (PDT)
Message-ID: <840dab46-6cdd-1204-3642-2b67d04cd212@grimberg.me>
Date: Sun, 28 Aug 2022 15:25:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] nvme-tcp: Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220823074451.12170-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220828_052524_362967_B52226D6 
X-CRM114-Status: GOOD (  28.58  )
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



On 8/23/22 10:44, Daniel Wagner wrote:
> On reconnect, the number of queues might have changed.
> 
> In the case where we have more queues available than previously we try
> to access queues which are not initialized yet.
> 
> The other case where we have less queues than previously, the
> connection attempt will fail because the target doesn't support the
> old number of queues and we end up in a reconnect loop.
> 
> Thus, only start queues which are currently present in the tagset
> limited by the number of available queues. Then we update the tagset
> and we can start any new queue.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 59 ++++++++++++++++++++++++++---------------
>   1 file changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 044da18c06f5..93206215e381 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1762,11 +1762,12 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
>   		nvme_tcp_stop_queue(ctrl, i);
>   }
>   
> -static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
> +static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
> +				    int first, int last)
>   {
>   	int i, ret;
>   
> -	for (i = 1; i < ctrl->queue_count; i++) {
> +	for (i = first; i < last; i++) {
>   		ret = nvme_tcp_start_queue(ctrl, i);
>   		if (ret)
>   			goto out_stop_queues;
> @@ -1775,7 +1776,7 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
>   	return 0;
>   
>   out_stop_queues:
> -	for (i--; i >= 1; i--)
> +	for (i--; i >= first; i--)
>   		nvme_tcp_stop_queue(ctrl, i);
>   	return ret;
>   }
> @@ -1899,31 +1900,38 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
>   	nvme_tcp_free_io_queues(ctrl);
>   }
>   
> -static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
> +static int nvme_tcp_configure_io_queues(struct nvme_ctrl *nctrl, bool new)

Lets not change the name here, it creates some churn...

>   {
> -	int ret;
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);

Why do you need the tcp ctrl?

> +	int ret, nr_queues;
>   
> -	ret = nvme_tcp_alloc_io_queues(ctrl);
> +	ret = nvme_tcp_alloc_io_queues(nctrl);
>   	if (ret)
>   		return ret;
>   
>   	if (new) {
> -		ret = nvme_tcp_alloc_tag_set(ctrl);
> +		ret = nvme_tcp_alloc_tag_set(nctrl);
>   		if (ret)
>   			goto out_free_io_queues;
>   
> -		ret = nvme_ctrl_init_connect_q(ctrl);
> +		ret = nvme_ctrl_init_connect_q(nctrl);
>   		if (ret)
>   			goto out_free_tag_set;
>   	}
>   
> -	ret = nvme_tcp_start_io_queues(ctrl);
> +	/*
> +	 * Only start IO queues for which we have allocated the tagset
> +	 * and limitted it to the available queues. On reconnects, the
> +	 * queue number might have changed.
> +	 */
> +	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);

	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);

> +	ret = nvme_tcp_start_io_queues(nctrl, 1, nr_queues);
>   	if (ret)
>   		goto out_cleanup_connect_q;
>   
>   	if (!new) {
> -		nvme_start_queues(ctrl);
> -		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
> +		nvme_start_queues(nctrl);
> +		if (!nvme_wait_freeze_timeout(nctrl, NVME_IO_TIMEOUT)) {
>   			/*
>   			 * If we timed out waiting for freeze we are likely to
>   			 * be stuck.  Fail the controller initialization just
> @@ -1932,26 +1940,35 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			ret = -ENODEV;
>   			goto out_wait_freeze_timed_out;
>   		}
> -		blk_mq_update_nr_hw_queues(ctrl->tagset,
> -			ctrl->queue_count - 1);
> -		nvme_unfreeze(ctrl);
> +		blk_mq_update_nr_hw_queues(nctrl->tagset,
> +			nctrl->queue_count - 1);
> +		nvme_unfreeze(nctrl);
>   	}
>   
> +	/*
> +	 * If the number of queues has increased (reconnect case)
> +	 * start all new queues now.
> +	 */
> +	ret = nvme_tcp_start_io_queues(nctrl, nr_queues,
> +				       ctrl->tag_set.nr_hw_queues + 1);
> +	if (ret)
> +		goto out_cleanup_connect_q;

You need to go to out_wait_freeze_timed_out as IOs pending have
possibly restarted with nvme_unfreeze...

> +
>   	return 0;
>   
>   out_wait_freeze_timed_out:
> -	nvme_stop_queues(ctrl);
> -	nvme_sync_io_queues(ctrl);
> -	nvme_tcp_stop_io_queues(ctrl);
> +	nvme_stop_queues(nctrl);
> +	nvme_sync_io_queues(nctrl);
> +	nvme_tcp_stop_io_queues(nctrl);
>   out_cleanup_connect_q:
> -	nvme_cancel_tagset(ctrl);
> +	nvme_cancel_tagset(nctrl);
>   	if (new)
> -		blk_mq_destroy_queue(ctrl->connect_q);
> +		blk_mq_destroy_queue(nctrl->connect_q);
>   out_free_tag_set:
>   	if (new)
> -		blk_mq_free_tag_set(ctrl->tagset);
> +		blk_mq_free_tag_set(nctrl->tagset);
>   out_free_io_queues:
> -	nvme_tcp_free_io_queues(ctrl);
> +	nvme_tcp_free_io_queues(nctrl);
>   	return ret;
>   }
>   

