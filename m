Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF5AC3271E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJUd5tL2vXKA3/FKGBq5j51mcK0X00rTSZvqD7g81PE=; b=u+fDKB8DNvgi8N/rM3dmU07aQS
	qA5jBEcjkZEDGrkFdsYwtf/onSWXpZ1fC/YeRnkz8suf3eNrsrlv/T/OPKPOItz6takDnNem6Djf3
	Qzzsu9dz9BhmkJNUDDfaSGikJ5hq8WP43yRiC1zhNxZCmfmIKwSjULWVP2mouy6UL7xeUTb/fR89d
	/NAuWoicd6oTrUOLJjU1ZwmfP3O527ubdEVmw6TgX0qQ107nGn4b9aOGYvakdOJ4ax2C8lkQfaxPu
	4X4mym69IMvLudYz8oZOpn6eRl29M21HR40zxMEaQsX4KoifKtQbnoU9/ZB4bNbxiJahtkMrK44RU
	9XAakobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPN3Z-0000000DNGV-3r5C;
	Thu, 04 Jul 2024 14:03:29 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPN3V-0000000DNF0-0fow
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 14:03:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A435C1F7C4;
	Thu,  4 Jul 2024 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720101803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJUd5tL2vXKA3/FKGBq5j51mcK0X00rTSZvqD7g81PE=;
	b=rDYnNy1DFBofNLni8N+U2l1NMyTnbC7a9ApGB2MPt/1qx9qQr6DX4Ryiaj9gW2aTPOwhtd
	wg29gVYDUPj8at6NAnPY1vhTNejlAxGKJerhH1h85GeHbAN66w9RevGZDyyIPcviDFTVp5
	M0sAumyUQ6UozM1cuhiUct5npOVnbPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720101803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJUd5tL2vXKA3/FKGBq5j51mcK0X00rTSZvqD7g81PE=;
	b=LEmPgtwqs3hfrz9lynP6qtpVYSJYQ0ekK/QxZ/bajRKIEdCR2Qua/h/dI1Nt2swGDHfdMU
	m9339L44r10Q3TBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rDYnNy1D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LEmPgtwq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720101803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJUd5tL2vXKA3/FKGBq5j51mcK0X00rTSZvqD7g81PE=;
	b=rDYnNy1DFBofNLni8N+U2l1NMyTnbC7a9ApGB2MPt/1qx9qQr6DX4Ryiaj9gW2aTPOwhtd
	wg29gVYDUPj8at6NAnPY1vhTNejlAxGKJerhH1h85GeHbAN66w9RevGZDyyIPcviDFTVp5
	M0sAumyUQ6UozM1cuhiUct5npOVnbPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720101803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJUd5tL2vXKA3/FKGBq5j51mcK0X00rTSZvqD7g81PE=;
	b=LEmPgtwqs3hfrz9lynP6qtpVYSJYQ0ekK/QxZ/bajRKIEdCR2Qua/h/dI1Nt2swGDHfdMU
	m9339L44r10Q3TBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9174F1369F;
	Thu,  4 Jul 2024 14:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qNPMIqurhmZfKgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 04 Jul 2024 14:03:23 +0000
Message-ID: <33fd9417-28e2-45aa-9b8a-c27c84f54ac7@suse.de>
Date: Thu, 4 Jul 2024 16:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme-tcp: align I/O cpu with blk-mq mapping
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
 <2ea2706d-65a1-419e-aa96-6ca353d954e0@suse.de>
 <37c87a22-ef34-4ed7-ab6c-14c23b11adef@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <37c87a22-ef34-4ed7-ab6c-14c23b11adef@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A435C1F7C4
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_070325_528366_244F2FDC 
X-CRM114-Status: GOOD (  51.56  )
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

