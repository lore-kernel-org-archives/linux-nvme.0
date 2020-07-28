Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F3C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:29:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909752072E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JGPk06gs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909752072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s0yvDn3kvtrrUj5Bu2vajy2uXIazyFNKSqLY5MsTloE=; b=JGPk06gsyBg97dQ5NxzP376ei
	83eIc+pea5oZn7V6xwNvRmC9Kxb5Obg5fKzyhDzWHjsQmuJCgCiLoW8Frqus85P8KGuXhkMlMiRWh
	EA+vys3jL426S/NCnRDC0ZmNDDwVECCXs93JsoTz5GRE6oQvSlPU7hE7n2oPYXDrQNSQU9wzv8nGx
	tI0DwNyfbQMvZYYsfBn54F/vo0+JqmDALdAx8canynBbzXPw9eFD3CgEQUP9U/EpHwUX+bum1WENk
	OKL6D/YTQLgY9NMbxQJBRoCT5CmPNVQNQLJlihyZUHwdvTg/X5QvdT5kEMqGRrZEmGfvqGLMmOcls
	GhFOKH+2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0GJN-0003AL-Dt; Tue, 28 Jul 2020 03:29:53 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0GJK-00039d-4t
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:29:50 +0000
Received: by mail-wr1-f68.google.com with SMTP id l2so6238661wrc.7
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 20:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7myqsClUVVLv5WyDQfP9pAmnSNXqqcC+JbgkSGf7s8s=;
 b=QLis2vCNx+vDdX0MTrmhTJQRo+h5Y6ghmP1clibFb2PAclvlHSZYs7mTsZsHOdJ4ni
 nNpidwuSEIA9fYFnyg5cLsfpDMe5ZxKQL9T7T4GCexpUNe32UdYnYu47NkzpMFgcAiNT
 pzxqWWxtawYLdafjXETXq485fCR9ieNE6bFc9/8b+8t+lFXwTnaF8stv63D+otwdhgxa
 S/GiETov1hZPVaMtQXW4nefp8rRI8tw85nWvXz+Js3m7eQL9Wl2ckSVgi17uke2r6MJi
 UxzPcqUStosuZpfygN11u/se0swdKOIku51WwqCede/f2mWFFtCO37dbdrHlsqBqJ0IL
 E7rw==
X-Gm-Message-State: AOAM533lU6ii58Y9IupQjVTIRhenHSS1v/ceK3C1PDbXjsjJ/1BNT2T/
 7HYxtOsl9D8hSQZGr3vZS08=
X-Google-Smtp-Source: ABdhPJxwUPpUnZrE5NLRpGm4WZS+zBVXqLngl5+LubDWnV0xHAjB4+UKCrl9e5Ssc3Tsmjl2xtJ5Hg==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr23062487wrs.368.1595906988919; 
 Mon, 27 Jul 2020 20:29:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id k1sm6593984wrw.91.2020.07.27.20.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 20:29:48 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
 <20200728021744.GB1305646@T590>
 <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
 <20200728022802.GC1305646@T590>
 <baede23a-94c1-1494-bcca-964e1396f253@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0af89fcf-3505-acb1-6c91-1fff8e53b146@grimberg.me>
Date: Mon, 27 Jul 2020 20:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <baede23a-94c1-1494-bcca-964e1396f253@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_232950_242231_8BB615E2 
X-CRM114-Status: GOOD (  20.91  )
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
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>>>>>>> +{
>>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>>> +	unsigned int i;
>>>>>>> +
>>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>>> +
>>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>>>>>>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>>>>>>> +		if (!hctx->rcu_sync)
>>>>>>> +			continue;
>>>>>>
>>>>>> This approach of quiesce/unquiesce tagset is good abstraction.
>>>>>>
>>>>>> Just one more thing, please allocate a rcu_sync array because hctx is
>>>>>> supposed to not store scratch stuff.
>>>>>
>>>>> I'd be all for not stuffing this in the hctx, but how would that work?
>>>>> The only thing I can think of that would work reliably is batching the
>>>>> queue+wait into units of N. We could potentially have many thousands of
>>>>> queues, and it could get iffy (and/or unreliable) in terms of allocation
>>>>> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
>>>>> doesn't take a lot of devices at current CPU counts to make an alloc
>>>>> covering all of it huge. Let's say 64 threads, and 32 devices, then
>>>>> we're already at 64*32*48 bytes which is an order 5 allocation. Not
>>>>> friendly, and not going to be reliable when you need it. And if we start
>>>>> batching in reasonable counts, then we're _almost_ back to doing a queue
>>>>> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
>>>>> the time for single page allocations.
>>>>
>>>> We can convert to order 0 allocation by one extra indirect array.
>>>
>>> I guess that could work, and would just be one extra alloc + free if we
>>> still retain the batch. That'd take it to 16 devices (at 32 CPUs) per
>>> round, potentially way less of course if we have more CPUs. So still
>>> somewhat limiting, rather than do all at once.
>>
>> With the approach in blk_mq_alloc_rqs(), each allocated page can be
>> added to one list, so the indirect array can be saved. Then it is
>> possible to allocate for any size queues/devices since every
>> allocation is just for single page in case that it is needed, even no
>> pre-calculation is required.
> 
> As long as we watch the complexity, don't think we need to go overboard
> here in the risk of adding issues for the failure path.

No we don't. I prefer not to do it. And if this turns out to be that bad
we can later convert it to a complicated page vector.

I'll move forward with this approach.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
