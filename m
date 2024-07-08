Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F883C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hPvsyIEBv8/mkjBb2jnVRCBhYu0VRbn7wtfLue03mZ0=; b=2wpdDzRhDSyNybbHKyUufpUTx2
	UiW1lnyWFRI6zdDQZwp2yqQZPkC6mbP0yrbIlDZvSO5GtA3A/a/aKrFj4MouFJi7oynjw1+xDTOQg
	+QnvfkCpTDxaD+DoVYTg/3WVQpheUqgIzNqG/ni8pFTr35OQx9DlEhTMXNq/wEST7VYNp95eLyh2D
	Dwu1MguksI41QQfsSt76tBpwfLvIYyIKZGU71EHcZ/RqnUXf/AfcumStIm+4cLY2suAnRVakL8pgT
	uNbCnLbAtE9NQr7dpn3HFfUYB4HqpShFzP2R+cHpcLuNpXxhxVZx4yx+rYulrPDPU8igkZYkgmLot
	e4qm61jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoJA-00000003tpc-0id0;
	Mon, 08 Jul 2024 13:21:32 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoJ5-00000003toi-0GsJ
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 13:21:30 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F42521AC8;
	Mon,  8 Jul 2024 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720444885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPvsyIEBv8/mkjBb2jnVRCBhYu0VRbn7wtfLue03mZ0=;
	b=wisygNq8u4O2NdpDjVMW6ja3YurhLJco80ed7v8MenYj2237Fs+OM8Z0t7UBQZfPR+0XOO
	NtJjNKkHT13cgC5ucAOwe5T7yDNI3lpGIuSKi9PMvNzgO9wxBq4L+Q5MAkknr1S9r/Iosc
	MzOOX2vemX6AncaNdjt+r3g3FwdXMjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720444885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPvsyIEBv8/mkjBb2jnVRCBhYu0VRbn7wtfLue03mZ0=;
	b=TaaslbSstnJWuOOvRnST+0CrJfNEXNmwQwwbesB+LDFVbF8o1VwW51e713sQOdt3lgx1d0
	DUi3chJEtaxuNOAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wisygNq8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TaaslbSs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720444885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPvsyIEBv8/mkjBb2jnVRCBhYu0VRbn7wtfLue03mZ0=;
	b=wisygNq8u4O2NdpDjVMW6ja3YurhLJco80ed7v8MenYj2237Fs+OM8Z0t7UBQZfPR+0XOO
	NtJjNKkHT13cgC5ucAOwe5T7yDNI3lpGIuSKi9PMvNzgO9wxBq4L+Q5MAkknr1S9r/Iosc
	MzOOX2vemX6AncaNdjt+r3g3FwdXMjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720444885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPvsyIEBv8/mkjBb2jnVRCBhYu0VRbn7wtfLue03mZ0=;
	b=TaaslbSstnJWuOOvRnST+0CrJfNEXNmwQwwbesB+LDFVbF8o1VwW51e713sQOdt3lgx1d0
	DUi3chJEtaxuNOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B0AE1396E;
	Mon,  8 Jul 2024 13:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lH8PCtXni2bKewAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Jul 2024 13:21:25 +0000
Message-ID: <a54ac72e-f04f-4bb7-a9de-5a3d3d71d9c6@suse.de>
Date: Mon, 8 Jul 2024 15:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-2-hare@kernel.org>
 <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4F42521AC8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_062127_483735_E1E0B0A8 
X-CRM114-Status: GOOD (  45.17  )
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

On 7/8/24 13:57, Sagi Grimberg wrote:
> Hey Hannes, thanks for doing this.
> 
> On 08/07/2024 10:10, Hannes Reinecke wrote:
>> We need to restrict both side, rx and tx, to only run for a certain time
>> to ensure that we're not blocking the other side and induce starvation.
>> So pass in a 'deadline' value to nvme_tcp_send_all()
> 
> Please split the addition of nvme_tcp_send_all() to a separate prep patch.
> 
Okay, no problem.

>>   and nvme_tcp_try_recv()
>> and break out of the loop if the deadline is reached.
> 
> I think we want to limit the rx/tx in pdus/bytes. This will also allow us
> to possibly do burst rx from data-ready.
> 
PDUs is not the best scheduling boundary here, as each PDU can be of 
different size, and the network interface most definitely is limited by
the number of bytes transferred.

