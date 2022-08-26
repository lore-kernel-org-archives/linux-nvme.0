Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F20AECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDZaDA+pOLf49Mnhbnzq/4BTWaAhLwWjEThZ1vkUmxM=; b=kXtRiZtkPShAeb1V1E6umY7onk
	SZmkgvtLk61umRn0HVbQhLl/UOMcc57ry/WbS+bY3/laigYAvaR1Aog9pBZO+H94BwDwPwIE9gRQq
	TB3zUnwJ+cQEKygT+z4s12X1qxNfhARqQP42sHi7UAUDxxiB7IviAN1WUnh6unv+/YgZxrHNFt3SN
	68WFcl7WaI9Wsg2Vdtkmu3auGKQxJsIFy4Y7ku8/9PaLR4u7QTzscdkW7WgC+RlAO7zENoXCnFg5q
	N3DrqfNn5y+U5Ef9YVI5LYzdPrSoXYtbzUBXbcdFL1JMGDTOUs6sKV32PGNjwlAO+hq3wcSpb20jM
	1aODuuqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRToL-00GQwb-CG; Fri, 26 Aug 2022 07:31:25 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRToH-00GQZJ-Hy
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 07:31:23 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDWcK1428zYcpb;
	Fri, 26 Aug 2022 15:26:57 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 15:31:16 +0800
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
 <20220825105550.3hxjveuex4nmup54@carbon.lan>
 <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
 <20220826063024.tndzjp7j6xhx3234@carbon.lan>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e9caacd6-033a-3f93-e9d5-2ad80fa07cfe@huawei.com>
Date: Fri, 26 Aug 2022 15:31:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220826063024.tndzjp7j6xhx3234@carbon.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_003121_987773_9A3BA914 
X-CRM114-Status: GOOD (  23.31  )
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



On 2022/8/26 14:30, Daniel Wagner wrote:
> On Fri, Aug 26, 2022 at 09:10:04AM +0800, Chao Leng wrote:
>> On 2022/8/25 18:55, Daniel Wagner wrote:
>>> On Thu, Aug 25, 2022 at 06:08:10PM +0800, Chao Leng wrote:
>>>>> +	/*
>>>>> +	 * If the number of queues has increased (reconnect case)
>>>>> +	 * start all new queues now.
>>>>> +	 */
>>>>> +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
>>>>> +					ctrl->tag_set.nr_hw_queues + 1);
>>>>> +	if (ret)
>>>>> +		goto out_cleanup_connect_q;
>>>>> +
>>>> Now the code looks weird.
>>>> Maybe we can do like this:
>>>> first blk_mq_update_nr_hw_queues, and then nvme_rdma_start_io_queues.
>>>
>>> We have to start the exiting queues before going into the 'if (!new)'
>>> part. That's why the start of queues is splited into two steps.
>> Indeed it is not necessary.
>> It's just a little negative: some request will failed, and then retry
>> or failover. I think it is acceptable.
> 
> The first version made nvme_rdma_start_io_queues() re-entrant and hence
> we just could call nvme_rdma_start_io_queues() twice without the max
> queue logic here.
> 
> After seeing both version I tend to do say the first one keeps the
> 'wierd' stuff more closer together and doesn't make the callside of
> nvme_rdma_start_io_queues() do the counting. So my personal preference
I don't understand "do the counting".
Show the code:
---
  drivers/nvme/host/rdma.c | 9 ++++-----
  1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 7d01fb770284..8dfb79726e13 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -980,10 +980,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
                         goto out_free_tag_set;
         }

-       ret = nvme_rdma_start_io_queues(ctrl);
-       if (ret)
-               goto out_cleanup_connect_q;
-
         if (!new) {
                 nvme_start_queues(&ctrl->ctrl);
                 if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
@@ -1000,13 +996,16 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
                 nvme_unfreeze(&ctrl->ctrl);
         }

+       ret = nvme_rdma_start_io_queues(ctrl);
+       if (ret)
+               goto out_wait_freeze_timed_out;
+
         return 0;

  out_wait_freeze_timed_out:
         nvme_stop_queues(&ctrl->ctrl);
         nvme_sync_io_queues(&ctrl->ctrl);
         nvme_rdma_stop_io_queues(ctrl);
-out_cleanup_connect_q:
         nvme_cancel_tagset(&ctrl->ctrl);
         if (new)
                 blk_cleanup_queue(ctrl->ctrl.connect_q);
-- 
> is to go with v1.
> 
> Maybe there is another way but I haven't figured it out yet.
> .
> 

