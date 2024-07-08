Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAFBC3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bL64+wZkU2iUfENWrhWVq9xKXTux9tKW9+b+BgRap68=; b=g+SXa6/pVa/2LuCEAXcNB0M9MB
	kdY0Cq+25FgcJuGFV6uJSZXwgxmxYYmpZjZau9S3tsumMl/yLOk3P6SyVlfB/ZsJDNhrNSjdFjWld
	kAx8dqgGUkcSe0M3XcwzthUUrKfdnNZGrK6ew5G7CBcce9vZIbo3Wp0vb4j/3LuJ02drxlz4VEhvn
	GUR9tO+Tukzjh/Wz10iznqBo/pjT1Lfftn5RuFueprndegMRf06NYd4zZV9QVOm43qeAub+jlEAKE
	FJ8Qp4vrvd5h2v3mTETCcnISAcruNu1KWog8zzNRJmVTmFglYs0GJpOyt/lATgsH2E/l5LaQFlARG
	jEw6iqOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpIl-000000043br-2Yrr;
	Mon, 08 Jul 2024 14:25:11 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpIh-000000043bG-41xR
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 14:25:09 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42111cf2706so4702375e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 07:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448705; x=1721053505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL64+wZkU2iUfENWrhWVq9xKXTux9tKW9+b+BgRap68=;
        b=NeH1tJSsAtVqQbJbC/dBDOUm7FWgg5NpOjHA/k580YiugGtwhrlvxBQ39IDKu28c1K
         rfuGzGyxyFdKwREHZjdPyDkCtJmKCWM+30ByRB8UB29rYIU5pEsyaluXkCWqEaOtcMA6
         TYCS02PUKwJO7vykwBxr2Jx0ZeHK/Zm9xMCiwRpqmoyqnj9VTgO2QD9oLGZV+NpkQw/T
         tTXh9DrgxuJkHGCX3pzugJc10JFOXlQJMOsdoduRmTWYHPVvmi6FPuXAIrm+2ndPqgLH
         0h9ZGpFX0N05T6tmosDVT61r0hkaV4ItYafhmt3wiZu7hjmUDhZftLEkQ/t/mQQJtbMU
         FILA==
X-Forwarded-Encrypted: i=1; AJvYcCUPNQA5KQYQ1DgHg9ppafSOnTjeE1X/4x7b6hGqnp7tFZnYbYkhnXZgSNiFRu/KwmCAzBzzEFb5Qrj1wxzVkcF0Ztp/2EmF4fPBnMpQ6Lg=
X-Gm-Message-State: AOJu0YzuOPpt+HFfXEBJPM1I5BBr/2vE5SaJnrG5N1LdltIOBilaR33D
	ZLReUypvtksDrs+e5V2xHffo4ffItUrfqb8bPimLgcZMeWPxAsW5
X-Google-Smtp-Source: AGHT+IHOMvYBP1f9Pay8CCFP1dwKa7iGuXiQXIqFahoeV6LL6ptELe9EmIDSloEWg2+CbDkxN1qMew==
X-Received: by 2002:a05:600c:4f03:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-4266358805emr33887955e9.4.1720448704790;
        Mon, 08 Jul 2024 07:25:04 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d16b0sm165949635e9.7.2024.07.08.07.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:25:04 -0700 (PDT)
Message-ID: <5334b2dd-23ab-4637-a762-e871f884db54@grimberg.me>
Date: Mon, 8 Jul 2024 17:25:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-2-hare@kernel.org>
 <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
 <a54ac72e-f04f-4bb7-a9de-5a3d3d71d9c6@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a54ac72e-f04f-4bb7-a9de-5a3d3d71d9c6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_072508_037614_5BC60101 
X-CRM114-Status: GOOD (  58.70  )
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



