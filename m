Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25B2E810CE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Sep 2023 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWyindJSCz6j00e/axZD+2A+hn3yQ+j/UZTlQnY3B5c=; b=2ZuksTBN01pFhCG17ylnIEN1OR
	ujw+DaIgbQPZV/+GAa5PeL8ltazhMFxoWIH0LCV2jZP8KhRZm9YWxxhX65z0DVj+b3awoQO6D1nrz
	X0XNc6R3mAVa9wHS9uoeOVLOthQ8XNqtpg6hK4eMFiI/eTn8cNy0ZZfM5DoetMwh5s88ljoOSUNpY
	WjTroafN5u+lwDNE+WTI/UXCi5zw2saYn9qdUz/tWbZ9yE08ENqQFVWhbyOtEkxe4pd8VzRIHNi26
	sY693CTdwiIW+OJABMK2apvzKGJhwM6AO6WS7UAQcF3tcOUaesGR95IchNjeZc4vYGmsnAXLMhYrF
	D3Jxj8yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSJm-000lv0-2L;
	Wed, 27 Sep 2023 11:02:58 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlSJj-000luU-0D
	for linux-nvme@lists.infradead.org;
	Wed, 27 Sep 2023 11:02:56 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-32163c3ece5so1376879f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 27 Sep 2023 04:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695812571; x=1696417371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWyindJSCz6j00e/axZD+2A+hn3yQ+j/UZTlQnY3B5c=;
        b=Wp6qTui8vE1IvUVFr6cSPUAMDCyhTePZXSDpQIqQSTK6+OpL/DeEVHqlaklkwJBXyh
         3VnXks6+IX/kuHk1zyfgUCuhd8ZKSgnr5ZA2wu+AZ+QZ6VwAUaFt7X7uoONesAZHrVX3
         kUTGHBCSZzfw9AGKTLG51b5UfUdjd8/LAoUnFpSZPXwN66PiZCQc/cQOEQtsFB6nT5Ps
         RapqpyxB5Tcil2WkXMSMIqTODnbn0ZJR6Ag4Ydbu1TNVMb45ydjpMPT3VHlM4/TgLKXI
         E7H8vI/EWwxurnfsk54S+ODWsZDGf3YDoEba2rRTGvAxynGEwoWz7mv7GuEmkI4UO1Sk
         uUow==
X-Gm-Message-State: AOJu0YxUT3dYxO9x3Lw7KGEUDuS6Ulg6NTbT5N3BfaYGSwpvm3HJDe+T
	5Gai5rZ5sUEuCg5VPsaboH4=
X-Google-Smtp-Source: AGHT+IEoCvOUNx7lmxs7fhz7dAug+sgxF3gSVLPyd7Oq6NCzFRvZMyB1fKV2lTEdmH5QD7/FBfwVpA==
X-Received: by 2002:adf:ef0d:0:b0:317:3d36:b2c1 with SMTP id e13-20020adfef0d000000b003173d36b2c1mr1355350wro.7.1695812571164;
        Wed, 27 Sep 2023 04:02:51 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b0032167e49619sm16906283wrw.5.2023.09.27.04.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:02:50 -0700 (PDT)
Message-ID: <4f653c5e-2921-0059-1034-db2c8122d0a8@grimberg.me>
Date: Wed, 27 Sep 2023 14:02:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] nvme-multipath: Implement new iopolicy "queue-depth"
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, "Ewan D. Milne" <emilne@redhat.com>,
 linux-nvme@lists.infradead.org
Cc: tsong@purestorage.com, jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-3-emilne@redhat.com>
 <2f021d5f-22e3-4dea-b8c7-418d5a5f0d90@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2f021d5f-22e3-4dea-b8c7-418d5a5f0d90@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_040255_123366_311ABD7A 
X-CRM114-Status: GOOD (  23.52  )
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


>> The existing iopolicies are inefficient in some cases, such as
>> the presence of a path with high latency. The round-robin
>> policy would use that path equally with faster paths, which
>> results in sub-optimal performance.
>>
>> The queue-depth policy instead sends I/O requests down the path
>> with the least amount of requests in its request queue. Paths
>> with lower latency will clear requests more quickly and have less
>> requests in their queues compared to "bad" paths. The aim is to
>> use those paths the most to bring down overall latency.
>>
>> [edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>        and compilation warnings, updated MODULE_PARM description
>>        and changed to use new blk_mq_queue_nr_active() instead of adding
>>        additional atomic counters.]
>>
>> Co-developed-by: Thomas Song <tsong@purestorage.com>
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>> ---
>>   drivers/nvme/host/multipath.c | 48 +++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/nvme.h      |  1 +
>>   2 files changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c 
>> b/drivers/nvme/host/multipath.c
>> index 0a88d7bdc5e3..deea7fd4aa95 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
>>   static const char *nvme_iopolicy_names[] = {
>>       [NVME_IOPOLICY_NUMA]    = "numa",
>>       [NVME_IOPOLICY_RR]    = "round-robin",
>> +    [NVME_IOPOLICY_QD]      = "queue-depth",
>>   };
>>   static int iopolicy = NVME_IOPOLICY_NUMA;
>> @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const 
>> struct kernel_param *kp)
>>           iopolicy = NVME_IOPOLICY_NUMA;
>>       else if (!strncmp(val, "round-robin", 11))
>>           iopolicy = NVME_IOPOLICY_RR;
>> +    else if (!strncmp(val, "queue-depth", 11))
>> +        iopolicy = NVME_IOPOLICY_QD;
>>       else
>>           return -EINVAL;
>> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct 
>> kernel_param *kp)
>>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>>       &iopolicy, 0644);
>>   MODULE_PARM_DESC(iopolicy,
>> -    "Default multipath I/O policy; 'numa' (default) or 'round-robin'");
>> +    "Default multipath I/O policy; 'numa' (default) , 'round-robin' 
>> or 'queue-depth'");
>>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>>   {
>> @@ -329,6 +332,41 @@ static struct nvme_ns 
>> *nvme_round_robin_path(struct nvme_ns_head *head,
>>       return found;
>>   }
>> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head,
>> +        int node)
>> +{
>> +    struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
>> +    unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
>> +    unsigned int depth;
>> +
>> +    list_for_each_entry_rcu(ns, &head->list, siblings) {
>> +        if (nvme_path_is_disabled(ns))
>> +            continue;
>> +
>> +        depth = blk_mq_queue_nr_active(ns->queue);
> 
> That would require an 'atomic_read' on each path for each I/O.
> Which absolutely sucks for performance.

Actually in the current implementation its for every hctx in every
path...

> Considering that we really are only interested in a rough idea about 
> path usage,

I am not sure that a "rough idea" is sufficient here.

> wouldn't it be better to use READ_ONCE()/WRITE_ONCE()
> for accumulating the nr of requests per queue?

I'm assuming that WRITE_ONCE() is a slip up because the path
selector should absolutely not update the hctx active count.

I think its unnatural to access atomic variables non-atomically, and at 
the very least requires a code comment to why this is ok. But regardless
we need some testing to tell us if this is OK to do.

This only matters when there are less hctx than running cpus, but that
is a probable case for fabrics.

