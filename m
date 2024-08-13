Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690CEC52D7C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrqBJVGTlh5ZtHH92QXhX9ddeZFS69LoB5LowDVWzGY=; b=SDVDSvsdNqssEwDzRyxUpMdmJ4
	1wVNypNik2N+6zcyX4Zj5uyW9X/rRnNbPDdcu98XB94BJJf3IJKtt/nf2lmOnEEq/7PdTk6mwaRoJ
	TtvFoZ7TywbFvnLIMm4fWzogz0qNIYXMvXCXTM4vQJK9Tb/b0QlIlM7pX5ho3IiIyyLgg6KjXvByl
	m9jl/OM4azSGgPujcCH3QnE3UCBCpPCfpanlxjm7Q/UU/Nqb3vJNyPdLkqihXOl8jZSjQcAG/LkGN
	4yjM0YEqA9XV8aQVFAnuzCxOOw8TzHJpMUi4aJOZikz/deLYtMY1pZ8Ih6yj97RdmhnmbYcto4uOp
	Bzs+m6lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxJP-00000004lpj-0NAS;
	Tue, 13 Aug 2024 19:36:07 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxJL-00000004lpE-37Iz
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 19:36:05 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42802ddfaa6so6872775e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Aug 2024 12:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577762; x=1724182562;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrqBJVGTlh5ZtHH92QXhX9ddeZFS69LoB5LowDVWzGY=;
        b=LF1PVLtysntEuI4juLoYY1LymTzO1rzZHU4h/Ej+UtLKgtlRvA3x3GnleK4CkjaHU4
         XOdLVETuOlpinF9BhgUcn9ngfo5BZwtyR34ROGV/jUhCYMqfQB2h/Z7sMMLNY7d/uGzf
         X5aA2Y8Oq+OV8cuICWY8VjEP07znHP0BJipMJBpVFIGrj6XqZ4OczrQPb+K+84DXF2hU
         KB+zIoDXAfRYnMIDOF+42ZRUhLI65BQwHgwzg3s7F7O07M8yWOV31tgE5wLxPJcQ9nOT
         x1lVDpm+WYhlK088X2Dg5Vpu2EILCWZ/ogxhpX7y/kxADH0wd7rshT7XOgC8Li1ADz5V
         BnFw==
X-Forwarded-Encrypted: i=1; AJvYcCUiIabyfChm1O917JG5r7+G0D9JPI0gI8RRE5IRELHgD5jroWKAe+dSW9G3iyskzKuG5pKJXNnd+VJSZ6+Oawxs9PQpDANFEq69qTOuZkY=
X-Gm-Message-State: AOJu0YzOdsEE5MhYOGZyn3iWH7e81HR9EodiVPRUoTn9fBgI/lFIKvJ3
	06bjQcCgwbcXPXCGltX4rtRpF4Nop/v2vfS2TKgxVJW/C+rLjkZ0
X-Google-Smtp-Source: AGHT+IGGOddiqtWY/jUwRyrTe6O6DaJ92J93stEJjNbOPNJViZ++V1jJF0hLblDj0PiCdPPemnukgw==
X-Received: by 2002:a5d:5f93:0:b0:367:9495:9016 with SMTP id ffacd0b85a97d-3717783bfc7mr274783f8f.6.1723577761645;
        Tue, 13 Aug 2024 12:36:01 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c751d875sm150478805e9.25.2024.08.13.12.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:36:01 -0700 (PDT)
Message-ID: <83c23710-372c-4eae-9529-8f9c71669cb9@grimberg.me>
Date: Tue, 13 Aug 2024 22:36:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvme-tcp: align I/O cpu with blk-mq mapping
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-9-hare@kernel.org>
 <cdd6bc37-fd55-45d1-a1d9-dcb2b4461242@grimberg.me>
Content-Language: en-US
In-Reply-To: <cdd6bc37-fd55-45d1-a1d9-dcb2b4461242@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_123603_806054_9BAB9B20 
X-CRM114-Status: GOOD (  33.00  )
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




