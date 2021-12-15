Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CA1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Dec 2021 20:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYn1ZC4DeuBKxM0V2BD7F1TKYsmbDE4nEOted6fGKI0=; b=EE0jawXYStimQUCf9akcC1unic
	Wd3Fu+LR/K41Oh/JkkBP0th/UrgFyvq75qH0MvNvrmyegh806jgB0t8F86/aqYO9T35Xb+JtYTOf9
	UH0UJFbhohzqiIZiaq3yb1vVJcLeSJF5Ku0SqXfre282baATSPJF0mcduzL7jLLU3S6kxkIZ3a1UM
	rLQtCicwguqtIaURYkeKq+XsqcrJ8VpzplbrdBYQOlql31yYqtrxkmYoTamprDBDxjXhLtmwrHmVJ
	cFXyS/KIXw+0qFlwDuSoRO/dG5PnfrdJb+IuQniBKI1FxYzBsC2g3dbQ/a3RghZpX3oySmRZ8DD/K
	N92fj/Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxarp-002cEC-CU; Wed, 15 Dec 2021 20:27:13 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxarm-002cBw-0D
 for linux-nvme@lists.infradead.org; Wed, 15 Dec 2021 20:27:11 +0000
Received: by mail-il1-x131.google.com with SMTP id l5so20297736ilv.7
 for <linux-nvme@lists.infradead.org>; Wed, 15 Dec 2021 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LYn1ZC4DeuBKxM0V2BD7F1TKYsmbDE4nEOted6fGKI0=;
 b=se+oAFPIed6TNd0+XV9t2qZzZ80RJl8fuRbEqnYd0TaUu09Ie1k/fHYEpH4MW/1Rbe
 oNEBBZcfySoXb/Q1bq2LaacVcb9KgoRIHsDl4yoO03POJLU7Fx/JJJvuz1Df1PRtsB3P
 CgOG+mHa1UK/BmvfCAVsWWYE6BWJkwzMtcYWEbjRW99aSE8axodOyvaXSbsOaXhOS870
 EB0PgrAsF7j86zFD8Qrql46YS4LsL3yVzJwtGhk04gMSh9Zu0Nvcuooqp7SZYAN4gGle
 dv7HThoMfhUWvyoqQEu9KVabscD95IW3lK9zETG8sdQryQcP882B26S/Q94Va3wbyrAQ
 z30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LYn1ZC4DeuBKxM0V2BD7F1TKYsmbDE4nEOted6fGKI0=;
 b=LwKUDTVYIyIF1a0a73nrGsFcejl5tPMGha5TCPhjJVDF9GpOcqKq1VIIVitSTMWVUG
 aitO0aKtpzECYJpPOoYZPXUySZTCuhr5o6jtuIEa0WNTFIfYROBriMUKBxJPIPdAlsHb
 bIGB43AszUTCgPZl9tp1i4If3mRxq58BuipMLIANPSRN5xpNR1uCOksM6+Il0HoozVBP
 xJdgIpECQmwW5uFz2017obSJGFjeFAy2xxvAsuP5x0Vp2pv/uiZxpLaUyFwZQbcHkEkP
 3s4UrVU6uDu8nERdGsDe+8QeXkuZRtEguQYswI3fwoqq17O4fNAWOchtR7wMqL3r6FNM
 2M6A==
X-Gm-Message-State: AOAM530mKs5enwaoGwVUi+hoqQVp4lOggf6/ZsHy9uzB/1lD8bLJNRWp
 xas5Z3oImjbAEewV1AdTChg+vOuIptmkpA==
X-Google-Smtp-Source: ABdhPJwL0sALDY0MBYeyDEG7RYyYRKxrVtN1yVtKOAk3BO7u9LJ/x6SYjPmmzOyFScZhQGgNR/lquw==
X-Received: by 2002:a92:d992:: with SMTP id r18mr7350460iln.224.1639600028666; 
 Wed, 15 Dec 2021 12:27:08 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id r14sm1575628ill.70.2021.12.15.12.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Dec 2021 12:27:08 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Keith Busch <kbusch@kernel.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk>
 <20211215172947.GB4164278@dhcp-10-100-145-180.wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ac9c7c9f-0b7f-12ea-38bb-b3b9279c8baf@kernel.dk>
Date: Wed, 15 Dec 2021 13:27:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211215172947.GB4164278@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211215_122710_083112_0088B82F 
X-CRM114-Status: GOOD (  26.91  )
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

On 12/15/21 10:29 AM, Keith Busch wrote:
> On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
>> +static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
>> +{
>> +	/*
>> +	 * We should not need to do this, but we're still using this to
>> +	 * ensure we can drain requests on a dying queue.
>> +	 */
>> +	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
>> +		return false;
> 
> The patch looks good:
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks Keith!

> Now a side comment on the above snippet:
> 
> I was going to mention in v2 that you shouldn't need to do this for each
> request since the queue enabling/disabling only happens while quiesced,
> so the state doesn't change once you start a batch. But I realized
> multiple hctx's can be in a single batch, so we have to check each of
> them instead of just once. :(
> 
> I tried to remove this check entirely ("We should not need to do this",
> after all), but that's not looking readily possible without just
> creating an equivalent check in blk-mq: we can't end a particular
> request in failure without draining whatever list it may be linked
> within, and we don't know what list it's in when iterating allocated
> hctx tags.
> 
> Do you happen to have any thoughts on how we could remove this check?
> The API I was thinking of is something like "blk_mq_hctx_dead()" in
> order to fail pending requests on that hctx without sending them to the
> low-level driver so that it wouldn't need these kinds of per-IO checks.

That's a good question, and something I thought about as well while
doing the change. The req based test following it is a bit annoying as
well, but probably harder to get rid of. I didn't pursue this one in
particular, as the single test_bit() is pretty cheap.

Care to take a stab at doing a blk_mq_hctx_dead() addition?

-- 
Jens Axboe


