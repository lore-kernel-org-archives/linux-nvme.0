Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAA6C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 09:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWGSKRbVgY5ZwEMm1vceeuFMl7TSQjaj1bkfpyeuFB4=; b=pMI/v5z6B0tj6B93Z30gs3gABc
	l+xtIm1ddwULx+R+TpjFhNngOPxwj+LQbZmTHsBD7XWzPE8WxiWLI7l/hM0Jt1CgshwGkNNaDRx8V
	/LCQP+LClbOZL2hTaZDF4fHfZ9qbGcxRUeIwnhpwkAC5kHDU5wo+L4F3jq+8faAfIYVTutgYgwjO+
	hrUYaszS8d/+IYmV1VoG5mCeTVtQZ6+HBn9uDN+nxRLTHaO8nbBAuBJ53zvXhzb9j0nhC6ruq7y0C
	pfbGco9/lF9xTmjvgOaOHZCRzXXtBHkSgeUY7ccMYBKkVbZrY4Ch4nNbCbFZldq7Klx7nTMACNH7g
	ceGT/wQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pohhB-001UHB-0K;
	Tue, 18 Apr 2023 09:32:17 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pohh8-001UEo-0X
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 09:32:15 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f0968734f6so11636215e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 02:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681810330; x=1684402330;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWGSKRbVgY5ZwEMm1vceeuFMl7TSQjaj1bkfpyeuFB4=;
        b=Z/MLEd7eOmOiYV8All0RP/tOlja8gfzqkYdGk2hS0jSFz0G2F3i4fTSBlXpWLo7ly+
         BwAYAT8dw3Wqc51DlisNYQzqTGTWaeWkE3ZT6tHbfKFg+7Z0DkanQrE+j364hVaqBtRf
         UcraLNzlrTQSEyBP6EXQvQ8s4FuAYpEd7j4tMWvcSzZehwj7y6FZineR/Qf5DdgcUFGM
         Rdi545FjSZxHmrvihzTrbdxAY/alLalTvdh948foGAYx8xA6csgMcs3W8hp9g+pb5X89
         p+i79I8Jq/kIHOCoLTIs3m1AgbIDjWVtwTjVCqHVpF771cOZNGwmc4fkS/YQ8Slqwrk4
         l00A==
X-Gm-Message-State: AAQBX9c8kMyNdJbSgoNq2dTAcEGpW3ByV4289Ro3UvyoZBcvnt6vufmk
	DHmwPzhVhdbnostgDNywsG0=
X-Google-Smtp-Source: AKy350Zi/64s5JtLoJP79lPGv/jdj56Su04oeLVVeFXtbpUjiOu3LDXLxM6TK74+Mmep0y3i0kh66A==
X-Received: by 2002:a05:600c:3b24:b0:3f1:7490:e58e with SMTP id m36-20020a05600c3b2400b003f17490e58emr3865172wms.2.1681810329743;
        Tue, 18 Apr 2023 02:32:09 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o37-20020a05600c512500b003f172d13531sm6679412wms.11.2023.04.18.02.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 02:32:09 -0700 (PDT)
Message-ID: <8c880a08-6e1d-2fda-18ea-d19db155957c@grimberg.me>
Date: Tue, 18 Apr 2023 12:32:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] nvme/tcp: Add support to set the tcp worker cpu
 affinity
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Li Feng <lifeng1519@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413132941.2489795-1-fengli@smartx.com>
 <ZDz3TlFUxMxaO1W4@ovpn-8-16.pek2.redhat.com>
 <D8FFAFCB-5486-4211-9AC8-2779AE368183@gmail.com>
 <ZDz9vv6tbmKyhK7h@ovpn-8-16.pek2.redhat.com>
 <d71d4924-d2f0-3252-5268-5dafd1ebbc39@grimberg.me>
 <ZD4doq5Ko49wLvQK@ovpn-8-16.pek2.redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZD4doq5Ko49wLvQK@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_023214_199734_4DCD08DF 
X-CRM114-Status: GOOD (  45.03  )
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

