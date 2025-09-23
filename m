Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AC0CAC5A5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 07:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMr26ZBAm5xAMQM9ORYUjToBmIHJMFnv0jx88M3KXBA=; b=D51bHVw1hX6IUBPeasphEp4nTS
	Gm+lCsvVKueCVAzRfxffAvrW3nRIamiVjBuVii9zmxBIuHwgfRzWg61QpPBe9pU+H+vbsKicVob0I
	MoPqmOdF8cYsdp8t60G+h1zncX0TSTPnhZv6SpgGhPF+andi1S2OAXSc9DTJGNW9uVyA8ueKw0f0R
	UmcuS5s493dlhQ4SoUj8FzFyKSio/SRLW8lnNw1Wfvph4QBO20flts8/Tr2vF8V+bwKNO9idmwiZw
	J9c8uwbLv9ZBF3srPuVsdrfbb1k54RWDfIDPv/p8VZodHR543EEtLv23ZaZVkvN/crxAxZlaHOkkJ
	Rgz1kR7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0x3V-0000000Ccts-1QVp;
	Tue, 23 Sep 2025 07:03:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0x3S-0000000Ccrx-0WXI
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 07:03:15 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18CCC21A1A;
	Tue, 23 Sep 2025 07:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758610992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMr26ZBAm5xAMQM9ORYUjToBmIHJMFnv0jx88M3KXBA=;
	b=hrzYnIjsbfqUQGt54kuEKbSnMmkvAdlj1dkzrqeqrlGExI2gLS7Uz+c6w6LYxaJdysjoV/
	20uz+Y1/8isZmXtTGB0pycqwYxkfuB6BDxzEGbIqtOy9Ocod8z34+E6BGMu1UZVs5FP5ky
	kJMdMzT4FwC0PkXBuuOiSYXKHWM1OZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758610992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMr26ZBAm5xAMQM9ORYUjToBmIHJMFnv0jx88M3KXBA=;
	b=ScoDMCLfeRMpi7rvKMnlUAivLpwoM0rbEe3f6ec95uymux0pV/qvPncUdTMH6fU3GwNTzq
	ge3DpyTxYVJ/GeDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758610992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMr26ZBAm5xAMQM9ORYUjToBmIHJMFnv0jx88M3KXBA=;
	b=hrzYnIjsbfqUQGt54kuEKbSnMmkvAdlj1dkzrqeqrlGExI2gLS7Uz+c6w6LYxaJdysjoV/
	20uz+Y1/8isZmXtTGB0pycqwYxkfuB6BDxzEGbIqtOy9Ocod8z34+E6BGMu1UZVs5FP5ky
	kJMdMzT4FwC0PkXBuuOiSYXKHWM1OZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758610992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMr26ZBAm5xAMQM9ORYUjToBmIHJMFnv0jx88M3KXBA=;
	b=ScoDMCLfeRMpi7rvKMnlUAivLpwoM0rbEe3f6ec95uymux0pV/qvPncUdTMH6fU3GwNTzq
	ge3DpyTxYVJ/GeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B419D1388C;
	Tue, 23 Sep 2025 07:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ivgKC9G0mhMJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 23 Sep 2025 07:03:11 +0000
Message-ID: <25a6ed74-70bf-4230-993b-de4fbaea16a7@suse.de>
Date: Tue, 23 Sep 2025 09:03:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-3-nilay@linux.ibm.com>
 <70beea89-0ba2-4300-a109-b8d2103fe4d6@suse.de>
 <7e82159d-9e7d-415d-954b-985777ba41e7@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7e82159d-9e7d-415d-954b-985777ba41e7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_000314_516214_285075B0 
X-CRM114-Status: GOOD (  33.02  )
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

