Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B2C25B79
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsLFmVAnn1Gz/LQVT7m+7KqiKaxqBcxquh41X4WO4mY=; b=L+P4N41jXo1difl0TTPLqIQqf3
	tJYlCE53IT+V6MAEV4MuKofN+4RbsfP2JeWPfKt3kdZJH16q2o22rS0+fvKvDh3hS0A0X3DjkKqw5
	rNei8qb2CVP1swAzfPEAVv0m/e0aP6OEI6HvL7zHD98u/F1eIOlesbAjE/b0laBw0+8SrdIXBelLs
	rW7LVTkv96KUaU6aQvaNs6ECXTbYUX+uMNxVAOUYwdTu6eqKL5VQV/TxR+Uqt45IyHva04U5NVLQB
	T1D893AM9NqR6N16g/ahFnpZDRfFOklvKbM+dKKMsyxHCbQe0D2eBZbxw63MLFsKJIBc5/+gAdPVp
	RXM7lE0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5Oo-00000005pG7-2apT;
	Thu, 23 May 2024 10:10:14 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA5Ok-00000005pF8-2W5D
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 10:10:12 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-354f89a59c6so121075f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 May 2024 03:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716459009; x=1717063809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsLFmVAnn1Gz/LQVT7m+7KqiKaxqBcxquh41X4WO4mY=;
        b=NmOHN5RKKPDnNE2zG4EmqIIf64/d93yVZtkWkFmygxCeRr/nwHOBkID7zajKIDVS0D
         Wn3KelwtP2eppljJ+z8QC7TTofRgSTKPLSzjBKRvvnNIy4JNOhSM/SnD5PODEsIL4vGp
         HeuLpNu27Be7KwXkwDQpxVyg+4iAnCTHQbcU38N6SKV1ldYS0//xgI03ozb4+ologgmp
         86MIoaL4G0yZNUQo0oTRnvagMbpssApKA9IN4dTppkTEJHVSmnHl72p6s/hmfRMxCVIX
         QNkFBr6USI4dRZZhUZGBWYmNy1T5wXVmqwBrGi1P+bo0+mOf/wBXXHV3Rpg/2kXB4LUJ
         xAPw==
X-Forwarded-Encrypted: i=1; AJvYcCWCVbBniPHMgeo7yD6KphArPOlMmvMD67Xu7ihzcxgzWDtRLXqxPV+aMOMYGBQkZ2KHLjoWxovhxuaJl8cp7F1MsQ5dIyBPcuFEprCOZdA=
X-Gm-Message-State: AOJu0YwFFLafa1iSnfSBsMsF5Zsfl/u9WOcg3TkQ4nuzb1xhx3+SQLBj
	uwxovb+HyYpa46ecO9ssmCYTXdP7SFr9dieo8FXdimPiHbS8zXnz
X-Google-Smtp-Source: AGHT+IEdIBUDU7YE8NNbwKyWJtWRvJKTSRgyt16TC3coer3oyTCCxdtTZKoNGRMqv8Iv8qtYmgq6Zw==
X-Received: by 2002:a05:600c:4584:b0:419:f241:6336 with SMTP id 5b1f17b1804b1-420fd2db0f7mr32685385e9.1.1716459008452;
        Thu, 23 May 2024 03:10:08 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad58dsm20655065e9.39.2024.05.23.03.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 03:10:08 -0700 (PDT)
Message-ID: <1bfa217a-933f-46c7-88b7-3dd0c9b6ad1a@grimberg.me>
Date: Thu, 23 May 2024 13:10:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix nvme status code when namespace is disabled
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, jirong.feng@easystack.cn
References: <20240428092540.77366-1-sagi@grimberg.me>
 <f43b8ba9-79a9-4209-903b-e74c6f7a5f1d@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f43b8ba9-79a9-4209-903b-e74c6f7a5f1d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_031010_671492_86BBA5C8 
