Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0A5C25B75
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNDTQgsxpMpNjqqz3RGGQa/8utliGwdXLh6r1NJoOTw=; b=LadC284dCXFBOu6kp2OzEIc21u
	UfKm97vI0u7LLKl+lQL0oz1FHLyVqRxxkK4nqVgy/sJCjY6h1UGRbBjJEn5dxpeSMTSDZI0zTDr8L
	7kTmToeoxrKmdn51WPQ6Foxv39NDw6gZBxK3R7A1Gx1UqP8TrndJVtM6jXH2XStQ6iCLzlBxBxuJG
	HDjh2oBqXKkZQ88L6ciOs7TOEJII9xGfaFKExc30I4zCqhv30SPuuDxKBeToHKdI6VVfvx4lqaBKl
	wT+jz9fp5bxcVpmuJzJOO4QLXyP8T+B4ix/p2Krvykm0hkrO0jgJ5xMLKTCZWIt+IwU9A1EHISPgQ
	Anem2L1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1Q2-0000000Fnmf-2cUD;
	Mon, 03 Jun 2024 06:43:46 +0000
Received: from mail-lj1-f176.google.com ([209.85.208.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE1Pz-0000000Fnke-1wor
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 06:43:44 +0000
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaaa3be101so1519831fa.0
        for <linux-nvme@lists.infradead.org>; Sun, 02 Jun 2024 23:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397020; x=1718001820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNDTQgsxpMpNjqqz3RGGQa/8utliGwdXLh6r1NJoOTw=;
        b=tZrmbt8Z0lXhr5rIk4YkSkBCX3otDvkDXHYH9zjOAjamdYi2JzWnlmJzkkIhgSkLK/
         FoWhyBwsuQ8NpaUz4xKu7iavniVeCcW1hWmfSJ5sUWlIqDvnaOBhDwDJjf9ibkhEB0KU
         2YArZbhYRkqkj1P7LjbKU1v1xDqUYKH0MntgPQOLhxXBE0k8mDJ0g7gZxa+anMKnfTSv
         bTeqg6vj9e/TR6/KVmcESJJYxxVEiTFSTtajLInNyyt7dlzxE/sJC7tjjK+cVeRRhj0A
         2KNdtgFkT3MAA1hlBj2gTT7rHVUe5nrMX/lm34KIqnERBMVbrwCm6sJ6COx9/w9QTdDo
         2oZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqyorHLev7GvLgnbeVBmE3t30m0FscU7WIhvMAoaWeBrX3JcWzRQ998yvNXIOxnH8fcNWYZMJosaSSvFBfXaBNsFUiGMH4GfgDvtGnEwA=
X-Gm-Message-State: AOJu0YwNmZvWl38iaa9S0QhhKT+/0umuoy3UtjjGpIHHQSwXM9S0WAlM
	Bk9Cy/mU8Oj5jOgLDeEgCeGk7Uy9kW1aP9T0rszgTszIXBlrVJiL
X-Google-Smtp-Source: AGHT+IFhoKl4A6gW+3AMFRX3aXIZl00ZwsTmD5n8LQy5un2eNu2ESE6agjetuNa5EoI6zfrFgtpFAg==
X-Received: by 2002:a19:8c07:0:b0:52b:41a1:92fd with SMTP id 2adb3069b0e04-52b89557b0amr4842846e87.1.1717397020053;
        Sun, 02 Jun 2024 23:43:40 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a5658sm105853505e9.34.2024.06.02.23.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 23:43:39 -0700 (PDT)
Message-ID: <ae484450-9195-4ea9-9a96-8a8e353183f7@grimberg.me>
Date: Mon, 3 Jun 2024 09:43:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231208125321.165819-1-hare@kernel.org>
 <20231208125321.165819-3-hare@kernel.org>
 <3eefcbfd-a93f-4c1c-957a-66058e5cdb54@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3eefcbfd-a93f-4c1c-957a-66058e5cdb54@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_234343_543790_8F396FBC 
X-CRM114-Status: GOOD (  35.08  )
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



On 02/06/2024 16:09, Max Gurtovoy wrote:
> Hi Hannes/Sagi,
>
> sorry for the late response on this one.
>
> On 08/12/2023 14:53, hare@kernel.org wrote:
>> From: Hannes Reinecke<hare@suse.de>
>>
>> nvmet_rdma_install_queue() is driven from the ->io_work workqueue
>
> nvmet_rdma_install_queue callback is not implemented in the driver. 
> And RDMA doesn't use io_work workqueue..
>
>
>> function, but will call flush_workqueue() which might trigger
>> ->release_work() which in itself calls flush_work on ->io_work.
>>
>> To avoid that check for pending queue in disconnecting status,
>> and return 'controller busy' when we reached a certain threshold.
>>
>> Signed-off-by: Hannes Reinecke<hare@suse.de>
>> Tested-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
>> ---
>>   drivers/nvme/target/rdma.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 4597bca43a6d..667f9c04f35d 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -37,6 +37,8 @@
>>   #define NVMET_RDMA_MAX_MDTS            8
>>   #define NVMET_RDMA_MAX_METADATA_MDTS        5
>>   +#define NVMET_RDMA_BACKLOG 128
>> +
>>   struct nvmet_rdma_srq;
>>     struct nvmet_rdma_cmd {
>> @@ -1583,8 +1585,19 @@ static int nvmet_rdma_queue_connect(struct 
>> rdma_cm_id *cm_id,
>>       }
>>         if (queue->host_qid == 0) {
>> -        /* Let inflight controller teardown complete */
>> -        flush_workqueue(nvmet_wq);
>> +        struct nvmet_rdma_queue *q;
>> +        int pending = 0;
>> +
>> +        /* Check for pending controller teardown */
>> +        mutex_lock(&nvmet_rdma_queue_mutex);
>> +        list_for_each_entry(q, &nvmet_rdma_queue_list, queue_list) {
>> +            if (q->nvme_sq.ctrl == queue->nvme_sq.ctrl &&
>
> nvme_sq->ctrl pointer is set upon FABRICS_CONNECT during 
> nvmet_install_queue().
>
> obviously this check is not relevant since queue->nvme_sq.ctrl is 
> always NULL, isn't it ?

I think that the goal was to look at all the queues that were scheduled 
for teardown (queue->release_work)
so sq->ctrl should be valid for those queues afaict.

>
> So, I wonder what does this check is doing ?
>
> Was the intention to check that port->cm_id (listener) is not 
> overloaded ?
>
> Also the return value is "FABRICS" return code and not the value that 
> rdma_cm is looking for.
>
> We probably should introduce nvmet_rdma_install_queue() and check the 
> status of pending disconnections associated with port->cm_it which is 
> the one with the configured backlog.
>
> I don't understand the solution also for the nvmet_tcp.
>
> I think this series only removed the "flush_workqueue(nvmet_wq);" 
> actually.
>
> Is there something I miss in this commit ?

IIRC the goal was to get rid of the circular locking lockdep complaint. 
nvmet needs a back-pressure
mechanism for incoming connections because queue teardown is async and 
nvmet may hit OOM in
connect-disconnect storm scenario. The goal here was to detect such 
scenario, by counting the number
of queues that are queued for teardown, and if they exceed a certain 
threshold, return a BUSY status
to the incoming fabrics connect.

Before, nvmet flushed the pending queue teardowns, but that triggered a 
lockdep complaint and
hannes attempted to address it.

>
>> +                q->state == NVMET_RDMA_Q_DISCONNECTING)
>> +                pending++;
>> +        }
>> +        mutex_unlock(&nvmet_rdma_queue_mutex);
>> +        if (pending > NVMET_RDMA_BACKLOG)
>> +            return NVME_SC_CONNECT_CTRL_BUSY;
>>       }
>>         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>> @@ -1880,7 +1893,7 @@ static int nvmet_rdma_enable_port(struct 
>> nvmet_rdma_port *port)
>>           goto out_destroy_id;
>>       }
>>   -    ret = rdma_listen(cm_id, 128);
>> +    ret = rdma_listen(cm_id, NVMET_RDMA_BACKLOG);
>>       if (ret) {
>>           pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
>>           goto out_destroy_id;


