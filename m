Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB1C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 03:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UOaPLdNPP/0FUVyO64uPXscTTF7C91TOiugnAfLQCBg=; b=MrWTozjLP64maEqywq6nH00+Zw
	gzClWy/JlcxLM8YdiGZ+LnQT2VpBWLqfYFP1kdZ4UBT6ckdp7XEmPJhfMOhF5PdoXTqJlpL3m8w5b
	2g1E+1wiLAxT3diP8tldUOQfJ+dHVUVyIy67qnyehojsgtNUd2fVCak442ZTN/5XAXQi88Ko7O4EX
	dJ87TsFAkj5bziaLS37iW4lFH60rQaNvSnCWXtF2+bLqNuj6lZ4qXhFcobR89cjRmt7zt07Y8MlTf
	p8LVvhmPhFolIKSnxjyRTeiSvshS1jg0wAsoCd1raor9uOodvjAOfGT47et3vnCgOIK3ZyngGZDkB
	U00OKWVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oliWL-004hh7-L4; Fri, 21 Oct 2022 03:16:29 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oliWI-004hf9-7s
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 03:16:28 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtqHs1YvrzmVF4;
	Fri, 21 Oct 2022 11:11:37 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:16:05 +0800
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
From: Chao Leng <lengchao@huawei.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-3-hch@lst.de>
 <25cf9a6a-9224-0b35-6dec-194440d4e58d@huawei.com>
Message-ID: <99c31c6b-47ec-adb2-4f57-15ee8f7b3143@huawei.com>
Date: Fri, 21 Oct 2022 11:16:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <25cf9a6a-9224-0b35-6dec-194440d4e58d@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_201626_473943_5682403B 
X-CRM114-Status: GOOD (  13.99  )
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



On 2022/10/21 10:47, Chao Leng wrote:
> 
> 
> On 2022/10/20 18:56, Christoph Hellwig wrote:
>> For submit_bio based queues there is no (S)RCU critical section during
>> I/O submission and thus nothing to wait for in blk_mq_wait_quiesce_done,
>> so skip doing any synchronization.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-mq.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 33292c01875d5..df967c8af9fee 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -280,7 +280,9 @@ EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
>>   void blk_mq_quiesce_queue(struct request_queue *q)
>>   {
>>       blk_mq_quiesce_queue_nowait(q);
>> -    blk_mq_wait_quiesce_done(q);
>> +    /* nothing to wait for non-mq queues */
>> +    if (queue_is_mq(q))
>> +        blk_mq_wait_quiesce_done(q);
> For the non-mq queues, maybe we should add a synchronize_rcu.
>      if (queue_is_mq(q))
>          blk_mq_wait_quiesce_done(q);
>      else
>          synchronize_rcu();
Please ignore this, synchronize_rcu is not needed.
>>   }
>>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>>
> 
> .

