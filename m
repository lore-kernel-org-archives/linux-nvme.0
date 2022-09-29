Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5765C07E9D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 07:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCea+yuMNfzqHczJpD3QZa/feznAa8hp0u8kN+n1uC0=; b=UjWe7P8g2QwmEz3G3SPWSXXZEY
	SuEmt4IujFA8XVYHEedylS0wwJGQ8xVAXjP1LKNAKGuw/ZfYemmWAm2pU8Kuly0biGJm+lV2VmkjU
	YM5B8n35j6nji2AdFj7g9qmoMcst2HN4kZ84KBdBATvxmUnU3ewDiBhIxZmIsBZChfux3pFHHrEaW
	Wepur4xmCcxK1DeoW/mautj8XuL1Z3iBZOLawqtuqENHXcLx9cgjdJOW1Jp5+A0WAxUE29yxMzt9R
	Fm2qqG6oI0Ygki79EYhEVjeb2VuJ0lw47bSfIkXR7efQEeA3aewKE43HNvNrgHYReNOi5dZfQOKTJ
	MB/NgnbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odo45-001aim-FN; Thu, 29 Sep 2022 07:34:37 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odo42-001agK-PJ
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 07:34:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso2684688wmk.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rCea+yuMNfzqHczJpD3QZa/feznAa8hp0u8kN+n1uC0=;
        b=vHtQCUPzKiSvWXZf5jywoH6uJHpQZwJIRPJcCIrM6zZxoqw4Kncx8uvbyef2IP4J+i
         UmLW54DWFPCeKvCHApgkfnnKrcTO52sa2lOZfAsjViSwOoWbiQi3btTXKPqQzMH4pspD
         zhBhHND0pVNIubYBgv1J2rnirHaPZDlrB6cpfQHq/UwoaU9ypkgzsTaPbg04khFfHN+D
         +Yi0jt2N7h1eim+8+smexl950Ui5SKUnFx1ftvQWFY8uwfpTaNbcbASaljvV0olk28gH
         txpqzAJSn7x/cURdkiIm6/7Ej3wviQdI6CFxSDjAGRL00cAdVtnco3EvuQuHewo1erG9
         L+Ng==
X-Gm-Message-State: ACrzQf3PzuAGdoI02Tg/v3CRcNMaeuUxfx6semimIuL3HVxHSU8dUxED
	6cHv8iIzFaMAzLzL9ZoIN9A=
X-Google-Smtp-Source: AMsMyM4Hal06sSQlltivoSRwABRZNw7j5y0WXHlKbBs7PskOstZToKQ3evFKWm0LMW5XFjXVCJG+Pg==
X-Received: by 2002:a05:600c:1589:b0:3b4:fe4a:c225 with SMTP id r9-20020a05600c158900b003b4fe4ac225mr9923953wmf.150.1664436871216;
        Thu, 29 Sep 2022 00:34:31 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e6-20020a05600c4b8600b003b482fbd93bsm3450329wmp.24.2022.09.29.00.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:34:30 -0700 (PDT)
Message-ID: <550f878d-8931-2264-2802-758ba0258b1d@grimberg.me>
Date: Thu, 29 Sep 2022 10:34:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvme-multipath: fix possible hang in live ns resize
 with ANA access
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Yogev Cohen <yogev@lightbitslabs.com>
References: <20220928201031.166876-1-sagi@grimberg.me>
 <dc0c4500-957b-b7f7-0cec-b26e11a138f7@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <dc0c4500-957b-b7f7-0cec-b26e11a138f7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_003434_840786_457B0F20 
X-CRM114-Status: GOOD (  22.46  )
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



On 9/29/22 04:32, Chao Leng wrote:
> 
> 
> On 2022/9/29 4:10, Sagi Grimberg wrote:
>> When we revalidate paths as part of ns size change (as of commit
>> e7d65803e2bb), it is possible that during the path revalidation, the
>> only paths that is IO capable (i.e. optimized/non-optimized) are the
>> ones that ns resize was not yet informed to the host, which will cause
>> inflight requests to be requeued (as we have available paths but none
>> are IO capable). These requests on the requeue list are waiting for
>> someone to resubmit them at some point.
>>
>> The IO capable paths will eventually notify the ns resize change to the
>> host, but there is nothing that will kick the requeue list to resubmit
>> the queued requests.
>>
>> Fix this by always kicking the requeue list, and if no IO capable path
>> exists, these requests will just end up being queued again.
>>
>> A typical log that indicates that IOs are requeued:
>> -- 
>> nvme nvme1: creating 4 I/O queues.
>> nvme nvme1: new ctrl: "testnqn1"
>> nvme nvme2: creating 4 I/O queues.
>> nvme nvme2: mapped 4/0/0 default/read/poll queues.
>> nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
>> nvme nvme1: rescanning namespaces.
>> nvme1n1: detected capacity change from 2097152 to 4194304
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> block nvme1n1: no usable path - requeuing I/O
>> nvme nvme2: rescanning namespaces.
>> -- 
>>
>> Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
>> Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Changes from v1:
>> - fix commit msg body format
>> - follow reverse-xmas declaration pattern
>>
>>   drivers/nvme/host/multipath.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c 
>> b/drivers/nvme/host/multipath.c
>> index 6ef497c75a16..1113139c9736 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -173,15 +173,17 @@ void nvme_mpath_revalidate_paths(struct nvme_ns 
>> *ns)
>>   {
>>       struct nvme_ns_head *head = ns->head;
>>       sector_t capacity = get_capacity(head->disk);
>> +    struct nvme_ns *n;
>>       int node;
>> -    list_for_each_entry_rcu(ns, &head->list, siblings) {
>> -        if (capacity != get_capacity(ns->disk))
>> -            clear_bit(NVME_NS_READY, &ns->flags);
>> +    list_for_each_entry_rcu(n, &head->list, siblings) {
>> +        if (capacity != get_capacity(n->disk))
>> +            clear_bit(NVME_NS_READY, &n->flags);
>>       }
>>       for_each_node(node)
>>           rcu_assign_pointer(head->current_path[node], NULL);
>> +    nvme_kick_requeue_lists(ns->ctrl);
> We just need to schedule the requeue_work of the head instead of all heads.
> we can do like this:
>    kblockd_schedule_work(&head->requeue_work);

Yes, you're right, that is simpler to do. I'll send a v3.

