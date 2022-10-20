Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8B1C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYC02fp3nDRBCPiStZb8PTaboNUxyjE49rrVBWA1Cfs=; b=HdEtL8xh/LcMB1Q2L4FKRlq2Xe
	diHrgvbPiEVWNiue5iaBWIDlmTJG8ixqXL3BJ64Q0NjlXHKJge/Jy/X9yYSlf5dyEWFwTh+Jk48IF
	homoWfwuw9RmiyMgDjNt+P/fBmutq90xKrJSHe/Th8oxeA2wvYhqSkm1XRNA3wpEm+Y1xQYRnBX2N
	O3+ebd/+Me3MgsqyaAIbbQsaCbeHszKjob5RHpm0iy6yVUMTB6Bgtb3ATaxx1LmkVqqgz8vr2pDzh
	Wo7ljDM2q/eO8p8hFyLe7jDofDQW4BQUbE5KMxEts1cFessi7bqc1IU5kkBBf0pWdCtg2Keel0641
	VXvBHfrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olS9d-00D9Zi-Ke; Thu, 20 Oct 2022 09:47:57 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olS9Z-00D9W8-OR
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 09:47:56 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtN1y3G43zmVFx;
	Thu, 20 Oct 2022 17:43:02 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 17:47:47 +0800
Subject: Re: [PATCH v3 2/2] nvme: use blk_mq_[un]quiesce_tagset
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <axboe@kernel.dk>,
	<ming.lei@redhat.com>, <paulmck@kernel.org>
References: <20221020035348.10163-1-lengchao@huawei.com>
 <20221020035348.10163-3-lengchao@huawei.com>
 <13088882-2d1b-ca71-8420-84bb47760cff@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <ffba2ecb-0c91-2960-9d83-08d7a3248cb1@huawei.com>
Date: Thu, 20 Oct 2022 17:47:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <13088882-2d1b-ca71-8420-84bb47760cff@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_024754_187288_514A0134 
X-CRM114-Status: GOOD (  16.29  )
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



On 2022/10/20 14:11, Sagi Grimberg wrote:
> 
> 
> On 10/20/22 06:53, Chao Leng wrote:
>> All controller namespaces share the same tagset, so we can use this
>> interface which does the optimal operation for parallel quiesce based on
>> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
>>
>> nvme connect_q should not be quiesced when quiesce tagset, so set the
>> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
>>
>> Currntely we use NVME_NS_STOPPED to ensure pairing quiescing and
>> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
>> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
>> In addition, we never really quiesce a single namespace. It is a better
>> choice to move the flag from ns to ctrl.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 57 +++++++++++++++++++-----------------------------
>>   drivers/nvme/host/nvme.h |  3 ++-
>>   2 files changed, 25 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 059737c1a2c1..c7727d1f228e 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4890,6 +4890,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>>               ret = PTR_ERR(ctrl->connect_q);
>>               goto out_free_tag_set;
>>           }
>> +        blk_queue_flag_set(QUEUE_FLAG_SKIP_TAGSET_QUIESCE, ctrl->connect_q);
>>       }
>>       ctrl->tagset = set;
>> @@ -5013,6 +5014,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>>       clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>>       spin_lock_init(&ctrl->lock);
>>       mutex_init(&ctrl->scan_lock);
>> +    mutex_init(&ctrl->queue_state_lock);
> 
> Why is this lock needed?
It is used to secure the process which need that the queue must be quiesced.
The scenario:(without the lock)
Thread A: call nvme_stop_queues and set the NVME_CTRL_STOPPED and then quiesce the tagset
           and wait the grace period.
Thread B: call nvme_stop_queues, because the NVME_CTRL_STOPPED is already setted,
           continue to do something which need that the queue must be quiesced,
           because the grace period of the queue is not ended, may cause abnormal.
Thread A: the grace period end, and continue.
So add a lock to ensure that all queues are quiesced after set the NVME_CTRL_STOPPED.

The old code was implemented by forcing a wait for the grace period. Show the code:
	if (!test_and_set_bit(NVME_NS_STOPPED, &ns->flags))
		blk_mq_quiesce_queue(ns->queue);
	else
		blk_mq_wait_quiesce_done(ns->queue);
The old code was not absolutely safe, such as this scenario:
Thread A: test_and_set_bit, and interrupt by hardware irq, lost chance to run.
Thread B: test_and_set_bit, and wait the grace period, and then continue
           to do something which need that the queue must be quiesced,
           because the queue is not quiesced, may cause abnormal.
Thread A: get the chance to run, blk_mq_quiesce_queue, and then continue.
> 
> .

