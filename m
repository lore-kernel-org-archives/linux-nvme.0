Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D2C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gp39AURNEx9n2siFCjAr5lWvTQ+kPSFSdcdqIg8ohqs=; b=EpIX87GHBJVunCkDlXqtFE+dxE
	1fn1bFaHMzB8xuH96246fhK5dG1Uc5MtplM3TuqkXOxG5xbCi1pbX0OkdpbzU4mKHzR4XrSLmEiIL
	Vm10j3tOogKFdWgmAziD7pJOB5SdaJYFLFA21nRPnglfxsGcJPSXb4wMF9Tn2J9uYXg5mXmCMB0N7
	rbBfuNMaCBto8NJZg6456RHSPydCzlcAKhvU98cMCMCVGD6/gbQ3sUYjHqEninOKfMsFcI3wPEO1c
	mK/9nCMMCW0RW4+D9SHSfznYnfz+HcKmScuN1wyNWNZk4TOt5O9O8OMLtBId0H2H2FqQt6PAhgOZf
	1S05PY2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGBi-0000000CMxo-1MCM;
	Thu, 04 Jul 2024 06:43:26 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPGBd-0000000CMx4-0bx2
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 06:43:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44E3D21B9D;
	Thu,  4 Jul 2024 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720075399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp39AURNEx9n2siFCjAr5lWvTQ+kPSFSdcdqIg8ohqs=;
	b=tIHfmTW/GQO9Hl5d0/otN+AAgZqVbH91C5f4KHAUaRBmKQlcc85ZPngPmq6lhDXnjn+uMi
	3lKxQw3vE3yUt8J3nBvh5muZGdiYe8G5b1mI8gX9qtvUlrLfldoqcGb/UPQaZ6UgCZYSV8
	v6uiP8M1Wo2ECwagmAlxiYc3OCaWusY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720075399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp39AURNEx9n2siFCjAr5lWvTQ+kPSFSdcdqIg8ohqs=;
	b=Wqgk94/SkVFQKDpcVXMkR6PYyHHdND+tcjrwZap10N9lzSsWAxAFHPhV3qDL9LTGzxQ2pK
	2h/LBmJDeg3opTDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="tIHfmTW/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Wqgk94/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720075399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp39AURNEx9n2siFCjAr5lWvTQ+kPSFSdcdqIg8ohqs=;
	b=tIHfmTW/GQO9Hl5d0/otN+AAgZqVbH91C5f4KHAUaRBmKQlcc85ZPngPmq6lhDXnjn+uMi
	3lKxQw3vE3yUt8J3nBvh5muZGdiYe8G5b1mI8gX9qtvUlrLfldoqcGb/UPQaZ6UgCZYSV8
	v6uiP8M1Wo2ECwagmAlxiYc3OCaWusY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720075399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp39AURNEx9n2siFCjAr5lWvTQ+kPSFSdcdqIg8ohqs=;
	b=Wqgk94/SkVFQKDpcVXMkR6PYyHHdND+tcjrwZap10N9lzSsWAxAFHPhV3qDL9LTGzxQ2pK
	2h/LBmJDeg3opTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80E1413889;
	Thu,  4 Jul 2024 06:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P6LtOIVEhmaUKQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 04 Jul 2024 06:43:17 +0000
Message-ID: <2ea2706d-65a1-419e-aa96-6ca353d954e0@suse.de>
Date: Thu, 4 Jul 2024 08:43:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-3-hare@kernel.org>
 <b6702586-12c4-4390-9085-2cc6d9fbb462@grimberg.me>
 <11c0b02b-03a3-4097-948b-651b14baa0cf@suse.de>
 <9bc9d94f-a129-4c6e-ac9e-d0eb8db341b0@grimberg.me>
 <dc849cb6-8bf3-4363-9bd1-9b13138c0fb7@suse.de>
 <34d22ad9-1d10-44df-a131-c9aea18fde0c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <34d22ad9-1d10-44df-a131-c9aea18fde0c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 44E3D21B9D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_234321_368767_53B8B883 
X-CRM114-Status: GOOD (  35.60  )
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

On 7/3/24 21:38, Sagi Grimberg wrote:
[ .. ]
>>>
>>> We should make the io_cpu come from blk-mq hctx mapping by default, 
>>> and for every controller it should use a different cpu from the hctx 
>>> mapping. That is the default behavior. in the wq_unbound case, we 
>>> skip all of that and make io_cpu = WORK_CPU_UNBOUND, as it was before.
>>>
>>> I'm not sure I follow your logic.
>>>
>> Hehe. That's quite simple: there is none :-)
>> I have been tinkering with that approach in the last weeks, but got 
>> consistently _worse_ results than with the original implementation.
>> So I gave up on trying to make that the default.
> 
> What is the "original implementation" ?

