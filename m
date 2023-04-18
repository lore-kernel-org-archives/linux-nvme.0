Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB72C6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4V/ozDRIxfvwxUeqafdroC25koHkfvAktO/M2R/Qcw=; b=fWhPM0byitUHF841FYjyWCQiHJ
	WGMQjqbtNwVIo7Fz7uZfGJNYj3GbgKYSIDqlkD+K5FqpUoKCKyoQgMsVdus3nv5L460PSQVOB5oNF
	fV1U0WvfqTUsQRHaBRqbKPRxmsrF0aaFYh08Ae/d5dd5rVvCg1+2HBYKs+JgI2h1gRMa8X/I4bSP1
	1oHYno/a1jjBFwI4c7rhlDQ6I+bVqYNF7WSy3jJmBK8mQxTuYkEGp/u3TUB2VS0gFV3QEkOTJTClt
	ZraIkR0c/za3HBhIqJIsdH0yqzkNbDscG6+/Dgj8AAcZxzFRlvo15HrS174hsXC6nqDOn9HK6O63K
	30OQkDuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poodh-002rOF-1R;
	Tue, 18 Apr 2023 16:57:09 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poodf-002rLn-03
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 16:57:08 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f174c4b404so3469435e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 09:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837021; x=1684429021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4V/ozDRIxfvwxUeqafdroC25koHkfvAktO/M2R/Qcw=;
        b=Xy8BKpongymR37s147mZlnjc5I689Qbn1Bmg7HHxLZefkRJbXJryAtfW1shB0xR/fU
         79o9t10O4GnZk5o2sUIOVdd+tCmDUEvmVPdrLsmsCkbuQaFYZr1KF+0iIp/5GS3Yoag1
         wpX2FjybxUI6CYW9PBrf/nCb2l6e2v32k1YWWqX0DZ3yDLMw/XvuuPr5uenuJABAzxC4
         7QnuLBje8HwTDwwUQ8acORk5h41DceaDZx+xcMX9w5cwb30csHhHpDwHBtZvA0krII0C
         dna6g7K5YaUDJcmTg0gf9xf077ejqTpF/ZbJSeDHAxu2MuyPgelSMk11LNR9BKJq8KHO
         dGyQ==
X-Gm-Message-State: AAQBX9cL4WtR7LMEqJ+XHNVuQ2GsOt6vzBGrjyrfCKzZHGiViIqtyv5b
	TGl+0zPhYkNSG3+czaOlFUg=
X-Google-Smtp-Source: AKy350aw1dzH7po1PgjLcdzb6uX8SsJLhqQ2vu326F+WBPV+4fph/P09lcR6gVEzEo5yIh3kVW01gg==
X-Received: by 2002:a05:600c:1c93:b0:3f0:b1c9:b676 with SMTP id k19-20020a05600c1c9300b003f0b1c9b676mr11278789wms.2.1681837020901;
        Tue, 18 Apr 2023 09:57:00 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d58ee000000b002f3e1122c1asm13540293wrd.15.2023.04.18.09.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:57:00 -0700 (PDT)
Message-ID: <c7e4a236-8776-d611-ed9a-ed46b14081fb@grimberg.me>
Date: Tue, 18 Apr 2023 19:56:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] nvme: check IO start time when deciding to defer KA
Content-Language: en-US
To: Uday Shankar <ushankar@purestorage.com>,
 Costa Sapuntzakis <costa@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>
Cc: linux-nvme@lists.infradead.org
References: <20230417225558.2890062-1-ushankar@purestorage.com>
 <20230417225558.2890062-3-ushankar@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417225558.2890062-3-ushankar@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_095707_052453_ACBAD422 
X-CRM114-Status: GOOD (  28.82  )
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



