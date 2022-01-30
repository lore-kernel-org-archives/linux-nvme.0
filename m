Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A870C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WOiOSq0pCNDJ8h8mVWjMoFo0iJbvwuqJR5/dWo3LauE=; b=RS3ihKGxubLPv5hwlz9MJjFeSj
	d5/Xsxz6hg9XLYuZAS/keqDy/kflEWQncQH9GFG2iEroFsc36BIQFBuOzRbNPLLdhhnKgMweU5H8P
	2zHbw5NXw21XjOqSH942cnouau6FquX9W+5pOttZ9/8Gil7lwb4Jj3G+I/Tx39CgWUo6Gl0Ic80mC
	yyLg1g0VjqMnVoQrQIHHh9v2+47DhAZ6KTUCURKu0FXvWA8se/0T6l/3pVlzcfCLCbo1SUsBz400N
	OFit6nXNa/1bdZgqXTQBx+NMtzju/9xRw7mzv1d/XeMaWVgKvuVO4xZNk+bJa7y5ymFXvaEzcmpFS
	q9q8g+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6oJ-006I9c-6P; Sun, 30 Jan 2022 09:47:51 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6oC-006I7r-It
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:47:46 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 j5-20020a05600c1c0500b0034d2e956aadso7297466wms.4
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WOiOSq0pCNDJ8h8mVWjMoFo0iJbvwuqJR5/dWo3LauE=;
 b=WwDwIxy5AJ+evK1bus8fWVCUV4HCKbB/E/TJVlst01ZODy8LFX4E7E3AbHWrqPUHom
 qe3EwsSnAEtpSKLn97KDwvSAqZ5PLRW0mFqvgujzeaHnSlwt6nui6pvrUIeauvRMML70
 SrFT2h05KKMoFIDWKA65XPXVtxXm16PFybOuuP65aPjG9rp8R/s2D1cJk6aIeKMY3ZP0
 ckCif1Nvc/Ymbygdt3s8hox2nGkTXMjTxbPZHVpwUXYmSKbXv8cOkTtNc2gaRiQvzYU2
 izSWlQVczv1b/t/Go1tGHsbhXxV1Cs3YZ/cx/0Jy/AoKNS0C8oukBVnw/xsFsM+526Lc
 K3XA==
X-Gm-Message-State: AOAM532XirM3tCsRXrQYLA4RYPVVUceHga7mj6xypfAmjKi4r46TPwDT
 B8968z/k7WCwdr5Z7Zj0T/Y=
X-Google-Smtp-Source: ABdhPJwj28xmyQuj56pY0wHs2PiFjCxu3jL+eBEtKjyJFSfjIqc6+KrkbHnNdeGOZPIjIn9yLPfLHw==
X-Received: by 2002:a05:600c:21c1:: with SMTP id
 x1mr14176439wmj.59.1643536062990; 
 Sun, 30 Jan 2022 01:47:42 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l5sm1211062wmq.7.2022.01.30.01.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 01:47:42 -0800 (PST)
Message-ID: <4d067af3-5ce9-8337-efde-6410dff4c904@grimberg.me>
Date: Sun, 30 Jan 2022 11:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-6-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220128092015.19289-6-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_014744_690186_EB1484FD 
X-CRM114-Status: GOOD (  15.85  )
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



On 1/28/22 11:20, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Add and use helper to remove duplicate code for admin tag initialization
> for all transports.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/fc.c   | 12 +++---------
>   drivers/nvme/host/nvme.h | 17 +++++++++++++++++
>   2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 23c896a138a3..ec2afedfa991 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3529,18 +3529,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	nvme_fc_init_queue(ctrl, 0);
>   
> -	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
> -	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
> -	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
> -	ctrl->admin_tag_set.reserved_tags = NVMF_RESERVED_TAGS;
> -	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
> +	nvme_init_admin_tagset(&(ctrl->admin_tag_set), ctrl,
> +			       ctrl->ctrl.numa_node, &nvme_fc_admin_mq_ops,
> +			       BLK_MQ_F_NO_SCHED, NVMF_RESERVED_TAGS);
>   	ctrl->admin_tag_set.cmd_size =
>   		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
>   			    ctrl->lport->ops->fcprqst_priv_sz);
> -	ctrl->admin_tag_set.driver_data = ctrl;
> -	ctrl->admin_tag_set.nr_hw_queues = 1;
> -	ctrl->admin_tag_set.timeout = NVME_ADMIN_TIMEOUT;
> -	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
>   
>   	ret = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
>   	if (ret)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f8658f984d64..6a3fd759415a 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -938,4 +938,21 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
>   	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
>   }
>   
> +static inline void nvme_init_admin_tagset(struct blk_mq_tag_set *set,
> +					  void *driver_data, int numa_node,
> +					  const struct blk_mq_ops *ops,
> +					  unsigned int flags,
> +					  unsigned int reserved_tags)
> +{
> +	memset(set, 0, sizeof(*set));
> +	set->driver_data = driver_data;
> +	set->numa_node = numa_node;
> +	set->ops = ops;
> +	set->flags = flags;
> +	set->reserved_tags = reserved_tags;
> +	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
> +	set->nr_hw_queues = 1;
> +	set->timeout = NVME_ADMIN_TIMEOUT;
> +}

Not sure what this buys us... helper that takes 6 arguments and
sets 2 duplicated values?

