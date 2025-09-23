Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62D5CAC5B0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IOqxp6rWW44C1pEjNsMPWrJzOhxqGJ0oJ538Blit5M8=; b=eGa0WjGRroXPZTi8O2Wk0Q29XH
	97yE/rZFvgQqRjLHzLQ27ci2sGLA5w9syKGYQfJpgRi88gX/FHiNGxnHBDOLTJb7ZW4/rITpaAell
	kcYfh1T/TAJKaHwCUH4HzczsOZaY/NJ66B6mrsPszDadwM8QI906Mco21hD40cWWPzjfoC+NNzBjU
	luEue2hqhuG+Kpv5tNWzhUukC9RM7ZsapGZNIY/fNoSwvE3ZZwEE7GiRQplhkPlqDGRkSBq44oL7W
	lubiPcROyfhiAEyR5QEpo2gULfsamB15qmXYX9Z5HQU9/VnHw1900iuEvhnWOOpTaSh5g6HMoIgve
	2PbPXboA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10hu-0000000D6Tc-36jh;
	Tue, 23 Sep 2025 10:57:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v10hr-0000000D6T6-3z8F
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 10:57:13 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N0umeM021229;
	Tue, 23 Sep 2025 10:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IOqxp6
	rWW44C1pEjNsMPWrJzOhxqGJ0oJ538Blit5M8=; b=NRb/7/0v1CIi+ZWXsSexbs
	fbsO4k2oArXt2BbxxmTV3BgjLYximFST6Vf6tZZKJ4a/IAItBs4Lj8Zj8aQ9xUgR
	oDiTgE7e0WotXK0Bcm2/ZCBk52annVqWnKZan9sn3MRC6eLE2I1blG+iKmAPaeIL
	Y+JhviXLIsSe2Nlrs9q+CXQ93nfir9ttzfmLnrjhd1veASn04+GLJNmfBUiMGMPZ
	J2G5EeVL9H2/rBHliuDVNOw5LiZD6uFwyrtRb0UQ7wTEOxZuTSAIuBlwQzCvJQzA
	zkNTgSIzmbIhRilTkpxH+aTtVtwloNASuhm0oLsx8su93LJeeTyIgn3eo3Uhkd+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq89v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 10:57:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58N93xY9031129;
	Tue, 23 Sep 2025 10:57:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vd3wvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 10:57:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NAur6L13042302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 10:56:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D54458043;
	Tue, 23 Sep 2025 10:57:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429F958059;
	Tue, 23 Sep 2025 10:57:01 +0000 (GMT)
Received: from [9.43.127.180] (unknown [9.43.127.180])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 10:57:00 +0000 (GMT)
Message-ID: <dc123d3e-2d33-4bb1-9f30-cb60aa2e0c98@linux.ibm.com>
Date: Tue, 23 Sep 2025 16:26:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] nvme-multipath: add support for adaptive I/O
 policy
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-3-nilay@linux.ibm.com>
 <70beea89-0ba2-4300-a109-b8d2103fe4d6@suse.de>
 <7e82159d-9e7d-415d-954b-985777ba41e7@linux.ibm.com>
 <25a6ed74-70bf-4230-993b-de4fbaea16a7@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <25a6ed74-70bf-4230-993b-de4fbaea16a7@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d27d02 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Q0N2y4tA3tniAjGL18oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7c6ZzD9xjkEt8rwnCn3VhgAaMwaFNLYs
X-Proofpoint-GUID: 7c6ZzD9xjkEt8rwnCn3VhgAaMwaFNLYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX60S2tzuXMrF9
 icxEam62s5WqyiSA1zxtJMvyTYlfZ6nPEsxSb7b4gAih2Haig/zoJhVFnepJ5MwYTWqcd5neVGD
 q9nAaa9v9n+7EBPUrQ4ellledooq2E8PfuOF9V4GPQ/4cNYnLc8Kcd0jx5kiR0z5QjzU2Pf3dfd
 J47RYjrVGr7hdHQrgZqivZu3mfU7v1VPyySEq5VxYRw4kYYD8ERZ7P5SU3QvHS6NL15jALY6AY9
 tXPY/qxrF0uoWzljW6R7/GiAS6XdMYEl0lMmA1WHvTWDW6gQUPltGsEqrwpkRCz2NEX04jLuL0T
 glrFAXu7FL56nJv7e1LCvw/iwMGuZLR4rnBlumV7MTGnVeQdn6LCzyGUQaudl/O/aHvsemFet5V
 raJOlDOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_035712_469039_086C2250 
