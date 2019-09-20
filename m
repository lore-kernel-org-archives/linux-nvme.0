Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06FC49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 20:45:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C069B2190F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 20:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BPlfF/HJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C069B2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yZY20nAYllMK3Ckv/NlGUgGs66FuyXN3ITbQnr7nGrg=; b=BPlfF/HJaDRpa2ha3pjlicSDy
	Pqq8G8+m5g5K7ZxdcsrANSke8BLSSU7bd1m3k28t2FwpxhWh7FkUUPFwb2/oc83gLPxhhijEQo6Fk
	qq/NS4+kYgPBCbDIIDmxsxFSPoI4E8BnA3keqe4NaHwdSMOTuEYYNEsKLuQoJJPjsk1NlHjQCogiv
	7/rLKYsI5jCnMXMh3pjpGfxaAhUfuuYicwvdgfiwhCgl8DPD8eGQoDZ9MgrEYDwdTWUqC6QGYqodA
	Dq4aWSQUmBSteb9em/AqmVHvbL9SOT78Loz4r2vsDo/8hqVRuw8JGqcQOH64rAa0xGitfJ2C2k5w4
	cW6R9j8Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBPmf-0006o2-E5; Fri, 20 Sep 2019 20:45:41 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBPmc-0006nj-O6
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 20:45:40 +0000
Received: by mail-wr1-f66.google.com with SMTP id v8so8093976wrt.2
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 13:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dDKMsbuxijXFlLq6eWilir6TdAT/w1I2nrkQyKxFFKQ=;
 b=n43WL4Acn1+BnP84HD2ddjEPGuEh7YYi515yHO7JMWaVjmDPELxEfIDqYwr0SKEIUu
 F1g9N8OhfMwVsrKPxT7sSK4MJ3mMdaNMXB0Y0LE5r9Upe2o+R3WQYwPRCK5gm8YPXifA
 ymRqskq+zrua63cmn2r0nIGSBJk65NsDygfXO0Z5rymCw8Yt4gSuuVFCgJNCPxmNcOgl
 nWbHGGb24leSSXpzmnpuDQOE9BzqzgF+Z2IEQSVtdbMB4O76YzAek66I+IHWWjP+a62C
 5viBccEzNPQ3/czs8gE2ztX6SlJgRve17jrFlyez8uK4ImHsu0aIaSv6gk/MzPaBeix7
 dl0w==
X-Gm-Message-State: APjAAAXKt3R2v360zjLB+Dy6FZYV1vBx369QJaiTrordNt0H5oPUnZnG
 4KYk6d3oxleuXoyNPtzE/b8=
X-Google-Smtp-Source: APXvYqy6t7jOph7kwIiXf0XdHn8gEinjwnTiBpYkdM2eSYkv+J2p7RiyTTY3BRNfEYwZgPktkoL/3Q==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr13894129wrp.312.1569012336940; 
 Fri, 20 Sep 2019 13:45:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id c132sm3104677wme.27.2019.09.20.13.45.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 13:45:36 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Long Li <longli@microsoft.com>, Ming Lei <ming.lei@redhat.com>
References: <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
 <ffefcfa0-09b6-9af5-f94e-8e7ddd2eef16@linaro.org>
 <6eb2a745-7b92-73ce-46f5-cc6a5ef08abc@grimberg.me>
 <20190907000100.GC12290@ming.t460p>
 <f5685543-8cd5-6c6a-5b80-c77ef09c6b3b@grimberg.me>
 <CY4PR21MB0741838CE0C9D52556AA4558CE8E0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <30dc6fa9-ea5e-50d6-56f9-fbc9627d8c29@grimberg.me>
 <CY4PR21MB074168DE7729C131CE4394CCCE880@CY4PR21MB0741.namprd21.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <100d001a-1dda-32ff-fa5e-c18b121444d9@grimberg.me>
Date: Fri, 20 Sep 2019 13:45:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CY4PR21MB074168DE7729C131CE4394CCCE880@CY4PR21MB0741.namprd21.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_134538_787745_00EA3498 
X-CRM114-Status: GOOD (  24.89  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, John Garry <john.garry@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Sagi,
>>>
>>> Sorry it took a while to bring my system back online.
>>>
>>> With the patch, the IOPS is about the same drop with the 1st patch. I think
>> the excessive context switches are causing the drop in IOPS.
>>>
>>> The following are captured by "perf sched record" for 30 seconds during
>> tests.
>>>
>>> "perf sched latency"
>>> With patch:
>>>     fio:(82)              | 937632.706 ms |  1782255 | avg:    0.209 ms | max:   63.123
>> ms | max at:    768.274023 s
>>>
>>> without patch:
>>>     fio:(82)              |2348323.432 ms |    18848 | avg:    0.295 ms | max:   28.446
>> ms | max at:   6447.310255 s
>>
>> Without patch means the proposed hard-irq patch?
> 
> It means the current upstream code without any patch. But It's prone to soft lockup.
> 
> Ming's proposed hard-irq patch gets similar results to "without patch", however it fixes the soft lockup.

Thanks for the clarification.

The problem with what Ming is proposing in my mind (and its an existing
problem that exists today), is that nvme is taking precedence over
anything else until it absolutely cannot hog the cpu in hardirq.

In the thread Ming referenced a case where today if the cpu core has a
net softirq activity it cannot make forward progress. So with Ming's
suggestion, net softirq will eventually make progress, but it creates an
inherent fairness issue. Who said that nvme completions should come
faster then the net rx/tx or another I/O device (or hrtimers or sched
events...)?

As much as I'd like nvme to complete as soon as possible, I might have
other activities in the system that are as important if not more. So
I don't think we can solve this with something that is not cooperative
or fair with the rest of the system.

>> If we are context switching too much, it means the soft-irq operation is not
>> efficient, not necessarily the fact that the completion path is running in soft-
>> irq..
>>
>> Is your kernel compiled with full preemption or voluntary preemption?
> 
> The tests are based on Ubuntu 18.04 kernel configuration. Here are the parameters:
> 
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set

I see, so it still seems that irq_poll_softirq is still not efficient in
reaping completions. reaping the completions on its own is pretty much
the same in hard and soft irq, so its really the scheduling part that is
creating the overhead (which does not exist in hard irq).

Question:
when you test with without the patch (completions are coming in 
hard-irq), do the fio threads that run on the cpu cores that are 
assigned to the cores that are handling interrupts get substantially lower
throughput than the rest of the fio threads? I would expect that
the fio threads that are running on the first 32 cores to get very low
iops (overpowered by the nvme interrupts) and the rest doing much more
given that nvme has almost no limits to how much time it can spend on
processing completions.

If need_resched() is causing us to context switch too aggressively, does 
changing that to local_softirq_pending() make things better?
--
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index d8eab563fa77..05d524fcaf04 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -116,7 +116,7 @@ static void __latent_entropy irq_poll_softirq(struct 
softirq_action *h)
                 /*
                  * If softirq window is exhausted then punt.
                  */
-               if (need_resched())
+               if (local_softirq_pending())
                         break;
         }
--

Although, this can potentially cause other threads from making forward
progress.. If it is better, perhaps we also need a time limit as well.

Perhaps we should add statistics/tracing on how many completions we are
reaping per invocation...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
