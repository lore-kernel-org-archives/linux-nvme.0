Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67089C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:13:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EC62072E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xfmiLkLI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mE+igJq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EC62072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zeTDfCAqRe02638JWVl5J60rLNOH7glS0Rs9GmTU6HE=; b=xfmiLkLImxKCDc2DIs5a0pymx
	4BFjzXLC+qPjaj4F+jNyMn9XSSk9fhS9/qjpMneAVx1ObMv/C4jwwdkOCmmnDftK0nnsjNKgRcKLU
	QFqEFtk964LNjFVj+m/urgfwz3KwIdCFstpAN82Rn0M6YprLiOcP+qQvpC9NznN04tZ95F2VJOI4a
	MK7AnfSH2y3FAfa7Mhdkizz8gYrSyeqXiZIghAuEr+kucl9a6veCbROgxHaKYFPPfK0MFWgTb/Mfj
	yatziJ3YrLgVBhrIVzM3LJYokMXfHBs9uTWZ3WaFR4g9tygBTEMVpXt3DApyOQTuqgT2+6xVgjutK
	BkGVPN1Uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0BNK-0006IC-QC; Mon, 27 Jul 2020 22:13:38 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0BNI-0006HX-4u
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 22:13:36 +0000
Received: by mail-pl1-x643.google.com with SMTP id m16so8896555pls.5
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6a95zXSN/3Ne4hUmXR/5l/w4mugoC555WVp08JuUcsM=;
 b=mE+igJq0yQSPQ5HU1MFiLoThv1VoxQy0O3MKpHebvgVqbBGaAPDUiyXMdy0wbVc116
 Mb+4CNOOWX9c+uUyJj9emhcqrrf9AQrtUSvmiZk4yr0Ym+NU06kYKBPAfKkk1swidG+G
 rEbDSB+XCbTCwxulH7YEV2UCTyt9tmQMszVhV/lJTjyr+uiCBBA+Dx0YN0WevgBJxGfs
 1CCfa10xqCsE7hNCUBZDQ0IJRAkP8tZyTotzknCLTkJ0L4LQnbt+gzSW71/LouVAZnk5
 aZg1VbCB5TqJkICr/SQVU3Sank/QINcSANug7RiULbXN6/4TzXAAE0iwvS/R1gHdNY5n
 WaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6a95zXSN/3Ne4hUmXR/5l/w4mugoC555WVp08JuUcsM=;
 b=jemXzyeNy+6Q2HviRKDbdkqHGpZAUqk8y4MSgUzpqbrchwJzsDLMwYRoktrIeZRhM1
 Pv03jZgFvLqn9pZyApzPnnSs9BrbKszM7D7Kcg7swu9MflyADQlUixFn5zSnDLD4u2SI
 mpASgwbDRGKTliEPUZbjfmWDj+SvwesQAhpSl+Kn/onUV8XilMBnRus+Nspq29b26uYK
 p0rA0R5fsgKq9SBOwjSYCu9S3TlIxpPi0LtCBKodrI+6su9pkesIa0AZ5WvAtjepSoem
 CJtWHZyXlZxX5IOKDe65cReK/3xdv9FS1W3CioqjFgXAEj+219gSGtetUz/0M+SwMr2H
 N+iA==
X-Gm-Message-State: AOAM533lNhQiKnDuaa94iwjnLpvK3+t2/x8hidL6lWwsloosm50pwJw+
 GitXhILVOYxWJCxQpzkFYlBNOg==
X-Google-Smtp-Source: ABdhPJzJ/ebKlyaHGQl6M67GcDmNahnW3IwGWH/CFCfLw+j478VPPMhzoQ4X3/l1B6myJW7X7YI8QQ==
X-Received: by 2002:a17:90b:350f:: with SMTP id
 ls15mr1330378pjb.84.1595888012995; 
 Mon, 27 Jul 2020 15:13:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id r2sm15878201pfh.106.2020.07.27.15.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 15:13:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] blk-mq: add async quiesce interface
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200727220717.278116-1-sagi@grimberg.me>
 <20200727220717.278116-2-sagi@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fe247bae-8428-bca8-81b5-a7015bc39591@kernel.dk>
Date: Mon, 27 Jul 2020 16:13:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727220717.278116-2-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_181336_215187_9FC9C224 
X-CRM114-Status: GOOD (  25.65  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/27/20 4:07 PM, Sagi Grimberg wrote:
> Drivers that may have to quiesce a large amount of request queues at once
> (e.g. controller or adapter reset). These drivers would benefit from an
> async quiesce interface such that the can trigger quiesce asynchronously
> and wait for all in parallel.
> 
> This leaves the synchronization responsibility to the driver, but adds
> a convenient interface to quiesce async and wait in a single pass.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-mq.c         | 46 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  4 ++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index abcf590f6238..d913924117d2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,6 +209,52 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>  
> +void blk_mq_quiesce_queue_async(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +	int rcu = false;
> +
> +	blk_mq_quiesce_queue_nowait(q);
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
> +		if (!hctx->rcu_sync) {
> +			/* fallback to serial rcu sync */
> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
> +				synchronize_srcu(hctx->srcu);
> +			else
> +				rcu = true;
> +		} else {
> +			init_completion(&hctx->rcu_sync->completion);
> +			init_rcu_head(&hctx->rcu_sync->head);
> +			if (hctx->flags & BLK_MQ_F_BLOCKING)
> +				call_srcu(hctx->srcu, &hctx->rcu_sync->head,
> +					wakeme_after_rcu);
> +			else
> +				call_rcu(&hctx->rcu_sync->head,
> +					wakeme_after_rcu);
> +		}
> +	}
> +	if (rcu)
> +		synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);

This won't always be async, and that might matter to some users. I think
it'd be better to put the fallback path into the _wait() part instead,
since the caller should expect that to be blocking/waiting as the name
implies.

Nit picking, but...

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
