Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421F2D15DB1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8NbFy8BUa88g2cm+RPUXZWB/UReHoId4kkp+4N1bf0=; b=tJUH0APByuFWaJM7dTw7v9CrW/
	DYA2gQhRVDPv1gaMf4porv/CCtE1rVp2UNBCjGumoGTxD1Zcjw5Q0+7EUjHQ62AngbqFK5vQwgnND
	uCxg2ru533W+JDj+KMnjzIxjQM0xViYDaKO/GRgcLrkE3JhYJrrtu9rmK5qZfoW+OH6iiny4d1DuI
	OKQPhJHNCqnoFS8gzM/gD4ZIr0C45BLI/dtf6WQXx8H30kkHQr9k/qhKa6RutGQahaPsAEd0xhp61
	lOFoy+Sf4RILNLuj77DRls/gaonz+CwgmIe+JAUyfpG2D6SHZp33wIuGh+XjUSdYneVnNAPa4or4U
	5PTYI4eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uM0-00000007n3x-1OQl;
	Mon, 21 Oct 2024 15:29:56 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2u7Y-00000007kVu-3Unq
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:15:19 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2047040f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Oct 2024 08:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523699; x=1730128499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8NbFy8BUa88g2cm+RPUXZWB/UReHoId4kkp+4N1bf0=;
        b=vapQI7F3r2EtcCcNSOR93BUm+PUImcTQyLzJBL20obmjBZCUfC55FevesmMrzDns6Q
         tDh9wcigIz/knTMyhjSerj0S6XdoBuzVSetDfSknLcRuuKsvgnbcF/UMcop2ptDPm+fC
         HnLwkB0HpKl4CBS4ul+T8jqAT0oicNojZ174MKwl/9dGParokMF+mQzL/tmfAkJoep3+
         kXVv6yLoEvufc10lapMuY24nzzZPSPByUsVe+xQZL77HLGSNhXs1JYYMQfcMUmX5a65q
         OEebhC6uh7hkH3+wVHDwXf3aGeWPSJi9PRJQbBtEjJgbUGyQcqNP9dBScI8DiUc4YPS6
         e+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUa/BGM5ZK4z2jxEkHvmGyb8xLyWCicF4d1riY8hrV8kFYp05pN6Llok5h/eIbRihJqruemjZIRKvIB@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm4V8XTMu1JLIOqna8fpaqYQtxxycdntU6bMaXkVgiROR4Z9kV
	aPGOCj0kmOsbv7F8I1DtOnrrft0BHH07n6SGKjzmzP50GMpK2UCbhIZIgA==
X-Google-Smtp-Source: AGHT+IGkG1Wjqj4EpQHTDyZqY2GU/4lFQ+oCAxgeloys5FG5CGf8f4qIYEfLcIx2gZhwYcTnMsGdFQ==
X-Received: by 2002:a05:6000:b8a:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-37eab4ed34dmr7736934f8f.40.1729523698395;
        Mon, 21 Oct 2024 08:14:58 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b98asm4570081f8f.61.2024.10.21.08.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:14:57 -0700 (PDT)
Message-ID: <f8b03260-9792-4612-aebd-52db4458b949@grimberg.me>
Date: Mon, 21 Oct 2024 18:14:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] nvme: make keep-alive synchronous operation
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com,
 dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <20241016030339.54029-3-nilay@linux.ibm.com>
 <a5908bbc-4230-460d-b814-a0b41d16a15d@grimberg.me>
 <bd0bfd18-b5bf-485a-9891-20974557d740@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bd0bfd18-b5bf-485a-9891-20974557d740@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_081500_896446_B0E8F80B 
X-CRM114-Status: GOOD (  39.28  )
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




