Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE3C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 02:23:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F97120672
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 02:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0GutAZ0d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="X64vyxCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F97120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Roqh2ewERSJX8xAHwBoxx68Eh3syOkdZmNjHlZRXl1w=; b=0GutAZ0dutvKmxB0XV0Z8oKi3
	hOgoTc+4L+nmJa+UqRaEKJGI0Rf5H5HwzIXZbpnqj6BO8wD7okm3hZBk7IyQiAPSIwVA2nbrozK6f
	Hf9dFDva9jKn9Iw3w97hroeyb7BfxyAAHyS075TKJRcWL/Ln2H0cwq6l5hEliIMhZe2oAwwb5/Ox5
	tGomA29NaxgQ+pHgVdgjIO796A5pZ2mL+MDH2rcUU+Re/2P8rVN8hsiTS/AKWsjfVCbwVtLWlbKQB
	HCaWB3ApkBbXSOutATAHTWFgdka+PEm04tObaYb5f+9swIpedSQ8GbGEQ23pzPlycGTA+kgdvfR0H
	EPqzw33Nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0FH1-0007qm-0y; Tue, 28 Jul 2020 02:23:23 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0FGx-0007pl-QX
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 02:23:20 +0000
Received: by mail-pl1-x642.google.com with SMTP id k13so1307925plk.13
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 19:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lNH1NYbUVc5zuSMDLmBacK4vanWB5H7USzQ7gMT9cT4=;
 b=X64vyxCn2fxmc6y+JkjyPeT/TAJdTSWExdDQUQwKUybUEhnQ4J7a2oqE+OSeNLALzK
 m9ifA6fUstcips6XPcJm6gpT1JHQMUTuP4za1FS7ls4iSWJj4EyfHOb34N16xINfJOLV
 kCGmIjeH3o4jEEaRYdxNuyXhXiTTUN4sKx1N4oepdXj+7tRlAklrSDhnLAesVVkY1Phk
 Lg66OGEE2hrW9Q2CXcHeIL7zKCJlLjeZortncyFAxY+uGOl0WbQiIxdWkin3eWu95zOG
 2M2KQvfpd9XRE1IW5vLPwJUOEAfeXI653DAtrWO9r3J7rw8qxRCoSRsJWlEfClu9AmFy
 xVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lNH1NYbUVc5zuSMDLmBacK4vanWB5H7USzQ7gMT9cT4=;
 b=DmZJbHOb9BtLrNjW6ZEKXsVB36CUi1xmoPKJi91S7IngBQSa4qhR2qan+XazBmz7gr
 j2de/vq/9YoatcT2/bKXuICJa7U64qq4alSJkFSOH2itGlWGXr2VmI4qp/BKNSE94NWm
 A8njpXE+S4AZ7bzUwhTIEYESAAQEseu+XgiQI1J26rRvFLGDu+SaEZkldD+VAk7zhwzQ
 hm9+v2MnoR7q89Ev2UiNcT2h/vhvhOgLrNIE8WHZZFBCpjJxZlArkgi1uhhTwmZukOlQ
 l5BQeu9JZf7ZfFXVu7vIkB4zcdkFOtFYqOCH1Gh0IANlGKSsFuStv3HPk0aRfIz3WTkr
 SSoQ==
X-Gm-Message-State: AOAM5323mhQxFgHyNK4IBxwJ9JF0C232FXr4G/3GQrGsmXmmd5wMTt5Q
 PpInkJdL83fBiVkfQ50Scto/Gg==
X-Google-Smtp-Source: ABdhPJwMLZTKLOPqhALd98ixY8dCk8CL+dlP08rMmTtVJlLWoDagyMEG8TYC/fwfsZ49LhMNeuBaOA==
X-Received: by 2002:a17:90a:e017:: with SMTP id
 u23mr2030385pjy.179.1595902997709; 
 Mon, 27 Jul 2020 19:23:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id w18sm16165627pgj.31.2020.07.27.19.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 19:23:16 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me> <20200728014038.GA1305646@T590>
 <1d119df0-c3af-2dfa-d569-17109733ac80@kernel.dk>
 <20200728021744.GB1305646@T590>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5fce2096-2ed2-b396-76a7-5fb8ea97a389@kernel.dk>
Date: Mon, 27 Jul 2020 20:23:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728021744.GB1305646@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_222319_877184_20C4ADBB 
X-CRM114-Status: GOOD (  26.06  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lin <mlin@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/27/20 8:17 PM, Ming Lei wrote:
> On Mon, Jul 27, 2020 at 07:51:16PM -0600, Jens Axboe wrote:
>> On 7/27/20 7:40 PM, Ming Lei wrote:
>>> On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
>>>> drivers that have shared tagsets may need to quiesce potentially a lot
>>>> of request queues that all share a single tagset (e.g. nvme). Add an interface
>>>> to quiesce all the queues on a given tagset. This interface is useful because
>>>> it can speedup the quiesce by doing it in parallel.
>>>>
>>>> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
>>>> in parallel such that all of them wait for the same rcu elapsed period with
>>>> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
>>>> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
>>>> sufficient.
>>>>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>>  block/blk-mq.c         | 66 ++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/blk-mq.h |  4 +++
>>>>  2 files changed, 70 insertions(+)
>>>>
>>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>>> index abcf590f6238..c37e37354330 100644
>>>> --- a/block/blk-mq.c
>>>> +++ b/block/blk-mq.c
>>>> @@ -209,6 +209,42 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>>>>  
>>>> +static void blk_mq_quiesce_blocking_queue_async(struct request_queue *q)
>>>> +{
>>>> +	struct blk_mq_hw_ctx *hctx;
>>>> +	unsigned int i;
>>>> +
>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>> +
>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
>>>> +		hctx->rcu_sync = kmalloc(sizeof(*hctx->rcu_sync), GFP_KERNEL);
>>>> +		if (!hctx->rcu_sync)
>>>> +			continue;
>>>
>>> This approach of quiesce/unquiesce tagset is good abstraction.
>>>
>>> Just one more thing, please allocate a rcu_sync array because hctx is
>>> supposed to not store scratch stuff.
>>
>> I'd be all for not stuffing this in the hctx, but how would that work?
>> The only thing I can think of that would work reliably is batching the
>> queue+wait into units of N. We could potentially have many thousands of
>> queues, and it could get iffy (and/or unreliable) in terms of allocation
>> size. Looks like rcu_synchronize is 48-bytes on my local install, and it
>> doesn't take a lot of devices at current CPU counts to make an alloc
>> covering all of it huge. Let's say 64 threads, and 32 devices, then
>> we're already at 64*32*48 bytes which is an order 5 allocation. Not
>> friendly, and not going to be reliable when you need it. And if we start
>> batching in reasonable counts, then we're _almost_ back to doing a queue
>> or two at the time... 32 * 48 is 1536 bytes, so we could only do two at
>> the time for single page allocations.
> 
> We can convert to order 0 allocation by one extra indirect array. 

I guess that could work, and would just be one extra alloc + free if we
still retain the batch. That'd take it to 16 devices (at 32 CPUs) per
round, potentially way less of course if we have more CPUs. So still
somewhat limiting, rather than do all at once.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
