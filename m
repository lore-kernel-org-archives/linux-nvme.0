Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1919C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALkOLR2GbgTlCh1APD9eaYJPD+CXayMkm+sid4h2xhY=; b=nYuegNb8tQXvYpQSRS8cN9O/1e
	wxxmB3PxEZqVxgqCbjyVxsPV8nL4LpID2PTNHq4X6zhtBmyM+8AnF3d9jiM7DQo9WeEe1X1TvOBjF
	9MwxHniZK4luZjV5fhBN6+/9pPmxXXey2LLMrZIFl+uPjQCsWMsbiXMG7TEsGm3k1txj30S6P6JxZ
	UUhhGmt+aTbxqY9El6cgfIbu+PA6GXWRs3TGKMvINtCfnX439+K/nrv2/nra4SN7CxAKfYHMek1Gf
	npf2FHvCOaQr4CM9OUj60rdgpieC/CuKsaPt+zqXKqaj2yY8FRU/SMGSxnFJ8QYMWGCIhU/Tvq2X2
	l0MD4Erg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpWD-000000046K0-3IFT;
	Mon, 08 Jul 2024 14:39:05 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQpWA-000000046Hf-3XtT
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 14:39:04 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3679483091aso276651f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 07:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449540; x=1721054340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALkOLR2GbgTlCh1APD9eaYJPD+CXayMkm+sid4h2xhY=;
        b=bzHfRKXdBxBivPJkHTPyBT5A6WN2Ys1EQ3Za8IrBQ0yLTUzZbMSt6kH6J2CicJi5SB
         tjTKA+zwKbIigPuDcyaGrq6lPSH55pBOGhsswsDqmyfntoxsyuAD/VoXJbYlhVXUhJAh
         VXA4bBOUoIoMII48kGOUTS052923TGEIoXvCTGdhc/GVy/sQqwX9wERI+vQBS4LcP98g
         GuXhqccm7mNsNzNw12/IlE0U6Yur78+eF7Il5ezDVi+bf5NgODCTUE1ZsRCwoStz6FxJ
         RrJo8TgtsGqxHZmr0jsva/3Qs2hhH0tg9fUvlSOU5R4d8aDLhbY3bfQ9C6z0WFIcuTDI
         i8mw==
X-Forwarded-Encrypted: i=1; AJvYcCXnPcedqxP9o5xX/rqkBL3dGhHYDEt+UNCwoGzmTMNU8ZPpCC+m4RI8zyRJAs/iuxE0C+fpX1cBiKVwXS8z0TZE7us7xoD7rgOmh7XY0x8=
X-Gm-Message-State: AOJu0YxQK03h7i1jorUQuTkhfVB/KDooYxsGC6z5GRWwgs+BDJUGgkb7
	g/sr6jPK2ojT0AHOtXfexCQ4guSG8vxWWARTxpPD5B+e3lSMZBkQ
X-Google-Smtp-Source: AGHT+IFVRGgWK2VkNyQigvOVUDM2ruwFR/9Eg/6Sywt9sN+ZvNfcR+6QA5+uLYGpSNgGQidogb5VSg==
X-Received: by 2002:a05:6000:1788:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-3679dd73a60mr8624042f8f.6.1720449540423;
        Mon, 08 Jul 2024 07:39:00 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679887d58fsm12210772f8f.42.2024.07.08.07.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:39:00 -0700 (PDT)
Message-ID: <af15dbd5-56d0-4179-a898-51c1486f3260@grimberg.me>
Date: Mon, 8 Jul 2024 17:38:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-3-hare@kernel.org>
 <a089cc30-fe38-46fe-b953-83a8ada222fd@grimberg.me>
 <072f0e6b-8827-4b04-a374-0cfe228bd9d4@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <072f0e6b-8827-4b04-a374-0cfe228bd9d4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_073902_915291_998DD1E0 
X-CRM114-Status: GOOD (  34.26  )
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



