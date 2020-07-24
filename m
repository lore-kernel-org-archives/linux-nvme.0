Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C22C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:15:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9527F206F0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="veHSgfFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9527F206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jz15aSLpDtqN1FejO2MJHxsLLA6rDgcTs09V5kKR9Yk=; b=veHSgfFor9JaL2izO2v3skFW3
	DAM803f1Z3Qrag7UwxI8YkT0k21HjoUOAmQyWxFObTrx8bh4EO4uOKh8pvCY7kJzEAoPow9aPN+G9
	CSQZMUK9zj8TfIv9oP0Uk5RrP3me8t/aIqg7Pi0qsJKmA1DVrNjKvQoLpE5xcM89YdZ0z9foxFmZj
	IQ9CjkInZ2ICFcxAuERtzegz68ZYzwQ4j0osVjmF4+3iZifyEJJS8zs5Slx49JAvKPbgU98ZeZFRD
	x7+slKej6TsS1s7HWYZZQaRePAlsWZsFvrrMJo7QX60rpQdEUhzAPgevbd58JG57sgZmvO2aKx48s
	qIxq7S3PA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6uj-0005Kn-6t; Fri, 24 Jul 2020 23:15:41 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6uh-0005KQ-Fd
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:15:40 +0000
Received: by mail-pj1-f65.google.com with SMTP id gc15so6482035pjb.0
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VDRitduT1+qdBUewpLukFH13LnQAhPmXr59LSsZHuGI=;
 b=bfjY5iYRXggQKnatD0Ge7EDfxeL+bzn5nu50HhB8gpZD8kHQfDjWTGcQb5NH8dl4RO
 wqDRNnlyKKYHYIQgP94RE2UrDWdE75F3zsYQ07YH62LD63EwrevvMwdljTDh3QcDqUU1
 exo0AJNu61DGUq/UpVisRWGeqo8lib3WXLYFJ6a1VPIS5AOym+OBM2K2svz4w6UTXBmB
 OxNcTULloj2uPA+T4vs01WozvoM7uvGU9iLkOkeJ66S7TT0wMVS8ieKHvIzQ9zR3nkTi
 aQ//O50ApyqeSjXmYo6EYp8oGTjv08yHBDX62+sMGVXaRvlEVPAHqCTRrNtiZsBdy5md
 qHTg==
X-Gm-Message-State: AOAM530MmKwAXG27uUy9K+NopdXjfoG4WIACj/u53YV8Ji97kZ0qPVoT
 W9mehjYmHDWyglNu6lpYknU=
X-Google-Smtp-Source: ABdhPJxRivBMCBACk/Swep+B9IFOkaSq6SdiBn2jXKyy0q4la+7I50Tk2c6/avOwmd1mhYb8sYXfgQ==
X-Received: by 2002:a17:902:c206:: with SMTP id
 6mr10567735pll.30.1595632538620; 
 Fri, 24 Jul 2020 16:15:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ac47:9fc4:b59:66fa?
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id q5sm5162962pgv.1.2020.07.24.16.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 16:15:37 -0700 (PDT)
Subject: Re: [PATCH rfc v2 3/4] nvme-core: reduce io failover time
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200724230604.34625-1-sagi@grimberg.me>
 <20200724230604.34625-4-sagi@grimberg.me>
Message-ID: <35c1e22c-38fc-7411-31bc-3a5c583d0dea@grimberg.me>
Date: Fri, 24 Jul 2020 16:15:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724230604.34625-4-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_191539_599011_D6207EC2 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2ae8caa4e25f..e3fae68f7de6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4548,8 +4548,13 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		blk_mq_quiesce_queue(ns->queue);
> +		blk_mq_quiesce_queue_nowait(ns->queue);
>   	up_read(&ctrl->namespaces_rwsem);
> +	/*
> +	 * BLK_MQ_F_BLOCKING drivers should never call us
> +	 */
> +	WARN_ON_ONCE(ctrl->tagset.flags & BLK_MQ_F_BLOCKING);

Woops^2 tagset is a pointer... will resend v3 after I get some
feedback...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
