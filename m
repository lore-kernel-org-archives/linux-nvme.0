Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11731E7AD43
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jDTA2585eaPmSWbYbJF6wcGNJDJi+1BHvQUAlecYY/s=; b=LH3wU8BSagk0zofm1r7gmeL/SS
	BzH3v7xwlxdjVugqIEgp0Yyvd2kCzKJpX2CsmRWXcDyK5KftZ1XQDS1ZnqMp1swDz7h3mbYqm2T1b
	kzBebN5Snwhptyxckzf9vZL2w+apNIavcpqlBJXtU7DqB7KF1KCptF5h2Ao9rEDOp7ybyq5EKEbLz
	Rx38KbSPZycRkodP+bY2aJRSdF8ZkVp9XIvD5kO054K1oNS1+qjT7owYgK+4gJ4iHR7rgwEC+nMav
	xDB5tHcCvbGMBE3L77fVrxlzRb2vaYKyhMABiCVzCrWXgdsDdTbu0ALCmGo0nMM9+PCGjZXu1F6av
	xFLQk4vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkSl-00000000Orb-3pmW;
	Thu, 25 Dec 2025 12:29:03 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYkSc-00000000Oqn-1Lww
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 12:28:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so48646515e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 04:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766665732; x=1767270532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDTA2585eaPmSWbYbJF6wcGNJDJi+1BHvQUAlecYY/s=;
        b=WKu9ZDzQtzzJzPiKzkZIn0+XrQF4bgD1eYcQY+1BldWtQf4G9paoBJW7Y/c+05U22l
         XleWBkNKXHrcfCIft4ss86Hl2PLnbIdgHuiBxDRcV4dIXMqvAU874W0vCpZbmEPx4fF5
         u0Gj9m7jZTrAuLqrV+yQ8tviPH3Af32/ALSep55lKYnrbVZHsyndnkl/VGiN+ZShtKRY
         MButWNLMs+qlsoi7nE21YFNq0YOuKfsjo6eXIINg0z7CGv0FWG7Kz8oNDhr29ovQ5of3
         QG7e5rsSUaXHfuCLuqr9UeOJVwYWhrpiSp0oTdriz2PNMTIf/wgtqp+xpbY1r8Sncm21
         EhBg==
X-Forwarded-Encrypted: i=1; AJvYcCXFr/H33GAgAdabYlOigI7Wq4zng/FC2ld9sNuuZei0umx/FAxgpY++MeVKo5bNNFLRrcMAQlOsTpze@lists.infradead.org
X-Gm-Message-State: AOJu0Yzv2VOa701LDm6Pzxq4QFRLkXAJVvM7X3oU0Ba91rX2lxmu9rMR
	L4KoabN+wbHWj+nbnZnZYXVS4FJKN1wTnQX0lqgbyGMHPUFoQZC5HOp4
X-Gm-Gg: AY/fxX4qOWvmWxI3Cg+eHQzxPfynOHTff1yM6j4kBP1DVyaAm93xJ6188hXYCAaBWsJ
	SxSVSbXK6MG+5LWjI8XvWN2YMgbRHy3E8v80JcnXf4ke9aBHQEVm+751pA4g2sEpPtyrCnIdoS0
	wBcvWdQ+1UhHpEgZX/6gynQdMbssxRqn5EPi2gYlIZ5WIoMpEGEj9FMDt9jkLFwHv5aBJGmuxkU
	/Un4yeTS58xJ4X+7+8eGVUjeK5bLTNv6ddnx+JExMgUG6oba5CRmT7xlvvwY2RfQO1CafxJ+mME
	A8f4pR69tbjiMyq4co2zIn/FJkNUyPklzyi2936IRbNdunnqwVcBKmrZxxzodsIguogZNoFLkqe
	ZuDcncMS/uPWEgR2bXV556e70D0R9xZeUKQNd7Dy4FjoFoXtLJkv53/+REu7+b5HocxOpYLHUG1
	m6StB43HjO+fkflXfiZhjAtaIUYPsPxxh/TQ+1q3AiBt4QQw==
X-Google-Smtp-Source: AGHT+IEhFvdYMTBBeR1UKm+camvA2JnNWgeMj+92xUhJV8ggBGatZtFLLVGG84b/VLQiLK6BFyhrPQ==
X-Received: by 2002:a05:600c:444a:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47d1959eae7mr208931045e9.29.1766665731379;
        Thu, 25 Dec 2025 04:28:51 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a7b687sm165257595e9.6.2025.12.25.04.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 04:28:50 -0800 (PST)