>>
>> As we now have a timestamp we can also use it to print out a warning
>> if the actual time spent exceeds the deadline.
>>
>> Performance comparison:
>>                 baseline rx/tx fairness
>> 4k seq write:  449MiB/s 480MiB/s
>> 4k rand write: 410MiB/s 481MiB/s
>> 4k seq read:   478MiB/s 481MiB/s
>> 4k rand read:  547MiB/s 480MiB/s
>>
>> Random read is ever so disappointing, but that will be fixed with the 
>> later
>> patches.
> 
> That is a significant decline in relative perf. I'm counting 12.5%...
> Can you explain why that is?
> 
Not really :-(
But then fairness cuts both ways; so I am not surprised that some 
workloads suffer here.

> How does this look for multiple controllers?
> 
Haven't really checked (yet); it would make a rather weak case if
we killed performance just to scale better ...

> 
> 
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++---------
>>   1 file changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 0873b3949355..f621d3ba89b2 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -153,6 +153,7 @@ struct nvme_tcp_queue {
>>       size_t            data_remaining;
>>       size_t            ddgst_remaining;
>>       unsigned int        nr_cqe;
>> +    unsigned long        deadline;
> 
> I don't see why you need to keep this in the queue struct. You could have
> easily initialize it in the read_descriptor_t and test against it.
> 
Because I wanted to interrupt the receive side for large data transfers, 
and haven't found a way to pass the deadline into ->read_sock().

>>       /* send state */
>>       struct nvme_tcp_request *request;
>> @@ -359,14 +360,18 @@ static inline void nvme_tcp_advance_req(struct 
>> nvme_tcp_request *req,
>>       }
>>   }
>> -static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>> +static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue,
>> +                    unsigned long deadline)
>>   {
>>       int ret;
>>       /* drain the send queue as much as we can... */
>>       do {
>>           ret = nvme_tcp_try_send(queue);
>> +        if (time_after(jiffies, deadline))
>> +            break;
>>       } while (ret > 0);
>> +    return ret;
> 
> I think you want a different interface, nvme_tcp_send_budgeted(queue, 
> budget).
> I don't know what you pass here, but jiffies is a rather large 
> granularity...
> 
Hmm. I've been using jiffies as the io_work loop had been counting
in jiffies. But let me check what would happen if I move that over to
PDU / size counting.

>>   }
>>   static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue 
>> *queue)
>> @@ -385,6 +390,7 @@ static inline void nvme_tcp_queue_request(struct 
>> nvme_tcp_request *req,
>>           bool sync, bool last)
>>   {
>>       struct nvme_tcp_queue *queue = req->queue;
>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>       bool empty;
>>       empty = llist_add(&req->lentry, &queue->req_list) &&
>> @@ -397,7 +403,7 @@ static inline void nvme_tcp_queue_request(struct 
>> nvme_tcp_request *req,
>>        */
>>       if (queue->io_cpu == raw_smp_processor_id() &&
>>           sync && empty && mutex_trylock(&queue->send_mutex)) {
>> -        nvme_tcp_send_all(queue);
>> +        nvme_tcp_send_all(queue, deadline);
>>           mutex_unlock(&queue->send_mutex);
>>       }
> 
> Umm, spend up to a millisecond in in queue_request ? Sounds like way too 
> much...
> Did you ever see this deadline exceeded? sends should be rather quick...
> 
Of _course_ it's too long. That's kinda the point.
But I'm seeing network latency up to 4000 msecs (!) on my test setup,
so _that_ is the least of my worries ...

>> @@ -959,9 +965,14 @@ static int nvme_tcp_recv_skb(read_descriptor_t 
>> *desc, struct sk_buff *skb,
>>               nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>               return result;
>>           }
>> +        if (time_after(jiffies, queue->deadline)) {
>> +            desc->count = 0;
>> +            break;
>> +        }
>> +
> 
> That is still not right.
> You don't want to spend a full deadline reading from the socket, and 
> then spend a full deadline writing to the socket...
> 
Yes, and no.
Problem is that the current code serializes writes  and reads.
Essentially for each iteration we first to a write, and then a read.
If we spend the full deadline on write we will need to reschedule,
but we then _again_ start with writes. This leads to a heavy preference
for writing, and negative performance impact.

> You want the io_work to take a full deadline, and send budgets of 
> try_send and try_recv. And set it to sane counts. Say 8 pdus, or
> 64k bytes. We want to get to some magic value that presents a
> sane behavior, that confidently fits inside a deadline, and is fair.
> 
Easier said than done.
Biggest problem is that most of the latency increase comes from the
actual 'sendmsg()' and 'read_sock()' calls.
And the only way of inhibiting that would be to check _prior_ whether
we can issue the call in the first place.
(That's why I did the SOCK_NOSPACE tests in the previous patchsets).

>>       }
>> -    return consumed;
>> +    return consumed - len;
>>   }
>>   static void nvme_tcp_data_ready(struct sock *sk)
>> @@ -1258,7 +1269,7 @@ static int nvme_tcp_try_send(struct 
>> nvme_tcp_queue *queue)
>>       return ret;
>>   }
>> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>> +static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, unsigned 
>> long deadline)
>>   {
>>       struct socket *sock = queue->sock;
>>       struct sock *sk = sock->sk;
>> @@ -1269,6 +1280,7 @@ static int nvme_tcp_try_recv(struct 
>> nvme_tcp_queue *queue)
>>       rd_desc.count = 1;
>>       lock_sock(sk);
>>       queue->nr_cqe = 0;
>> +    queue->deadline = deadline;
>>       consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>>       release_sock(sk);
>>       return consumed;
>> @@ -1278,14 +1290,15 @@ static void nvme_tcp_io_work(struct 
>> work_struct *w)
>>   {
>>       struct nvme_tcp_queue *queue =
>>           container_of(w, struct nvme_tcp_queue, io_work);
>> -    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>> +    unsigned long tx_deadline = jiffies + msecs_to_jiffies(1);
>> +    unsigned long rx_deadline = tx_deadline + msecs_to_jiffies(1), 
>> overrun;
>>       do {
>>           bool pending = false;
>>           int result;
>>           if (mutex_trylock(&queue->send_mutex)) {
>> -            result = nvme_tcp_try_send(queue);
>> +            result = nvme_tcp_send_all(queue, tx_deadline);
>>               mutex_unlock(&queue->send_mutex);
>>               if (result > 0)
>>                   pending = true;
>> @@ -1293,7 +1306,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>                   break;
>>           }
>> -        result = nvme_tcp_try_recv(queue);
>> +        result = nvme_tcp_try_recv(queue, rx_deadline);
> 
> I think you want a more frequent substitution of sends/receives. the 
> granularity of 1ms budget may be too coarse?
> 
The problem is not the granularity, the problem is the latency spikes
I'm seeing when issuing 'sendmsg' or 'read_sock'.

>>           if (result > 0)
>>               pending = true;
>>           else if (unlikely(result < 0))
>> @@ -1302,7 +1315,13 @@ static void nvme_tcp_io_work(struct work_struct 
>> *w)
>>           if (!pending || !queue->rd_enabled)
>>               return;
>> -    } while (!time_after(jiffies, deadline)); /* quota is exhausted */
>> +    } while (!time_after(jiffies, rx_deadline)); /* quota is 
>> exhausted */
>> +
>> +    overrun = jiffies - rx_deadline;
>> +    if (nvme_tcp_queue_id(queue) > 0 &&
>> +        overrun > msecs_to_jiffies(10))
>> +        dev_dbg(queue->ctrl->ctrl.device, "queue %d: queue stall (%u 
>> msecs)\n",
>> +            nvme_tcp_queue_id(queue), jiffies_to_msecs(overrun));
> 
> Umm, ok. why 10? why not 2? or 3?
> Do you expect io_work to spend more time executing?
> 
Eg 4000 msecs like on my testbed?
Yes.

