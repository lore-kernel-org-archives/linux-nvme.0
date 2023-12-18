Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC3FC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 12:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvpI+mFaxUEKY4/jXh9nI0sI/iEheUfe3jX4MQk9bmo=; b=rggLq19BEHhWdqBUrDkqQ4plHy
	+uKEToOZbRQTvGZfWyHzQCUSf53x0JOz8LWJUQyhZxk4zt7DhPG1VESBPSYwYvQQYkFn6/9Ug4W2K
	juuZA9xeBRP8Hsh9l1aSsakBC6dynMFT8ZYWAlWT0WQ6rS8T5cSeqKQjzON7TkOroC4VmSgpx+PIg
	IgRDbL7LH4y28DEtzY2BFhZJL4Vn7lH9wDmhlB3VVZAnEjqCAJ5V07EG7hpgd6AYO0vyOXx7r37sj
	9OPZMTI2Si0xPWz4BwxHJd8zVQ4elYWjnBIsGHF3fec69br9uH8j3bA0R4+xBhtCYy5OKQ7FIvyAL
	bQ4Csd5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCw1-00Ae2C-0T;
	Mon, 18 Dec 2023 12:41:25 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCvv-00Advw-0x
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 12:41:22 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VymXjUT_1702903245;
Received: from 30.178.84.39(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VymXjUT_1702903245)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 20:41:14 +0800
Message-ID: <92139239-c9c7-4356-8bb1-dbac5ab7cbc4@linux.alibaba.com>
Date: Mon, 18 Dec 2023 20:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] nvmet: rdma: utilize ib_device capability for
 setting max_queue_size
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
 <1702897533-49685-3-git-send-email-kanie@linux.alibaba.com>
 <b1d2b392-f6a5-4eb4-bc44-d2850c934e8c@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <b1d2b392-f6a5-4eb4-bc44-d2850c934e8c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_044119_540989_22662568 
X-CRM114-Status: GOOD (  12.20  )
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


在 2023/12/18 19:57, Sagi Grimberg 写道:
>
>> Respond with the smaller value between 1024 and the ib_device's
>> max_qp_wr as the RDMA max queue size.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/target/rdma.c | 7 ++++++-
>>   include/linux/nvme-rdma.h  | 2 ++
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 8a728c5..c3884dd 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -2002,7 +2002,12 @@ static u8 nvmet_rdma_get_mdts(const struct 
>> nvmet_ctrl *ctrl)
>>     static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_sq 
>> *nvmet_sq)
>>   {
>> -    return NVME_RDMA_MAX_QUEUE_SIZE;
>> +    struct nvmet_rdma_queue *queue =
>> +        container_of(nvmet_sq, struct nvmet_rdma_queue, nvme_sq);
>> +    int max_qp_wr = queue->dev->device->attrs.max_qp_wr;
>> +
>> +    return (u16)min_t(int, NVMET_QUEUE_SIZE,
>> +              max_qp_wr / (NVME_RDMA_SEND_WR_FACTOR + 1));
>>   }
>
> Should be folded to prev patch
OK, I will do it.
>
>>     static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
>> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
>> index 4dd7e6f..c19858b 100644
>> --- a/include/linux/nvme-rdma.h
>> +++ b/include/linux/nvme-rdma.h
>> @@ -8,6 +8,8 @@
>>     #define NVME_RDMA_MAX_QUEUE_SIZE    128
>>   +#define NVME_RDMA_SEND_WR_FACTOR 3  /* MR, SEND, INV */
>> +
>>   enum nvme_rdma_cm_fmt {
>>       NVME_RDMA_CM_FMT_1_0 = 0x0,
>>   };

