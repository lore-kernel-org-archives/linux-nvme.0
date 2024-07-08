Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB919C3DA42
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/G7wxsve0Dt9ncJ3DugrXIZLnOkW1Vk/8W8S6NUfg0=; b=k68M6Z4AbM6dI9QBIoE0lT5DWl
	aLbXrMeMIYJQmqEpIZdUF/sfBs7le9Frv/9/7+n0qEG8N6E366c95zn2QfQute3pKifaUTCfOTbnM
	0+QsuBnzCj9/uyS6zyzUify7Sy5RHmvsyQl+/c8f01svQRYHYcZep9DImOupL0ECU7N5rOIwDXhx3
	9gpeSFgs53pPKxVNTzPoAkmGRlKLceiaGEHEQN6CscwnQhPHIsyiXDc5kVndvUP6ceUlI0J9J7L0O
	FHGM/kySLAyjhsCqypmlxlUBtNF2WltghqeV9VpCVREFeDpxuStQXtkSQIcWZv7vII49K3ZEE6Giz
	bClkmgZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQqe4-00000004IFW-3QC6;
	Mon, 08 Jul 2024 15:51:16 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQqe0-00000004IDn-12PA
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 15:51:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 664C31F444;
	Mon,  8 Jul 2024 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720453870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/G7wxsve0Dt9ncJ3DugrXIZLnOkW1Vk/8W8S6NUfg0=;
	b=owxpMrhRy0FVYTj6xK8wx2jeFgtt85lzds/8GV5nQLwcYUL1BboQ9qjJF1yTwclascztzE
	qqsehNH0ALLSv/HnNtB8ItsU4QgxJBCKIxXkiqy8D5Mb5yHj2AiVv9de3YHEsM7DgrJEmk
	kevbRIFX4Gt1U4xyCiOzhcGD/NhF+U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720453870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/G7wxsve0Dt9ncJ3DugrXIZLnOkW1Vk/8W8S6NUfg0=;
	b=G3Z7aJmmTaKqQ9pLGvbSek5/+4LbuYcLhn7Me/AAEDzkiNp+3/9QUbthtylVFKYqsXtId0
	LHXC+aDU1izz2sDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=owxpMrhR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=G3Z7aJmm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720453870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/G7wxsve0Dt9ncJ3DugrXIZLnOkW1Vk/8W8S6NUfg0=;
	b=owxpMrhRy0FVYTj6xK8wx2jeFgtt85lzds/8GV5nQLwcYUL1BboQ9qjJF1yTwclascztzE
	qqsehNH0ALLSv/HnNtB8ItsU4QgxJBCKIxXkiqy8D5Mb5yHj2AiVv9de3YHEsM7DgrJEmk
	kevbRIFX4Gt1U4xyCiOzhcGD/NhF+U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720453870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/G7wxsve0Dt9ncJ3DugrXIZLnOkW1Vk/8W8S6NUfg0=;
	b=G3Z7aJmmTaKqQ9pLGvbSek5/+4LbuYcLhn7Me/AAEDzkiNp+3/9QUbthtylVFKYqsXtId0
	LHXC+aDU1izz2sDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DF3513A7F;
	Mon,  8 Jul 2024 15:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dt+gCe4KjGbJJgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Jul 2024 15:51:10 +0000
Message-ID: <7d52a56b-2311-4f64-a0f4-383c5521e91c@suse.de>
Date: Mon, 8 Jul 2024 17:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-2-hare@kernel.org>
 <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
 <a54ac72e-f04f-4bb7-a9de-5a3d3d71d9c6@suse.de>
 <5334b2dd-23ab-4637-a762-e871f884db54@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5334b2dd-23ab-4637-a762-e871f884db54@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 664C31F444
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_085112_616932_7FB00BD5 
X-CRM114-Status: GOOD (  55.67  )
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

