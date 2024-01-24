Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCC5C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 19:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uD5n5CYMyoxmSF0veZJBcYhXMJ89+GcCRIw+PVWIrPM=; b=s/azrQuxe/voqpIWA81+iVt/wJ
	/KEyJ090V09NOObNAQoH2S6O20MCvg/vaOQwERAgmNL26wlnJNbWyJbfo/VwFeA6bmnYqziFfq17p
	wimyRDTP2Z2TyjziADHx63woUR/Hi28id+ZDh8heQ2CIKmW+Z5/q+8mh8NGbFPLos/ECAwT1S5k67
	49k5vGeVn+d6jkPSBgPgm02d3aKvDrgnbr6/wRW/5vEog3zo0ZYrFkUSrC8RWaYxGY8iVXSHYX3vF
	PLlG4D34yi6k8cUdxU76fzCgLAM8U45PvwUvZCDGa/gVm6nzAsuww9Wf+7lNUg990mXlrLVPxCOCX
	teReUnew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSj5A-004tSf-2v;
	Wed, 24 Jan 2024 19:38:44 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSj57-004tSB-0p
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 19:38:43 +0000
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6dde173384aso4599324a34.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 11:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706125119; x=1706729919; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uD5n5CYMyoxmSF0veZJBcYhXMJ89+GcCRIw+PVWIrPM=;
        b=GsQLPo6qPm+dwv0cMhBQlixhO1A5HVT+1p1pjtekQcUwsYp+5rkzoM7Hx39aM7Hv61
         q9J/IhRWmtC4OPDk6QPUFZf0XiPD1nXgeviQ1/Z1pJpHzAWB+EsBTpJXEeNYkMO5M0hN
         Fs013aav1CBR65PwoVY1C+qXsERT2DLZZYf6y884vld/zLxSDNWThsE6muCswQkrFyTl
         KP2wCgVmpEwtzIVPYO2jWcRfvFZAmocv3HsUydqrMfhAieI+BOlM/lUNg0nP4xPrO4uD
         2+FpZbOdBv2/e7j4KwUD0NA91LU70QANvYY+2BJq9kpmKhe8ViyGWDPjRIBowsBSyu3i
         dzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125119; x=1706729919;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uD5n5CYMyoxmSF0veZJBcYhXMJ89+GcCRIw+PVWIrPM=;
        b=SrhLuEKPf0LYTBfRNoesSArwJXJPy3kKkEDfJULEVYWoCMOd2FJp6bOYgWBc0f5OHA
         vuBwE/KDc8uc3U4KAFTvx04jYOmdgKWw9r4sSjWh5Rx0kS4TLz2M9wZbW6Fpx/ISzOOU
         F/AuPBI0ElBTFlcnoGJDGuMyCsFyyIUaSuzuyzREgfIYVauL87GWWmv5HLg7iCkuFyUx
         cDy1QMBPa/mHApDmR0GPdbMEeYiuReojPiIJR7m+FX572skZmRJjJsCu7tuSn+YHH5xz
         oU1htf6wMidoOKlgmgz8EL7wobLSRtOwAcdjDqgpCN2T2slR9mC+/I5E3gE0Dltv6PH6
         X4tw==
X-Gm-Message-State: AOJu0Yzf+9hAzSSqvChQnKo35FEb73lDSdrikmKLcGZ3jB8hVzpMM6GJ
	sJfyPgoutqyb3E5vP6kFI7qYkw/lSlR/jsEIfbnr0GRxV0hBEXip
X-Google-Smtp-Source: AGHT+IEZKGQQ8NRnyHbwJDoSiUbCjNKBhT+6Y+poRPh8R25KQHYVof+7qR8X3Eln7HX7ElULtRgQWw==
X-Received: by 2002:a9d:620b:0:b0:6db:bcb5:a070 with SMTP id g11-20020a9d620b000000b006dbbcb5a070mr1971227otj.62.1706125119005;
        Wed, 24 Jan 2024 11:38:39 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id w10-20020a9d77ca000000b006ddda12a747sm2695692otl.70.2024.01.24.11.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:38:38 -0800 (PST)
Message-ID: <7c2451ad-2d6d-4517-9373-0f5d58f2cfad@gmail.com>
Date: Wed, 24 Jan 2024 13:38:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_113841_301165_58B87672 
X-CRM114-Status: GOOD (  39.24  )
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



