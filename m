Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88809C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5vLDoaXEBHswJcQxHH+l0uEpBx5pMUOIllHTr5ONuY=; b=fxOrURtFhWTja5xJg22DghF3Gc
	l8fC8Qm5vBFOzlOm28FqEP5EOLQ5K6v92WOrpF7A/usakoUDghKRg4KyJfM1J73vp6txhjGCHCet/
	LEjga48SZmNlODmk5dOyuzjhHLF8R3C8pNMc76Q5/HGGb8tbWbeOS2XV1a1woFSXhYWG99kps1PHL
	33ri0q/9uE/9zinPaoksz02QbxMTPAmdQgCa5/sIR+BQOTJZlBe98BGThAmj8eek690DQ/dR4za4i
	wZYWPWBB12/dNA19unSins5sNaP7GltvhUTbCzERupndCyCgbfD+Q4eYNgydqcDtVZ9nEbm5v3U5M
	JeRc1dZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzwU-00FFUi-6j; Thu, 14 Jul 2022 14:35:50 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzwR-00FFQ0-BM
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 14:35:48 +0000
Received: by mail-wm1-f47.google.com with SMTP id ay25so1176795wmb.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 Jul 2022 07:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E5vLDoaXEBHswJcQxHH+l0uEpBx5pMUOIllHTr5ONuY=;
        b=Nbq+Rp65CAhR4/2JbdH0YUgYq4O8aFlAqRJ6IWO2M6Rw39spQ1wLm7nyPGThtGspRM
         W3QEzCDOJfFHn4VHNwjcu3/sAZYYtWiqDnAylhvK1ca7VT3vMt6cQ2yAGtcTpXmUi1My
         uPbutwQGMh8o1GNwihqvqAZ8L5lz6NMpXliGrgXvUKbRJmji1NhAO/m5lYmWHmEQ6kGj
         MZUFAIEISVRig5CxmlVAVqDEwifzKYeZdHFMemmL5TGZX233YhHch88uI4AE+jwFbVRK
         h7AUvOnbfvSEiD9W7jo5NG/HMcnAIZ/Rfi0K7NIgzkuRrqLRJ3ae4l0wKd6QZBjbuiCW
         qJCw==
X-Gm-Message-State: AJIora8BnUbVfMxBWnYpgXxCY75fG9PbRHrVy5g9qEIAqjjvTn0K3P0H
	lTTPFt7Z61gd/2SmCeDtp2M=
X-Google-Smtp-Source: AGRyM1tYpIrxjuPpzOE07YvFbKPSJUQCaVWba8hj+czvnyYP6QaTYSUWIkD1Q3RkjG86hQXOZKoFOQ==
X-Received: by 2002:a05:600c:35c1:b0:3a1:7a5b:64ba with SMTP id r1-20020a05600c35c100b003a17a5b64bamr9435665wmq.33.1657809343670;
        Thu, 14 Jul 2022 07:35:43 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id co18-20020a0560000a1200b0021b5861eaf7sm1617253wrb.3.2022.07.14.07.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 07:35:43 -0700 (PDT)
Message-ID: <922264f1-3a76-aefa-8e5f-2e41a2130b22@grimberg.me>
Date: Thu, 14 Jul 2022 17:35:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] nvme-tcp: short-circuit connect retries
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220714124133.68598-1-hare@suse.de>
 <20220714124133.68598-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220714124133.68598-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_073547_446957_D158E84C 
X-CRM114-Status: GOOD (  23.50  )
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


> When a reconnect attempt fails with a non-retryable status
> (eg when the subsystem has been unprovisioned) there hardly
> is any reason to retry the reconnect attempt.
> So pass the actual error status to nvme_tcp_reconnect_or_remove()
> and short-circuit retries if the DNR bit is set.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 70096a2e8762..4220c1ad6b29 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2065,8 +2065,10 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	nvme_tcp_destroy_io_queues(ctrl, remove);
>   }
>   
> -static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
> +static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl, int status)
>   {
> +	bool recon = true;
> +
>   	/* If we are resetting/deleting then do nothing */
>   	if (ctrl->state != NVME_CTRL_CONNECTING) {
>   		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
> @@ -2074,7 +2076,12 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   		return;
>   	}
>   
> -	if (nvmf_should_reconnect(ctrl)) {
> +	if (status > 0 && (status & NVME_SC_DNR)) {
> +		dev_info(ctrl->device, "reconnect failure %d\n", status);
> +		recon = false;
> +	}
> +

Why should we call this if we need to remove for sure?
I suggest we just change the call-site.

> +	if (recon && nvmf_should_reconnect(ctrl)) {
>   		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
>   			ctrl->opts->reconnect_delay);
>   		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
> @@ -2162,10 +2169,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
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

	status = nvme_tcp_setup_ctrl(ctrl, false);
	if (!status) {
		dev_info(ctrl->device,
			"Successfully reconnected (%d attempt)\n",
                         ctrl->nr_reconnects);
		ctrl->nr_reconnects = 0;
	} else {
		dev_info(ctrl->device,
			"Failed reconnect attempt %d (%d)\n",
				ctrl->nr_reconnects, status);
		if (status > 0 && (status & NVME_SC_DNR)) {
			dev_info(ctrl->device,
				"Removing controller...\n");
			nvme_delete_ctrl(ctrl);
		} else {
			nvme_tcp_reconnect_or_remove(ctrl);
		}
	}
}

>   
>   	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
> @@ -2178,7 +2187,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   requeue:
>   	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>   			ctrl->nr_reconnects);
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
>   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> @@ -2203,7 +2212,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);

This emphasizes that this is a redundant parameter.

>   }
>   
>   static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
> @@ -2229,6 +2238,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   {
>   	struct nvme_ctrl *ctrl =
>   		container_of(work, struct nvme_ctrl, reset_work);
> +	int ret;
>   
>   	nvme_stop_ctrl(ctrl);
>   	nvme_tcp_teardown_ctrl(ctrl, false);
> @@ -2240,14 +2250,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	if (nvme_tcp_setup_ctrl(ctrl, false))
> +	ret = nvme_tcp_setup_ctrl(ctrl, false);
> +	if (ret)
>   		goto out_fail;

Similar error handling here.

	status = nvme_tcp_setup_ctrl(ctrl, false);
	if (status) {
		++ctrl->nr_reconnects;
		if (status > 0 && (status & NVME_SC_DNR)) {
			dev_info(ctrl->device,
				"Removing controller...\n");
			nvme_delete_ctrl(ctrl);
		} else {
			nvme_tcp_reconnect_or_remove(ctrl);
		}
	}

>   
>   	return;
>   
>   out_fail:
>   	++ctrl->nr_reconnects;
> -	nvme_tcp_reconnect_or_remove(ctrl);
> +	nvme_tcp_reconnect_or_remove(ctrl, ret);
>   }
>   
>   static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)

