Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4945FD6D220
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Dec 2025 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vv4kFEOId2XoglbIU22ofx2rlZAzp/jKSU9ZmktJBnA=; b=Yn0m6YOG0pbGU3BCCWYHrCD9DM
	jpggni/GjMQpV2odTGDBXmNHOJPl04UoBJrTaQ0JEdtRoSxCclLKK8ux9cw458nZwEgqVtHt4qFOR
	BPoqnM3MV+N5TiMJVm2zZ9qYHb9R8MeqAR4Uj6WgxL+iunt1tLSIroqGHx5KZmxrsOYuFq86826LU
	1CzWHPepd4OMLLzAeNgnP+XyCB95TM0pX60FLRz8CYniZp9VgAb0ioHBHNNIraPV20HUIVyfyb2Jf
	XlAN5q52z4eO7lwhBPnn9oSF11csYdmN2TWQIBm2DeS+27i5BFvhS97pFtsiPBsZAo14MpIP4rjQb
	hvGtXGwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWEL4-00000008YyT-0NZj;
	Thu, 18 Dec 2025 13:46:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWEL0-00000008Yy4-3hix
	for linux-nvme@lists.infradead.org;
	Thu, 18 Dec 2025 13:46:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B5EA5BCEA;
	Thu, 18 Dec 2025 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766065595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv4kFEOId2XoglbIU22ofx2rlZAzp/jKSU9ZmktJBnA=;
	b=UDmrPjhl2q+3UzFoxqMlTQd8+60JMpYcqO+ubj0lOFGobgPFX7dpXptoLOtOrwQh+wmqLj
	ET39mKmo/NckxYmFUrY+SRcFWaPptmLyXbH1z33AnEAasD5mX+TnRK2jfzJH8XShQpBN1m
	EYZH8XzZUl+3oxYMOykreecKFMSw7qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766065595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv4kFEOId2XoglbIU22ofx2rlZAzp/jKSU9ZmktJBnA=;
	b=clUiSk7JIFhb23lOJeoyGnQ9AYBGgENjOM8TQ1KKNAqTUaOnJwOlgCGrMkSTFjGl4PrDMF
	WM0joNPUJ+KHirAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UDmrPjhl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=clUiSk7J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1766065595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv4kFEOId2XoglbIU22ofx2rlZAzp/jKSU9ZmktJBnA=;
	b=UDmrPjhl2q+3UzFoxqMlTQd8+60JMpYcqO+ubj0lOFGobgPFX7dpXptoLOtOrwQh+wmqLj
	ET39mKmo/NckxYmFUrY+SRcFWaPptmLyXbH1z33AnEAasD5mX+TnRK2jfzJH8XShQpBN1m
	EYZH8XzZUl+3oxYMOykreecKFMSw7qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1766065595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv4kFEOId2XoglbIU22ofx2rlZAzp/jKSU9ZmktJBnA=;
	b=clUiSk7JIFhb23lOJeoyGnQ9AYBGgENjOM8TQ1KKNAqTUaOnJwOlgCGrMkSTFjGl4PrDMF
	WM0joNPUJ+KHirAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F29B23EA63;
	Thu, 18 Dec 2025 13:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e8L6OboFRGkLCAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Dec 2025 13:46:34 +0000
Message-ID: <afcc3e2b-0317-42c0-8968-ed771ac6af14@suse.de>
Date: Thu, 18 Dec 2025 14:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, dwagner@suse.de, axboe@kernel.dk,
 kanie@linux.alibaba.com, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <6d7c519c-122e-41a6-9f76-a3c4dedb52f5@grimberg.me>
 <abe16085-f0dd-4f82-b48c-f2eb125da2ee@linux.ibm.com>
 <7358ab3b-b04c-4451-85b0-5bb8073f7134@grimberg.me>
 <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bf31f0e2-ebef-49ff-852b-fd5003eed165@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B5EA5BCEA
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_054639_224114_F236D154 
X-CRM114-Status: GOOD (  42.95  )
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

On 12/18/25 12:19, Nilay Shroff wrote:
> 
> 
> On 12/16/25 5:06 AM, Sagi Grimberg wrote:
>>
>>
>> On 13/12/2025 9:27, Nilay Shroff wrote:
>>>
>>> On 12/12/25 6:34 PM, Sagi Grimberg wrote:
>>>>
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
>>
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
> 
That was not the point.
Thing is, we _cannot_ move I/O away from a given CPU. Once I/O 
originates from a given CPU, it will stay on that CPU irrespective of 
the path taken.
Remember: the I/O scheduler decides which path a given i/O should take,
not on which cpu any given I/O should run on.
So if a specific CPU has increase latency due to additional tasks / 
interrupts running on it it will show up _on all paths_, but only for 
weights on that CPU.
And Sagis point was that it would skew the measurement.

Which it certainly does.
But on the other hand _all_ I/O on this cpu will be affected, and we
don't have cross-speak to other CPUs (as this is a percpu counter).
So the only change would be that we're seeing increased numbers here,
the relation between paths won't change.
(Except in the really pathological case where the addedd latency is so
high that the path latency will get lost in the noise. But then it
wouldn't matter anyway as it'll be slow as hell.)

