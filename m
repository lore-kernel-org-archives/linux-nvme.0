Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB902C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:05:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E7E2070B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 21:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WK+qdb0h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pTZzDoy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E7E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nE1zmbX+FDNuCi/YK2rYphLKcEE+xAUaXeq67xPUguw=; b=WK+qdb0hV7uvbhjmyKbwSqOPA
	hZ0mUjEz8Q3R6L4iTRvowP2PW4BTrAZLbE5LLo2KyvIslLqbNwDj09o7MOsEJh2d7RAM3+2SKsJ3y
	EJue10Rlyj+jyDVETPlr5Z6VekPFqu7UcgqbDetSNhMGqaieFb9CH2hkp1uHl9ZUkFXCjFJ4MnM25
	QmuyeVQ8HqPrkZBwbiWFN9y9Y0eflssLCEYZBoDp0xXQihuidnQ5daqS/1CAt13tyunFd3rg6bCMY
	PtHH2bxVqXVcuGDxAzVSaEAOouWipfLR8nnEUMYPdK+ZApGe8uJvwegLO2B7HTmbcQw4HXOacIP+/
	PMaFS/BQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0AJf-0007o8-5D; Mon, 27 Jul 2020 21:05:47 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0AJc-0007nP-P3
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 21:05:45 +0000
Received: by mail-pj1-x1041.google.com with SMTP id k71so10376243pje.0
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M6OD+yOQvORkRlTgQV/1JnSgKOlwQw4SxTkeowcTbZk=;
 b=pTZzDoy6oV2JfpdHLLKNS86nO/DyqjZGFIm6nl5rynxv/GajERZlAFawqO0LUAKZ4G
 hvLr3hqPF1Z/gGmfa1lpEFJlV6CacW3Xxx/yq/1h+bMryPKL+jL8BPEuG4yFwTFZiyzM
 L17i8uKXvuJX7OKxwEFmABLlar1nMCSMvUZvZ/knzliZrgwmXsQ8YbekXkS0bHnambLs
 sqtGHwuDgCNfiIn7OWdx0Qh4wGtTcqMJo4COPgB54ptd8QK777hhGB1Pmnr0WOSYKTPV
 QzmEuDceUeSZzQOaJrApBISFpfJUsEhDenrrPJxolp/e/9s4q2EPQfZ1ChWiVmyqqhV1
 HGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M6OD+yOQvORkRlTgQV/1JnSgKOlwQw4SxTkeowcTbZk=;
 b=U3RchQLpD17Hl0z34e5eEahnFQtMg8gmIUJh9SeeY/EPdL7qNuHmTg+UYq+VG+JsrE
 TjLPc4lhZnY1Z3s3dHcMn/xtigrodf1VLhf4nAeLjwkOC6nxOeBIP/U56+TzIaf6FdcR
 yrfExzPEOM7bTXpnt7VGze1c9hw7853xytoOdkgV8mlDsQXoGeM6hnyWYcs3VnX2IqOz
 4miB8UoYFADU+JBfDZzFklirfTKXS93iGguJqbz3i53KxvV6BAf6EYsa8sHhpFPgY1B1
 izCVuqaUdFPQaoT6xdFP+iwG2gDAiz0BbO4+oELYuxfs7zcwwHKUgq03Pogz1gO5tVL+
 GepA==
X-Gm-Message-State: AOAM5308l65R5OniMGcSaHYnrHXqNlXyaZj7vGWP8R5Z0RXX+NlyihXg
 iSa08dOiMfru9j7BBQQ23jD8hw==
X-Google-Smtp-Source: ABdhPJz+2MYf/0T4cwbYqtNje9/MZTK8Od4RSqrvEt6gRT4CRRVSZRurwTgj0OCnY1svQR2WEL3Xmg==
X-Received: by 2002:a17:90a:6e47:: with SMTP id
 s7mr1057440pjm.217.1595883942702; 
 Mon, 27 Jul 2020 14:05:42 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id a67sm16823682pfa.81.2020.07.27.14.05.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 14:05:42 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
Date: Mon, 27 Jul 2020 15:05:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_170544_880111_66041403 
X-CRM114-Status: GOOD (  25.52  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/27/20 3:00 PM, Sagi Grimberg wrote:
> 
>>>>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>>>>> +{
>>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>>> +	unsigned int i;
>>>>>>> +
>>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>>> +
>>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>>>>> +				wakeme_after_rcu);
>>>>>>> +		else
>>>>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>>>>> +				wakeme_after_rcu);
>>>>>>> +	}
>>>>>>
>>>>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>>>>> synchronize_rcu() is OK for all hctx during waiting.
>>>>>
>>>>> That's true, but I want a single interface for both. v2 had exactly
>>>>> that, but I decided that this approach is better.
>>>>
>>>> Not sure one new interface is needed, and one simple way is to:
>>>>
>>>> 1) call blk_mq_quiesce_queue_nowait() for each request queue
>>>>
>>>> 2) wait in driver specific way
>>>>
>>>> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
>>>> then you may add per-tagset APIs for the waiting.
>>>
>>> Because it puts assumptions on how quiesce works, which is something
>>> I'd like to avoid because I think its cleaner, what do others think?
>>> Jens? Christoph?
>>
>> I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
>> call that.
> 
> I agree with this approach as well.
> 
> Jens, this mean that we use the call_rcu mechanism also for non-blocking
> hctxs, because the caller  will call it for multiple request queues (see
> patch 2) and we don't want to call synchronize_rcu for every request
> queue serially, we want it to happen in parallel.
> 
> Which leaves us with the patchset as it is, just to convert the
> rcu_synchronize structure to be dynamically allocated on the heap
> rather than keeping it statically allocated in the hctx.
> 
> This is how it looks:

OK, so maybe I'm not fully up-to-date on the thread, but why aren't we
just having a blk_mq_quiesce_queue_wait() that does something ala:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 667155f752f7..b4ceaaed2f9c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,32 +209,37 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
-/**
- * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
- * @q: request queue.
- *
- * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Once this function is returned, we make
- * sure no dispatch can happen until the queue is unquiesced via
- * blk_mq_unquiesce_queue().
- */
-void blk_mq_quiesce_queue(struct request_queue *q)
+void blk_mq_quiesce_queue_wait(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_quiesce_queue_nowait(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
 			synchronize_srcu(hctx->srcu);
 		else
 			rcu = true;
 	}
+
 	if (rcu)
 		synchronize_rcu();
 }
+
+/**
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
+ * @q: request queue.
+ *
+ * Note: this function does not prevent that the struct request end_io()
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatch can happen until the queue is unquiesced via
+ * blk_mq_unquiesce_queue().
+ */
+void blk_mq_quiesce_queue(struct request_queue *q)
+{
+	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue_wait(q);
+}
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
 /*

Do we care about BLK_MQ_F_BLOCKING runtime at all?

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