X-CRM114-Status: GOOD (  46.25  )
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



On 9/23/25 12:33 PM, Hannes Reinecke wrote:
> On 9/23/25 05:43, Nilay Shroff wrote:
>>
>>
>> On 9/22/25 1:00 PM, Hannes Reinecke wrote:
>>> On 9/21/25 13:12, Nilay Shroff wrote:
> [ .. ]>>> +        srcu_idx = srcu_read_lock(&head->srcu);
>>>> +        list_for_each_entry_srcu(cur_ns, &head->list, siblings,
>>>> +                srcu_read_lock_held(&head->srcu)) {
>>>
>>> And this is even more awkward as we need to iterate over all paths
>>> (during completion!).
>>>
>> Hmm yes, but we only iterate once every ~15 seconds per CPU, so the overhead is minimal.
>> Typically we don’t have a large number of paths to deal with: enterprise SSDs usually
>> expose at most two controllers, and even in fabrics setups the path count is usually
>> limited to around 4–6. So the loop should run quite fast.
> 
> Hmm. Not from my experience. There is at least one implementation from a
> rather substantial array vendor exposing up to low hundreds of queues.
> 
Sorry but I think we're discussing two different thing here? I'm referring
to the nvme paths (i.e. nvmeXcYnz) and probably you're referring to the 
DMA queues or hw I/O queues. If that's true then yes some enterprise SSD
may expose low hundreds of queues, for instance, on my SSD I see 128 queues
being supported:
# nvme get-feature -f 0x7 /dev/nvme0 -H 
get-feature:0x07 (Number of Queues), Current value:0x007f007f
	Number of IO Completion Queues Allocated (NCQA): 128
	Number of IO Submission Queues Allocated (NSQA): 128

But when it comes to the nvme paths, that should be limited (mostly single 
digit). So my point was iterating those paths (and that's what the above 
code implements) shouldn't be expensive. But please correct me if my
assumption was wrong.  

>> Also, looping in itself isn’t unusual — for example, the queue-depth I/O policy already
>> iterates over all paths in the submission path to check queue depth before dispatching each
>> I/O. That said, if looping in the completion path is still a concern, we could consider
>> moving this into a dedicated worker thread instead. What do you think?
>>
> 
> Not sure if that's a good idea; either the worker thread runs
> asynchronous to the completion and then we have to deal with reliably
> adding up numbers, or we're running synchronous and lose performance.
> Still think that _not_ iterating and just adding up single-cpu latencies
> might be worthwhile.
> 
Yes worker thread should run asynchronously with completion and we can 
deal with it in one of the two ways:
- If accuracy is critical, we could use atomic counters (e.g. atomic_cmpxchg)
  to update batch counts and calculate path weights asynchronously in the worker.

- If a small skew is acceptable, snapshot-and-reset is sufficient. Since EWMA
  smoothing absorbs micro-errors, missing 1–2 samples in a 15s window at real
  I/O rates is negligible. Many kernel subsystems (block stats, net flow stats,
  etc.) already rely on snapshot-and-reset without atomic, exactly for this reason.

IMO, for the adaptive policy, we don’t need atomic_xchg() unless we’re chasing
perfect stats. Snapshot-and-reset per-CPU accumulators is good enough, because
EWMA smoothing and weight recalculation will easily absorb micro-errors. So what
do you prefer if in case we choose worker thread?

>>> Do we really need to do this?
>>> What would happen if we just measure the latency on the local CPU
>>> and do away with this loop?
>>> We would have less samples, true, but we would even be able to
>>> not only differentiate between distinct path latency but also between
>>> different CPU latencies; I would think this being a bonus for
>>> multi-socket machines.
>>>
>> The idea is to keep per-cpu view consistent for each path. As we know,
>> in NVMe/fabrics multipath, submission and completion CPUs don’t necessarily
>> match (depends on the host’s irq/core mapping). And so if we were to measure
>> the latency/EWMA locally per-cpu then the per-CPU accumulator might be biased
>> towards the completion CPU, not the submission CPU. For instance, if submission
>> is on CPU A but completion lands on CPU B, then CPU A’s weights never reflect
>> it's I/O experience — they’ll be skewed by how interrupts get steered.
>>
> True. Problem is that for the #CPUs > #queues we're setting up a cpu
> affinity group, and interrupts are directed to one of the CPU in that
> group. I had hoped that the blk-mq code would raise a softirq in that
> case and call .end_request on the cpu registered in the request itself.
> Probably need to be evaluated.
> 
I already evaluated this. If completion ends up on a cpu which is different 
from the submission cpu then yes block layer code may raise softirq to steer
the completion on the same cpu as submission. But this is not guaranteed always.
For instance if poll queues are used for submission then submission and 
completion on the same cpu is not guaranteed. Similarly, if threaded 
interrupt is configured then this is not guaranteed. In fact blk-mq
also supports a flag named QUEUE_FLAG_SAME_FORCE which forces completion 
on the same CPU as the submission CPU. But again this flags also doesn't
work always if we have poll-queue or thread interrupt is configured.
Please refer blk_mq_complete_request_remote().

>> So on a multi socket/NUMA systems, depending on topology, calculating local
>> per-cpu ewma/latency may or may not line up. For example:
>>
>> - If we have #cpu <= #vectors supported by NVMe disk then typically
>>    we have 1:1 mapping between submission and completion queues and hence all completions for
>>    a queue are steered to the same CPU that also submits, then per-CPU stats are accurate.
>>
>> - But when #CPUs > #vectors, completions may be centralized or spread differently. In that
>>    case, the per-CPU latency view can be distorted — e.g., CPU A may submit, but CPU B takes
>>    completions, so CPU A’s weights never reflect its own I/O behavior.
>>
> See above. We might check if blk-mq doesn't cover for this case already.
> Thing is, I actually _do_ want to measure per-CPU latency.
> On a multi-socket system it really does matter whether an I/O is run
> from a CPU on the socket attached to the PCI device, or from an
> off-socket CPU. If we are calculating just the per-path latency
> we completely miss that (as blk-mq will spread out across _all_
> cpus), but if we are measuring a per-cpu latency we will end up
> with a differential matrix where cpus with the lowest latency
> will be preferred.
> So if we have a system with two sockets and two PCI HBAs, each
> connected to a different socket, using per-path latency will be
> spreading out I/Os across all cpus. Using per-cpu latency will
> direct I/Os to the cpus with the lowest latency, preferring
> the local cpus.
> 
Yes, agreed and so in this proposed patch we measure per-cpu latency and 
_NOT_ per-path latency. Measuring the per-cpu latency and using it for
forwarding I/O is ideal for multi socket/NUMA systems. 

>>> _And_ we wouldn't need to worry about path failures, which is bound
>>> to expose some race conditions if we need to iterate paths at the
>>> same time than path failures are being handled.
>>>
>> Yes agreed we may have some race here and so the path score/weight may be
>> skewed when that happens but then that'd be auto-corrected in the next epoc
>> (after ~15 sec) when we re-calculate the path weight/score again, isn't it?
>>
> Let's see. I still would want to check if we can't do per-cpu
> statistics, as that would automatically avoid any races :-)
>
As I mentioned above, there are certain use cases (like poll-queues, threaded
interrupts etc.) where submission and completion could happen on different CPUs,
so we have to account for such cases and cross over CPU while accumulating the 
batch latency.

Thanks,
--Nilay
 