On 7/8/24 16:25, Sagi Grimberg wrote:
> 
> 
> On 08/07/2024 16:21, Hannes Reinecke wrote:
>> On 7/8/24 13:57, Sagi Grimberg wrote:
>>> Hey Hannes, thanks for doing this.
>>>
[ .. ]
>>> That is a significant decline in relative perf. I'm counting 12.5%...
>>> Can you explain why that is?
>>>
>> Not really :-(
>> But then fairness cuts both ways; so I am not surprised that some 
>> workloads suffer here.
> 
> Well, 12.5% is rather steep, don't you agree?
> I'm even more surprised that seq/rand read make a difference...
> 
Yeah; but I guess I found the issue now (we should interrupt data 
transfers if the deadline expires, not just pdu transfers).

[ .. ]
>>>
>>> I don't see why you need to keep this in the queue struct. You could 
>>> have
>>> easily initialize it in the read_descriptor_t and test against it.
>>>
>> Because I wanted to interrupt the receive side for large data 
>> transfers, and haven't found a way to pass the deadline into 
>> ->read_sock().
> 
> desc.count is for you to interpret however you want it to be no?
> 
Except for the magic 'desc.count == 0' value; but yeah, that should work.

>>
>>>>       /* send state */
>>>>       struct nvme_tcp_request *request;
>>>> @@ -359,14 +360,18 @@ static inline void nvme_tcp_advance_req(struct 
>>>> nvme_tcp_request *req,
>>>>       }
>>>>   }
>>>> -static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>>>> +static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue,
>>>> +                    unsigned long deadline)
>>>>   {
>>>>       int ret;
>>>>       /* drain the send queue as much as we can... */
>>>>       do {
>>>>           ret = nvme_tcp_try_send(queue);
>>>> +        if (time_after(jiffies, deadline))
>>>> +            break;
>>>>       } while (ret > 0);
>>>> +    return ret;
>>>
>>> I think you want a different interface, nvme_tcp_send_budgeted(queue, 
>>> budget).
>>> I don't know what you pass here, but jiffies is a rather large 
>>> granularity...
>>>
>> Hmm. I've been using jiffies as the io_work loop had been counting
>> in jiffies. But let me check what would happen if I move that over to
>> PDU / size counting.
> 
> Cool.
> 
>>
>>>>   }
>>>>   static inline bool nvme_tcp_queue_has_pending(struct 
>>>> nvme_tcp_queue *queue)
>>>> @@ -385,6 +390,7 @@ static inline void nvme_tcp_queue_request(struct 
>>>> nvme_tcp_request *req,
>>>>           bool sync, bool last)
>>>>   {
>>>>       struct nvme_tcp_queue *queue = req->queue;
>>>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>>       bool empty;
>>>>       empty = llist_add(&req->lentry, &queue->req_list) &&
>>>> @@ -397,7 +403,7 @@ static inline void nvme_tcp_queue_request(struct 
>>>> nvme_tcp_request *req,
>>>>        */
>>>>       if (queue->io_cpu == raw_smp_processor_id() &&
>>>>           sync && empty && mutex_trylock(&queue->send_mutex)) {
>>>> -        nvme_tcp_send_all(queue);
>>>> +        nvme_tcp_send_all(queue, deadline);
>>>>           mutex_unlock(&queue->send_mutex);
>>>>       }
>>>
>>> Umm, spend up to a millisecond in in queue_request ? Sounds like way 
>>> too much...
>>> Did you ever see this deadline exceeded? sends should be rather quick...
>>>
>> Of _course_ it's too long. That's kinda the point.
>> But I'm seeing network latency up to 4000 msecs (!) on my test setup,
>> so _that_ is the least of my worries ...
> 
> This has nothing to do with the network latency afaict. This is just a 
> matter of how long does it take to write to the socket buffer (or in our case, 
> construct skbs and add them to the socket as TX is zero copy).
> 
Not the transfer itself? I would have thought so ...

>>
>>>> @@ -959,9 +965,14 @@ static int nvme_tcp_recv_skb(read_descriptor_t 
>>>> *desc, struct sk_buff *skb,
>>>> nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>>>               return result;
>>>>           }
>>>> +        if (time_after(jiffies, queue->deadline)) {
>>>> +            desc->count = 0;
>>>> +            break;
>>>> +        }
>>>> +
>>>
>>> That is still not right.
>>> You don't want to spend a full deadline reading from the socket, and 
>>> then spend a full deadline writing to the socket...
>>>
>> Yes, and no.
>> Problem is that the current code serializes writes  and reads.
>> Essentially for each iteration we first to a write, and then a read.
>> If we spend the full deadline on write we will need to reschedule,
>> but we then _again_ start with writes. This leads to a heavy preference
>> for writing, and negative performance impact.
> 
> Yes, the assumption we should take is that the tx/rx limits allow to 
> switch between the
> two at least once or twice in the io_work while loop, and that they get 
> a fair'ish share
> of quota.
> 
>>
>>> You want the io_work to take a full deadline, and send budgets of 
>>> try_send and try_recv. And set it to sane counts. Say 8 pdus, or
>>> 64k bytes. We want to get to some magic value that presents a
>>> sane behavior, that confidently fits inside a deadline, and is fair.
>>>
>> Easier said than done.
>> Biggest problem is that most of the latency increase comes from the
>> actual 'sendmsg()' and 'read_sock()' calls.
> 
> This is a bit surprising. because read_sock reads data that is already
> processed by the tcp stack, and ready to simply copy back to the user
> pages. Same for sendmsg, the socket is non-blocking, so I would not
> expect it to stall for unusually long periods. Maybe there is an issue
> hiding in how we call send/recv?
> 
Hmm. That could be.

>> And the only way of inhibiting that would be to check _prior_ whether
>> we can issue the call in the first place.
>> (That's why I did the SOCK_NOSPACE tests in the previous patchsets).
> 
> The socket is non-blocking. I always thought that SOCK_NOSPACE is 
> serving blocking
> sockets... afaik, there shouldn't be a real difference between checking 
> NOSPACE vs.
> attempting sendmsg on a non-blocking socket... But I could be wrong here..
> 

Weellll ... if 'SOCK_NOSPACE' is for blocking sockets, why do we even 
get the 'write_space()' callback?
It gets triggered quite often, and checking for the SOCK_NOSPACE bit 
before sending drops the number of invocations quite significantly.

[  .. ]
>>>>                   break;
>>>>           }
>>>> -        result = nvme_tcp_try_recv(queue);
>>>> +        result = nvme_tcp_try_recv(queue, rx_deadline);
>>>
>>> I think you want a more frequent substitution of sends/receives. the 
>>> granularity of 1ms budget may be too coarse?
>>>
>> The problem is not the granularity, the problem is the latency spikes
>> I'm seeing when issuing 'sendmsg' or 'read_sock'.
> 
> I think that its possible that there is another underlying issue. 
> Because these calls
> should NOT be blocked for a long period of time for non-blocking sockets.
> 
I did some instrumentation, and that certainly pointed into that 
direction. But will have to redo that to get some meaningful data here.
Another point really might be the granularity; jiffies isn't a good 
measurement here (even with HZ=1000 we'll only have milliseconds 
granularity, so it might be that we're incurring fluctuations due to
jiffy calculation itself).

>>
>>>>           if (result > 0)
>>>>               pending = true;
>>>>           else if (unlikely(result < 0))
>>>> @@ -1302,7 +1315,13 @@ static void nvme_tcp_io_work(struct 
>>>> work_struct *w)
>>>>           if (!pending || !queue->rd_enabled)
>>>>               return;
>>>> -    } while (!time_after(jiffies, deadline)); /* quota is exhausted */
>>>> +    } while (!time_after(jiffies, rx_deadline)); /* quota is 
>>>> exhausted */
>>>> +
>>>> +    overrun = jiffies - rx_deadline;
>>>> +    if (nvme_tcp_queue_id(queue) > 0 &&
>>>> +        overrun > msecs_to_jiffies(10))
>>>> +        dev_dbg(queue->ctrl->ctrl.device, "queue %d: queue stall 
>>>> (%u msecs)\n",
>>>> +            nvme_tcp_queue_id(queue), jiffies_to_msecs(overrun));
>>>
>>> Umm, ok. why 10? why not 2? or 3?
>>> Do you expect io_work to spend more time executing?
>>>
>> Eg 4000 msecs like on my testbed?
> 
> If you see ANYTHING in the IO path stalling for 4 seconds then we have a 
> bigger issue here.
> 
You don't say ...

