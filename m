Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E43C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oZusonizB6ccImUlS0jDsNTW4mE+ew+Gpq1Jl1P+Gy4=; b=H36RAXjXBBCU6sr5OCWXDBfiYV
	m70LLqHbv5XzkKAaNTTAnqcACr+QSDktQI/vy3+VKOtYLievoiQeslW+Uw0UWz47c8qBZxF5aZtjn
	ciL8KsnFTh3RYNpAfymhmBsjG+ZYhfRbUX/j5nXdh5u8KRr8ZeXN6IKAq/PL27ckIW27xBngC75Cj
	U4KlkvzKPEQ4foK3iLuicWts10fqjSVMNy6A0FlkcpP3zL9ONKc7ZjU6VO/4isHHbz3ksD/zAIYVw
	BBkW+GPo77y7NBl3OkACsy/eTsHRcJLzBsFD25oocPmptigNnuk9rgcUFaybbUdvZxv4CdSsuJsSj
	2f9yVZpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9PAL-00ATXq-Sh; Sun, 25 Dec 2022 11:27:42 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Osj-00AKSf-KB
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 11:09:31 +0000
Received: by mail-wm1-f49.google.com with SMTP id l26so4664585wme.5
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 03:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZusonizB6ccImUlS0jDsNTW4mE+ew+Gpq1Jl1P+Gy4=;
        b=5VIsizhHpgA4KZ1yqq+Ahx3uEtd893GhCAKRLLQNxUoUwg+s++6cH9+S5S+yZwOUlR
         gz6LkENt0le6HP2w0xl7M69SuYtu6Zqul8SfMk05haJRkzOz2dJ2UKcLj3+jvU5oDD01
         ut5n1VsYOJMV+MQeajn5mYHKVlWU89kZtK3OJunCm6YOZkrEpvXkLQuTLLMFJQRe0f7A
         7ZnTOF2KZljBXtqct5wlsO0OxrGyrsfzZkT+HrT7q+61oKVo7TsXsDo1arCnC6ICtgAG
         QhMiVXb7UiqqIilDWhSKqQP7x7umqacHV3DE/U1mloI1dyDRdG6yj7/Ocz3qG9leQMqX
         /YXg==
X-Gm-Message-State: AFqh2krcKWxV80zbwcfPlCEFXx47OHd26lwG2UPK7tmNhafO2RtP+KS0
	4itOVNmRIS+STmcAPJQlNFM=
X-Google-Smtp-Source: AMrXdXtpg1GGgD8/oOySIWSbsklMbi67qBwzOqoyJv+/kKhXFzlFuYjxZwpaw48VkgAJ8O9OLXyomA==
X-Received: by 2002:a7b:cb89:0:b0:3d2:2101:1f54 with SMTP id m9-20020a7bcb89000000b003d221011f54mr11229982wmi.4.1671966565908;
        Sun, 25 Dec 2022 03:09:25 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b003b95ed78275sm11116473wmq.20.2022.12.25.03.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 03:09:25 -0800 (PST)
Message-ID: <b5dd5c24-9bab-3b5e-a4a0-e1f9b1ea8998@grimberg.me>
Date: Sun, 25 Dec 2022 13:09:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] nvme: store the actual queue size in ctrl->sqsize
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>, Hugh Dickins <hughd@google.com>,
 linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221225103234.226794-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_030929_748724_72C26CAE 
X-CRM114-Status: GOOD (  16.13  )
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



On 12/25/22 12:32, Christoph Hellwig wrote:
> Convert from the strange on the wire 0s based value to a regular size
> when reading the filed to avoid adjustments all over.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/apple.c   |  3 +--
>   drivers/nvme/host/core.c    | 19 +++++++++++++++++--
>   drivers/nvme/host/fabrics.c |  2 +-
>   drivers/nvme/host/fc.c      | 12 ++++++------
>   drivers/nvme/host/pci.c     |  4 ++--
>   drivers/nvme/host/rdma.c    | 23 +++++++++++------------
>   drivers/nvme/host/tcp.c     | 12 ++++++------
>   7 files changed, 44 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index e36aeb50b4edc1..073a1e8c021c14 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1080,8 +1080,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
>   	writeq(anv->ioq.tcb_dma_addr,
>   	       anv->mmio_nvme + APPLE_NVMMU_IOSQ_TCB_BASE);
>   
> -	anv->ctrl.sqsize =
> -		APPLE_ANS_MAX_QUEUE_DEPTH - 1; /* 0's based queue depth */
> +	anv->ctrl.sqsize = APPLE_ANS_MAX_QUEUE_DEPTH;
>   	anv->ctrl.cap = readq(anv->mmio_nvme + NVME_REG_CAP);
>   
>   	dev_dbg(anv->dev, "Enabling controller now");
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cda1361e6d4fbb..f2b7bb8bcc31fa 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3242,7 +3242,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>   		return ret;
>   	}
>   
> -	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
> +	/* CAP.MQES is 0s based */
> +	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap) - 1, ctrl->sqsize);

Shoudn't this be NVME_CAP_MQES(ctrl->cap) + 1 ?

