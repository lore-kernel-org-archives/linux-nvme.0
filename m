Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0770C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Z5hkM5YiDCjtXbtzdm5t1P7TKrmSPSWiK78I2mBAcY=; b=w6XUaIM0gFy8ZrKjhKn1N/qZi1
	x1CXbfR3IzIDzVX5562vtZLUWOWMMaF9/bXnWy1Sy7ZDiyuXy5aQTAcZSy1rzNCgHta9x0kuzaQRH
	PybBOdlXCio/BLJa6jXFxtmGB3hLpQyOwC7+4r4XR26NpF6uxWzmDS+hE14POfVZ3brQQNiTxMOEL
	EfL+6EElYSBVzIrUnymWz9yRs5R6DN2nAb6qW2XxTqgAHth5su5frKGpRJlhd7DXitpwcYbzD6eQd
	52o2+YByY6DRPGiZm9i67GrVUohh0J2xyA4z7P2LU4FsSU/dKg1O1ugcaSMS3Bkf7cbQPpPqheexY
	WNFpC/kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQu5b-00000004pp7-1YtZ;
	Mon, 08 Jul 2024 19:31:55 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQu5Y-00000004poD-2o66
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 19:31:54 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266ea4e4bdso873105e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 12:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467111; x=1721071911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z5hkM5YiDCjtXbtzdm5t1P7TKrmSPSWiK78I2mBAcY=;
        b=Vj3lOEK2cAreeXgLjZowx4LZAmjnXsp5LrqpC7zK6X6M/93IHMQB6fsyEk+QGbrdBN
         vu4ksKaXIDmyb59Do9Cs3jAbz4sauPh6qLUWFfMNzscExlSqkRFfWGhTeD2bXF2PrBlE
         I3YesGT+AyixqQhFHRr0SRQIjQEJyG400o0nT7Qx/RfOhko5D+pjGDs1yI6Zg2rZdzAI
         6SOfDvZb4YYo10QRQJV9Eo+w5j0Xwr5pj/E0jY6vLXjzX8ShZuxvYZJllJqn2n1ONcGA
         bXEzkE1lQpxxhWcXQ+rYoIm6DWrb1DzJJonp/kykhiFUJkkxSY+InzO5VhwwR0Sk+nqX
         Pnrw==
X-Forwarded-Encrypted: i=1; AJvYcCVxZWMgLpCdt/uNcr3u9eirDVUTAH2qSFf0unkRglm63HQRrBYah8xQxIPufqTX4SseuzqKbxa2OE6TOqqJ0bgpbUlvjU4zF/ko+GBkme4=
X-Gm-Message-State: AOJu0Yx8aozEPDxQ6xcrqx8aEdG4NRVsgcYHQjQl96jYS1XdBfnKoy/U
	b1cqm4nd/bEIVucYlUhk7e8qKp2D+A9OzeeEZ/48gy0VtxAgrOPo
X-Google-Smtp-Source: AGHT+IHgnl3yJC3mQhoYA8uF0FdBuc95XulKaT1cj3BxvVxlJPlArj0ZlH5PaS6Lmdf5hpu45ln/XA==
X-Received: by 2002:a5d:588d:0:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-367ceae243amr302300f8f.7.1720467109759;
        Mon, 08 Jul 2024 12:31:49 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d165bsm177292845e9.4.2024.07.08.12.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 12:31:49 -0700 (PDT)
Message-ID: <8013f402-4831-46c3-b207-c08821c15760@grimberg.me>
Date: Mon, 8 Jul 2024 22:31:48 +0300
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
 <5334b2dd-23ab-4637-a762-e871f884db54@grimberg.me>
 <7d52a56b-2311-4f64-a0f4-383c5521e91c@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7d52a56b-2311-4f64-a0f4-383c5521e91c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_123152_735848_B2B40541 
X-CRM114-Status: GOOD (  38.81  )
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



