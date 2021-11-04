Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98271C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 12:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485476103B
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 12:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 485476103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ej0eWNFisreiLgm5Gx2MavoORrQkFcLnCbVVUJzGCxc=; b=jVBfnvfRpge2nEn9NCi8bRyyta
	tsJBR0dIRNyzsptCIL5/UrmPTr9PG6CjAswVAYOtwhaWgNzfSzNLgSt3tqAI0BeK57oMenFSd+1lB
	PMC2rpqBQprPcmvMYjIfpv26IdO61vUDPt5zu/eWfOmI4oJXdMluayGxv9YDQ3FVXQ9P7qyjksgjr
	8Z4rIXbWOYQX1o77TQwtGKyuxr24XzQpPAVOOQeYh4DstKQuXzI3L3+qhdo5sV7cE89KoCSxQkmC/
	Lk8U+WQJQCGyTvKN/y4TJVJvWZGU+vPoOER/Ksg6h6LuELHgC9eDVf90iV/weU68Ys0FPsqklT2Ro
	KFmuuJ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mibpA-008sHH-Ob; Thu, 04 Nov 2021 12:26:32 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mibp5-008sFM-3G
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 12:26:30 +0000
Received: by mail-ed1-f53.google.com with SMTP id c8so4048268ede.13
 for <linux-nvme@lists.infradead.org>; Thu, 04 Nov 2021 05:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ej0eWNFisreiLgm5Gx2MavoORrQkFcLnCbVVUJzGCxc=;
 b=3NxOL+xq2ucbmyWi5iIXAJoCgCwHtbqelYze4YZIBq9QlqDpZEjkrllocWU5T/lqEg
 Bc9AMaCDDbLdC3zxBcnh7pIrnq1eqbQsiOC4zsaJe2QqbvLR0Y/zersfoqv5kMFurSAj
 02XmX4eEn0svInz3dKus96ddYx3GpmVVF3yMveLmUHz49xeKDPJ6pgwdg7DTeSI95F+7
 BUyQtHpApjh+pnUO0HlF/aT+1iJhWGTtM4qy0eIU51zB7AS8wBS+TRTOai3uCY/CP5T+
 QWUNP4qEcOTH6+fSqaclBumYq3bT2/Dk/jzx/g3kH/VDBcITKUp3S8dKvw5JMLXOkOgt
 Wdgw==
X-Gm-Message-State: AOAM532ZI/g4lrJ6j5FNh4rWBazmNploVbolgd8QgOd9zjJgazEX4Jbg
 FREj2ljd8M+6nScYnXTdZpF80ceCx1c=
X-Google-Smtp-Source: ABdhPJySxMYj6Rtb5+YUqfyYt62DfSDvDu7u3hRF3AURkjqwPx5YIWT55QLKxhyqSgHhym2nvkhf3A==
X-Received: by 2002:a17:906:730c:: with SMTP id
 di12mr60081257ejc.184.1636028784257; 
 Thu, 04 Nov 2021 05:26:24 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id e13sm2470119eje.95.2021.11.04.05.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 05:26:23 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
To: Ruozhu Li <liruozhu@huawei.com>, linux-nvme@lists.infradead.org
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8165ac91-3ed1-f0c4-16d3-7e6741a610fb@grimberg.me>
Date: Thu, 4 Nov 2021 14:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104071332.28952-2-liruozhu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_052627_223980_F7042C3D 
X-CRM114-Status: GOOD (  25.89  )
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


> A crash happens when I try to disconnect a reconnecting ctrl:
> 
> 1) The network was cut off when the connection was just established,
> scan work hang there waiting for some IOs complete.Those IOs were
> retrying because we return BLK_STS_RESOURCE to blk in reconnecting.
> 
> 2) After a while, I tried to disconnect this connection.This procedure
> also hung because it tried to obtain ctrl->scan_lock.It should be noted
> that now we have switched the controller state to NVME_CTRL_DELETING.
> 
> 3) In nvme_check_ready(), we always return true when ctrl->state is
> NVME_CTRL_DELETING, so those retrying IOs were issued to the bottom
> device which was already freed.
> 
> To fix this, when ctrl->state is NVME_CTRL_DELETING, issue cmd to bottom
> device only when queue state is live.If not, return host path error to blk.
> 
> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   drivers/nvme/host/nvme.h | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 838b5e2058be..752203ad7639 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -666,6 +666,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
>   		struct request *rq)
>   {
>   	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
> +	    ctrl->state != NVME_CTRL_DELETING &&

Please explain why you need this change? As suggested by the name
only DELETING_NOIO does not accept I/O, and if we return
BLK_STS_RESOURCE we can get into an endless loop of resubmission.

>   	    ctrl->state != NVME_CTRL_DEAD &&
>   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index b334af8aa264..9b095ee01364 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -709,7 +709,7 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		return true;
>   	if (ctrl->ops->flags & NVME_F_FABRICS &&
>   	    ctrl->state == NVME_CTRL_DELETING)
> -		return true;
> +		return queue_live;

I agree with this change. I thought I've already seen this change from
James in the past.

