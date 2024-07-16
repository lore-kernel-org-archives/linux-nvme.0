Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F9DC3DA59
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vUb+h4iR+SfupLLuXHRz6dRkSTTMmLi3YHN8v82yLpI=; b=kZ212NFYM68Bx80ghiHufpKezu
	DXf5yIaM6Dcq5aSa9Oa+0Q17PSjyjpxDKasVYhUpeZw19Z+CRT8rv9oQbIF1qD44hC/mMk8RoulVu
	0O84/jiJyRQXDzUthTemtHYDZjTcqhtdhTpGaZ8BqAmHMckxdDAuNIsUEAUxozMt2ntIuix+xPloH
	yELHfYwS4Svv1eoU1T2Cay4HylfkTMCn9TGq/pI7vBJUwr7PCUUJYSa8pZJ6R28OL452LbgwE2NQy
	vJaaMwPlDpnoj3FhBjiMP0gkN/4dQMZEbxGdDIJh2n5ChyoFXzWAjRynxsJarwiNNKI0R7bGopNZ0
	C1W9pELg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTWun-00000008xC8-3nqE;
	Tue, 16 Jul 2024 01:23:37 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTWuj-00000008xAo-3obs
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 01:23:36 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-708b273b437so2613436a34.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jul 2024 18:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721093013; x=1721697813; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUb+h4iR+SfupLLuXHRz6dRkSTTMmLi3YHN8v82yLpI=;
        b=iOa+GCCi4NMJSZw430OruNthT6Ym3GLdd63TsRqBW1J7L1KHAYqxyovxY/ac3FT4Z8
         PLLhRZ/2UJNNqgHHq/4A0ZTBkLWcip5lyc+tsQLp5C9Lh5yM/jueCD+dlhk4RrxpuXcY
         sHlDF7kyjDCg604GDTBBFJoSOfc7qSZCNfAtEjKOjC9LnHP88IyyGeVAlcRjwgmexmF/
         PglypgLD5fVVk4CSrx0VkMqvx+6Z/rYI6MR4hXUh9bMes9UzJLNnd4B916MTOpGHLSjo
         0UcwBwz1ZNZMY3nrugf7iVUymPwxui9SPwZMhSw+KAYy/TNx6KulG12RLY5FEJw1r5rt
         AIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721093013; x=1721697813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUb+h4iR+SfupLLuXHRz6dRkSTTMmLi3YHN8v82yLpI=;
        b=svvKu+v4TMh8muCNlz+QkM/LoqFZ/08Qp9OZGcNnZqr+lXWZW2H4BLpbmnf7Q3VKv/
         iZu45hOox663tdYvY6o7KMqKSigzzOCDf6zcICJlFR6tO9VdwJtyHnKA+xNONbCh6YCf
         aNXdaLDchAkSE8nGcDoYAQaVLl0eOIWme55e5goqL7iOGITvu+VmKitaslO1gpcyy9cz
         L0aVP35pTb7g7vmSPx4tvqacV1P3+2xyhW7zx7oFs4MRwoHa8+Syk349AkyiIreKNHwP
         SAb/yWhsslKUJloOUeRJqULh6nSlYG+gc6WVLwQKZuXn0RrQ+VKEkzaSmphcboMMpw17
         FsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQpVGzS5mxu/2b37PfHUQei4TpDCySzfRu0/5b7jLVwnFIk6BlaH1Mhxh+LEjzNEn0e7hkVqSqx167rSyGrr/k3og4La3M+XBDNAKNAcc=
X-Gm-Message-State: AOJu0YxUT4DVZ95toAPgVtxVsME3orWbq1dZGe9WDKPNp5k+dNX4qKLK
	azas/LuJqIastmHIOZah0dzdDaMs2b1yUtRQvWO28BUnxvX1CGO/
X-Google-Smtp-Source: AGHT+IH697lcHbRfq1jAnm9ryPLu+CgJ6tkqoTRWEM2EE1y+piw3W7TlglpeV/tGI4U4D5mO5A6xIw==
X-Received: by 2002:a05:6830:6302:b0:703:62c8:b247 with SMTP id 46e09a7af769-708d9be4484mr950244a34.35.1721093012720;
        Mon, 15 Jul 2024 18:23:32 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0c7f4f1sm1171650a34.35.2024.07.15.18.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 18:23:32 -0700 (PDT)
Message-ID: <4c9ab413-2d05-4cec-9d37-a7ea3b5941c8@gmail.com>
Date: Mon, 15 Jul 2024 20:23:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme_core: scan namespaces asynchronously
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>, Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
 <76fbe503-a8e7-47aa-9335-6e0a90cba4c2@grimberg.me>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <76fbe503-a8e7-47aa-9335-6e0a90cba4c2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_182333_982678_05C779D3 
X-CRM114-Status: GOOD (  34.12  )
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