On 08/07/2024 18:50, Hannes Reinecke wrote:
> On 7/8/24 16:25, Sagi Grimberg wrote:
>>
>>
>> On 08/07/2024 16:21, Hannes Reinecke wrote:
>>> On 7/8/24 13:57, Sagi Grimberg wrote:
>>>> Hey Hannes, thanks for doing this.
>>>>
> [ .. ]
>>>> That is a significant decline in relative perf. I'm counting 12.5%...
>>>> Can you explain why that is?
>>>>
>>> Not really :-(
>>> But then fairness cuts both ways; so I am not surprised that some 
>>> workloads suffer here.
>>
>> Well, 12.5% is rather steep, don't you agree?
>> I'm even more surprised that seq/rand read make a difference...
>>
> Yeah; but I guess I found the issue now (we should interrupt data 
> transfers if the deadline expires, not just pdu transfers).
>
> [ .. ]
>>>>
>>>> I don't see why you need to keep this in the queue struct. You 
>>>> could have
>>>> easily initialize it in the read_descriptor_t and test against it.
>>>>
>>> Because I wanted to interrupt the receive side for large data 
>>> transfers, and haven't found a way to pass the deadline into 
>>> ->read_sock().
>>
>> desc.count is for you to interpret however you want it to be no?
>>
> Except for the magic 'desc.count == 0' value; but yeah, that should work.
>
>>>
>>>>>       /* send state */
>>>>>       struct nvme_tcp_request *request;
>>>>> @@ -359,14 +360,18 @@ static inline void 
>>>>> nvme_tcp_advance_req(struct nvme_tcp_request *req,
>>>>>       }
>>>>>   }
>>>>> -static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>>>>> +static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue,
>>>>> +                    unsigned long deadline)
>>>>>   {
>>>>>       int ret;
>>>>>       /* drain the send queue as much as we can... */
>>>>>       do {
>>>>>           ret = nvme_tcp_try_send(queue);
>>>>> +        if (time_after(jiffies, deadline))
>>>>> +            break;
>>>>>       } while (ret > 0);
>>>>> +    return ret;
>>>>
>>>> I think you want a different interface, 
>>>> nvme_tcp_send_budgeted(queue, budget).
>>>> I don't know what you pass here, but jiffies is a rather large 
>>>> granularity...
>>>>
>>> Hmm. I've been using jiffies as the io_work loop had been counting
>>> in jiffies. But let me check what would happen if I move that over to
>>> PDU / size counting.
>>
>> Cool.
>>
>>>
>>>>>   }
>>>>>   static inline bool nvme_tcp_queue_has_pending(struct 
>>>>> nvme_tcp_queue *queue)
>>>>> @@ -385,6 +390,7 @@ static inline void 
>>>>> nvme_tcp_queue_request(struct nvme_tcp_request *req,
>>>>>           bool sync, bool last)
>>>>>   {
>>>>>       struct nvme_tcp_queue *queue = req->queue;
>>>>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>>>       bool empty;
>>>>>       empty = llist_add(&req->lentry, &queue->req_list) &&
>>>>> @@ -397,7 +403,7 @@ static inline void 
>>>>> nvme_tcp_queue_request(struct nvme_tcp_request *req,
>>>>>        */
>>>>>       if (queue->io_cpu == raw_smp_processor_id() &&
>>>>>           sync && empty && mutex_trylock(&queue->send_mutex)) {
>>>>> -        nvme_tcp_send_all(queue);
>>>>> +        nvme_tcp_send_all(queue, deadline);
>>>>>           mutex_unlock(&queue->send_mutex);
>>>>>       }
>>>>
>>>> Umm, spend up to a millisecond in in queue_request ? Sounds like 
>>>> way too much...
>>>> Did you ever see this deadline exceeded? sends should be rather 
>>>> quick...
>>>>
>>> Of _course_ it's too long. That's kinda the point.
>>> But I'm seeing network latency up to 4000 msecs (!) on my test setup,
>>> so _that_ is the least of my worries ...
>>
>> This has nothing to do with the network latency afaict. This is just 
>> a matter of how long does it take to write to the socket buffer (or 
>> in our case, construct skbs and add them to the socket as TX is zero 
>> copy).
>>
> Not the transfer itself? I would have thought so ...

It may trigger push packets down to [tcp/ip]_output under some conditions,
but that is also not something that should block for long.

>
>>>
>>>>> @@ -959,9 +965,14 @@ static int 
>>>>> nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>>>>> nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>>>>>               return result;
>>>>>           }
>>>>> +        if (time_after(jiffies, queue->deadline)) {
>>>>> +            desc->count = 0;
>>>>> +            break;
>>>>> +        }
>>>>> +
>>>>
>>>> That is still not right.
>>>> You don't want to spend a full deadline reading from the socket, 
>>>> and then spend a full deadline writing to the socket...
>>>>
>>> Yes, and no.
>>> Problem is that the current code serializes writes  and reads.
>>> Essentially for each iteration we first to a write, and then a read.
>>> If we spend the full deadline on write we will need to reschedule,
>>> but we then _again_ start with writes. This leads to a heavy preference
>>> for writing, and negative performance impact.
>>
>> Yes, the assumption we should take is that the tx/rx limits allow to 
>> switch between the
>> two at least once or twice in the io_work while loop, and that they 
>> get a fair'ish share
>> of quota.
>>
>>>
>>>> You want the io_work to take a full deadline, and send budgets of 
>>>> try_send and try_recv. And set it to sane counts. Say 8 pdus, or
>>>> 64k bytes. We want to get to some magic value that presents a
>>>> sane behavior, that confidently fits inside a deadline, and is fair.
>>>>
>>> Easier said than done.
>>> Biggest problem is that most of the latency increase comes from the
>>> actual 'sendmsg()' and 'read_sock()' calls.
>>
>> This is a bit surprising. because read_sock reads data that is already
>> processed by the tcp stack, and ready to simply copy back to the user
>> pages. Same for sendmsg, the socket is non-blocking, so I would not
>> expect it to stall for unusually long periods. Maybe there is an issue
>> hiding in how we call send/recv?
>>
> Hmm. That could be.
>
>>> And the only way of inhibiting that would be to check _prior_ whether
>>> we can issue the call in the first place.
>>> (That's why I did the SOCK_NOSPACE tests in the previous patchsets).
>>
>> The socket is non-blocking. I always thought that SOCK_NOSPACE is 
>> serving blocking
>> sockets... afaik, there shouldn't be a real difference between 
>> checking NOSPACE vs.
>> attempting sendmsg on a non-blocking socket... But I could be wrong 
>> here..
>>
>
> Weellll ... if 'SOCK_NOSPACE' is for blocking sockets, why do we even 
> get the 'write_space()' callback?
> It gets triggered quite often, and checking for the SOCK_NOSPACE bit 
> before sending drops the number of invocations quite significantly.

I need to check, but where have you testing it? in the inline path?
Thinking further, I do agree that because the io_work is shared, we may
sendmsg immediately as space is becomes available instead of some 
minimum space.

Can you please quantify this with your testing?
How many times we get write_space() callback? how many times we get 
EAGAIN, and what
is the perf... Also interesting if this is more apparent in specific 
workloads. I'm assuming its
more apparent with large write workloads.