On 7/4/24 11:07, Sagi Grimberg wrote:
> 
> 
> On 7/4/24 09:43, Hannes Reinecke wrote:
>> On 7/3/24 21:38, Sagi Grimberg wrote:
>> [ .. ]
>>>>>
>>>>> We should make the io_cpu come from blk-mq hctx mapping by default, 
>>>>> and for every controller it should use a different cpu from the 
>>>>> hctx mapping. That is the default behavior. in the wq_unbound case, 
>>>>> we skip all of that and make io_cpu = WORK_CPU_UNBOUND, as it was 
>>>>> before.
>>>>>
>>>>> I'm not sure I follow your logic.
>>>>>
>>>> Hehe. That's quite simple: there is none :-)
>>>> I have been tinkering with that approach in the last weeks, but got 
>>>> consistently _worse_ results than with the original implementation.
>>>> So I gave up on trying to make that the default.
>>>
>>> What is the "original implementation" ?
>>
>> nvme-6.10
>>
>>> What is you target? nvmet?
>>
>> nvmet with brd backend
>>
>>> What is the fio job file you are using?
>>
>> tiobench-example.fio from the fio samples
>>
>>> what is the queue count? controller count?
>>
>> 96 queues, 4 subsystems, 2 controller each.
>>
>>> What was the queue mapping?
>>>
>> queue 0-5 maps to cpu 6-11
>> queue 6-11 maps to cpu 54-59
>> queue 12-17 maps to cpu 18-23
>> queue 18-23 maps to cpu 66-71
>> queue 24-29 maps to cpu 24-29
>> queue 30-35 maps to cpu 72-77
>> queue 36-41 maps to cpu 30-35
>> queue 42-47 maps to cpu 78-83
>> queue 48-53 maps to cpu 36-41
>> queue 54-59 maps to cpu 84-89
>> queue 60-65 maps to cpu 42-47
>> queue 66-71 maps to cpu 90-95
>> queue 72-77 maps to cpu 12-17
>> queue 78-83 maps to cpu 60-65
>> queue 84-89 maps to cpu 0-5
>> queue 90-95 maps to cpu 48-53
> 
> What are the io_cpu for each queue?
> 
These are the io_cpu mappings; 'maps to' means the value of io_cpu.
IE queue 0 has the io_cpu value of 6.

>>
>>> Please lets NOT condition any of this on wq_unbound option at this 
>>> point. This modparam was introduced to address
>>> a specific issue. If we see IO timeouts, we should fix them, not tell 
>>> people to filp a modparam as a solution.
>>>
>> Thing is, there is no 'best' solution. The current implementation is 
>> actually quite good in the single subsystem case. Issues start to appear
>> when doing performance testing with a really high load.
>> Reason for this is a high contention on the per-cpu workqueues, which 
>> are simply overwhelmed by doing I/O _and_ servicing 'normal' OS workload
>> like writing do disk etc.
> 
> What other 'normal' workloads are you seeing in your test?
> 
Well, it is an OS, after all. And that OS has some housekeeping to do 
like writing out the fio output etc.

>> Switching to wq_unbound reduces the contention and makes the system to 
>> scale better, but that scaling leads to a performance regression for
>> the single subsystem case.
> 
> The kthreads are the same kthreads, the only difference is concurrency 
> management, which may take advantage of different cpu cores, but pays
> a price in latency and bouncing cpus.
> 
Precisely. That's why I'm seeing a slightly better performance for the
existing implementation and single subsystems.

>> (See my other mail for performance numbers)
>> So what is 'better'?
> 
> Which email? To Tejun? it seems that bound is better than unbound for 
> all cases. You are suggesting that you regress with multiple controllers
> though. That is why I suggested that we _spread_ queue io_cpu 
> assignments for the bound case (as I suggested in your first attempt), 
> I'd want to see what happens in this case.
> 
Correct; this is for the single subsystem case.
For which the current implementation is more efficient than the unbound one.