On 1/22/2024 3:13 AM, Sagi Grimberg wrote:
> 
> 
> On 1/18/24 23:03, Stuart Hayes wrote:
>> Use async function calls to make namespace scanning happen in parallel.
>>
>> Without the patch, NVME namespaces are scanned serially, so it can take a
>> long time for all of a controller's namespaces to become available,
>> especially with a slower (TCP) interface with large number of namespaces.
>>
>> The time it took for all namespaces to show up after connecting (via TCP)
>> to a controller with 1002 namespaces was measured:
>>
>> network latency   without patch   with patch
>>       0                 6s            1s
>>      50ms             210s           10s
>>     100ms             417s           18s
>>
> 
> Impressive speedup. Not a very common use-case though...
> 
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>
>> -- 
>> V2: remove module param to enable/disable async scanning
>>      add scan time measurements to commit message
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0af612387083..069350f85b83 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (c) 2011-2014, Intel Corporation.
>>    */
>> +#include <linux/async.h>
>>   #include <linux/blkdev.h>
>>   #include <linux/blk-mq.h>
>>   #include <linux/blk-integrity.h>
>> @@ -3812,12 +3813,38 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>>           nvme_ns_remove(ns);
>>   }
>> -static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> +/*
>> + * struct nvme_scan_state - keeps track of controller & NSIDs to scan
>> + * @ctrl:    Controller on which namespaces are being scanned
>> + * @count:    Next NSID to scan (for sequential scan), or
>> + *        Index of next NSID to scan in ns_list (for list scan)
>> + * @ns_list:    pointer to list of NSIDs to scan (NULL if sequential scan)
>> + */
>> +struct nvme_scan_state {
>> +    struct nvme_ctrl *ctrl;
>> +    atomic_t count;
>> +    __le32 *ns_list;
>> +};
>> +
>> +static void nvme_scan_ns(void *data, async_cookie_t cookie)
> 
> I think its better to call it nvme_scan_ns_async to indicate what
> it is.
> 
>>   {
>> -    struct nvme_ns_info info = { .nsid = nsid };
>> +    struct nvme_ns_info info = {};
>> +    struct nvme_scan_state *scan_state;
>> +    struct nvme_ctrl *ctrl;
>> +    u32 nsid;
>>       struct nvme_ns *ns;
>>       int ret;
>> +    scan_state = data;
>> +    ctrl = scan_state->ctrl;
> 
> I think these assignments can be done on the declaration.
> 
>> +    nsid = (u32)atomic_fetch_add(1, &scan_state->count);
>> +    /*
>> +     * get NSID from list (if scanning from a list, not sequentially)
>> +     */
>> +    if (scan_state->ns_list)
>> +        nsid = le32_to_cpu(scan_state->ns_list[nsid]);
>> +
> 
> This is awkward. ns_list passed in optionally.
> How about we limit this change to only operate on nvme_scan_ns_list?
> If the controller is old or quirked to support only a sequential scan
> it does not benefit from a parallel scan. I doubt that these controllers
> are likely to expose a large number of namespaces anyways.
> 
>> +    info.nsid = nsid;
>>       if (nvme_identify_ns_descs(ctrl, &info))
>>           return;
>> @@ -3881,11 +3908,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>       __le32 *ns_list;
>>       u32 prev = 0;
>>       int ret = 0, i;
>> +    ASYNC_DOMAIN(domain);
>> +    struct nvme_scan_state scan_state;
>>       ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>>       if (!ns_list)
>>           return -ENOMEM;
>> +    scan_state.ctrl = ctrl;
>> +    scan_state.ns_list = ns_list;
> 
> Is there a need to have a local ns_list variable here?
> 
>>       for (;;) {
>>           struct nvme_command cmd = {
>>               .identify.opcode    = nvme_admin_identify,
>> @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>               goto free;
>>           }
>> +        /*
>> +         * scan list starting at list offset 0
>> +         */
>> +        atomic_set(&scan_state.count, 0);
>>           for (i = 0; i < nr_entries; i++) {
>>               u32 nsid = le32_to_cpu(ns_list[i]);
>>               if (!nsid)    /* end of the list? */
>>                   goto out;
>> -            nvme_scan_ns(ctrl, nsid);
>> +            async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>>               while (++prev < nsid)
>>                   nvme_ns_remove_by_nsid(ctrl, prev);
>>           }
>> +        async_synchronize_full_domain(&domain);
>>       }
>>    out:
>>       nvme_remove_invalid_namespaces(ctrl, prev);
> 
> Is it a good idea to remove the invalid namespaces before synchronizing
> the async scans?
> 
>>    free:
>> +    async_synchronize_full_domain(&domain);
>>       kfree(ns_list);
>>       return ret;
>>   }
>> @@ -3922,14 +3959,23 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
>>   {
>>       struct nvme_id_ctrl *id;
>>       u32 nn, i;
>> +    ASYNC_DOMAIN(domain);
>> +    struct nvme_scan_state scan_state;
>>       if (nvme_identify_ctrl(ctrl, &id))
>>           return;
>>       nn = le32_to_cpu(id->nn);
>>       kfree(id);
>> +    scan_state.ctrl = ctrl;
>> +    /*
>> +     * scan sequentially starting at NSID 1
>> +     */
>> +    atomic_set(&scan_state.count, 1);
>> +    scan_state.ns_list = NULL;
>>       for (i = 1; i <= nn; i++)
>> -        nvme_scan_ns(ctrl, i);
>> +        async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>> +    async_synchronize_full_domain(&domain);
>>       nvme_remove_invalid_namespaces(ctrl, nn);
>>   }
> 
> I think we need a blktest for this. ns scanning has been notorious when
> running simultaneously with controller reset/reconnect/remove
> sequences... Ideally a test with a larger number of namespaces to
> exercise the code.
> 
> Also, make sure that blktest suite does not complain about anything
> else.

Thank you for the feedback on the patch, I agree with it.

I'm not sure how to implement a blktest suite for this, though.  I can look into it.