X-CRM114-Status: GOOD (  21.28  )
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



On 23/05/2024 12:49, Hannes Reinecke wrote:
> On 4/28/24 11:25, Sagi Grimberg wrote:
>> If the user disabled a nvmet namesapce, it is removed from
>> the subsystem namespaces list. When nvmet processes a command
>> directed to an nsid that was disabled, it cannot differentiate
>> between a nsid that is disabled vs. a non-existent namespace,
>> and resorts to return NVME_SC_INVALID_NS with the dnr bit set.
>>
>> This translates to a non-retryable status for the host, which
>> translates to a user error. We should expect disabled namespaces
>> to not cause an I/O error in a multipath environment.
>>
>> Address this by searching a configfs item for the namespace nvmet
>> failed to find, and if we found one, conclude that the namespace
>> is disabled (perhaps temporarily). Return NVME_SC_INTERNAL_PATH_ERROR
>> in this case and keep DNR bit cleared.
>>
>> Reported-by: Jirong Feng <jirong.feng@easystack.cn>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Jirong Feng, can you please re-run the test as requested and verify
>> that the I/O error goes away. If so, please reply with your "Tested-by"
>> tag.
>>
>>   drivers/nvme/target/configfs.c | 13 +++++++++++++
>>   drivers/nvme/target/core.c     |  8 ++++++--
>>   drivers/nvme/target/nvmet.h    |  1 +
>>   3 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c 
>> b/drivers/nvme/target/configfs.c
>> index 77a6e817b315..e744bd0a9cc2 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -754,6 +754,19 @@ static struct configfs_attribute 
>> *nvmet_ns_attrs[] = {
>>       NULL,
>>   };
>>   +bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
>> +{
>> +    struct config_item *ns_item;
>> +    char name[4] = {};
>> +
>> +    if (sprintf(name, "%u", nsid) <= 0)
>> +        return false;
>> + mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
>> +    ns_item = config_group_find_item(&subsys->namespaces_group, name);
>> + mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
>> +    return ns_item != NULL;
>> +}
>> +
>>   static void nvmet_ns_release(struct config_item *item)
>>   {
>>       struct nvmet_ns *ns = to_nvmet_ns(item);
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 78cba026610a..ed0b8f3707b4 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -437,11 +437,15 @@ void nvmet_stop_keep_alive_timer(struct 
>> nvmet_ctrl *ctrl)
>>   u16 nvmet_req_find_ns(struct nvmet_req *req)
>>   {
>>       u32 nsid = le32_to_cpu(req->cmd->common.nsid);
>> +    struct nvmet_subsys *subsys = nvmet_req_subsys(req);
>>   -    req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
>> +    req->ns = xa_load(&subsys->namespaces, nsid);
>>       if (unlikely(!req->ns)) {
>>           req->error_loc = offsetof(struct nvme_common_command, nsid);
>> -        return NVME_SC_INVALID_NS | NVME_SC_DNR;
>> +        if (nvmet_subsys_nsid_exists(subsys, nsid))
>> +            return NVME_SC_INTERNAL_PATH_ERROR;
>> +        else
>> +            return NVME_SC_INVALID_NS | NVME_SC_DNR;
>>       }
>>         percpu_ref_get(&req->ns->ref);
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index f460728e1df1..c1306de1f4dd 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -543,6 +543,7 @@ void nvmet_subsys_disc_changed(struct 
>> nvmet_subsys *subsys,
>>           struct nvmet_host *host);
>>   void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
>>           u8 event_info, u8 log_page);
>> +bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
>>     #define NVMET_MIN_QUEUE_SIZE    16
>>   #define NVMET_MAX_QUEUE_SIZE    1024
>
> Shouldn't we rather use 'ANA inaccessible' status here?
> Just to make it clear that the namespace is disabled, and not some 
> other internal error?

No, because this is not related to the ANA group, but a namespace error.