On 08/07/2024 16:21, Hannes Reinecke wrote:
> On 7/8/24 13:57, Sagi Grimberg wrote:
>> Hey Hannes, thanks for doing this.
>>
>> On 08/07/2024 10:10, Hannes Reinecke wrote:
>>> We need to restrict both side, rx and tx, to only run for a certain 
>>> time
>>> to ensure that we're not blocking the other side and induce starvation.
>>> So pass in a 'deadline' value to nvme_tcp_send_all()
>>
>> Please split the addition of nvme_tcp_send_all() to a separate prep 
>> patch.
>>
> Okay, no problem.
>
>>>   and nvme_tcp_try_recv()
>>> and break out of the loop if the deadline is reached.
>>
>> I think we want to limit the rx/tx in pdus/bytes. This will also 
>> allow us
>> to possibly do burst rx from data-ready.
>>
> PDUs is not the best scheduling boundary here, as each PDU can be of 
> different size, and the network interface most definitely is limited by
> the number of bytes transferred.

Well, PDUs is at least A proxy of bytes in terms of limits, but I agree 
bytes may be more appropriate.

>
>>>
>>> As we now have a timestamp we can also use it to print out a warning
>>> if the actual time spent exceeds the deadline.
>>>
>>> Performance comparison:
>>>                 baseline rx/tx fairness
>>> 4k seq write:  449MiB/s 480MiB/s
>>> 4k rand write: 410MiB/s 481MiB/s
>>> 4k seq read:   478MiB/s 481MiB/s
>>> 4k rand read:  547MiB/s 480MiB/s
>>>
>>> Random read is ever so disappointing, but that will be fixed with 
>>> the later
>>> patches.
>>
>> That is a significant decline in relative perf. I'm counting 12.5%...
>> Can you explain why that is?
>>
> Not really :-(
> But then fairness cuts both ways; so I am not surprised that some 
> workloads suffer here.

Well, 12.5% is rather steep, don't you agree?
I'm even more surprised that seq/rand read make a difference...

>
>
>> How does this look for multiple controllers?
>>
> Haven't really checked (yet); it would make a rather weak case if
> we killed performance just to scale better ...
>
>>
>>
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++---------
>>>   1 file changed, 29 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 0873b3949355..f621d3ba89b2 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -153,6 +153,7 @@ struct nvme_tcp_queue {
>>>       size_t            data_remaining;
>>>       size_t            ddgst_remaining;
>>>       unsigned int        nr_cqe;
>>> +    unsigned long        deadline;
>>
>> I don't see why you need to keep this in the queue struct. You could 
>> have
>> easily initialize it in the read_descriptor_t and test against it.
>>
> Because I wanted to interrupt the receive side for large data 
> transfers, and haven't found a way to pass the deadline into 
> ->read_sock().

desc.count is for you to interpret however you want it to be no?

>
>>>       /* send state */
>>>       struct nvme_tcp_request *request;
>>> @@ -359,14 +360,18 @@ static inline void nvme_tcp_advance_req(struct 
>>> nvme_tcp_request *req,
>>>       }
>>>   }
>>> -static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>>> +static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue,
>>> +                    unsigned long deadline)
>>>   {
>>>       int ret;
>>>       /* drain the send queue as much as we can... */
>>>       do {
>>>           ret = nvme_tcp_try_send(queue);
>>> +        if (time_after(jiffies, deadline))
>>> +            break;
>>>       } while (ret > 0);
>>> +    return ret;
>>
>> I think you want a different interface, nvme_tcp_send_budgeted(queue, 
>> budget).
>> I don't know what you pass here, but jiffies is a rather large 
>> granularity...
>>
> Hmm. I've been using jiffies as the io_work loop had been counting
> in jiffies. But let me check what would happen if I move that over to
> PDU / size counting.

Cool.

>
>>>   }
>>>   static inline bool nvme_tcp_queue_has_pending(struct 
>>> nvme_tcp_queue *queue)
>>> @@ -385,6 +390,7 @@ static inline void nvme_tcp_queue_request(struct 
>>> nvme_tcp_request *req,
>>>           bool sync, bool last)
>>>   {
>>>       struct nvme_tcp_queue *queue = req->queue;
>>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>       bool empty;
>>>       empty = llist_add(&req->lentry, &queue->req_list) &&
>>> @@ -397,7 +403,7 @@ static inline void nvme_tcp_queue_request(struct 
>>> nvme_tcp_request *req,
>>>        */
>>>       if (queue->io_cpu == raw_smp_processor_id() &&
>>>           sync && empty && mutex_trylock(&queue->send_mutex)) {
>>> -        nvme_tcp_send_all(queue);
>>> +        nvme_tcp_send_all(queue, deadline);
>>>           mutex_unlock(&queue->send_mutex);
>>>       }
>>
>> Umm, spend up to a millisecond in in queue_request ? Sounds like way 
>> too much...
>> Did you ever see this deadline exceeded? sends should be rather quick...
>>
> Of _course_ it's too long. That's kinda the point.
> But I'm seeing network latency up to 4000 msecs (!) on my test setup,
> so _that_ is the least of my worries ...

This has nothing to do with the network latency afaict. This is just a 
matter
of how long does it take to write to the socket buffer (or in our case, 
construct
skbs and add them to the socket as TX is zero copy).

>
>>> @@ -959,9 +965,14 @@ static int nvme_tcp_recv_skb(read_descriptor_t 
>>> *desc, struct sk_buff *skb,
>>> nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>>               return result;
>>>           }
>>> +        if (time_after(jiffies, queue->deadline)) {
>>> +            desc->count = 0;
>>> +            break;
>>> +        }
>>> +
>>
>> That is still not right.
>> You don't want to spend a full deadline reading from the socket, and 
>> then spend a full deadline writing to the socket...
>>
> Yes, and no.
> Problem is that the current code serializes writes  and reads.
> Essentially for each iteration we first to a write, and then a read.
> If we spend the full deadline on write we will need to reschedule,
> but we then _again_ start with writes. This leads to a heavy preference
> for writing, and negative performance impact.

Yes, the assumption we should take is that the tx/rx limits allow to 
switch between the
two at least once or twice in the io_work while loop, and that they get 
a fair'ish share
of quota.

>
>> You want the io_work to take a full deadline, and send budgets of 
>> try_send and try_recv. And set it to sane counts. Say 8 pdus, or
>> 64k bytes. We want to get to some magic value that presents a
>> sane behavior, that confidently fits inside a deadline, and is fair.
>>
> Easier said than done.
> Biggest problem is that most of the latency increase comes from the
> actual 'sendmsg()' and 'read_sock()' calls.

This is a bit surprising. because read_sock reads data that is already
processed by the tcp stack, and ready to simply copy back to the user
pages. Same for sendmsg, the socket is non-blocking, so I would not
expect it to stall for unusually long periods. Maybe there is an issue
hiding in how we call send/recv?

> And the only way of inhibiting that would be to check _prior_ whether
> we can issue the call in the first place.
> (That's why I did the SOCK_NOSPACE tests in the previous patchsets).

The socket is non-blocking. I always thought that SOCK_NOSPACE is 
serving blocking
sockets... afaik, there shouldn't be a real difference between checking 
NOSPACE vs.
attempting sendmsg on a non-blocking socket... But I could be wrong here..

>
>>>       }
>>> -    return consumed;
>>> +    return consumed - len;
>>>   }
>>>   static void nvme_tcp_data_ready(struct sock *sk)
>>> @@ -1258,7 +1269,7 @@ static int nvme_tcp_try_send(struct 
>>> nvme_tcp_queue *queue)
>>>       return ret;
>>>   }
>>> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>>> +static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, unsigned 
>>> long deadline)
>>>   {
>>>       struct socket *sock = queue->sock;
>>>       struct sock *sk = sock->sk;
>>> @@ -1269,6 +1280,7 @@ static int nvme_tcp_try_recv(struct 
>>> nvme_tcp_queue *queue)
>>>       rd_desc.count = 1;
>>>       lock_sock(sk);
>>>       queue->nr_cqe = 0;
>>> +    queue->deadline = deadline;
>>>       consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>>>       release_sock(sk);
>>>       return consumed;
>>> @@ -1278,14 +1290,15 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>   {
>>>       struct nvme_tcp_queue *queue =
>>>           container_of(w, struct nvme_tcp_queue, io_work);
>>> -    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>> +    unsigned long tx_deadline = jiffies + msecs_to_jiffies(1);
>>> +    unsigned long rx_deadline = tx_deadline + msecs_to_jiffies(1), 
>>> overrun;
>>>       do {
>>>           bool pending = false;
>>>           int result;
>>>           if (mutex_trylock(&queue->send_mutex)) {
>>> -            result = nvme_tcp_try_send(queue);
>>> +            result = nvme_tcp_send_all(queue, tx_deadline);
>>>               mutex_unlock(&queue->send_mutex);
>>>               if (result > 0)
>>>                   pending = true;
>>> @@ -1293,7 +1306,7 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>                   break;
>>>           }
>>> -        result = nvme_tcp_try_recv(queue);
>>> +        result = nvme_tcp_try_recv(queue, rx_deadline);
>>
>> I think you want a more frequent substitution of sends/receives. the 
>> granularity of 1ms budget may be too coarse?
>>
> The problem is not the granularity, the problem is the latency spikes
> I'm seeing when issuing 'sendmsg' or 'read_sock'.

I think that its possible that there is another underlying issue. 
Because these calls
should NOT be blocked for a long period of time for non-blocking sockets.

>
>>>           if (result > 0)
>>>               pending = true;
>>>           else if (unlikely(result < 0))
>>> @@ -1302,7 +1315,13 @@ static void nvme_tcp_io_work(struct 
>>> work_struct *w)
>>>           if (!pending || !queue->rd_enabled)
>>>               return;
>>> -    } while (!time_after(jiffies, deadline)); /* quota is exhausted */
>>> +    } while (!time_after(jiffies, rx_deadline)); /* quota is 
>>> exhausted */
>>> +
>>> +    overrun = jiffies - rx_deadline;
>>> +    if (nvme_tcp_queue_id(queue) > 0 &&
>>> +        overrun > msecs_to_jiffies(10))
>>> +        dev_dbg(queue->ctrl->ctrl.device, "queue %d: queue stall 
>>> (%u msecs)\n",
>>> +            nvme_tcp_queue_id(queue), jiffies_to_msecs(overrun));
>>
>> Umm, ok. why 10? why not 2? or 3?
>> Do you expect io_work to spend more time executing?
>>
> Eg 4000 msecs like on my testbed?

If you see ANYTHING in the IO path stalling for 4 seconds then we have a 
bigger issue here.

> Yes.
>
>>>       queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>>>   }
>>> @@ -2666,6 +2685,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>>> *hctx, struct io_comp_batch *iob)
>>>   {
>>>       struct nvme_tcp_queue *queue = hctx->driver_data;
>>>       struct sock *sk = queue->sock->sk;
>>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>       if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>>>           return 0;
>>> @@ -2673,7 +2693,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
>>> *hctx, struct io_comp_batch *iob)
>>>       set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>>>       if (sk_can_busy_loop(sk) && 
>>> skb_queue_empty_lockless(&sk->sk_receive_queue))
>>>           sk_busy_loop(sk, true);
>>> -    nvme_tcp_try_recv(queue);
>>> +    nvme_tcp_try_recv(queue, deadline);
>>
>> spend a millisecond in nvme_tcp_poll() ??
>> Isn't it too long?
> Haven't tried with polling, so can't honestly answer.
>
> In the end, it all boils down to numbers.
> I'm having 2 controllers with 32 queues and 256 requests.
> Running on a 10GigE link one should be getting a net throughput
> of 1GB/s, or, with 4k requests, 256k IOPS.
> Or a latency of 0.25 milliseconds per command.
> In the optimal case. As I'm seeing a bandwidth of around
> 500MB/s, I'm looking at a latency 0.5 milliseconds _in the ideal case_.
>
> So no, I don't think the 1 milliseconds is too long.

nvme_tcp_poll is NOT designed to poll for the entirety or an individual 
IO lifetime. Its
a non-selective polling interface wired to io_uring. It should peek the 
socket, consume what ever
is there, and break. It most definitely should not spend 1ms in this 
check...

