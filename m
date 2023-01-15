Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FC7C3DA78
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Jan 2023 19:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FK7oFFeq5Tw8xgXsLAU8hzzS7+19YkOI46ZEBSY7QKk=; b=HT8jLrrLNh1I/UntK/ySZ08b97
	ru/YNMO06bG988zb7yzVXWp80JgGXlW1Mlm4+1x+cQL4T9LdxLimoiuJX35af5jPb0q9D4e5NnJFX
	Mrij83y35BEhPBr7LZt4wAMjiD06Od4ls3H6LzaBkG1HQh7kXhS9CaNc1s2gXNlvMmrCWS0umjjDe
	c1Cd+F9rt+HWrBMpMphv0S3JV5W42xTTVtKJkdJ+afoH0ny5EajdEVMTqEZcOtvXcu8yD7XnaLVSM
	EpYkPrSeWZBtStcmthfWsDD3f0O1tgxxn7SNo0FOfgKd3q0YKTrU3OAqOVcch+sYQM8yXkH9aYQo1
	h6G5Yoew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH92z-007ryy-1f; Sun, 15 Jan 2023 19:52:05 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH92v-007ryA-SL
	for linux-nvme@lists.infradead.org; Sun, 15 Jan 2023 19:52:03 +0000
Received: by mail-pj1-x102b.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso27443777pjl.2
        for <linux-nvme@lists.infradead.org>; Sun, 15 Jan 2023 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FK7oFFeq5Tw8xgXsLAU8hzzS7+19YkOI46ZEBSY7QKk=;
        b=mdlaCbQRTDiTMgHNbzNaomwP/pCxBw5qA72tS1ZRkEM7emg5/vIOix+HXIXwQSs5iv
         jY37JCVxh7alAWvov0Hj15xmQa2BRJAmal0nUdqCWfBeT7zlu9aCZowEKX8nOkDV5Frw
         vKtg+MODuhkXdgOWw9Gbs6D5wOO1n2cJaH2BkmJ99kY8JsndR9BY2sv8Fi6eIY64SYLO
         kTqTN+rdtLmXewaOTP44GxAOrQkzo3flVeBaJhogBFIgNMAnFqyjVWjT3q3bXi88/dAE
         PyLX+OHRBkgK105Ge8qpnHpaCqHfPPQJFHSr8H1rWdyN6wVGqeICK9xQLxnXPJOM+erX
         TC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FK7oFFeq5Tw8xgXsLAU8hzzS7+19YkOI46ZEBSY7QKk=;
        b=5x5XxS01YExwrQS1TXfxuryMD4eyPtC587bUb++y/Uxt8WIMNz+ELI8B5suVOjBDRq
         GFnmEk/S9P4NZNoIUv8gQkhArjlPmLXpap3Ppvy1YhzNZx7LVqfwoBHj5oYjDTmV6bA0
         o2urgMcAfkbrBn3vSz3tNHAr2a8D5BGGKUfVpAbpW2/Fk/DPCfBAMiiG2h8h958Lhd4D
         lPZH8xyCDssrDwy2u4WFTMX3bNVtz3nhEKfJnnuig983axZXrO3GH8dfdzEgTn3nBp+3
         Wz1Q2l64mzywbOa9q2DdUCzelcCJxzckHrrbWgRj3YqgoDjdIzqtKBYIZAz8q3lHI3Lc
         SLBQ==
X-Gm-Message-State: AFqh2kpBnk2R/jBB29ZmfI1efEgy2XHuCc3WmzLJKcidb/TGXnSCoWjD
	JJqmSMnJp6d7Y8IHqUihDCNWdGYssY0=
X-Google-Smtp-Source: AMrXdXs/Gy6QUPswQaLrvV4s6zrt1RO4/BeIY4dzKJmuAgBFRGX7h6FJjFbp+dXIcHeSwvg3mwNdFQ==
X-Received: by 2002:a17:90b:344b:b0:229:3f14:8bdf with SMTP id lj11-20020a17090b344b00b002293f148bdfmr7305392pjb.14.1673812319482;
        Sun, 15 Jan 2023 11:51:59 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a4c8400b002261ea8ac4fsm17310068pjh.13.2023.01.15.11.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 11:51:59 -0800 (PST)
Message-ID: <9fbdb00d-4d79-04eb-c986-814a5e1f9212@gmail.com>
Date: Sun, 15 Jan 2023 11:51:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@infradead.org, kbusch@kernel.org, sagi@grimberg.me
Cc: israelr@nvidia.com, chaitanyak@nvidia.com
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230115100341.40347-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_115201_985229_14C1F31F 
X-CRM114-Status: GOOD (  22.69  )
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

On 1/15/2023 2:03 AM, Max Gurtovoy wrote:
> The check if the connection request matches an existing controller is
> duplicated in several transports (such as RDMA and TCP). Move it to
> common code as optional operation.
> 
> Also, this check can be done before creating the controller to simplify
> the flow.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 7 +++++++
>   drivers/nvme/host/fabrics.h | 3 +++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index ce27276f552d..3d5035331b9f 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1100,6 +1100,13 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
>   	if (ret)
>   		goto out_module_put;
>   
> +	if (ops->existing_ctrl) {
> +		if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {
> +			ret = -EALREADY;
> +			goto out_module_put;
> +		}
> +	}
> +
>   	ctrl = ops->create_ctrl(dev, opts);
>   	if (IS_ERR(ctrl)) {
>   		ret = PTR_ERR(ctrl); > diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index a6e22116e139..587b92575a9b 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -153,6 +153,8 @@ struct nvmf_ctrl_options {
>    *			that would go into starting up that fabric
>    *			for the purpose of conneciton to an NVMe controller
>    *			using that fabric technology.
> + * @existing_ctrl():	optional function pointer that checks if a connection
> + * 			request matches an existing controller.
>    *
>    * Notes:
>    *	1. At minimum, 'required_opts' and 'allowed_opts' should
> @@ -170,6 +172,7 @@ struct nvmf_transport_ops {
>   	int			allowed_opts;
>   	struct nvme_ctrl	*(*create_ctrl)(struct device *dev,
>   					struct nvmf_ctrl_options *opts);
> +	bool			(*existing_ctrl)(struct nvmf_ctrl_options *opts);
>   };
>   
>   static inline bool

Reviewed-by: James Smart <jsmart2021@gmail.com>

A bit disheartening we're "commonizing" in manner that FC can't 
participate.   I looked at FC supporting this, and although it could, 
it's a bunch of code duplication, more code than leaving rdma/tcp code 
in w/o optimization, and FC still has to repeat what it does in 
controller create as there are other checks to be made. It's more 
optimal to leave things as is on FC.

Max: mind pinging me ahead of time when creating these common items so 
we can get the 3rd transport participating if possible ?

-- james