Message-ID: <a4f6c221-3fcf-4d23-b917-8688f88a8341@grimberg.me>
Date: Thu, 25 Dec 2025 14:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, dwagner@suse.de,
 axboe@kernel.dk, kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
 <abe16085-f0dd-4f82-b48c-f2eb125da2ee@linux.ibm.com>
 <7358ab3b-b04c-4451-85b0-5bb8073f7134@grimberg.me>
 <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_042854_488608_0A59606F 
X-CRM114-Status: GOOD (  41.19  )
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



On 18/12/2025 13:19, Nilay Shroff wrote:
>
> On 12/16/25 5:06 AM, Sagi Grimberg wrote:
>>
>> On 13/12/2025 9:27, Nilay Shroff wrote:
>>> On 12/12/25 6:34 PM, Sagi Grimberg wrote:
>>>> On 05/11/2025 12:33, Nilay Shroff wrote:
>>>>> This commit introduces a new I/O policy named "adaptive". Users can
>>>>> configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
>>>>> subsystemX/iopolicy"
>>>>>
>>>>> The adaptive policy dynamically distributes I/O based on measured
>>>>> completion latency. The main idea is to calculate latency for each path,
>>>>> derive a weight, and then proportionally forward I/O according to those
>>>>> weights.
>>>>>
>>>>> To ensure scalability, path latency is measured per-CPU. Each CPU
>>>>> maintains its own statistics, and I/O forwarding uses these per-CPU
>>>>> values.
>>>> So a given cpu would select path-a vs. another cpu that may select path-b?
>>>> How does that play with less queues than cpu cores? what happens to cores
>>>> that have low traffic?
>>>>
>>> The path-selection logic does not depend on the relationship between the number
>>> of CPUs and the number of hardware queues. It simply selects a path based on the
>>> per-CPU path score/credit, which reflects the relative performance of each available
>>> path.
>>> For example, assume we have two paths (A and B) to the same shared namespace.
>>> For each CPU, we maintain a smoothed latency estimate for every path. From these
>>> latency values we derive a per-path score or credit. The credit represents the relative
>>> share of I/O that each path should receive: a path with lower observed latency gets more
>>> credit, and a path with higher latency gets less.
>> I understand that the stats are maintained per-cpu, however I am not sure that having a
>> per-cpu path weights make sense. meaning that if we have paths a,b,c and for cpu0 we'll
>> have one set of weights and for cpu1 we'll have another set of weights.
>>
>> What if the a given cpu happened to schedule some other application in a way that impacts
>> completion latency? won't that skew the sampling? that is not related to the path at all. That
>> is possibly more noticable in tcp which completes in a kthread context.
>>
>> What do we lose if the 15 seconds weight assignment, averages all the cpus samping? won't
>> that mitigate to some extent the issue of non-path related latency skew?
>>
> You’re right — what you’re describing is indeed possible. The intent of the adaptive policy,
> however, is to measure end-to-end I/O latency, rather than isolating only the raw path or
> transport latency.
> The observed completion latency intentionally includes all components that affect I/O from
> the host’s perspective: path latency, fabric or protocol stack latency (for example, TCP/IP),
> scheduler-induced delays, and the target device’s own I/O latency. By capturing the full
> end-to-end behavior, the policy reflects the actual cost of issuing I/O on a given path.
> Scheduler-related latency can vary over time due to workload placement or CPU contention,
> and this variability is accounted for by the design. Since per-path weights are recalculated
> periodically (for example, every 15 seconds), any sustained changes in CPU load or scheduling
> behavior are naturally incorporated into the path scoring. As a result, the policy can
> automatically adapt/adjust and rebalance I/O toward paths that are performing better under
> current system conditions.
> In short, while per-CPU sampling may include effects beyond the physical path itself, this is
> intentional and allows the adaptive policy to respond in real time to changing end-to-end
> performance characteristics.

The issue is that you are crediting latency to a path where portions of 
it (or maybe even the majority)
may be completely unrelated to the path at all. What I mean is that you 
are accounting things that are unrelated
to the path selection.

In my mind, it would be better to amortize the cpu-local aspects of the 
path selection (e.g. average out latency across
cpus - or across cpu numa-node) when calculating credits, and then have 
all cpus use the same credits).

