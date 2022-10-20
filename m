Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1354DC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIE4tVkAl/8OtkJR94qMxzahBylE8N8vF8eOxMPkUwg=; b=GTOa9HHpbe2s0Y5GorOxnbq0/m
	4YJ3PdHs1jI2JLqj70dM/9BHotf2istBa2bcZuMgeQd87PjaSIFOrci8WUvqd3l4ON3PGKtq8wBpZ
	p/0E+bmEvK72hJRoPHwhXnP8+RRMbLNb+6So15Sslne1bs2dieSXH6iYQKlPObFc+V/4B6dUdJLMl
	pKZc0G+nJFeqhxfjoBpiR0Cxil4nxdCgrI2LrslxnxMrpEzd0ULIOtdHVjcwXge+n0AVE4tlcCbuU
	fx62ZHYQizgwlvG2hdLFkn5dbRvE0FZWxcFJ9ykncg76T1NhZRNz5OwlZCDjvXVzJ/PdKJEX9TbAI
	AtwGuFxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVW5-00FPXC-FP; Thu, 20 Oct 2022 13:23:21 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVK0-00FIC2-VC
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:10:55 +0000
Received: by mail-wr1-f54.google.com with SMTP id u10so34379551wrq.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIE4tVkAl/8OtkJR94qMxzahBylE8N8vF8eOxMPkUwg=;
        b=B2pSOUgDUv93jZlbqFE5DZZFspI8khVSdDZamvrIejzINg+fqT5sqa/OHr+e6c++Lq
         EEnV8nGzNffjJ+1c+s8xJgx82wuAxYavTq2/lJPwn6g2oZQOPjVT8cswcauSnVFjgLaI
         dSJJU2Ae5qopSnTl614K3KDH9pyJ9K7x1XLVWVlevaQxAwGJEDEFE4C9XeJb4XAvlAVk
         zqaSGL6xE+hghPeI7eNt79DLj3vr5BVifhkdBRLBQd43NNfTO7kHO89DHov6qd1cY6px
         GNyOek3/5yhAbNbIcFVWnJv5LLGeDu75nvWwY6pztKo1PEGkzKdVspa+fHksmKnG/DI4
         Kc5w==
X-Gm-Message-State: ACrzQf1pFTvSvIWKbdASDw65LMPrZW64KCmL6q1IFYuNvQiLTi/4ATak
	crRCN7wTcd3Hu7SMq/sJ23U=
X-Google-Smtp-Source: AMsMyM5J+mYFaEbKwV+/XSzQKfWt6EmJQNjgkG3sHp/yWz21+2H1+HgE2q3N7AJSpbPK17XxATrYEA==
X-Received: by 2002:a5d:598d:0:b0:231:2304:3a5a with SMTP id n13-20020a5d598d000000b0023123043a5amr8734785wri.434.1666271450723;
        Thu, 20 Oct 2022 06:10:50 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm19907804wrq.72.2022.10.20.06.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:10:49 -0700 (PDT)
Message-ID: <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
Date: Thu, 20 Oct 2022 16:10:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-8-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_061053_090073_AE14F1E6 
X-CRM114-Status: GOOD (  22.22  )
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


> This helper is pretty pointless now, and also in the way of per-tagset
> quiesce.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7fdb744979c..0ab3a18fd9f85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5104,17 +5104,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   		blk_mq_wait_quiesce_done(ns->queue->tag_set);
>   }
>   
> -/*
> - * Prepare a queue for teardown.
> - *
> - * This must forcibly unquiesce queues to avoid blocking dispatch.
> - */
> -static void nvme_set_queue_dying(struct nvme_ns *ns)
> -{
> -	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> -}
> -
>   /**
>    * nvme_kill_queues(): Ends all namespace queues
>    * @ctrl: the dead controller that needs to end
> @@ -5130,10 +5119,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
> -
>   	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> -		list_for_each_entry(ns, &ctrl->namespaces, list)
> -			nvme_set_queue_dying(ns);
> +		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +			blk_mark_disk_dead(ns->disk);
> +			nvme_start_ns_queue(ns);
> +		}

I have to say that I always found nvme_kill_queues interface somewhat
odd. its a core function that unquiesces the admin/io queues
assuming that they were stopped at some point by the driver.

If now there is no dependency between unquiesce and blk_mark_disk_dead,
maybe it would be a good idea to move the unquiescing to the drivers
which can pair with the quiesce itself, and rename it to
nvme_mark_namespaces_dead() or something?