On 08/07/2024 15:43, Hannes Reinecke wrote:
> On 7/8/24 14:08, Sagi Grimberg wrote:
>>
>>
>> On 08/07/2024 10:10, Hannes Reinecke wrote:
>>> We should align the 'io_cpu' setting with the blk-mq
>>> cpu mapping to ensure that we're not bouncing threads
>>> when doing I/O. To avoid cpu contention this patch also
>>> adds an atomic counter for the number of queues on each
>>> cpu to distribute the load across all CPUs in the blk-mq cpu set.
>>> Additionally we should always set the 'io_cpu' value, as
>>> in the WQ_UNBOUND case it'll be treated as a hint anyway.
>>>
>>> Performance comparison:
>>>                 baseline rx/tx    blk-mq align
>>> 4k seq write:  449MiB/s 480MiB/s 524MiB/s
>>> 4k rand write: 410MiB/s 481MiB/s 524MiB/s
>>> 4k seq read:   478MiB/s 481MiB/s 566MiB/s
>>> 4k rand read:  547MiB/s 480MiB/s 511MiB/s
>>>
>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>> ---
>>>   drivers/nvme/host/tcp.c | 65 
>>> +++++++++++++++++++++++++++++++----------
>>>   1 file changed, 49 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index f621d3ba89b2..a5c42a7b4bee 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -26,6 +26,8 @@
>>>   struct nvme_tcp_queue;
>>> +static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
>>> +
>>>   /* Define the socket priority to use for connections were it is 
>>> desirable
>>>    * that the NIC consider performing optimized packet processing or 
>>> filtering.
>>>    * A non-zero value being sufficient to indicate general 
>>> consideration of any
>>> @@ -1578,20 +1580,42 @@ static bool nvme_tcp_poll_queue(struct 
>>> nvme_tcp_queue *queue)
>>>   static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>>>   {
>>>       struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>>> -    int qid = nvme_tcp_queue_id(queue);
>>> -    int n = 0;
>>> -
>>> -    if (nvme_tcp_default_queue(queue))
>>> -        n = qid - 1;
>>> -    else if (nvme_tcp_read_queue(queue))
>>> -        n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
>>> -    else if (nvme_tcp_poll_queue(queue))
>>> +    struct blk_mq_tag_set *set = &ctrl->tag_set;
>>> +    int qid = nvme_tcp_queue_id(queue) - 1;
>>
>> umm, its not the qid, why change it? I mean it looks harmless, but
>> I don't see why.
>>
>>> +    unsigned int *mq_map = NULL;;
>>> +    int n = 0, cpu, io_cpu, min_queues = WORK_CPU_UNBOUND;
>>
>> min_queues initialization looks very very weird. I can't even parse it.
>> besides, why is it declared in this scope?
>>
> Because it's evaluated in the loop, with the value carried over across
> loop iterations.

Right. missed that.

> WORK_CPU_UNBOUND is the init value, to detect if it had been set at all.

as far as I read this patch, min_queues and num_queues are a quantity of
queues. So it is bizzar to see it initiatlized to this completely 
unrelated value
of WORK_CPU_UNBOUND. its really confusing. Still not sure what is tbh.

>
>>> +
>>> +    if (nvme_tcp_default_queue(queue)) {
>>> +        mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
>>> +        n = qid;
>>> +    } else if (nvme_tcp_read_queue(queue)) {
>>> +        mq_map = set->map[HCTX_TYPE_READ].mq_map;
>>> +        n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
>>> +    } else if (nvme_tcp_poll_queue(queue)) {
>>> +        mq_map = set->map[HCTX_TYPE_POLL].mq_map;
>>>           n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
>>> -                ctrl->io_queues[HCTX_TYPE_READ] - 1;
>>> -    if (wq_unbound)
>>> -        queue->io_cpu = WORK_CPU_UNBOUND;
>>> -    else
>>> -        queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, 
>>> -1, false);
>>> +                ctrl->io_queues[HCTX_TYPE_READ];
>>> +    }
>>> +
>>> +    if (WARN_ON(!mq_map))
>>> +        return;
>>> +    for_each_online_cpu(cpu) {
>>> +        int num_queues;
>>> +
>>> +        if (mq_map[cpu] != qid)
>>> +            continue;
>>> +        num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
>>> +        if (num_queues < min_queues) {
>>> +            min_queues = num_queues;
>>> +            io_cpu = cpu;
>>> +        }
>>> +    }
>>> +    if (io_cpu != queue->io_cpu) {
>>> +        queue->io_cpu = io_cpu;
>>> +        atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
>>> +    }
>>
>> Why is that conditioned ? why not always assign and inc the counter?
>>
> Because we're having the conditional
>
> if (mq_map[cpu] != qid)
>
> above, so technically we might not find the correct mapping.
> Might be worthwhile doing a WARN_ON() here, but it might trigger
> with CPU hotplug...

Writing code that looks like:
     if (a != b) {
         a = b;
     }

is silly.

iiuc It is probably because you initialized the queue->io_cpu to
WORK_CPU_UNBOUND and now you don't want to touch it. But it is
still kinda ugly.

I suggest that you always select a io_cpu and always account it.
You said yourself that if the wq is unbound, it doesn't really matter what
the io_cpu is...

And I think that a code comment would help here. its not the most trivial
code...

>
>>> +    dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
>>> +        qid, queue->io_cpu);
>>>   }
>>>   static void nvme_tcp_tls_done(void *data, int status, key_serial_t 
>>> pskid)
>>> @@ -1735,7 +1759,7 @@ static int nvme_tcp_alloc_queue(struct 
>>> nvme_ctrl *nctrl, int qid,
>>>       queue->sock->sk->sk_allocation = GFP_ATOMIC;
>>>       queue->sock->sk->sk_use_task_frag = false;
>>> -    nvme_tcp_set_queue_io_cpu(queue);
>>> +    queue->io_cpu = WORK_CPU_UNBOUND;
>>>       queue->request = NULL;
>>>       queue->data_remaining = 0;
>>>       queue->ddgst_remaining = 0;
>>> @@ -1847,6 +1871,10 @@ static void __nvme_tcp_stop_queue(struct 
>>> nvme_tcp_queue *queue)
>>>       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>>>       nvme_tcp_restore_sock_ops(queue);
>>>       cancel_work_sync(&queue->io_work);
>>> +    if (queue->io_cpu != WORK_CPU_UNBOUND) {
>>> + atomic_dec(&nvme_tcp_cpu_queues[queue->io_cpu]);
>>> +        queue->io_cpu = WORK_CPU_UNBOUND;
>>> +    }
>>
>> Does anything change if we still set the io_cpu in wq_unbound case?
>> If not, I think we should always do it and simplify the code.
>>
> See above. WORK_CPU_UNBOUND means that we failed to find the cpu
> in the mq_map. Yes, I know, unlikely, but not impossible.

If you always select a cpu, it should be fine.

>
>>>   }
>>>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>>> @@ -1891,9 +1919,10 @@ static int nvme_tcp_start_queue(struct 
>>> nvme_ctrl *nctrl, int idx)
>>>       nvme_tcp_init_recv_ctx(queue);
>>>       nvme_tcp_setup_sock_ops(queue);
>>> -    if (idx)
>>> +    if (idx) {
>>> +        nvme_tcp_set_queue_io_cpu(queue);
>>>           ret = nvmf_connect_io_queue(nctrl, idx);
>>> -    else
>>> +    } else
>>>           ret = nvmf_connect_admin_queue(nctrl);
>>>       if (!ret) {
>>> @@ -2920,6 +2949,7 @@ static struct nvmf_transport_ops 
>>> nvme_tcp_transport = {
>>>   static int __init nvme_tcp_init_module(void)
>>>   {
>>>       unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
>>> +    int cpu;
>>>       BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>>>       BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
>>> @@ -2937,6 +2967,9 @@ static int __init nvme_tcp_init_module(void)
>>>       if (!nvme_tcp_wq)
>>>           return -ENOMEM;
>>> +    for_each_possible_cpu(cpu)
>>> +        atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
>>> +
>>
>> Why?
>
> Don't we need to initialize the atomic counters?

I thought this was the module __exit function, sorry.