On 18/07/2024 0:34, Sagi Grimberg wrote:
>
>
> On 16/07/2024 10:36, Hannes Reinecke wrote:
>> We should align the 'io_cpu' setting with the blk-mq
>> cpu mapping to ensure that we're not bouncing threads
>> when doing I/O. To avoid cpu contention this patch also
>> adds an atomic counter for the number of queues on each
>> cpu to distribute the load across all CPUs in the blk-mq cpu set.
>> Additionally we should always set the 'io_cpu' value, as
>> in the WQ_UNBOUND case it'll be treated as a hint anyway.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/host/tcp.c | 65 +++++++++++++++++++++++++++++++----------
>>   1 file changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index f3a94168b2c3..a391a3f7c4d7 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -28,6 +28,8 @@
>>     struct nvme_tcp_queue;
>>   +static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
>> +
>>   /* Define the socket priority to use for connections were it is 
>> desirable
>>    * that the NIC consider performing optimized packet processing or 
>> filtering.
>>    * A non-zero value being sufficient to indicate general 
>> consideration of any
>> @@ -1799,20 +1801,42 @@ static bool nvme_tcp_poll_queue(struct 
>> nvme_tcp_queue *queue)
>>   static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>>   {
>>       struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>> -    int qid = nvme_tcp_queue_id(queue);
>> -    int n = 0;
>> -
>> -    if (nvme_tcp_default_queue(queue))
>> -        n = qid - 1;
>> -    else if (nvme_tcp_read_queue(queue))
>> -        n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] - 1;
>> -    else if (nvme_tcp_poll_queue(queue))
>> +    struct blk_mq_tag_set *set = &ctrl->tag_set;
>> +    int qid = nvme_tcp_queue_id(queue) - 1;
>> +    unsigned int *mq_map = NULL;;
>> +    int n = 0, cpu, io_cpu, min_queues = WORK_CPU_UNBOUND;
>
> Again, min_queues is a minimum quantity, not an id. It makes zero sense
> to use WORK_CPU_UNBOUND as the initializer. Just set it to INT_MAX or 
> something.
>> +
>> +    if (nvme_tcp_default_queue(queue)) {
>> +        mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
>> +        n = qid;
>> +    } else if (nvme_tcp_read_queue(queue)) {
>> +        mq_map = set->map[HCTX_TYPE_READ].mq_map;
>> +        n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
>> +    } else if (nvme_tcp_poll_queue(queue)) {
>> +        mq_map = set->map[HCTX_TYPE_POLL].mq_map;
>>           n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
>> -                ctrl->io_queues[HCTX_TYPE_READ] - 1;
>> -    if (wq_unbound)
>> -        queue->io_cpu = WORK_CPU_UNBOUND;
>> -    else
>> -        queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, 
>> -1, false);
>> +                ctrl->io_queues[HCTX_TYPE_READ];
>> +    }
>> +
>> +    if (WARN_ON(!mq_map))
>> +        return;
>> +    for_each_online_cpu(cpu) {
>> +        int num_queues;
>> +
>> +        if (mq_map[cpu] != qid)
>> +            continue;
>> +        num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
>> +        if (num_queues < min_queues) {
>> +            min_queues = num_queues;
>> +            io_cpu = cpu;
>> +        }
>> +    }
>> +    if (io_cpu != queue->io_cpu) {
>> +        queue->io_cpu = io_cpu;
>
> Hannes, the code may make sense to you, but not to me.
> Please do not add code like:
>     if (a != b) {
>         b = a;
>     }
>
> I think it is a sign that we are doing something wrong here.
>
>> + atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
>> +    }
>
> Again, why can't we always set io_cpu and increment the counter?
> If the wq is unbound, it makes no difference, and if the wq is bound, 
> that
> is actually what you want to do. What am I missing?
>
>> +    dev_dbg(ctrl->ctrl.device, "queue %d: using cpu %d\n",
>> +        qid, queue->io_cpu);
>>   }
>>     static void nvme_tcp_tls_done(void *data, int status, 
>> key_serial_t pskid)
>> @@ -1957,7 +1981,7 @@ static int nvme_tcp_alloc_queue(struct 
>> nvme_ctrl *nctrl, int qid,
>>         queue->sock->sk->sk_allocation = GFP_ATOMIC;
>>       queue->sock->sk->sk_use_task_frag = false;
>> -    nvme_tcp_set_queue_io_cpu(queue);
>> +    queue->io_cpu = WORK_CPU_UNBOUND;
>>       queue->request = NULL;
>>       queue->data_remaining = 0;
>>       queue->ddgst_remaining = 0;
>> @@ -2088,6 +2112,10 @@ static void __nvme_tcp_stop_queue(struct 
>> nvme_tcp_queue *queue)
>>       kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>>       nvme_tcp_restore_sock_ops(queue);
>>       cancel_work_sync(&queue->io_work);
>> +    if (queue->io_cpu != WORK_CPU_UNBOUND) {
>
> I think that we can safely always set queue->io_cpu to a cpu. If the 
> unbound_wq
> only operates on a subset of the cores, it doesn't matter anyways...
>
> The rest of the patch looks good though.

Hey Hannes,

 From this series, I think that this is one patch that we both agree 
that should
be addressed. The idea that we want to spread out multiple 
controllers/queues
over multiple cpu cores is correct.

How about addressing the comments on this patch and split it from the series
until we have more info on the rest?