On 7/15/2024 5:28 PM, Sagi Grimberg wrote:
> 
> 
> On 15/07/2024 23:34, Stuart Hayes wrote:
>> Use async function calls to make namespace scanning happen in parallel.
>>
>> Without the patch, NVME namespaces are scanned serially, so it can take
>> a long time for all of a controller's namespaces to become available,
>> especially with a slower (TCP) interface with large number of
>> namespaces.
>>
>> It is not uncommon to have large numbers (hundreds or thousands) of
>> namespaces on nvme-of with storage servers.
>>
>> The time it took for all namespaces to show up after connecting (via
>> TCP) to a controller with 1002 namespaces was measured on one system:
>>
>> network latency   without patch   with patch
>>       0                 6s            1s
>>      50ms             210s           10s
>>     100ms             417s           18s
>>
>> Measurements taken on another system show the effect of the patch on the
>> time nvme_scan_work() took to complete, when connecting to a linux
>> nvme-of target with varying numbers of namespaces, on a network of
>> 400us.
>>
>> namespaces    without patch   with patch
>>       1            16ms           14ms
>>       2            24ms           16ms
>>       4            49ms           22ms
>>       8           101ms           33ms
>>      16           207ms           56ms
>>     100           1.4s           0.6s
>>    1000          12.9s           2.0s
> 
> Not sure how common is the 1000 namespaces use-case, but the dozens of namespaces
> seems compelling enough.
> 
>>
>> On the same system, connecting to a local PCIe NVMe drive (a Samsung
>> PM1733) instead of a network target:
>>
>> namespaces    without patch   with patch
>>       1            13ms           12ms
>>       2            41ms           13ms
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>> ---
>> changes from V2:
>>    * make a separate function nvme_scan_ns_async() that calls
>>      nvme_scan_ns(), instead of modifying nvme_scan_ns()
>>    * only scan asynchronously from nvme_scan_ns_list(), not from
>>      nvme_scan_ns_sequential()
>>    * provide more timing data in the commit message
>>
>> changes from V1:
>>    * remove module param to enable/disable async scanning
>>    * add scan time measurements to commit message
>>
>>
>>   drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>>   1 file changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 782090ce0bc1..dbf05cfea063 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2014, Intel Corporation.
>>    */
>> +#include <linux/async.h>
>>   #include <linux/blkdev.h>
>>   #include <linux/blk-mq.h>
>>   #include <linux/blk-integrity.h>
>> @@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>       }
>>   }
>> +/*
>> + * struct async_scan_info - keeps track of controller & NSIDs to scan
>> + * @ctrl:    Controller on which namespaces are being scanned
>> + * @next_idx:    Index of next NSID to scan in ns_list
>> + * @ns_list:    Pointer to list of NSIDs to scan
>> + */
>> +struct async_scan_info {
>> +    struct nvme_ctrl *ctrl;
>> +    atomic_t next_idx;
> 
> next_nsid ?
> 

OK!

>> +    __le32 *ns_list;
>> +};
>> +
>> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
>> +{
>> +    struct async_scan_info *scan_info = data;
>> +    int idx;
>> +    u32 nsid;
>> +
>> +    idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
>> +    nsid = le32_to_cpu(scan_info->ns_list[idx]);
>> +
>> +    nvme_scan_ns(scan_info->ctrl, nsid);
>> +}
>> +
>>   static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>                       unsigned nsid)
>>   {
>> @@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>   static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>   {
>>       const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
>> -    __le32 *ns_list;
>> +    struct async_scan_info scan_info;
> 
> What initializes next_idx?

See below--there's an atomic_set().  It is inside of the outer "for" loop because there can
be multiple lists that have to be scanned and it has to reset to 0 each time.

> 
>>       u32 prev = 0;
>>       int ret = 0, i;
>> +    ASYNC_DOMAIN(domain);
>> -    ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>> -    if (!ns_list)
>> +    scan_info.ctrl = ctrl;
>> +    scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>> +    if (!scan_info.ns_list)
>>           return -ENOMEM;
> 
> I think you can leave the local variable ns_list as is, and just assign it to scan_info
> after, its common practice to allocate to a local pointer and use it to init a struct member.
> 
> Plus it will make the patch diff simpler.
> 

No problem, I agree.  I think someone suggested the opposite last time I submitted this.  :)

>>       for (;;) {
>> @@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>               .identify.nsid        = cpu_to_le32(prev),
>>           };
>> -        ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
>> -                        NVME_IDENTIFY_DATA_SIZE);
>> +        ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
>> +                       scan_info.ns_list,
>> +                       NVME_IDENTIFY_DATA_SIZE);
>>           if (ret) {
>>               dev_warn(ctrl->device,
>>                   "Identify NS List failed (status=0x%x)\n", ret);
>>               goto free;
>>           }
>> +        atomic_set(&scan_info.next_idx, 0);

This atomic_set is what initializes next_idx.

>>           for (i = 0; i < nr_entries; i++) {
>> -            u32 nsid = le32_to_cpu(ns_list[i]);
>> +            u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
>>               if (!nsid)    /* end of the list? */
>>                   goto out;
>> -            nvme_scan_ns(ctrl, nsid);
>> +            async_schedule_domain(nvme_scan_ns_async, &scan_info,
>> +                        &domain);
>>               while (++prev < nsid)
>>                   nvme_ns_remove_by_nsid(ctrl, prev);
>>           }
>> +        async_synchronize_full_domain(&domain);
>>       }
>>    out:
>>       nvme_remove_invalid_namespaces(ctrl, prev);
>>    free:
>> -    kfree(ns_list);
>> +    async_synchronize_full_domain(&domain);
>> +    kfree(scan_info.ns_list);
>>       return ret;
>>   }
> 

Thank you for the feedback!