> Hi Sagi,
> 
> On Mon, Apr 17, 2023 at 04:33:40PM +0300, Sagi Grimberg wrote:
>>
>>>>> On Thu, Apr 13, 2023 at 09:29:41PM +0800, Li Feng wrote:
>>>>>> The default worker affinity policy is using all online cpus, e.g. from 0
>>>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
>>>>>> have a bad performance.
>>>>>
>>>>> Can you explain in detail how nvme-tcp performs worse in this situation?
>>>>>
>>>>> If some of CPUs are knows as busy, you can submit the nvme-tcp io jobs
>>>>> on other non-busy CPUs via taskset, or scheduler is supposed to choose
>>>>> proper CPUs for you. And usually nvme-tcp device should be saturated
>>>>> with limited io depth or jobs/cpus.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Ming
>>>>>
>>>>
>>>> Taskset can’t work on nvme-tcp io-queues, because the worker cpu has decided at the nvme-tcp ‘connect’ stage,
>>>> not the sending io stage. Assume there is only one io-queue, the binding cpu is CPU0, no matter io jobs
>>>> run other cpus.
>>>
>>> OK, looks the problem is on queue->io_cpu, see nvme_tcp_queue_request().
>>>
>>> But I am wondering why nvme-tcp doesn't queue the io work on the current
>>> cpu? And why is queue->io_cpu introduced? Given blk-mq defines cpu
>>> affinities for each hw queue, driver is supposed to submit IO request
>>> to hardware on the local CPU.
>>>
>>> Sagi and Guys, any ideas about introducing queue->io_cpu?
>>
>> Hey Ming,
>>
>> I have some vague memories wrt to this, but from what I recall:
>>
>> - The number of queues is dependent on both the controller and
>> the user (Not a reason/motivation on its own, just clarifying).
>>
>> - It simply matches what pci does (to some extent, outside of rx side
>> entropy that may exist), it just happens to take more cpu cycles due to
>> the network stack overhead.
>>
>> - I didn't want io threads to change CPUs because of RFS/aRFS
>> optimizations that people use, which allows the NIC to steer interrupts
>> (and napi context) to where the io thread is running, and thus minimize
>> latency due to improved locality. that on its own was shown to be worth
>> over 30% reduction.
> 
> OK, sounds like one per-queue kthread model may work for this case, and
> the kthread cpu affinity can be wired with hw queue's cpu affinity, and
> scheduler may figure out perfect time to migrate kthread to proper CPUs,
> and task migration is supposed to happen much less frequently.

That is not my experience with the task scheduler.

>> - At some point nvme-tcp rx context used to run in softirq, and having
>> to synchronize different cores (on different numa nodes maybe, depends
>> on what RSS decided) when processing the socket resulted in high
>> latency as well. This is not the case today (due to some nics back then
>> that surfaced various issues with this) but it may be come back in
>> the future again (if shown to provide value).
>>
>> - Also today when there is a sync network send from .queue_rq path,
>> it is only executed when the running cpu == queue->io_cpu, to avoid high
>> contention. My concern is that if the io context is not bound to
> 
> This one looks one optimization for send?

Yes.

> But this way actually causes contention with nvme_tcp_io_work().

Correct, but it is only taken if the current cpu matches the queue
io_cpu, which is either contended locally, or not with voluntary
preemption.

>> a specific cpu, it may create heavier contention on queue serialization.
>> Today there are at most 2 contexts that compete, io context (triggered from
>> network rx or scheduled in the submission path) and .queue_rq sync
>> network send path. I'd prefer to not have to introduce more contention with
>> increasing number of threads accessing an nvme controller.
> 
> I understand contention doesn't have to require one fixed cpu bound with wq or
> kthread. Using single per-queue work or kthread can avoid contention completely.

I'd like to keep the optimization for send path, always context-switch
to a kthread for I/O is expensive. So some contention will happen due to
serialization.

I opted to only take the send_mutex if the io context is scheduled on
the same CPU in order to not unconditionally take a mutex. If we don't
control where the queue io thread is scheduled, we will always attempt
to take send_mutex, which will increase the contention on it.

> Here one tcp queue needs to handle both send & recv, and I guess all tcp sends
> need to be serialized, same with tcp recvs. Maybe two wq/kthreads, one
> is for send, the other is for recv? Or single wq/kthread is fine too if
> the two can be done in async style.

That is what is done today.

> 
> Then the send_mutex can be saved, maybe nvme/tcp blocking can be removed.
> 
>>
>> Having said that, I don't think there is a fundamental issue with
>> using queue_work, or queue_work_node(cur_cpu) or
>> queue_work_node(netdev_home_cpu), if that does not introduce
>> additional latency in the common cases. Although having io threads
>> bounce around is going to regress users that use RFS/aRFS...
> 
> IMO, here the fundamental issue is that one fixed cpu(queue->io_cpu) is selected
> for handling IO submission aiming at same queue, which can't scale,

But a single queue is not designed to scale, we scale with multiple
queues.

> because we can't expect userspace or scheduler to reserve this fixed cpu for
> nvme_tcp queue.

Of course not, the queue io context is just another thread, which share
the cpu with all other system threads.

The design in nvme-tcp is that we keep the io context local to the cpu
where the user thread is running. Naturally there are cases where one
may desire to place it on some reserved cpu, or on a sibling, or based
on other factors (like the nic).

So on the one hand, I'd like to preserve the queue <-> cpu locality, and
minimize io threads from bouncing around, and on the other hand, I don't
want to expose all this to users to mangle with low-level stuff.

And, I'm not particularly keen on start troubleshooting users
performance issues leading to tweak some finicky scheduler knobs that
are system-wide.

But I'm not opposed to changing this if it proves to improve the driver.

