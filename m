Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC1DC5ACB3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKDElAslwZd7idVxpi80VbM7WIEP/JBTkolb8U8+WTo=; b=A4LW5m/4UZvfoRprBqMIMm933l
	RKqv2ENR2nNaQRo4mV8X4/lAKn8mGb+7K27Eu768i2kXrGtumU0VVpwse4yGnZLvi/itm0vzvpUpu
	CUDwOB1ZqZz5tJrAjyb662UQVv1wS16NEmgYooMLlNa5IiRtdrh+rj753N4trbVVEy6fSiJ5cZ3My
	n6yE20nYjQkBFXjUEIwBarrB7XAyOry2uaaTO/a7JjnsMkGhdkFxA9KUpnZim+lnMnAcHJ+1PssTz
	25s/kSpeT4fs+QfcI9VBARWiV/VgKJYsGtPesFEZgXavc2pMBnjVl+wu2VXo9gqlj1Eg+N9y6/Bq4
	LnRf0nSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Myc-00G7G6-2Q;
	Tue, 21 Nov 2023 09:23:26 +0000
Received: from mail-lf1-f48.google.com ([209.85.167.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5MyY-00G7EZ-31
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 09:23:24 +0000
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50aafe59afaso378669e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Nov 2023 01:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558600; x=1701163400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKDElAslwZd7idVxpi80VbM7WIEP/JBTkolb8U8+WTo=;
        b=avxjW3+z5FBqAVEXDpibEKduNy3uCXrCtdM6hBvL6udy0LMVd6o4v/7Td1tkP0p/9+
         oNAOePDKt66cgxRlgdCgRI9b/urgHj+QzL3TpplDCvySTIi3Vm1RKY8xZKsfSwCOtLRl
         hiutGaMCMPsA7aFRwiyw127XoBgWrmwJX2YNEkYvxLyGAr4XpqY/nz1EkD5Hp1j5KOca
         Au7/Wi3A1RBFo2SQHMlK+yuxSkDr6L2yrnp6nNHj6LA65C0E7OJukcW6rM4nluhSjgVe
         I0KHAepqeJSoIWmyX7LWrFmWGHuFXVN8PBRrixVdYHt7Yw0HmvlHM2QZffE3OidcDXti
         GWnA==
X-Gm-Message-State: AOJu0Yz0M/7OFPXCc6+NW5fzOcKzQ6eDKLFADeGwW64e97IiVZhwG2rL
	ywj/NvHkodgK6oIIxtnpHtk=
X-Google-Smtp-Source: AGHT+IFPZSJfnYNDN4mM2/zfNZUy/Ot4hbYTeyJzuazIzZY7rxwjRWUEFeu/F5ZEG6yZXSX0g6Ajdg==
X-Received: by 2002:a19:ca49:0:b0:50a:6bb5:5e8a with SMTP id h9-20020a19ca49000000b0050a6bb55e8amr5115851lfj.5.1700558599632;
        Tue, 21 Nov 2023 01:23:19 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d49c8000000b0031984b370f2sm13868029wrs.47.2023.11.21.01.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 01:23:19 -0800 (PST)
Message-ID: <be1195e3-2fca-4d68-8222-45f97a72a349@grimberg.me>
Date: Tue, 21 Nov 2023 11:23:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move nvme_stop_keep_alive() back to original
 position
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231121080103.23355-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231121080103.23355-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_012322_976938_4E2DE2B5 
X-CRM114-Status: GOOD (  22.63  )
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


> Stopping keep-alive not only stops the keep-alive workqueue,
> but also needs to be synchronized with I/O termination as we
> must not send a keep-alive command after all I/O had been
> terminated.
> So to avoid any regressions move the call to stop_keep_alive()
> back to its original position and ensure that keep-alive is
> correctly stopped failing to setup the admin queue.
> 
> Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")

It should be folded in I guess. I suggest to either suggest an
alternative phrasing of the patch or resend an alternative patch
set.

> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/core.c |  2 +-
>   drivers/nvme/host/fc.c   | 19 ++++++++-----------
>   drivers/nvme/host/rdma.c |  1 +
>   drivers/nvme/host/tcp.c  |  1 +
>   4 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd28e6b6574c..46a4c9c5ea96 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -482,7 +482,6 @@ EXPORT_SYMBOL_GPL(nvme_cancel_tagset);
>   
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl)
>   {
> -	nvme_stop_keep_alive(ctrl);
>   	if (ctrl->admin_tagset) {
>   		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>   				nvme_cancel_request, ctrl);
> @@ -4355,6 +4354,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
>   	nvme_auth_stop(ctrl);
> +	nvme_stop_keep_alive(ctrl);
>   	nvme_stop_failfast_work(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	cancel_work_sync(&ctrl->fw_act_work);
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 49c3e46eaa1e..9f9a3b35dc64 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2530,12 +2530,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	 * clean up the admin queue. Same thing as above.
>   	 */
>   	nvme_quiesce_admin_queue(&ctrl->ctrl);
> -
> -	/*
> -	 * Open-coding nvme_cancel_admin_tagset() as fc
> -	 * is not using nvme_cancel_request().
> -	 */
> -	nvme_stop_keep_alive(&ctrl->ctrl);
>   	blk_sync_queue(ctrl->ctrl.admin_q);
>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>   				nvme_fc_terminate_exchange, &ctrl->ctrl);
> @@ -3138,11 +3132,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	nvme_unquiesce_admin_queue(&ctrl->ctrl);
>   
>   	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
> -	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
> -		ret = -EIO;
>   	if (ret)
>   		goto out_disconnect_admin_queue;
> -
> +	if (test_bit(ASSOC_FAILED, &ctrl->flags)) {
> +		ret = -EIO;
> +		goto out_stop_keep_alive;
> +	}
>   	/* sanity checks */
>   
>   	/* FC-NVME does not have other data in the capsule */
> @@ -3150,7 +3145,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
>   				ctrl->ctrl.icdoff);
>   		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		goto out_disconnect_admin_queue;
> +		goto out_stop_keep_alive;
>   	}
>   
>   	/* FC-NVME supports normal SGL Data Block Descriptors */
> @@ -3158,7 +3153,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   		dev_err(ctrl->ctrl.device,
>   			"Mandatory sgls are not supported!\n");
>   		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> -		goto out_disconnect_admin_queue;
> +		goto out_stop_keep_alive;
>   	}
>   
>   	if (opts->queue_size > ctrl->ctrl.maxcmd) {
> @@ -3205,6 +3200,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   
>   out_term_aen_ops:
>   	nvme_fc_term_aen_ops(ctrl);
> +out_stop_keep_alive:
> +	nvme_stop_keep_alive(&ctrl->ctrl);
>   out_disconnect_admin_queue:
>   	dev_warn(ctrl->ctrl.device,
>   		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index a7fea4cbacd7..6d178d555920 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1080,6 +1080,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>   		nvme_rdma_free_io_queues(ctrl);
>   	}
>   destroy_admin:
> +	nvme_stop_keep_alive(&ctrl->ctrl);
>   	nvme_quiesce_admin_queue(&ctrl->ctrl);
>   	blk_sync_queue(ctrl->ctrl.admin_q);
>   	nvme_rdma_stop_queue(&ctrl->queues[0]);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6ed794815517..ddcd23fb8b75 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2237,6 +2237,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   		nvme_tcp_destroy_io_queues(ctrl, new);
>   	}
>   destroy_admin:
> +	nvme_stop_keep_alive(ctrl);
>   	nvme_tcp_teardown_admin_queue(ctrl, false);
>   	return ret;
>   }