>> Yes.
>>
>>>>       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>>>   }
>>>> @@ -2666,6 +2685,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>>>> *hctx, struct io_comp_batch *iob)
>>>>   {
>>>>       struct nvme_tcp_queue *queue = hctx->driver_data;
>>>>       struct sock *sk = queue->sock->sk;
>>>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>>       if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>>>>           return 0;
>>>> @@ -2673,7 +2693,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>>>> *hctx, struct io_comp_batch *iob)
>>>>       set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>>>>       if (sk_can_busy_loop(sk) && 
>>>> skb_queue_empty_lockless(&sk->sk_receive_queue))
>>>>           sk_busy_loop(sk, true);
>>>> -    nvme_tcp_try_recv(queue);
>>>> +    nvme_tcp_try_recv(queue, deadline);
>>>
>>> spend a millisecond in nvme_tcp_poll() ??
>>> Isn't it too long?
>> Haven't tried with polling, so can't honestly answer.
>>
>> In the end, it all boils down to numbers.
>> I'm having 2 controllers with 32 queues and 256 requests.
>> Running on a 10GigE link one should be getting a net throughput
>> of 1GB/s, or, with 4k requests, 256k IOPS.
>> Or a latency of 0.25 milliseconds per command.
>> In the optimal case. As I'm seeing a bandwidth of around
>> 500MB/s, I'm looking at a latency 0.5 milliseconds _in the ideal case_.
>>
>> So no, I don't think the 1 milliseconds is too long.
> 
> nvme_tcp_poll is NOT designed to poll for the entirety or an individual 
> IO lifetime. Its
> a non-selective polling interface wired to io_uring. It should peek the 
> socket, consume what ever
> is there, and break. It most definitely should not spend 1ms in this 
> check...
Oh, I know that.
That's why I said: "Haven't tried with polling."

The calculation is independent on polling.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


