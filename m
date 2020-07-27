Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6CC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 18:36:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82EB20729
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 18:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpyLJ77J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82EB20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O1wtOnJUtNZEUIgcxcMJyTXH0EDYSN5P+ga7jLGDXWc=; b=WpyLJ77JT/i4PZqN/ErHw8W+q
	NvtAhGnjfmRBvqOE64ad0tTXhh35p+6wXCOu7CcKmFjBh7pTz76Qkci3pn+ygWWfCeRH/91qDqkce
	4oxTnOBAVHvopb52GuIwgPrO29+PtAXTWvQ+rtZzBJxUEoy3grs9Fzo6CY1fvVMCrG1Bw6N8J5Tdj
	Wn7tbG8swvszXNx8YBAsNVev/Yi869s4XqwDnNiFjmgHxSVLdUW8ASYYExy7uYzTyHd5Gm/6n2mBU
	bFZBXEFH8rs0ZHTqYKskqlkVUjtxvg7C3wgxASfF0uWAIAlyp6YSVVsl0tNlgK6slYr/XYhBhOkKK
	bhrtoRgzQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k07yx-00080T-Bb; Mon, 27 Jul 2020 18:36:15 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k07yv-0007zd-6q
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 18:36:14 +0000
Received: by mail-pl1-f196.google.com with SMTP id w17so8555206ply.11
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 11:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5/iRfyPjaQoajA2PYsWzU8KDtKSbvhWEM8nxkAj9vrU=;
 b=Boroh+/N+bAvYukdO+bcgBl2EgTFb6Ku6Vm9/2zZbsRPCe06cXWyVJyM21VMOuxiDq
 NynSe4biLvnRpQfCj0AJ58EarbMeeZrWqA2p/PZlsWeC6rB08w7KCsSI+LPHYyAv2+Mj
 k88dcqJK8u3HaeY9t4ROfZX1WV7yK5fCfUmQpplhS64PJRqJaYCohtek3e5irOhIkFYA
 NjgHPvZIcjy1XThhQVyv7hOcb4I6qXxX55XZiKQXtS8oilw6WipC6gAhuU3sOyrPa2tI
 lAV5jkdk0uHhtfrG+Jz2QGdv1MHXjVFS5mQ2C5+3JMx2LgaZMnB9st9Vo5a8G+4p1pxX
 Gxzw==
X-Gm-Message-State: AOAM531bua2daL4g+uPJlhcYSg8WT8wPMs5RV8gTaNT1zOVjZsFdL3G+
 mZ+RDJzCPo0mqdMN3iZPLzg=
X-Google-Smtp-Source: ABdhPJxBMbYhr78xpaCXN8tdvoA5GDb1qATLaqyTOrnGO8ZcyQmjQ2Epo+HjB5shx3APQ9K2rol5ow==
X-Received: by 2002:a17:902:b20a:: with SMTP id
 t10mr19269862plr.185.1595874971708; 
 Mon, 27 Jul 2020 11:36:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id h131sm15860736pfe.138.2020.07.27.11.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 11:36:11 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
Date: Mon, 27 Jul 2020 11:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727020803.GC1129253@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_143613_268039_5381131C 
X-CRM114-Status: GOOD (  28.96  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>> +{
>>>> +	struct blk_mq_hw_ctx *hctx;
>>>> +	unsigned int i;
>>>> +
>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>> +
>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>> +				wakeme_after_rcu);
>>>> +		else
>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>> +				wakeme_after_rcu);
>>>> +	}
>>>
>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>> synchronize_rcu() is OK for all hctx during waiting.
>>
>> That's true, but I want a single interface for both. v2 had exactly
>> that, but I decided that this approach is better.
> 
> Not sure one new interface is needed, and one simple way is to:
> 
> 1) call blk_mq_quiesce_queue_nowait() for each request queue
> 
> 2) wait in driver specific way
> 
> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
> then you may add per-tagset APIs for the waiting.

Because it puts assumptions on how quiesce works, which is something
I'd like to avoid because I think its cleaner, what do others think?
Jens? Christoph?

>> Also, having the driver call a single synchronize_rcu isn't great
> 
> Too many drivers are using synchronize_rcu():
> 
> 	$ git grep -n synchronize_rcu ./drivers/ | wc
> 	    186     524   11384

Wasn't talking about the usage of synchronize_rcu, was referring to
the hidden assumption that quiesce is an rcu driven operation.

>> layering (as quiesce can possibly use a different mechanism in the future).
> 
> What is the different mechanism?

Nothing specific, just said that having drivers assume that quiesce is
synchronizing rcu or srcu is not great.

>> So drivers assumptions like:
>>
>>          /*
>>           * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
>>           * calling synchronize_rcu() once is enough.
>>           */
>>          WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
>>
>>          if (!ret)
>>                  synchronize_rcu();
>>
>> Are not great...
> 
> Both rcu read lock/unlock and synchronize_rcu is global interface, then
> it is reasonable to avoid unnecessary synchronize_rcu().

Again, the fact that quiesce translates to synchronize rcu/srcu based
on the underlying tagset is implicit.

>>>> +}
>>>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
>>>> +
>>>> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
>>>> +{
>>>> +	struct blk_mq_hw_ctx *hctx;
>>>> +	unsigned int i;
>>>> +
>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>> +		wait_for_completion(&hctx->rcu_sync.completion);
>>>> +		destroy_rcu_head(&hctx->rcu_sync.head);
>>>> +	}
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
>>>> +
>>>>    /**
>>>>     * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>>>>     * @q: request queue.
>>>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>>>> index 23230c1d031e..5536e434311a 100644
>>>> --- a/include/linux/blk-mq.h
>>>> +++ b/include/linux/blk-mq.h
>>>> @@ -5,6 +5,7 @@
>>>>    #include <linux/blkdev.h>
>>>>    #include <linux/sbitmap.h>
>>>>    #include <linux/srcu.h>
>>>> +#include <linux/rcupdate_wait.h>
>>>>    struct blk_mq_tags;
>>>>    struct blk_flush_queue;
>>>> @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
>>>>    	 */
>>>>    	struct list_head	hctx_list;
>>>> +	struct rcu_synchronize	rcu_sync;
>>> The above struct takes at least 5 words, and I'd suggest to avoid it,
>>> and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
>>> Meantime !BLK_MQ_F_BLOCKING doesn't need it.
>>
>> It is at the end and contains exactly what is needed to synchronize. Not
> 
> The sync is simply single global synchronize_rcu(), and why bother to add
> extra >=40bytes for each hctx.

We can use the heap for this, but it will slow down the operation. Not
sure if this is really meaningful given that it is in the end of the
struct...

We cannot use the stack, because we do the wait asynchronously.

>> sure what you mean by reuse hctx->srcu?
> 
> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> to each hctx for just simulating one single synchronize_rcu().

That is my preference, I don't want nvme or other drivers to take a
different route for blocking vs. non-bloking based on

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