On 9/23/25 05:43, Nilay Shroff wrote:
> 
> 
> On 9/22/25 1:00 PM, Hannes Reinecke wrote:
>> On 9/21/25 13:12, Nilay Shroff wrote:
[ .. ]>>> +        srcu_idx = srcu_read_lock(&head->srcu);
>>> +        list_for_each_entry_srcu(cur_ns, &head->list, siblings,
>>> +                srcu_read_lock_held(&head->srcu)) {
>>
>> And this is even more awkward as we need to iterate over all paths
>> (during completion!).
>>
> Hmm yes, but we only iterate once every ~15 seconds per CPU, so the overhead is minimal.
> Typically we don’t have a large number of paths to deal with: enterprise SSDs usually
> expose at most two controllers, and even in fabrics setups the path count is usually
> limited to around 4–6. So the loop should run quite fast.

Hmm. Not from my experience. There is at least one implementation from a
rather substantial array vendor exposing up to low hundreds of queues.

> Also, looping in itself isn’t unusual — for example, the queue-depth I/O policy already
> iterates over all paths in the submission path to check queue depth before dispatching each
> I/O. That said, if looping in the completion path is still a concern, we could consider
> moving this into a dedicated worker thread instead. What do you think?
> 

Not sure if that's a good idea; either the worker thread runs
asynchronous to the completion and then we have to deal with reliably
adding up numbers, or we're running synchronous and lose performance.
Still think that _not_ iterating and just adding up single-cpu latencies
might be worthwhile.

>> Do we really need to do this?
>> What would happen if we just measure the latency on the local CPU
>> and do away with this loop?
>> We would have less samples, true, but we would even be able to
>> not only differentiate between distinct path latency but also between
>> different CPU latencies; I would think this being a bonus for
>> multi-socket machines.
>>
> The idea is to keep per-cpu view consistent for each path. As we know,
> in NVMe/fabrics multipath, submission and completion CPUs don’t necessarily
> match (depends on the host’s irq/core mapping). And so if we were to measure
> the latency/EWMA locally per-cpu then the per-CPU accumulator might be biased
> towards the completion CPU, not the submission CPU. For instance, if submission
> is on CPU A but completion lands on CPU B, then CPU A’s weights never reflect
> it's I/O experience — they’ll be skewed by how interrupts get steered.
> 
True. Problem is that for the #CPUs > #queues we're setting up a cpu
affinity group, and interrupts are directed to one of the CPU in that
group. I had hoped that the blk-mq code would raise a softirq in that
case and call .end_request on the cpu registered in the request itself.
Probably need to be evaluated.

> So on a multi socket/NUMA systems, depending on topology, calculating local
> per-cpu ewma/latency may or may not line up. For example:
> 
> - If we have #cpu <= #vectors supported by NVMe disk then typically
>    we have 1:1 mapping between submission and completion queues and hence all completions for
>    a queue are steered to the same CPU that also submits, then per-CPU stats are accurate.
> 
> - But when #CPUs > #vectors, completions may be centralized or spread differently. In that
>    case, the per-CPU latency view can be distorted — e.g., CPU A may submit, but CPU B takes
>    completions, so CPU A’s weights never reflect its own I/O behavior.
> 
See above. We might check if blk-mq doesn't cover for this case already.
Thing is, I actually _do_ want to measure per-CPU latency.
On a multi-socket system it really does matter whether an I/O is run
from a CPU on the socket attached to the PCI device, or from an
off-socket CPU. If we are calculating just the per-path latency
we completely miss that (as blk-mq will spread out across _all_
cpus), but if we are measuring a per-cpu latency we will end up
with a differential matrix where cpus with the lowest latency
will be preferred.
So if we have a system with two sockets and two PCI HBAs, each
connected to a different socket, using per-path latency will be
spreading out I/Os across all cpus. Using per-cpu latency will
direct I/Os to the cpus with the lowest latency, preferring
the local cpus.

>> _And_ we wouldn't need to worry about path failures, which is bound
>> to expose some race conditions if we need to iterate paths at the
>> same time than path failures are being handled.
>>
> Yes agreed we may have some race here and so the path score/weight may be
> skewed when that happens but then that'd be auto-corrected in the next epoc
> (after ~15 sec) when we re-calculate the path weight/score again, isn't it?
> 
Let's see. I still would want to check if we can't do per-cpu
statistics, as that would automatically avoid any races :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

