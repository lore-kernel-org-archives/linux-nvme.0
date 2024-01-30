Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB193C47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 10:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aI8FdwWr+UA6unPLRi+e9uGm3jCVvitpQA/SxnZ52EA=; b=yUHkgMj/QDdpf1i58R6icsZk6S
	FUcCxrAxHd8DVtNyL+GXIPzrFNKivxgavdNo8qNfLcX5qtClLPo94FiAB883o9WuK6rcJyUZKuIIZ
	DsEh54Lfsu5hv9UWpA5yBFWvCfTnaaf7katwY0sPbwmpuSaSEspoMBO1FklXtUSbbIr28Wjk6bVPa
	y2rpbCePi92z1RUr94NLjJpScAkDkFy2nd4s50Tb6Fukc2CCa0EtkrbQfuD5QoF+Us8Srf2LmwI0N
	5D+cmShopk4OtnLfM2e6l9FLUj0DpUrQF9l8jYCHwNsjoaXHVK0EVdWkMYblDKaP5IZg53ICJr7Dd
	0Lpx2ZtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUlpB-0000000GIZh-0GqT;
	Tue, 30 Jan 2024 10:58:41 +0000
Received: from mail-ot1-f49.google.com ([209.85.210.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUlp9-0000000GIZ7-0rxH
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 10:58:40 +0000
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e129ea49b2so240953a34.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 02:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706612316; x=1707217116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI8FdwWr+UA6unPLRi+e9uGm3jCVvitpQA/SxnZ52EA=;
        b=Qv1saYUq+FX0/a8NixYTfOlbF0FpRapke5t/Z743x17q8YD8KPZ8f8fBZPPqKEJG+g
         3cVUFBg5ZMz4UJu4qTdXWDkPPYLTq2e5aXVzllmbvKt4SGrtozQridoGH+3yaR0Pv9ct
         h6oONHKHQU3dKb4F1/JwDnrawuBsvNVfxRmZlmZ0R2jy+mOY9jJwqxlgDgjBmgkyS5aR
         G26Q/XKTWj+A5+MP4OUn5CU+OFmaBA2oz80DdXbP8WSdJkNakE3srYOMRf0ouzwY2Ob4
         aZJBUrLyd9yQ06GVpf2ZOzIWrLgf8Jpv1rYB9nX+vJ1m8P1eL4JFdOjjH+EQBxbJybyZ
         mj/A==
X-Gm-Message-State: AOJu0YyCN1vrAa8tlKfYwjSUV7zuTQO2OiGoQhW+b/jrKWO1oQvy6wrW
	pMrQ/LFx211VFQzN6BPnRvVRjfkqTNE4oiuLjiz0knbQULYL1YY4
X-Google-Smtp-Source: AGHT+IEh9X0XUZtnDsr1MWMwMSI20gc+x/ANa7rhsfaH+iCxWKTuTf/KOarlusmjxXKTF8sfLnlJBg==
X-Received: by 2002:a05:6830:14ca:b0:6db:9bc7:7426 with SMTP id t10-20020a05683014ca00b006db9bc77426mr9692814otq.0.1706612316530;
        Tue, 30 Jan 2024 02:58:36 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n18-20020a9d6f12000000b006dbfafc2049sm1063538otq.30.2024.01.30.02.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:58:36 -0800 (PST)
Message-ID: <6dd1fc75-e5c0-4bde-94cb-b0509a5d8e3c@grimberg.me>
Date: Tue, 30 Jan 2024 12:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme: Add a new exported function
 nvme_request_shutdown().
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-5-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129181953.1183084-5-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_025839_290157_E609262F 
X-CRM114-Status: GOOD (  19.16  )
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


> Sets the shutdown bit but doesn't wait for ready.
> Use from nvme_disable_ctrl(). Export nvme_wait_ready()
> so we can call it from drivers/nvme/host/pci.c.
> 
> Signed-off-by: Jeremy Allison <jallison@ciq.com>
> ---
>   drivers/nvme/host/core.c | 22 ++++++++++++++++------
>   drivers/nvme/host/nvme.h |  3 +++
>   2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a42c347d08e8..13635ef88569 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2215,7 +2215,7 @@ const struct block_device_operations nvme_bdev_ops = {
>   	.pr_ops		= &nvme_pr_ops,
>   };
>   
> -static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> +int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>   		u32 timeout, const char *op)
>   {
>   	unsigned long timeout_jiffies = jiffies + timeout * HZ;
> @@ -2241,18 +2241,28 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(nvme_wait_ready);
> +
> +int nvme_request_shutdown(struct nvme_ctrl *ctrl)
> +{
> +	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
> +	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
> +	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> +}
> +EXPORT_SYMBOL_GPL(nvme_request_shutdown);

I think the name can be better, nvme_request_shutdown makes it seem
that you are actually sending a request to the controller.

Maybe nvme_ctrl_shutdown_start ? or as I suggested before
nvme_shutdown_nowait ?

>   
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>   {
>   	int ret;
>   
> -	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
> -	if (shutdown)
> -		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
> -	else
> +	if (shutdown) {
> +		ret = nvme_request_shutdown(ctrl);
> +	} else {
> +		ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>   		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
> +		ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
> +	}
>   
> -	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1700063bc24d..a3409afbebc5 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -758,6 +758,9 @@ blk_status_t nvme_host_path_error(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data);
>   void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
>   void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
> +int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> +		u32 timeout, const char *op);
> +int nvme_request_shutdown(struct nvme_ctrl *ctrl);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);

