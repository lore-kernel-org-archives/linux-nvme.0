Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A0DC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ytk+HQw4vCY/ZsFxmn2Qu+I/J6GZpszaleTvoN+Y0Kw=; b=HDqwX163qRFRv2C0pd4wHkv7i8
	+dB6RQ5yqL1xcX2/pjEkhOAmqoPW/zaA6QsSTXLiQQ7oVLq5IUEaxb9gJ/S8W70TTLvkVbKqmct3G
	xy4CWH9YBFhpwcZ/6uZeHXRVLhhCgVvbksYS6mCBfqfqt0rjllDCGQ60JnzLotlixSzUZ+o+PUjmq
	NpxfnqUu4MHQZ6elG0zjihAFCi3Rj+L8RR3lbRw7cjEu1p6yP0Nbd0DBi4So7Cwggce/5reifjCc2
	+wqqKTSTSVVlsf5gqAuDvzCMIaUlh3BsuhzcYJxvRwiAAKxGRJIyd199/eO4BiQIZoGzWgmpqaMiP
	/tRXNivA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9M49-0000000GweI-0ioD;
	Tue, 21 May 2024 09:45:53 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9M45-0000000GwdJ-2OpD
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 09:45:51 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ff95798d4so4870035e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 02:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284747; x=1716889547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytk+HQw4vCY/ZsFxmn2Qu+I/J6GZpszaleTvoN+Y0Kw=;
        b=IEXjfGWS1oVWUuN9Akl8bkTIDQfprProVchihyZsFvgFTLbGyBzACBR8TwDQ0pTNkR
         Bqq8WPCcHvM80LJYjB0cR4zO3+RdWDWhfq8A4cyaMTD2TrO/Y9pe2YwiuivX7as4qdhx
         2AIglbQCAmKTh0wnaB/vacrifu60rjc66OtGExRnNLuxLi7ZLQD4TmZKUbP7jHzJblC7
         HIxdjRAj7/YNzRJZuvYrQvTxlg6rA+FEvHmzKbA0JxMDDdW43b9LxrScXkiTAH4WYhgM
         6ucoGJZ5GykY1V3U62r8S0gmDdsqCd6yxU9X6YeYPUY3j2Ya95n2Az/hNKP20M15KJeS
         YsHg==
X-Gm-Message-State: AOJu0YyFtIP1n/9j9oiYvR8rfgJDQP9mzx6Pt5IQ/fX46W9agZ8UeZl2
	XuWaCYmEj92DXsdwiWVWigPn3SIMxbUOLcinPy6Podb3nK96RVJa
X-Google-Smtp-Source: AGHT+IEC0Q1sLZoQQmgxV8JbLvwWepf1ZWKX+aodXeqHEqJqt2+Whl/WHHSLoU6fBa7aoGD5HMxapA==
X-Received: by 2002:a05:600c:5116:b0:418:ef65:4b11 with SMTP id 5b1f17b1804b1-41feac59e8amr265338175e9.2.1716284746574;
        Tue, 21 May 2024 02:45:46 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff6fd7e73sm417039275e9.27.2024.05.21.02.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 02:45:46 -0700 (PDT)
Message-ID: <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
Date: Tue, 21 May 2024 12:45:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_024549_707972_3F4F8138 
X-CRM114-Status: GOOD (  25.98  )
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