>
>>> I/O distribution is thus governed directly by the available credits on that CPU. When the
>>> NVMe multipath driver performs path selection, it chooses the path with sufficient credits,
>>> updates the bio’s bdev to correspond to that path, and submits the bio. Only after this
>>> point does the block layer map the bio to an hctx through the usual ctx->hctx mapping (i.e.,
>>> matching the issuing CPU to the appropriate hardware queue). In other words, the multipath
>>> policy runs above the block-layer queueing logic, and the number of hardware queues does
>>> not affect how paths are scored or selected.
>> This is potentially another problem. application may jump between cpu cores due to scheduling
>> constraints. In this case, how is the path selection policy adhering to the path weights?
>>
>> What I'm trying to say here is that the path selection should be inherently reflective on the path,
>> not the cpu core that was accessing this path. What I am concerned about, is how this behaves
>> in the real-world. Your tests are running in a very distinct artificial path variance, and it does not include
>> other workloads that are running on the system that can impact completion latency.
>>
>> It is possible that what I'm raising here is not a real concern, but I think we need to be able to demonstrate
>> that.
>>
> In real-world systems, as stated earlier, the completion latency is influenced not only by
> the physical path but also by system load, scheduler behavior, and transport stack processing.
> By incorporating all of these factors into the latency measurement, the adaptive policy reflects
> the true cost of issuing I/O on a given path under current conditions. This allows it to respond
> to both path-level and system-level congestion.
>
> In practice, during experiments with two paths (A and B), I observed that when additional latency—
> whether introduced via the path itself or through system load—was present on path A, subsequent I/O
> was automatically steered toward path B. Once conditions on path A improved, the policy rebalanced
> I/O based on the updated path weights. This behavior demonstrates that the policy adapts dynamically
> and remains effective even in the presence of CPU migration and competing workloads.
> Overall, while per-CPU sampling may appear counterintuitive at first, it enables the policy to capture
> real-world end-to-end performance and continuously adjust I/O distribution in response to changing
> system and path conditions.

I just don't understand how the presence of additional workloads or 
system cpu load distribution
should affect the path that you select. I mean you can choose the 
"worst" path but you run on a cpu
that happens to run just your thread and you score it maybe better than 
the "best" path if you
are unfortunate enough to run on a cpu that currently is task switching 
multiple cpu intensive threads...

>> With this I tend to agree. but per-cpu has lots of other churns IMO.
>> Maybe the answer is that paths weights are maintained per NUMA node?
>> then accessing these weights in the fast-path is still cheap enough?
> That’s a fair point, and I agree that per-CPU accounting can introduce additional
> variability. However, moving to per-NUMA path weights would implicitly narrow the
> scope of what we are trying to measure, as it would largely exclude components of
> end-to-end latency that arise from scheduler behavior and application-level scheduling
> effects.

Not sure I agree. I argue that it will help you cleanup noise, which is 
unrelated to evaluation
of "path quality".

>   As discussed earlier, the intent of the adaptive policy is to capture the
> actual I/O cost observed by the workload, which includes not only path and controller
> locality but also fabric, stack, and scheduling effects. From that perspective, IMO,
> maintaining per-CPU path weights remains a better fit for the stated goal. It also
> offers a dual advantage: naturally reflecting NUMA locality on a per-CPU basis while
> preserving a true end-to-end view of path latency, agreed?

It's not intuitive to me why it is not just adding noise.

>
> I conducted an experiment on my NVMe-oF TCP testbed while simultaneously running
> iperf3 TCP traffic to introduce both CPU and network load alongside fio. The
> host system has 32 cpus, so iperf3 was configured with 32 parallel TCP streams.
> And fio was configured with numjobs=32, iodepth=32, bs=4K, direct I/O, and
> ioengine=io_uring. Below are the aggregated throughput results observed under
> different NVMe multipath I/O policies:
>
>          numa         round-robin   queue-depth  adaptive
>          -----------  -----------   -----------  ---------
> READ:   61.1 MiB/s   87.2 MiB/s    93.1 MiB/s   107 MiB/s
> WRITE:  95.8 MiB/s   138 MiB/s     159 MiB/s    179 MiB/s
> RW:     R:29.8 MiB/s R:53.1 MiB/s  R:58.8 MiB/s R:66.6 MiB/s
>          W:29.6 MiB/s W:52.7 MiB/s  W:58.2 MiB/s W:65.9 MiB/s
>
> These results show that under combined CPU and network stress, the adaptive I/O policy
> consistently delivers higher throughput across read, write, and mixed workloads when
> comapred against existing policies.

I'm not arguing other IO policies or comparison against them. We are 
discussing your implementation.

