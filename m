Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F11C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s280zFis6RuZV4uPM0FKdkId7SC16llfX/Rj8xc9XNI=; b=yh1Eze86GiqYCEl6WSk/vrvzaq
	pDNMaWvUWi1UjTRyOzeu7r/gnen6K6L7YAMwI5KIcFS4RhvPJka+0+4k8wOdcRVLa5ItRZjA5xPa3
	Q14OHUa4MxZHnElDe1/8rU4UMUx2a+JB4JSv2zksDwy8s/+PEDQ9z+pYkUA7wVu/+3ty31dTxgiGk
	fMdG5AMAbGWxCQXIQQ3ACBJclkZosCw2xesJea1PfituNHy7JW9WBbTPR+IxNSYMcvYdF2s/ANmLw
	RjLpDtVNYSy7Zpau0PXDfb9VPH75K5zkNWaQUVOvbuErpw6SBF3HVaYs7SYexrlURksmM1KUdum5t
	YxJpCH9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCmh-00Ac7S-0v;
	Mon, 18 Dec 2023 12:31:47 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCme-00Ac6W-11
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 12:31:45 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VylUOur_1702902692;
Received: from 30.178.84.39(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VylUOur_1702902692)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 20:31:33 +0800
Message-ID: <3ee29484-09a3-4fc5-8738-fb1ce6f12ce5@linux.alibaba.com>
Date: Mon, 18 Dec 2023 20:31:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
 <1702897533-49685-4-git-send-email-kanie@linux.alibaba.com>
 <d301da61-1076-462b-a679-4b847dd334ff@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <d301da61-1076-462b-a679-4b847dd334ff@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_043144_534878_0AFECD04 
X-CRM114-Status: GOOD (  15.24  )
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
>
> On 12/18/23 13:05, Guixin Liu wrote:
>> Currently, the host is limited to creating queues with a depth of
>> 128. To enable larger queue sizes, constrain the sqsize based on
>> the ib_device's max_qp_wr capability.
>>
>> And also remove unused NVME_RDMA_MAX_QUEUE_SIZE macro.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/rdma.c  | 14 ++++++++------
>>   include/linux/nvme-rdma.h |  2 --
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 81e2621..982f3e4 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -489,8 +489,7 @@ static int nvme_rdma_create_cq(struct ib_device 
>> *ibdev,
>>   static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>>   {
>>       struct ib_device *ibdev;
>> -    const int send_wr_factor = 3;            /* MR, SEND, INV */
>> -    const int cq_factor = send_wr_factor + 1;    /* + RECV */
>> +    const int cq_factor = NVME_RDMA_SEND_WR_FACTOR + 1;    /* + RECV */
>>       int ret, pages_per_mr;
>>         queue->device = nvme_rdma_find_get_device(queue->cm_id);
>> @@ -508,7 +507,7 @@ static int nvme_rdma_create_queue_ib(struct 
>> nvme_rdma_queue *queue)
>>       if (ret)
>>           goto out_put_dev;
>>   -    ret = nvme_rdma_create_qp(queue, send_wr_factor);
>> +    ret = nvme_rdma_create_qp(queue, NVME_RDMA_SEND_WR_FACTOR);
>>       if (ret)
>>           goto out_destroy_ib_cq;
>>   @@ -1006,6 +1005,7 @@ static int nvme_rdma_setup_ctrl(struct 
>> nvme_rdma_ctrl *ctrl, bool new)
>>   {
>>       int ret;
>>       bool changed;
>> +    int ib_max_qsize;
>>         ret = nvme_rdma_configure_admin_queue(ctrl, new);
>>       if (ret)
>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>> nvme_rdma_ctrl *ctrl, bool new)
>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>       }
>>   -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
>> +    if (ctrl->ctrl.sqsize + 1 > ib_max_qsize) {
>>           dev_warn(ctrl->ctrl.device,
>>               "ctrl sqsize %u > max queue size %u, clamping down\n",
>> -            ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
>> -        ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
>> +            ctrl->ctrl.sqsize + 1, ib_max_qsize);
>> +        ctrl->ctrl.sqsize = ib_max_qsize - 1;
>>       }
>
> This can be very very big, not sure why we should allow a queue of depth
> of a potentially giant size. We should also impose a hard limit, maybe
> align to the pci driver limit.

When we exec "nvme connect", the queue depth will be restricted to 
between 16 and 1024 in nvmf_parse_options(),

so this will not be very big, the max is 1024 in any case.