On 21/05/2024 11:48, Nilay Shroff wrote:
>
> On 5/21/24 01:50, John Meneghini wrote:
>> From: "Ewan D. Milne" <emilne@redhat.com>
>>
>> The round-robin path selector is inefficient in cases where there is a
>> difference in latency between multiple active optimized paths.  In the
>> presence of one or more high latency paths the round-robin selector
>> continues to the high latency path equally. This results in a bias
>> towards the highest latency path and can cause is significant decrease
>> in overall performance as IOs pile on the lowest latency path. This
>> problem is particularly accute with NVMe-oF controllers.
>>
>> The queue-depth policy instead sends I/O requests down the path with the
>> least amount of requests in its request queue. Paths with lower latency
>> will clear requests more quickly and have less requests in their queues
>> compared to higher latency paths. The goal of this path selector is to
>> make more use of lower latency paths, which will bring down overall IO
>> latency.
>>
>> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
>> [tsong: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>>        and compilation warnings, updated MODULE_PARM description, and
>>        fixed potential issue with ->current_path[] being used]
>> Signed-off-by: Thomas Song <tsong@purestorage.com>
>> [jmeneghi: vairious changes and improvements, addressed review comments]
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>> Reviewed-by: Randy Jennings <randyj@redhat.com>
>> Tested-by: Jyoti Rani <jani@purestorage.com>
>> ---
>>   drivers/nvme/host/core.c      |  2 +-
>>   drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
>>   drivers/nvme/host/nvme.h      |  9 ++++
>>   3 files changed, 92 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index a066429b790d..1dd7c52293ff 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
>>   EXPORT_SYMBOL_GPL(nvme_delete_wq);
>>   
>>   static LIST_HEAD(nvme_subsystems);
>> -static DEFINE_MUTEX(nvme_subsystems_lock);
>> +DEFINE_MUTEX(nvme_subsystems_lock);
>>   
>>   static DEFINE_IDA(nvme_instance_ida);
>>   static dev_t nvme_ctrl_base_chr_devt;
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 5397fb428b24..0e2b6e720e95 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
>>   static const char *nvme_iopolicy_names[] = {
>>   	[NVME_IOPOLICY_NUMA]	= "numa",
>>   	[NVME_IOPOLICY_RR]	= "round-robin",
>> +	[NVME_IOPOLICY_QD]      = "queue-depth",
>>   };
>>   
>>   static int iopolicy = NVME_IOPOLICY_NUMA;
>> @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>   		iopolicy = NVME_IOPOLICY_NUMA;
>>   	else if (!strncmp(val, "round-robin", 11))
>>   		iopolicy = NVME_IOPOLICY_RR;
>> +	else if (!strncmp(val, "queue-depth", 11))
>> +		iopolicy = NVME_IOPOLICY_QD;
>>   	else
>>   		return -EINVAL;
>>   
>> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>>   	&iopolicy, 0644);
>>   MODULE_PARM_DESC(iopolicy,
>> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
>> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
>>   
>>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>>   {
>> @@ -127,6 +130,11 @@ void nvme_mpath_start_request(struct request *rq)
>>   	struct nvme_ns *ns = rq->q->queuedata;
>>   	struct gendisk *disk = ns->head->disk;
>>   
>> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
>> +		atomic_inc(&ns->ctrl->nr_active);
>> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>> +	}
>> +
>>   	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>>   		return;
>>   
>> @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>>   {
>>   	struct nvme_ns *ns = rq->q->queuedata;
>>   
>> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
>> +		atomic_dec_if_positive(&ns->ctrl->nr_active);
>> +
>>   	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>>   		return;
>> +
>>   	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>>   			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
>>   			 nvme_req(rq)->start_time);
>> @@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>>   	return found;
>>   }
>>   
> I think you may also want to reset nr_active counter if in case, in-flight nvme request
> is cancelled. If the request is cancelled then nvme_mpath_end_request() wouldn't be invoked.
> So you may want to reset nr_active counter from nvme_cancel_request() as below:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bf7615cb36ee..4fea7883ce8e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -497,8 +497,9 @@ EXPORT_SYMBOL_GPL(nvme_host_path_error);
>   
>   bool nvme_cancel_request(struct request *req, void *data)
>   {
> -       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> -                               "Cancelling I/O %d", req->tag);
> +       struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
> +
> +       dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
>   
>          /* don't abort one completed or idle request */
>          if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
> @@ -506,6 +507,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>   
>          nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>          nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +       if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +               atomic_dec(&ctrl->nr_active);

Don't think this matters because cancellation only happens when we
teardown the controller anyways...

btw, can we have a better name than nr_active? this is just for IO and only
for multipath. Maybe ctrl->nr_mpath_io_active ?

Also perhaps rename the flag to NVME_MPATH_CTRL_IO_ACCOUNTING ?