>>
>>>>
>>>>>>
>>>>>> And it makes the 'CPU hogged' messages go away, which is a bonus 
>>>>>> in itself...
>>>>>
>>>>> Which messages? aren't these messages saying that the work spent 
>>>>> too much time? why are you describing the case where the work does 
>>>>> not get
>>>>> cpu quota to run?
>>>>
>>>> I means these messages:
>>>>
>>>> workqueue: nvme_tcp_io_work [nvme_tcp] hogged CPU for >10000us 32771 
>>>> times, consider switching to WQ_UNBOUND
>>>
>>> That means that we are spending too much time in io_work, This is a 
>>> separate bug. If you look at nvme_tcp_io_work it has
>>> a stop condition after 1 millisecond. However, when we call 
>>> nvme_tcp_try_recv() it just keeps receiving from the socket until
>>> the socket receive buffer has no more payload. So in theory nothing 
>>> prevents from the io_work from looping there forever.
>>>
>> Oh, no. It's not the loop which is the problem. It's the actual sending
>> which takes long; in my test runs I've seen about 250 requests timing 
>> out, the majority of which was still pending on the send_list.
>> So the io_work function wasn't even running to fetch the requests off 
>> the list.
> 
> That, is unexpected. This means that either the socket buffer is full 
> (is it?), or that the rx is taking a long time, taking
> away tx cpu time. I am not sure I understand why would unbound wq would 
> solve either other than maybe hide it in
> some cases.
> 
> In what workloads do you see this issue? reads/writes?
> 
Both, unfortunately.
Funny data point, though: for 2 subsystems I see I/O timeouts when 
writing the fio log to disk. There are no I/O timeouts when fio just
prints to stdout.
So it _is_ the OS which drives up starvation.

> Can you try the following patch:
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0b04a2bde81d..3360de9ef034 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -350,7 +350,7 @@ static inline void nvme_tcp_advance_req(struct 
> nvme_tcp_request *req,
>          }
>   }
> 
> -static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
> +static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   {
>          int ret;
> 
> @@ -358,6 +358,7 @@ static inline void nvme_tcp_send_all(struct 
> nvme_tcp_queue *queue)
>          do {
>                  ret = nvme_tcp_try_send(queue);
>          } while (ret > 0);
> +       return ret;
>   }
> 
>   static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue 
> *queue)
> @@ -1276,7 +1277,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                  int result;
> 
>                  if (mutex_trylock(&queue->send_mutex)) {
> -                       result = nvme_tcp_try_send(queue);
> +                       result = nvme_tcp_send_all(queue);
>                          mutex_unlock(&queue->send_mutex);
>                          if (result > 0)
>                                  pending = true;
> -- 
> 
> Just to understand if there is a starvation problem where in io_work() 
> the tx is paced, but the rx is not.

Surprise, surprise, that does work.
Together with aligning io_cpu with the blk-mq mapping I see a 
substantial improvement for the 4 subsystem case; no I/O timeouts,
and contention as measured by the number of 'nvme_tcp_io_work [nvme_tcp] 
hogged CPU' messages has been reduced, too.
Performance impact is mixed; you win some, you lose some, with nothing
conclusive either way.

>>
>>> This is indeed a bug that we need to address. Probably by setting 
>>> rd_desc.count to some limit, decrement it for every
>>> skb that we consume, and if we reach that limit and there are more 
>>> skbs pending, we break and self-requeue.
>>>
>>> If we indeed spend much time processing a single queue in io_work, it 
>>> is possible that we have a starvation problem
>>> that is escalating to the timeouts you are seeing.
>>>
>> See above; this is the problem. Most of the requests are still stuck 
>> on the send_list (with some even still on the req_list) when timeouts 
>> occur. This means the io_work function is not being scheduled fast 
>> enough (or often enough) to fetch the requests from the list.
> 
> Or, maybe some other root-cause is creating a large backlog of send 
> requests.
> 
What definitely contributes to the backlog is cpu time starvation.
With the original implementation I can easily trigger I/O timeouts by
writing the fio output to disk; writing to stdout pretty much avoids
the I/O timeouts.

I see to get some latency numbers for send and receive.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