>>>
>>> I/O distribution is thus governed directly by the available credits on that CPU. When the
>>> NVMe multipath driver performs path selection, it chooses the path with sufficient credits,
>>> updates the bio’s bdev to correspond to that path, and submits the bio. Only after this
>>> point does the block layer map the bio to an hctx through the usual ctx->hctx mapping (i.e.,
>>> matching the issuing CPU to the appropriate hardware queue). In other words, the multipath
>>> policy runs above the block-layer queueing logic, and the number of hardware queues does
>>> not affect how paths are scored or selected.
>>
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
> 
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
> 
>>>
>>>>> Every ~15 seconds, a simple average latency of per-CPU batched
>>>>> samples are computed and fed into an Exponentially Weighted Moving
>>>>> Average (EWMA):
>>>> I suggest to have iopolicy name reflect ewma. maybe "ewma-lat"?
>>> Okay that sounds good! Shall we name it "ewma-lat" or "weighted-lat"?
>>
>> wighted-lat is simpler.
> Okay I'll renanme it to "weighted-lat".>
>>>
>>>     Path weights are then derived from the smoothed (EWMA)
>>> latency as follows (example with two paths A and B):
>>>
>>>        path_A_score = NSEC_PER_SEC / path_A_ewma_latency
>>>        path_B_score = NSEC_PER_SEC / path_B_ewma_latency
>>>        total_score  = path_A_score + path_B_score
>>>
>>>        path_A_weight = (path_A_score * 100) / total_score
>>>        path_B_weight = (path_B_score * 100) / total_score
>>>
>>>> What happens to R/W mixed workloads? What happens when the I/O pattern
>>>> has a distribution of block sizes?
>>>>
>>> We maintain separate metrics for READ and WRITE traffic, and during path
>>> selection we use the appropriate metric depending on the I/O type.
>>>
>>> Regarding block-size variability: the current implementation does not yet
>>> account for I/O size. This is an important point — thank you for raising it.
>>> I discussed this today with Hannes at LPC, and we agreed that a practical
>>> approach is to normalize latency per 512-byte block. For our purposes, we
>>> do not need an exact latency value; a relative latency metric is sufficient,
>>> as it ultimately feeds into path scoring. A path with higher latency ends up
>>> with a lower score, and a path with lower latency gets a higher score — the
>>> exact absolute values are less important than maintaining consistent proportional
>>> relationships.
>>
>> I am not sure that normalizing to 512 blocks is a good proxy. I think that large IO will
>> have much lower amortized latency per 512 block. which could create an false bias
>> to place a high weight on a path, if that path happened to host large I/Os no?
>>
> Hmm, I think yes, good point, I think for nvme over fabrics this could be true.
> 
Although technically we are then measure two different things (IO 
latency vs block latency). But yeah, block latency might be better
suited for the normal case; I do wonder, though, if for high-speed
links we do see a difference as the data transfer time is getting
really fast...

[ .. ]
>>> I understand your concern about whether it really makes sense to keep this
>>> per-cpu-per-ns, and I see your point that you would prefer maintaining the
>>> stat per-hctx instead of per-CPU.
>>>
>>> However, as mentioned earlier, during path selection we cannot reliably map an
>>> I/O to a specific hctx, so using per-hctx statistics becomes problematic in
>>> practice. On the other hand, maintaining the metrics per-CPU has an additional
>>> advantage: on a NUMA-aware system, the measured I/O latency naturally reflects
>>> the NUMA distance between the workload’s CPU and the I/O controller. This means
>>> that on multi-node systems, the policy can automatically favor I/O paths/controllers
>>> that are local/near to the CPU issuing the request, which may lead to better
>>> latency characteristics.
>>
>> With this I tend to agree. but per-cpu has lots of other churns IMO.
>> Maybe the answer is that paths weights are maintained per NUMA node?
>> then accessing these weights in the fast-path is still cheap enough?
> 
> That’s a fair point, and I agree that per-CPU accounting can introduce additional
> variability. However, moving to per-NUMA path weights would implicitly narrow the
> scope of what we are trying to measure, as it would largely exclude components of
> end-to-end latency that arise from scheduler behavior and application-level scheduling
> effects. As discussed earlier, the intent of the adaptive policy is to capture the
> actual I/O cost observed by the workload, which includes not only path and controller
> locality but also fabric, stack, and scheduling effects. From that perspective, IMO,
> maintaining per-CPU path weights remains a better fit for the stated goal. It also
> offers a dual advantage: naturally reflecting NUMA locality on a per-CPU basis while
> preserving a true end-to-end view of path latency, agreed?
> 
Well, for fabrics you can easily have several paths connected to the 
same NUMA node (like in the classical 'two initiator ports 
cross-connected to two target ports', resulting in four paths in total.
But two of these paths will always be on the same NUMA node).
So that doesn't work out.

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
>   
And that is probably the best argument; we should put it under stress 
with various scenarios. I must admit I am _really_ in favour of this
iopolicy, as it would be able to handle any temporary issues on the 
fabric (or backend) without the need of additional signalling.
Talk to me about FPIN ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

