Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79876C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcP8L1ASZ7VKjPtKdoCZHqtLVumu6BUa7xe8jPUKAfE=; b=JuGc+dTo6HXIQZwRENBNjvThlQ
	p10lxdGbhCqayEI5iQNz5COT5E1yB0Rd5d7KlNzldOSt+E1iTk3ULvAYIATWXK0Y4Di5lEQNkFF4n
	EoKkVCPsrQWE3T2piJdfMtTR9kLCIWvieuPM0eXYW9y+0FspoLC/BfWUcDtEfDXkBG1c5NKvOh1Lp
	/aenWbA6T1cU97Uy+XADLvOUxROoiggOvbFOYt0+m/OK3f8O5eJmH75SIcnHO/60wasZ1KLuaqG6y
	SIYZSvOM6Q3TMD6w7v3mkkZBnEfmJeVEGly/nAG/SSuOXmgtoa96/WiXAORtL+wm0fMLNNU4C7BU2
	/1SlWHSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54Uu-00CAaI-2o;
	Mon, 20 Nov 2023 13:39:32 +0000
Received: from mail-lf1-f47.google.com ([209.85.167.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54Uk-00CAZ4-0D
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:39:28 +0000
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50948640356so1185802e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 05:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700487559; x=1701092359;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcP8L1ASZ7VKjPtKdoCZHqtLVumu6BUa7xe8jPUKAfE=;
        b=LrCQBmUsQFw6tBxzolZ3o7jeEMTdTZLY3z6dOj5oXvMPEcSQhNwOMx/Nr2K+TiAb06
         FdjxhlD/WKKY5qvh81atQKTbIizS2Exb/UVcka+DNmzhCMD6MVYerANc/6Wwmk94qwXc
         HonWGx3llWyf9ID/+UTkwQPjo4SvbSd5Ki3o5kPX3z76ASX1VYylUeTiCFbMdTJDC4Ee
         GJ08m92jsh4o1YRmUZ9Ehgu4n8Y6LdKXGPLIeDr3WkQDOww6vbu2hvLo2vC7VilJBxjE
         zqzd8XcegXx2O4ok+T903rTz0IWlmONXeoofYavBx7SE6hvcaWQc5c3J3iEsdwh8m3rx
         qcxg==
X-Gm-Message-State: AOJu0YxakDJEMHHsZDmMflAovLUjpPna8mXblXeWZ7a1v6dcgj+yISRO
	BbQDojwwYcAJ/Q0qGm/E2cE=
X-Google-Smtp-Source: AGHT+IEEyejHTSM8Cql8aLHFSQj0UPXH43PIENcFAi1p5QrejIVLsE0L10IquI/puaAg97YyEKFwMw==
X-Received: by 2002:ac2:561c:0:b0:503:960:c42 with SMTP id v28-20020ac2561c000000b0050309600c42mr4237252lfd.0.1700487558777;
        Mon, 20 Nov 2023 05:39:18 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o4-20020a056512050400b004fb7359ab83sm1179928lfb.80.2023.11.20.05.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 05:39:18 -0800 (PST)
Message-ID: <a1ce2c2e-4f67-4271-ac67-5a1e8c5ebfb1@grimberg.me>
Date: Mon, 20 Nov 2023 15:39:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
 <20231024061337.35621-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231024061337.35621-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_053922_136821_48E8EA5A 
X-CRM114-Status: GOOD (  25.28  )
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


> Setting up I/O queues might take quite some time on larger and/or
> busy setups, so KATO might expire before all I/O queues could be
> set up.
> Fix this by start keep alive from the ->init_ctrl_finish() callback,
> and stopping it when calling nvme_cancel_admin_tagset().

If this is a fix, the title should describe the issue it is fixing, and
the body should say how it is fixing it.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 6 +++---
>   drivers/nvme/host/fc.c   | 6 ++++++
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 62612f87aafa..f48b4f735d2d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -483,6 +483,7 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>   
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>   {
> +	nvme_stop_keep_alive(ctrl);
>   	if (ctrl->admin_tagset) {
>   		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>   				nvme_cancel_request, ctrl);

There is a cross dependency here, now nvme_cancel_admin_tagset needs to
have the keep-alive stopped first, which may be waiting on I/O, which
needs to be cancelled...

Keep in mind that kato can be arbitrarily long, and now this function
may be blocked on this kato period.

I also think that now the function is doing something that is more
than simply cancelling the inflight admin tagset, as it is named.

> @@ -3200,6 +3201,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>   	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
>   	ctrl->identified = true;
>   
> +	nvme_start_keep_alive(ctrl);
> +

I'm fine with moving it here. But instead, maybe just change
nvme_start_keep_alive() to use a zero delay and keep it where it
is? will that help?

>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl_finish);
> @@ -4333,7 +4336,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_auth_stop(ctrl);
> -	nvme_stop_keep_alive(ctrl);
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
> @@ -4344,8 +4346,6 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
>   
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> -	nvme_start_keep_alive(ctrl);
> -
>   	nvme_enable_aen(ctrl);
>   
>   	/*
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a15b37750d6e..a9affc8b755b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2530,6 +2530,12 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	 * clean up the admin queue. Same thing as above.
>   	 */
>   	nvme_quiesce_admin_queue(&ctrl->ctrl);
> +
> +	/*
> +	 * Open-coding nvme_cancel_admin_tagset() as fc
> +	 * is not using nvme_cancel_request().
> +	 */
> +	nvme_stop_keep_alive(ctrl);
>   	blk_sync_queue(ctrl->ctrl.admin_q);
>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>   				nvme_fc_terminate_exchange, &ctrl->ctrl);

What does this fix? This should really be split out of the patch.

