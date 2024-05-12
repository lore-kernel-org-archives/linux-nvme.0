Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ABDC10F1A
	for <linux-nvme@archiver.kernel.org>; Sun, 12 May 2024 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IOnqh7KNk/j+IDvG4j4HfUg2mkOq0KY3czqD2N8im3g=; b=KHdOPnPM78UxgL3zKkXu+vtsrV
	bQ8PRU0KgJjel95ARezuf/IGND3Y9D7iWfempVl6OaSFggrmoqI5wc5gpbuFBXjn5TSyJ9zce1p1r
	oZQGVO7g/dUKjhun9EjRQPYPLMK7uiJ5/a9tQqvuCYISkeYZGJw9FK/gu9nDdgqnSa37kSPlsosRi
	F6uqqGqCzCb5RIoYWpMGY0JaJ1seTBSkma3lft5zy/25jM/L/LkU74kjbS/T16wipgSU056Evl/oF
	7sNZzlurnWusrlV4Iqw2nEzgNsWypUSglNbQBIqJgbzKqpCiHwoBomPpqxmPWmCOAcZKGx0DB4Yho
	JDzvKkbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s69qF-0000000A3q6-3GjA;
	Sun, 12 May 2024 14:06:19 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s69qC-0000000A3pL-2qA0
	for linux-nvme@lists.infradead.org;
	Sun, 12 May 2024 14:06:18 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5221e161fa4so512115e87.3
        for <linux-nvme@lists.infradead.org>; Sun, 12 May 2024 07:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715522773; x=1716127573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOnqh7KNk/j+IDvG4j4HfUg2mkOq0KY3czqD2N8im3g=;
        b=YV3mxO/8+akHZHZc9sRKJ2dSgNE6Xaa+RbAsmjNEHfiyy4wlIhA75JhqBgbLzO8XTr
         YOj6suii5Zm20ZUf65wtapFwE9QMaaMSgFjBIgGK1P56vAw+X3yPQLd0439k9LbyJYnG
         BTDnG1Gv+WHVYscrTh3J3YKc73DTnp5/fTETU+Y4l9fgppujXrfkX1rD+79HuZKNNHYu
         feccNwA+V4PSUAranAVmS1HUzZ9PwmbGAjLAh4wIIkntuf5tMYGcM39UsObtuUKVr5Ea
         MwT2vvcjFXb2TVZTYfdNUGhbFndWbk5kir83+OxsyfAZMu2BmaL5J71eXZEXAXgMP66U
         TYng==
X-Forwarded-Encrypted: i=1; AJvYcCVFMiLVu2h0Y7gl69F3FPZvMpvLoHZ2Q/9KF54tagWjW+M6uwwNDHptxKC7kinKmCM0mqwYJDdlJGEWu3vUPJ4/W7SU9OfZ/OEzsm+R2go=
X-Gm-Message-State: AOJu0Yy3UYBmgAy9o65r1OklclVvjhYgWXVhZRWcfeJgBVpxstSh1Urd
	2EcFzZ3pkVTN8azv5rXSy07J2N+rnFV527DNdBebe0vHE2XWKPU4
X-Google-Smtp-Source: AGHT+IE2f0WE91SXtwH9gV9ydo13DvyQGGfMwUj37MdFLItZBKpM0u/yB9fp5Ih7OnhYcXHjKGxciw==
X-Received: by 2002:a05:651c:1a0b:b0:2e2:9416:a651 with SMTP id 38308e7fff4ca-2e5205e8545mr54070791fa.5.1715522773074;
        Sun, 12 May 2024 07:06:13 -0700 (PDT)
Received: from [172.21.2.130] ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b2648fsm162940465e9.7.2024.05.12.07.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 07:06:12 -0700 (PDT)
Message-ID: <3d2dc04f-86ee-4802-98f7-fc948e813ac0@grimberg.me>
Date: Sun, 12 May 2024 17:06:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme-core: add a function to submit a cancel command
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org
References: <20240510163026.786898-1-mlombard@redhat.com>
 <20240510163026.786898-3-mlombard@redhat.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240510163026.786898-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240512_070616_858201_4CE753D7 
X-CRM114-Status: GOOD (  21.43  )
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



On 10/05/2024 19:30, Maurizio Lombardi wrote:
> Add a function to send a cancel command to abort the specified request.
> To execute the task, the "single command" cancel action is used.
>
> When the cancel command completes, the host driver will print the
> number of deferred and immediate aborts performed by the target.
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  2 ++
>   2 files changed, 56 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b48967c98114..3d8c31d5f8ae 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2965,6 +2965,60 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
>   	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
>   }
>   
> +static enum rq_end_io_ret nvme_cancel_endio(struct request *req, blk_status_t error)
> +{
> +	struct nvme_ctrl *ctrl = req->end_io_data;
> +	u32 result;
> +	u16 imm_abrts, def_abrts;
> +	u16 status = nvme_req(req)->status;
> +
> +	result = le32_to_cpu(nvme_req(req)->result.u32);
> +
> +	def_abrts = upper_16_bits(result);
> +	imm_abrts = lower_16_bits(result);
> +
> +	dev_warn(ctrl->device,
> +		 "Cancel status: 0x%x imm abrts = %u def abrts = %u",
> +		 status, imm_abrts, def_abrts);
> +
> +	blk_mq_free_request(req);
> +	return RQ_END_IO_NONE;
> +}
> +
> +int nvme_submit_cancel_req(struct nvme_ctrl *ctrl, struct request *rq,
> +			   unsigned int sqid)
> +{
> +	struct nvme_command c = { };
> +	struct request *cancel_req;
> +
> +	if (sqid == 0)
> +		return -EINVAL;
> +
> +	c.cancel.opcode = nvme_cmd_cancel;
> +	c.cancel.cid = nvme_cid(rq);
> +	c.cancel.sqid = cpu_to_le32(sqid);
> +	c.cancel.nsid = NVME_NSID_ALL;
> +	c.cancel.action = NVME_CANCEL_ACTION_SINGLE_CMD;
> +
> +	cancel_req = blk_mq_alloc_request_hctx(rq->q, nvme_req_op(&c),

I know that people discouraged expanding the use of 
blk_mq_alloc_request_hctx in the past, but I think it is warranted here. 
Note that it does not play well with cpu hotplug code (we have the same 
issue with nvmf connect).
> +					       BLK_MQ_REQ_NOWAIT |
> +					       BLK_MQ_REQ_RESERVED,
> +					       sqid - 1);

I think we need to account for a new reserved commands that is now
can be taken outside of connect. Should this be reserved at all?
meaning even if we account for it, there are potentially more and more
requests that we'd want to cancel...

We just seen why not reserving requests for connect is in:
de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")

