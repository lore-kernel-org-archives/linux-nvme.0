Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C96C25B08
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Aug 2022 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECuxpwCDUrgeNoln0VDvjmcGTKomlTzEzl7fPmQcTHQ=; b=i/0HATExWEwKNnRAFn/zMBmGyv
	6sRsrRlnHciQRIfKJSc1QOer1vapR+uSmr/ifvG+sw/vlAfE61xdiEWyAwVUctxpQm3B8jEH/Zn7+
	9DJ1LDgAkPhm/PYgNvLZSwbPE4C5gOM6oYpT+32h6MxotCpqyGpc68qXnxpvnOzEf1WIWCgms0xky
	79nGiJURWetZUnv2jsrBYg0PTfUppKjoTOnq2S4Zb5w4BHgtdKl7KkbJahAD/VFTQt9ITRd3Pd3M2
	RwYVw8NFNFxMgaYnnqBxeQXcFW79TN333a36MQxSHy5nRlXPpgYvvz1qQv64GiwPde9cqYB3Vkxk9
	CmVfcqkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOHDh-001Qfl-5x; Wed, 17 Aug 2022 11:28:21 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOHDd-001QaW-Ek
	for linux-nvme@lists.infradead.org; Wed, 17 Aug 2022 11:28:19 +0000
Received: by mail-wm1-f47.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so1726700wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Aug 2022 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ECuxpwCDUrgeNoln0VDvjmcGTKomlTzEzl7fPmQcTHQ=;
        b=MtPd6BKJFY4XjjDPXc6CpAf+BT3+U2dJzTXSs6kF9KewErrpkVBSF1faWRSJ4y8D8Y
         PxLMrSpE+bgKWwSiogNQ7aTEOvwn3JuUF4ll+Rd50a7bYsxIk8Pmho54U9xDNmgDFcDm
         lS3+l5zTYvuGa6R9p+0BDUL1TW4CJYfBYxRsCXF5//8d7DaVL4jWQDK2eZV6UsZIZk6L
         Crq30BmQgBrLbSuwiwnzM+zaUVJkX87ZLuhweW3iCg3fqC+2MXt20nHKLcF7qCwklMSS
         Gaw4AmYpf0zSqpvebGcz1PJM/qMb5HO6hsgjtUoE27gL74GJleXSdUzKwdLIiyMlRPHD
         XKBg==
X-Gm-Message-State: ACgBeo2FZALu0MPVeiw48w+xG4VWnyINV3n7d6hx7Fjx5aJGlAfrZz8i
	AbvHvR1qlHRFvlNGPihCOjZG1vWRarQ=
X-Google-Smtp-Source: AA6agR64pHq14d2T48t3MHS9Gh4nolUmI2DWAZeE+JJrM/MnqQJ+cOEVvnQqUazGN7sONFxFAgtyZg==
X-Received: by 2002:a05:600c:19cf:b0:3a3:1df6:af0c with SMTP id u15-20020a05600c19cf00b003a31df6af0cmr1817929wmq.37.1660735694747;
        Wed, 17 Aug 2022 04:28:14 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d6da9000000b0022510e8cb82sm6094993wrs.52.2022.08.17.04.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 04:28:14 -0700 (PDT)
Message-ID: <a32bb1f7-921e-1c88-716c-22340d4384d1@grimberg.me>
Date: Wed, 17 Aug 2022 14:28:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] nvme-tcp: Handle number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220812142824.17766-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220812142824.17766-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_042817_546881_66734025 
X-CRM114-Status: GOOD (  39.72  )
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


> On reconnect, the number of queues might have changed. In the case
> where the old number of queues is lower than the new one, we try to
> restart the new number of queues. At this point though, the tagset
> is has not yet been updated and the operations fails.
> 
> Thus, on reconnect only start only the old number of queues, then update
> the tag set and then start the rest of the newly added queues.

I agree this change is needed. The same issue exists in rdma and
possibly others...


> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> We got a report from our customer that a firmware upgrade on the
> storage array is able to 'break' host. This is caused a change of
> number of queues which the target supports after a reconnect.
> 
> Let's assume the number of queues is 8 and all is working fine. Then
> the connection is dropped and the host starts to try to
> reconnect. Eventually, this succeeds but now the new number of queues
> is 10:
> 
> nvme0: creating 8 I/O queues.
> nvme0: mapped 8/0/0 default/read/poll queues.
> nvme0: new ctrl: NQN "nvmet-test", addr 10.100.128.29:4420
> nvme0: queue 0: timeout request 0x0 type 4
> nvme0: starting error recovery
> nvme0: failed nvme_keep_alive_end_io error=10
> nvme0: Reconnecting in 10 seconds...
> nvme0: failed to connect socket: -110
> nvme0: Failed reconnect attempt 1
> nvme0: Reconnecting in 10 seconds...
> nvme0: creating 10 I/O queues.
> nvme0: Connect command failed, error wo/DNR bit: -16389
> nvme0: failed to connect queue: 9 ret=-5
> nvme0: Failed reconnect attempt 2
> 
> As you can see queue number 9 is not able to connect.
> 
> As the order of starting and unfreezing is important we can't just
> move the start of the queues after the tagset update. So my stupid
> idea was to start just the older number of queues and then the rest.
> 
> This seems work:
> 
> nvme nvme0: creating 4 I/O queues.
> nvme nvme0: mapped 4/0/0 default/read/poll queues.
> nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 5 qcnt 5
> nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 5 qcnt 5
> nvme nvme0: new ctrl: NQN "nvmet-test", addr 10.100.128.29:4420
> nvme nvme0: queue 0: timeout request 0x0 type 4
> nvme nvme0: starting error recovery
> nvme0: Keep Alive(0x18), Unknown (sct 0x3 / sc 0x71)
> nvme nvme0: failed nvme_keep_alive_end_io error=10
> nvme nvme0: Reconnecting in 10 seconds...
> nvme nvme0: creating 6 I/O queues.
> nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 7 qcnt 5
> nvme nvme0: mapped 6/0/0 default/read/poll queues.
> nvme_tcp_start_io_queues nr_hw_queues 6 queue_count 7 qcnt 7
> nvme nvme0: Successfully reconnected (1 attempt)
> nvme nvme0: starting error recovery
> nvme0: Keep Alive(0x18), Unknown (sct 0x3 / sc 0x71)
> nvme nvme0: failed nvme_keep_alive_end_io error=10
> nvme nvme0: Reconnecting in 10 seconds...
> nvme nvme0: creating 4 I/O queues.
> nvme_tcp_start_io_queues nr_hw_queues 6 queue_count 5 qcnt 5
> nvme nvme0: mapped 4/0/0 default/read/poll queues.
> nvme_tcp_start_io_queues nr_hw_queues 4 queue_count 5 qcnt 5
> nvme nvme0: Successfully reconnected (1 attempt)
> 
> And yes, the patch per se is ugly, but I didn't want to reorganize
> code at this point. It just an illustration of my idea.
> 
> Feedback highly appreciated!
> 
> Thanks,
> Daniel
> 
> 
>   drivers/nvme/host/tcp.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e82dcfcda29b..177d2f5d9047 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1671,6 +1671,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags))
> +		return 0;
> +

How about we make concise calls to queue starts instead of
making this re-entrant safe... Although this does follow
the same model as pci...

>   	if (idx)
>   		ret = nvmf_connect_io_queue(nctrl, idx);
>   	else
> @@ -1759,12 +1762,18 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
>   		nvme_tcp_stop_queue(ctrl, i);
>   }
>   
> -static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
> +static int nvme_tcp_start_io_queues(struct nvme_ctrl *nctrl)
>   {
> -	int i, ret;
> +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	int i, ret, qcnt;
>   
> -	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = nvme_tcp_start_queue(ctrl, i);
> +	qcnt = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);
> +
> +	dev_info(nctrl->device, "nr_hw_queues %d queue_count %d qcnt %d\n",
> +	         ctrl->tag_set.nr_hw_queues, nctrl->queue_count, qcnt);

No need for this print as info, its just spamming...

> +
> +	for (i = 1; i < qcnt; i++) {
> +		ret = nvme_tcp_start_queue(nctrl, i);
>   		if (ret)
>   			goto out_stop_queues;
>   	}
> @@ -1773,7 +1782,7 @@ static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl)
>   
>   out_stop_queues:
>   	for (i--; i >= 1; i--)
> -		nvme_tcp_stop_queue(ctrl, i);
> +		nvme_tcp_stop_queue(nctrl, i);
>   	return ret;
>   }
>   
> @@ -1934,6 +1943,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		nvme_unfreeze(ctrl);
>   	}
>   
> +	ret = nvme_tcp_start_io_queues(ctrl);
> +	if (ret)
> +		goto out_cleanup_connect_q;
> +

Shouldn't we do the same for the create itself? Is there any chance that
we will leave a tcp connection idle in any situation?