>>       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>   }
>> @@ -2666,6 +2685,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>> *hctx, struct io_comp_batch *iob)
>>   {
>>       struct nvme_tcp_queue *queue = hctx->driver_data;
>>       struct sock *sk = queue->sock->sk;
>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>       if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>>           return 0;
>> @@ -2673,7 +2693,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>> *hctx, struct io_comp_batch *iob)
>>       set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>>       if (sk_can_busy_loop(sk) && 
>> skb_queue_empty_lockless(&sk->sk_receive_queue))
>>           sk_busy_loop(sk, true);
>> -    nvme_tcp_try_recv(queue);
>> +    nvme_tcp_try_recv(queue, deadline);
> 
> spend a millisecond in nvme_tcp_poll() ??
> Isn't it too long?
Haven't tried with polling, so can't honestly answer.

In the end, it all boils down to numbers.
I'm having 2 controllers with 32 queues and 256 requests.
Running on a 10GigE link one should be getting a net throughput
of 1GB/s, or, with 4k requests, 256k IOPS.
Or a latency of 0.25 milliseconds per command.
In the optimal case. As I'm seeing a bandwidth of around
500MB/s, I'm looking at a latency 0.5 milliseconds _in the ideal case_.

So no, I don't think the 1 milliseconds is too long.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