On 21/10/2024 14:58, Nilay Shroff wrote:
>
> On 10/21/24 03:19, Sagi Grimberg wrote:
>> Hey Nilay,
>>
>> First, can you please phrase the patch title to describe what it
>> is addressing, not what it is changing, that can come (as it does)
>> in the body.
>>
> sure, how about naming it as "nvme-fabrics: fix kernel crash while shutting down controller" ?
>
>> Second, I don't think we want to spend a thread waiting for
>> synchronous IO for the purpose of keep alive. Is this the only
>> way that this can be done?
>>
>> Third, was this observed with non-loop transports?
>>
> Yes it could happen even with non-loop fabric transports.
>
>> On 16/10/2024 6:03, Nilay Shroff wrote:
>>> The nvme keep-alive operation, which executes at a periodic interval,
>>> could potentially sneak in while shutting down a fabric controller.
>>> This may lead to a race between the fabric controller admin queue
>>> destroy code path (invoked while shutting down controller) and hw/hctx
>>> queue dispatcher called from the nvme keep-alive async request queuing
>>> operation. This race could lead to the kernel crash shown below:
>> What is different about keep-alive than any other command?
> The one difference is, of course, keep-alive is async but we may have
> other async requests running while shutting down the controller. I found
> that, when compared the keep-alive with other commands, the keep-alive
> runs in the worker thread context but other commands (for instance async
> read/write) runs in the user context and that uses the blk plugging. When we
> use plugging, the call path for issuing request to driver is quite different
> from that of issuing request using blk_execute_rq_nowait(). This subtle
> difference is probably the reason not causing the kernel crash issuing
> read/write command while shutting down the fabric controller.
>
> The call path for blk plugging for issuing the request to driver:
> __blk_flush_plug()
>    -> blk_mq_flush_plug_list()
>      ->blk_mq_dispatch_plug_list()
>
> The blk_mq_dispatch_plug_list() first increments ->q_usage_counter before
> dispatching requests. Basically here the queue dispatcher (blk_mq_run_hw_queue
> function) is protected from the queue being destroyed on other cpu thread.
> So that means that even after a request (assuming the only request in queue)
> is cancelled or flushed off due to fabric controller is shutting down, the
> blk-mq destroy code path would not be able to forward progress until the
> ->q_usage_counter is decremented and becomes zero. And we can see in
> blk_mq_dispatch_plug_list() that it decrements ->q_usage_counter only after
> the blk_mq_run_hw_queue function returns.

Sounds like an issue that is not related to keep-alive at all.

>>> Call Trace:
>>>       autoremove_wake_function+0x0/0xbc (unreliable)
>>>       __blk_mq_sched_dispatch_requests+0x114/0x24c
>>>       blk_mq_sched_dispatch_requests+0x44/0x84
>>>       blk_mq_run_hw_queue+0x140/0x220
>>>       nvme_keep_alive_work+0xc8/0x19c [nvme_core]
>>>       process_one_work+0x200/0x4e0
>>>       worker_thread+0x340/0x504
>>>       kthread+0x138/0x140
>>>       start_kernel_thread+0x14/0x18
>> What is the "crash" here? use-after-free?
> yes it's use-after-free kernel crash.
>>> While shutting down fabric controller, if nvme keep-alive request sneaks
>>> in then it would be flushed off. The nvme_keep_alive_end_io function is
>>> then invoked to handle the end of the keep-alive operation which
>>> decrements the admin->q_usage_counter and assuming this is the last/only
>>> request in the admin queue then the admin->q_usage_counter becomes zero.
>>> If that happens then blk-mq destroy queue operation (blk_mq_destroy_
>>> queue()) which could be potentially running simultaneously on another
>>> cpu (as this is the controller shutdown code path) would forward
>>> progress and deletes the admin queue. So, now from this point onward
>>> we are not supposed to access the admin queue resources. However the
>>> issue here's that the nvme keep-alive thread running hw/hctx queue
>>> dispatch operation hasn't yet finished its work and so it could still
>>> potentially access the admin queue resource while the admin queue had
>>> been already deleted and that causes the above crash.
>> Again, it is unclear to me what justifies the cure here. Every command can
>> race with the shutdown, and it can be sync or async.
>>
> While I was researching on this issue, I figured that the nvme keep-alive is
> probably the only async request running in worker thread context and not well
> synchronized with the fabric controller shutdown code path. Yes we may have other
> async request (for instance async read/write) which might get-in the way of the
> fabric controller shutdown code path but those mostly run in the user context and
> hence have a different code path than keep-alive command for submitting/queuing
> the request.

This sounds like we papered around the problem. is it not allowed to 
call blk_execute_rq_nowait
from a kthread?

>
>>> This fix helps avoid the observed crash by implementing keep-alive as a
>>> synchronous operation so that we decrement admin->q_usage_counter only
>>> after keep-alive command finished its execution and returns the command
>>> status back up to its caller (blk_execute_rq()). This would ensure that
>>> fabric shutdown code path doesn't destroy the fabric admin queue until
>>> keep-alive request finished execution and also keep-alive thread is not
>>> running hw/hctx queue dispatch operation.
>> I'd want to see exactly what is causing this race because we already flush
>> the keep alive work when starting the shutdown... so it only means it is
>> incorrectly firing again?
>>
>> What I think we should do instead, is given that we already cancel_sync the keep
>> alive work before making progress with the teardown, we should just make sure
>> that it doesn't triggered afterwards again if it does.
> No, keep-alive doesn't incorrectly fired, however once a keep-alive request is
> allocated but before it's queued,

The queue teardown quiesce the admin queue first, which should prevent 
the dispatch.
You probably mean that it runs a little later, after the dispatch passes 
the quiesced test...

The question is, why did blk_mq_quiesce_queue did not wait for rcu 
grace? which should
have ensured that there is no dispatch going on? at least that is what 
it's supposed to do...
something doesn't add up

