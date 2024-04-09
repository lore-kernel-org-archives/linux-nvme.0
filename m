Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62384CD128A
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fyv+Sgdpe/tURPZFPrQf1DpSV+fJ2iL3YgdlrzErjvE=; b=2FM+MRFzullCR95sqjAB5Kse2P
	ood110FbFU1ra5XZWtIdn5QTzshTrVxBYGM6kcLBZNahWSFO31rNHJc0E4h11EGgi3PxK8/uejrfE
	gGr48Lx4nUxkxQPxWSjitLO7haIAOQ0wqydLHCiFowQ1FTfcYDUg69V6fG0JjYrP7FvCDeHp5etVp
	g0qIfmenMKExDrJVaN4chdB3TDZexi88DZnKccVT7NPB6VAK26V+FXufxHHuMCmb9yFTvM3L0C5eN
	tODJ84PdGmrPug82WV4ixZSkLa2ok3Br1TeEtZPXTx+22bfq+JPMdubEeRYXzgYuIVRu7V8WtqPZ1
	j1USXpTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruIGI-00000003lLK-1FCc;
	Tue, 09 Apr 2024 20:40:10 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruIGF-00000003lJP-3IPd
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 20:40:09 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34602c11302so231333f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 13:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695205; x=1713300005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyv+Sgdpe/tURPZFPrQf1DpSV+fJ2iL3YgdlrzErjvE=;
        b=BSPaRdla59jMahVvnTzPp2flrCdeyABZti5nlx99RrzoNjQsioRWj2EVuDSmiWHAf+
         ZzeBIfZGjsqF8RVXlTSjCStBEocAfAm5iNsnGm2ed2Po1Y5yOLGCuISJSf0tPgC3L6/y
         Ex0V40SCvEY5IniKwwrkse3MNLRda5qtvGLswRkOwO2mKrtgqFjk4rsBYJoSsSjq5fYV
         GAmeXUSWiCV+iWHngeHa/CewgLlfZDKoAho/vW9jHEsIPv9rYA16t6OQayv9Pht8fmhR
         gn1r3AhNqPb7wy7YjccDjs4+yuY1BLloBQ2fKUxlzKzVT9G0VFOxEaTcDQMBieVl9ecI
         3t9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy8JqgJXWVk8ixhSIwgBskC6H6h9GbIPitO/0E/ec6U4emCA3F/x8HNIGWHkErn/0R8KkLhFJPxOWhENRVkT/rZAsmTAPi/y/NggZfQps=
X-Gm-Message-State: AOJu0YzVO1NJNMU9+1j0JjEciKMeIA3/WQz3BJFTIfCQmbnNYERS8DV+
	8DZOMGD7SJ64NFJu81sk+huz+uQkE4EiWVZW98fY03XpbbHJM4Bq
X-Google-Smtp-Source: AGHT+IGEPQeWWJ1gb55WKa4X7BOEKHCw4H0e29oACi5yCfUTHDaZG3IsGW3B3dIZWTe1nSDN2UNqfQ==
X-Received: by 2002:a5d:64e3:0:b0:343:ba58:1297 with SMTP id g3-20020a5d64e3000000b00343ba581297mr654216wri.3.1712695205394;
        Tue, 09 Apr 2024 13:40:05 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b0041668770f37sm44916wms.17.2024.04.09.13.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:40:05 -0700 (PDT)
Message-ID: <91c49412-4251-4e13-80df-9148208aeac7@grimberg.me>
Date: Tue, 9 Apr 2024 23:40:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-4-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240409093510.12321-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_134008_061880_C349B941 
X-CRM114-Status: GOOD (  32.38  )
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



On 09/04/2024 12:35, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
> association was established and we have received a status from the
> controller; consequently we should honour the DNR bit. If not any future
> reconnect attempts will just return the same error, so we can
> short-circuit the reconnect attempts and fail the connection directly.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [dwagner: add helper to decide to reconnect]
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/nvme.h | 24 ++++++++++++++++++++++++
>   drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
>   2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9b8904a476b8..dfe103283a3d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -701,6 +701,30 @@ static inline bool nvme_is_path_error(u16 status)
>   	return (status & 0x700) == 0x300;
>   }
>   
> +/*
> + * Evaluate the status information returned by the LLDD

We usually say transport, less so LLDD.

>   in order to
> + * decided if a reconnect attempt should be scheduled.
> + *
> + * There are two cases where no reconnect attempt should be attempted:
> + *
> + * 1) The LLDD reports an negative status. There was an error (e.g. no
> + *    memory) on the host side and thus abort the operation.
> + *    Note, there are exception such as ENOTCONN which is
> + *    not an internal driver error, thus we filter these errors
> + *    out and retry later.

What is this ENOTCONN here? From what I see its just a random
escape value to bypass the status check. I think that 0 would do the same
wouldn't it?

> + * 2) The DNR bit is set and the specification states no further
> + *    connect attempts with the same set of paramenters should be
> + *    attempted.
> + */
> +static inline bool nvme_ctrl_reconnect(int status)
> +{
> +	if (status < 0 && status != -ENOTCONN)
> +		return false;
> +	else if (status > 0 && (status & NVME_SC_DNR))
> +		return false;
> +	return true;
> +}
> +
>   /*
>    * Fill in the status and result information from the CQE, and then figure out
>    * if blk-mq will need to use IPI magic to complete the request, and if yes do
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fdbcdcedcee9..7e25a96e9870 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2155,9 +2155,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	nvme_tcp_destroy_io_queues(ctrl, remove);
>   }
>   
> -static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
> +		int status)
>   {
>   	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
> +	bool recon = nvme_ctrl_reconnect(status);
>   
>   	/* If we are resetting/deleting then do nothing */
>   	if (state != NVME_CTRL_CONNECTING) {
> @@ -2165,13 +2167,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   		return;
>   	}
>   
> -	if (nvmf_should_reconnect(ctrl)) {
> +	if (recon && nvmf_should_reconnect(ctrl)) {

its weird to have a condition that checks _and_ condition
of two different "should reconnect" conditions.

Why don't we simply pass the status to nvmf_should_reconnect()
and evaluate there?

>   		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
>   			ctrl->opts->reconnect_delay);
>   		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
>   				ctrl->opts->reconnect_delay * HZ);
>   	} else {
> -		dev_info(ctrl->device, "Removing controller...\n");
> +		dev_info(ctrl->device, "Removing controller (%d)...\n",
> +			 status);
>   		nvme_delete_ctrl(ctrl);
>   	}
>   }
> @@ -2252,10 +2255,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
>   			struct nvme_tcp_ctrl, connect_work);
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
> +	int ret;
>   
>   	++ctrl->nr_reconnects;
>   
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> +	ret = nvme_tcp_setup_ctrl(ctrl, false);
> +	if (ret)
>   		goto requeue;
>   
>   	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
> @@ -2268,7 +2273,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   requeue:
>   	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>   			ctrl->nr_reconnects);
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> @@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
>   }
>   
>   static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> @@ -2315,6 +2320,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   {
>   	struct nvme_ctrl *ctrl =
>   		container_of(work, struct nvme_ctrl, reset_work);
> +	int ret;
>   
>   	nvme_stop_ctrl(ctrl);
>   	nvme_tcp_teardown_ctrl(ctrl, false);
> @@ -2328,14 +2334,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> +	ret = nvme_tcp_setup_ctrl(ctrl, false);
> +	if (ret)
>   		goto out_fail;
>   
>   	return;
>   
>   out_fail:
>   	++ctrl->nr_reconnects;
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
>   static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)


