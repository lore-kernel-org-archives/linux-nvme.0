Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC5C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:44:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD06205CB
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 18:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jHIuyN2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD06205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OIvicWIeyjT/ImT5FFuxRwt/f0PJQO/NY3DSmnSi6Ik=; b=jHIuyN2Oj5o+4LHtmYNMQO4Tk
	pRJ2f0fC1NOo8ef6MRfNx4zc4CQyI+8Vzfc+t5eGyfFkhG2EER9n75xVV58EqUwTwldNuXnB4kWO7
	wq/mJ3sfhqfuMMc5ezh88fTKNK6TK3vdu2eIY2JPYEcwnGVtkWBbqSfi7O16a9v5IaBRBl6Ou/dmo
	roiGf2m64Wyjq9Z/C3lC6s7y9KHcTWehgiBfZOqKTY0zxqN/MLfgeAHmMEXZ7IVJrIIvdTyo2w1YB
	TwI7ux6XSmRMyjUM6SkaNWIjD5KCHRv7RregDP134jii24BNZ1Al1D7z/7nNDamUIkKJEtinTsnSk
	BAm4qPwmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6egc-000893-53; Fri, 14 Aug 2020 18:44:18 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6egZ-00088a-MQ
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 18:44:16 +0000
Received: by mail-pf1-f196.google.com with SMTP id k18so4968381pfp.7
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 11:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=njE8crebALjWVh52So1z/xIQubWNkcAy+q/R/THz2So=;
 b=SS0/x0Xu0yzMX+nTpUYBnG4+zKuU91ygaOe2qoJmJaGDjcxrYZ+Y6bOZpUZ44ebQjM
 1DTWDihcc9jLVNQrJwQJEVf0I4MjsPmYsq9bfVlOxvRakjKixAgKUFcmjhz8Whaq2RcR
 JK9iy0YL43qiHnsywlOzYctBotdzVtNhqu6/b2MBcSt/S+P8jj59QG5sW+xq9+LHwRr1
 ejnisTWwAmkJzrAkP4ZxMj5Wt8lxcKadmvqV2ToE/Ns+0yC5zq34g31tyUfzXmW6jggF
 kYLKZJDtdFYnGMhGu+MiYTujyhfLb5zn7/TsUcZMO3r7Z8e1+9SHkPSWee2X4dIUI4wW
 SX5g==
X-Gm-Message-State: AOAM532BASC3INrmZOB+30jg/jywyG167NUo5JYL7avg4oqUKkE7FW4b
 rzL7ulnZZgoq4UcEu0xR/u0=
X-Google-Smtp-Source: ABdhPJz00BAjF6C0ls3TtGPoHIT82zL5INnN6HO2YesiGlDRn/u5EZ72UAEcFrHazCpUBxDGha9ETg==
X-Received: by 2002:aa7:9f92:: with SMTP id z18mr2749067pfr.260.1597430654794; 
 Fri, 14 Aug 2020 11:44:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id h9sm10726191pfq.18.2020.08.14.11.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:44:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: redirect commands on dying queue
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20200814151528.277465-1-hch@lst.de>
 <20200814151528.277465-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02f6276a-bbb5-5185-6a4a-1ac7aa938399@grimberg.me>
Date: Fri, 14 Aug 2020 11:44:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814151528.277465-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_144415_766131_F44BF947 
X-CRM114-Status: GOOD (  21.10  )
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
Cc: Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> If a command send through nvme-multupath failed on a dying queue, resend it
> on another path.

So this is a race where we got a retry-able status from the controller
(not from the host teardwon sequence) and we just happen to see
a dying queue?

I guess that can happen..
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> [hch: rebased on top of the completion refactoring]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8d474adad721fb..271cb9bf29dcd0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -275,13 +275,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
>   		return COMPLETE;
>   
>   	if (req->cmd_flags & REQ_NVME_MPATH) {
> -		if (nvme_is_path_error(status))
> +		if (nvme_is_path_error(status) || blk_queue_dying(req->q))
>   			return FAILOVER;
> +	} else {
> +		if (blk_queue_dying(req->q))
> +			return COMPLETE;
>   	}
>   
> -	if (blk_queue_dying(req->q))
> -		return COMPLETE;
> -
>   	return RETRY;
>   }
>   
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
