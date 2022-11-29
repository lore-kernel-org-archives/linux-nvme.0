Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90985C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=23+PxjMKYNR0aA5BnIqYmQltq0HenPVL+mv767DsNnY=; b=BH8qCtxfJX5AK+gBL0J3juXPp+
	EoFhJDgVOiSjQKElxeqqup6G5F1xWcFvKweobexa9VrHRhDO+VRxyncPmkLOI95o5iEAvsLRVx1Xj
	Y0O/RJYdHc5LAfc60p5H8zYQ99Bf4GxLFLk7Q6KJfViND5wdT8sRn65HJ3xNlRi4UWdQKR3iz31V/
	1PYux0RjrfZXLqKVpfQhaS1RaQWNkFgY/mArcCFa0T6aVUO/e59s2kmdDv/m07JN3GOtbN7FgAfue
	wgvP/OL8TlakkckuSrJhQmbBkY+upTVa+jy0v+6GEvXeehQDq3qYfbWE9H89sz9qcLrXy1hBEDWGk
	0WzQJMcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01eG-009H3X-D0; Tue, 29 Nov 2022 14:31:48 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01eD-009H2J-3o
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:31:46 +0000
Received: by mail-pj1-x1032.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so12135402pjd.5
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 06:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23+PxjMKYNR0aA5BnIqYmQltq0HenPVL+mv767DsNnY=;
        b=7fFa0BS0IvSHfo0zVux6Zov1C1OUTT2/Nmpkuyz7u4TkyOOgyMLqukqCBbsXz/3b7K
         sv09LSDZ50rPbhfD4I27IxwyLYFghEMKE9+TOHYf09Ho8XDt3JQbzPVFrI2LNrYZ50hI
         6lO95ekqrgNz5wMrf8zatWgqjWY9RAHHi1eTodExJj+M2+TAirfUENCDsKIyCsKL34Yz
         /egG9hCjeogJDoiLgdgvfDYl6ddC5vObAb3uY3dhpzq51alsApb9XMXcDu+8AtxjWer5
         pu1edQX0xvEb96lTXgdDY6a1uzsMGD+yDuuak9T9Agxitm5PeSBYfe1NhX8xKzY0dufq
         iSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23+PxjMKYNR0aA5BnIqYmQltq0HenPVL+mv767DsNnY=;
        b=D/joGMMismMzkh7Z43syX+34y9l7ldKT8Ptt/laZUOuqds6jdnnym9Q/Hy2AYqMDrK
         SapzrbLoFiPbUIb55LCouVHE6C5D2jvgv60h3yrbeUpj25ps8XmJiN31H8OvGVpXIC9g
         9CWtEqayFTnYaxmKQD1GRm/ZfeTX6Vkf1aOQa9SSV685ODSO83uwr+tNLeqZIoQm5XGI
         /7/JQlfhtwAqAsg0IZqMVlXj9TTtDG57q0kCt9+rziURqoesZPWlLp6cqAOjm59wLjLe
         9bZDB4t2MffbVvuxmlJ5nXnexkTMpAXG+ve3OnyI6rIXKgFcsXVGx64nYc+fdq8v5IJ+
         ZAVQ==
X-Gm-Message-State: ANoB5pl1dmc0+3+drUi/MhHeRg4qaD7dDjfU/QmuwQWruTwDJz3uaCVK
	Xaay+iB1kHancxSGcJAZ75u8ZA==
X-Google-Smtp-Source: AA0mqf7OsJ6iTMyaJiG2Zb4DenGucSK9gvy3DI3vGMh3rS3LU/Ze4XcTMV9/7UEqPnYFajGo/RuuHg==
X-Received: by 2002:a17:902:cec7:b0:189:8f65:5792 with SMTP id d7-20020a170902cec700b001898f655792mr9133241plg.114.1669732303626;
        Tue, 29 Nov 2022 06:31:43 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h23-20020a63e157000000b00434272fe870sm8484035pgk.88.2022.11.29.06.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:31:42 -0800 (PST)
Message-ID: <a48919c0-a596-8b2d-e2fd-338a4af5cac9@kernel.dk>
Date: Tue, 29 Nov 2022 07:31:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221003094344.242593-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_063145_183029_22164589 
X-CRM114-Status: GOOD (  12.43  )
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

On 10/3/22 3:43?AM, Sagi Grimberg wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9bacfd014e3d..64fd772de817 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -419,6 +419,12 @@ void nvme_complete_rq(struct request *req)
>  }
>  EXPORT_SYMBOL_GPL(nvme_complete_rq);
>  
> +void nvme_start_request(struct request *rq)
> +{
> +	blk_mq_start_request(rq);
> +}
> +EXPORT_SYMBOL_GPL(nvme_start_request);
> +
>  void nvme_complete_batch_req(struct request *req)
>  {
>  	trace_nvme_complete_rq(req);

This really should be an inline. Apart from that, looks fine to me.

-- 
Jens Axboe

