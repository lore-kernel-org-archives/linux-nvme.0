Return-Path: <SRS0=0R6w=7K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59271C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 15:29:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFD620897
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2020 15:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E49ud5xm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jxYRINII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFD620897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ibRHFZ7WKRcno+9tmluG7KlbRHOaulN05lqq3pHNiBs=; b=E49ud5xmJgfhYOdgjjO7grHiVL
	ja2ryJhbEghDToQNcHx+j8fLnRnDMjRue471Jdy9qDoGF7dastkuW+AlGB3N4LEVg4kD2sC0gaseV
	eu7dAHDhTujzwz3ed9RaUgXb5xfj9q068coeOmpaJGAJwQgqqUJDLRtc4df5D6xWrO/ioTO8kKbT2
	rmJmko4/seuLmO7+d/qUfQG6i2pn87kTCsAO1PR1LdTQWyQz5qDwxdfC11PicIRkVmHqJXStDm7dU
	LQIn05scGQgYmMxT5HtiWGP8P/bawet4VAhFZQqjhDpe2eIIC52OtyWq8VsSgX3bMtGYLMensaBec
	F/JqvCqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jeKTF-0002aZ-CF; Thu, 28 May 2020 15:29:25 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jeKTC-0002Yx-Qc
 for linux-nvme@lists.infradead.org; Thu, 28 May 2020 15:29:24 +0000
Received: by mail-pf1-x444.google.com with SMTP id z26so13678228pfk.12
 for <linux-nvme@lists.infradead.org>; Thu, 28 May 2020 08:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=6hh6aW8X6dPaUqmUNUKIPNGpkpGmHF3l+Ej1630rR7c=;
 b=jxYRINIIuvSu4hsFlBFfH1FE4xWexxwsX1KrxYPcDF/eTTvuvpnSGNTG6NtK8wTdXo
 +2z92bAppPkWjSyz5JqSgIyLYHwdMRjWcd3PYKu0h+rYC6cWPuQ4nv4yU6NuA0715QLE
 tH5zcKQA9BpcjhMLysPMkIaU+1G5Ns3THixRQwB4Mt8s3x+BQ1lJfU5DFvDK+bI9f2KQ
 dnVPZzWPa8+CGL7ykDXY86nSgBliSY82AWsc5Wwz8zOyOXYZvvce/I7PkTYTeUrRTccJ
 HFgVJXx1dVU2WIYvAjBDbhbyubRRIgx7fgw2EJNLiJyeiL/T1VobzGU3RNiheFHuxBC4
 r3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6hh6aW8X6dPaUqmUNUKIPNGpkpGmHF3l+Ej1630rR7c=;
 b=grKfEfdlhMHNzHFl4w97lRat9272hmXK4HN1oUYqaYaSS67l5hzxx2UeRIBO9H0YIo
 xX/+Mtfb95uye4vfzXllvtg/ngn396GEGgo8milr8E9jE8ELvI8wqBva8zoeQQgiR4hW
 nI0ghj0t3sGsTpXRi6vZdkb4xZWu420ofWNclqOOGT3eSoeSzMwnzC+KXmuus+2EYzKZ
 JKlSxjkXhsGOpB1QUygoQaDbUc9RyNLdiuSpbZcyF1xkQfa+cquIn2InmnmmM6j5qW1U
 lGEk1lMHbI7Kdb2VkcvOIT9va/IhyzPEzcLQwqN6dIYL++j8k2fmH9X5sJ4DL131xxwh
 vMIw==
X-Gm-Message-State: AOAM53022ZXR6L0+/4tA+TEu6hxpR2mG6Gp7bn1w5m8LvnVCqn5hgKko
 BXxJF4WsaIGURDV3uJX4hCyHFA==
X-Google-Smtp-Source: ABdhPJz7b1KR9vT+ueAV8UIPrsY2TXg80aHNh2ckVH4KMc5hUGe8XyWk1oCnWvZJ5Bh6Y1ur8UK1Xw==
X-Received: by 2002:a62:15c7:: with SMTP id 190mr3640090pfv.190.1590679755304; 
 Thu, 28 May 2020 08:29:15 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id m188sm5386142pfd.67.2020.05.28.08.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 08:29:14 -0700 (PDT)
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
References: <20200528151931.3501506-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <85d8ac0f-a0fd-2644-d59b-755867ad8b29@kernel.dk>
Date: Thu, 28 May 2020 09:29:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528151931.3501506-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200528_082922_863553_CA10D6CD 
X-CRM114-Status: GOOD (  15.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/28/20 9:19 AM, Keith Busch wrote:
> For when drivers have a need to bypass error injection.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq.c         | 3 ++-
>  include/linux/blk-mq.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index cac11945f602..3c61faf63e15 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -556,7 +556,7 @@ static void __blk_mq_complete_request_remote(void *data)
>  	q->mq_ops->complete(rq);
>  }
>  
> -static void __blk_mq_complete_request(struct request *rq)
> +void __blk_mq_complete_request(struct request *rq)
>  {
>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>  	struct request_queue *q = rq->q;
> @@ -602,6 +602,7 @@ static void __blk_mq_complete_request(struct request *rq)
>  	}
>  	put_cpu();
>  }
> +EXPORT_SYMBOL(__blk_mq_complete_request);

Let's please make that _GPL

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