nvme-6.10

> What is you target? nvmet?

nvmet with brd backend

> What is the fio job file you are using?

tiobench-example.fio from the fio samples

> what is the queue count? controller count?

96 queues, 4 subsystems, 2 controller each.

> What was the queue mapping?
> 
queue 0-5 maps to cpu 6-11
queue 6-11 maps to cpu 54-59
queue 12-17 maps to cpu 18-23
queue 18-23 maps to cpu 66-71
queue 24-29 maps to cpu 24-29
queue 30-35 maps to cpu 72-77
queue 36-41 maps to cpu 30-35
queue 42-47 maps to cpu 78-83
queue 48-53 maps to cpu 36-41
queue 54-59 maps to cpu 84-89
queue 60-65 maps to cpu 42-47
queue 66-71 maps to cpu 90-95
queue 72-77 maps to cpu 12-17
queue 78-83 maps to cpu 60-65
queue 84-89 maps to cpu 0-5
queue 90-95 maps to cpu 48-53

> Please lets NOT condition any of this on wq_unbound option at this 
> point. This modparam was introduced to address
> a specific issue. If we see IO timeouts, we should fix them, not tell 
> people to filp a modparam as a solution.
> 
Thing is, there is no 'best' solution. The current implementation is 
actually quite good in the single subsystem case. Issues start to appear
when doing performance testing with a really high load.
Reason for this is a high contention on the per-cpu workqueues, which 
are simply overwhelmed by doing I/O _and_ servicing 'normal' OS workload
like writing do disk etc.
Switching to wq_unbound reduces the contention and makes the system to 
scale better, but that scaling leads to a performance regression for
the single subsystem case.
(See my other mail for performance numbers)
So what is 'better'?

>>
>>>>
>>>> And it makes the 'CPU hogged' messages go away, which is a bonus in 
>>>> itself...
>>>
>>> Which messages? aren't these messages saying that the work spent too 
>>> much time? why are you describing the case where the work does not get
>>> cpu quota to run?
>>
>> I means these messages:
>>
>> workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 32771 
>> times, consider switching to WQ_UNBOUND
> 
> That means that we are spending too much time in io_work, This is a 
> separate bug. If you look at nvme_tcp_io_work it has
> a stop condition after 1 millisecond. However, when we call 
> nvme_tcp_try_recv() it just keeps receiving from the socket until
> the socket receive buffer has no more payload. So in theory nothing 
> prevents from the io_work from looping there forever.
> 
Oh, no. It's not the loop which is the problem. It's the actual sending
which takes long; in my test runs I've seen about 250 requests timing 
out, the majority of which was still pending on the send_list.
So the io_work function wasn't even running to fetch the requests off 
the list.

> This is indeed a bug that we need to address. Probably by setting 
> rd_desc.count to some limit, decrement it for every
> skb that we consume, and if we reach that limit and there are more skbs 
> pending, we break and self-requeue.
> 
> If we indeed spend much time processing a single queue in io_work, it is 
> possible that we have a starvation problem
> that is escalating to the timeouts you are seeing.
> 
See above; this is the problem. Most of the requests are still stuck on 
the send_list (with some even still on the req_list) when timeouts 
occur. This means the io_work function is not being scheduled fast 
enough (or often enough) to fetch the requests from the list.

My theory here is that this is due to us using bound workqueues;
each workqueue function has to execute on a given cpu, and we can
only schedule one io_work function per cpu. So if that cpu is busy
(with receiving packets, say, or normal OS tasks) we cannot execute,
and we're seeing a starvation.

With wq_unbound we are _not_ tied to a specific cpu, but rather
scheduled in a round-robin fashion. This avoids the starvation
and hence the I/O timeouts do not occur.
But we need to set the 'cpu' affinity for wq_unbound to keep
the cache locality, otherwise the performance _really_ suffers
as we're bouncing threads all over the place.

>>
>> which I get consistently during testing with the default implementation.
> 
> Hannes, let's please separate this specific issue with the performance 
> enhancements.
> I do not think that we should search for performance enhancements to 
> address what appears to be a logical starvation issue.

I am perfectly fine with that approach. This patchset is indeed just to 
address the I/O timeout issues I've been seeing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


