Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1528EC433E3
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 16:28:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E8C2065F
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tSHlWhhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E8C2065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iphnzKnH8YKNXe+hcvq4Ax/C7p16dGwpQLL9KxUgBVI=; b=tSHlWhhMrmsljIbx8DyhUxbwX
	AxqORtCrzvLTm6SPOnHJnfJpyjObFfC9Azodxtw51y28EZZRMYlVgD7wm4fzk8XfWQKJkwxlt0l3v
	RuRs+J72GxDnVWkMbNYoH+RK+DVorWcV5EyNyiedhJzTKz5H6JYE8z09Ei3F2JiTRc2YY0XCwyJ8o
	SVLoLGc9zBd9CpolggBqohNCHJDTTaKngGwjJQ5YEj0OOvEHKvpFd705/TMALOjFIYnYwC62WrZgR
	2kab22lNXb2oKisi6BPrCCEkIABSVSachfgx4n9ajCMsz+0fSNu7PctXVwC9FCZ3mwh+NE+WCD6Zw
	AX2ZVd6Fw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzjVJ-0007Do-CC; Sun, 26 Jul 2020 16:28:01 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzjVH-0007DQ-Fc
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 16:28:00 +0000
Received: by mail-pl1-f195.google.com with SMTP id x9so6859425plr.2
 for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2020 09:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f9UHPTEDgofQBm9+ddcwo7E6t/wi8mG2HVW4ymePihg=;
 b=XTI7xjuy9aE+vvF/b4mPEYTRhZ6YAHuuLApigBcgp5y2BbZ4lFKSca7mMc9JBnyzd1
 7bc1q5iE/3zM4RsJj07A06x8v9oPz2olBKSj4w47x+2xM5c860gWXcqq85utWGlt+fkN
 T0d1rGbZy9FGoQOcDm3Cxmq4Cr9TO91K1n72WBU8zjDysex0Uj+V15CnbLwX5wv2wCOG
 N4yPOi8CTN9Iv2a8CuvTU1kL3PKN0vLTANV6CDMEaNixDd5GndJL8ar6AtphXHXhJItd
 10kRt7FBgJ0mrxZreHfc1Ap3MBvmDu4gbdVffQhzYPV3xXux9UsJuTRFnMPeYad5e8Wj
 EY3g==
X-Gm-Message-State: AOAM530WDJavdzTCGKq8kAEi1kZWqQN0hc7EvJa+0ZM8bd9mO4qHv9SD
 Xv7XF0mF2zUgxXyJqM+Kkfo=
X-Google-Smtp-Source: ABdhPJwEjvjDAiFfq6ZwfROrx1GzWMZV2Q8/Vu3XfAg2cyurbDNr5/NfNHmdIYdxxKj7hnMyFUw7lA==
X-Received: by 2002:a17:902:ff16:: with SMTP id
 f22mr2602902plj.269.1595780878301; 
 Sun, 26 Jul 2020 09:27:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c428:8d39:30dd:38a5?
 ([2601:647:4802:9070:c428:8d39:30dd:38a5])
 by smtp.gmail.com with ESMTPSA id hg11sm36668pjb.38.2020.07.26.09.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2020 09:27:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
Date: Sun, 26 Jul 2020 09:27:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726093132.GD1110104@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_122759_600748_00C798C8 
X-CRM114-Status: GOOD (  17.35  )
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


>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		init_completion(&hctx->rcu_sync.completion);
>> +		init_rcu_head(&hctx->rcu_sync.head);
>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>> +				wakeme_after_rcu);
>> +		else
>> +			call_rcu(&hctx->rcu_sync.head,
>> +				wakeme_after_rcu);
>> +	}
> 
> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
> synchronize_rcu() is OK for all hctx during waiting.

That's true, but I want a single interface for both. v2 had exactly
that, but I decided that this approach is better.

Also, having the driver call a single synchronize_rcu isn't great
layering (as quiesce can possibly use a different mechanism in the 
future). So drivers assumptions like:

         /*
          * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
          * calling synchronize_rcu() once is enough.
          */
         WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);

         if (!ret)
                 synchronize_rcu();

Are not great...

>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
>> +
>> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		wait_for_completion(&hctx->rcu_sync.completion);
>> +		destroy_rcu_head(&hctx->rcu_sync.head);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
>> +
>>   /**
>>    * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>>    * @q: request queue.
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 23230c1d031e..5536e434311a 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/blkdev.h>
>>   #include <linux/sbitmap.h>
>>   #include <linux/srcu.h>
>> +#include <linux/rcupdate_wait.h>
>>   
>>   struct blk_mq_tags;
>>   struct blk_flush_queue;
>> @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
>>   	 */
>>   	struct list_head	hctx_list;
>>   
>> +	struct rcu_synchronize	rcu_sync;
>   
> The above struct takes at least 5 words, and I'd suggest to avoid it,
> and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
> Meantime !BLK_MQ_F_BLOCKING doesn't need it.

It is at the end and contains exactly what is needed to synchronize. Not
sure what you mean by reuse hctx->srcu?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