On 4/18/23 01:55, Uday Shankar wrote:
> When a command completes, we set a flag which will skip sending a
> keep alive at the next run of nvme_keep_alive_work when TBKAS is on.
> However, if the command was submitted long ago, it's possible that
> the controller may have also restarted its keep alive timer (as a
> result of receiving the command) long ago. The following trace
> demonstrates the issue, assuming TBKAS is on and KATO = 8 for
> simplicity:
> 
> 1. t = 0: submit I/O commands A, B, C, D, E
> 2. t = 0.5: commands A, B, C, D, E reach controller, restart its keep
>              alive timer
> 3. t = 1: A completes
> 4. t = 2: run nvme_keep_alive_work, see recent completion, do nothing
> 5. t = 3: B completes
> 6. t = 4: run nvme_keep_alive_work, see recent completion, do nothing
> 7. t = 5: C completes
> 8. t = 6: run nvme_keep_alive_work, see recent completion, do nothing
> 9. t = 7: D completes
> 10. t = 8: run nvme_keep_alive_work, see recent completion, do nothing
> 11. t = 9: E completes
> 
> At this point, 8.5 seconds have passed without restarting the
> controller's keep alive timer, so the controller will detect a keep
> alive timeout.
> 
> Fix this by checking the IO start time when deciding to defer sending a
> keep alive command. Only set comp_seen if the command started after the
> most recent run of nvme_keep_alive_work. With this change, the
> completions of B, C, and D will not set comp_seen and the run of
> nvme_keep_alive_work at t = 4 will send a keep alive.
> 
> Reported-by: Costa Sapuntzakis <costa@purestorage.com>
> Reported-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c | 14 +++++++++++++-
>   drivers/nvme/host/nvme.h |  5 +++--
>   2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1298c7b9bffb..8a63051d7b5e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -397,7 +397,14 @@ void nvme_complete_rq(struct request *req)
>   	trace_nvme_complete_rq(req);
>   	nvme_cleanup_cmd(req);
>   
> -	if (ctrl->kas)
> +	/*
> +	 * Completions of long-running commands should not be able to
> +	 * defer sending of periodic keep alives, since the controller
> +	 * may have completed processing such commands a long time ago
> +	 * (arbitrarily close to command submission time).
> +	 */
> +	if (ctrl->kas && !ctrl->comp_seen
> +		      && nvme_req(req)->start_time >= ctrl->ka_last_check_time)
>   		ctrl->comp_seen = true;

indentation is wrong here.

>   
>   	switch (nvme_decide_disposition(req)) {
> @@ -1178,6 +1185,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>   		return RQ_END_IO_NONE;
>   	}
>   
> +	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
> +	smp_wmb();
>   	ctrl->comp_seen = false;
>   	spin_lock_irqsave(&ctrl->lock, flags);
>   	if (ctrl->state == NVME_CTRL_LIVE ||
> @@ -1196,6 +1205,9 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   	bool comp_seen = ctrl->comp_seen;
>   	struct request *rq;
>   
> +	WRITE_ONCE(ctrl->ka_last_check_time, jiffies);
> +	smp_wmb();
> +
>   	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
>   		dev_dbg(ctrl->device,
>   			"reschedule traffic based keep-alive timer\n");
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..f044ffb9ce10 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -162,9 +162,7 @@ struct nvme_request {
>   	u8			retries;
>   	u8			flags;
>   	u16			status;
> -#ifdef CONFIG_NVME_MULTIPATH
>   	unsigned long		start_time;
> -#endif
>   	struct nvme_ctrl	*ctrl;
>   };
>   
> @@ -323,6 +321,7 @@ struct nvme_ctrl {
>   	struct delayed_work ka_work;
>   	struct delayed_work failfast_work;
>   	struct nvme_command ka_cmd;
> +	unsigned long ka_last_check_time;
>   	struct work_struct fw_act_work;
>   	unsigned long events;
>   
> @@ -1028,6 +1027,8 @@ static inline void nvme_start_request(struct request *rq)
>   {
>   	if (rq->cmd_flags & REQ_NVME_MPATH)
>   		nvme_mpath_start_request(rq);
> +	else
> +		nvme_req(rq)->start_time = jiffies;

nvme_mpath_start_request may not set the start_time if stats are
disabled...

