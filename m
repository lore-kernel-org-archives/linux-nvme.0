Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC28C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:37:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E9C21D7B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8jFXPRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E9C21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2ERxYqtpL9GPM+JAhjoIXIc5C1o4HVb4fJf0H9sKhTk=; b=V8jFXPRzlxvSmzpQJQNuipezC
	pp64Qp20ihDhIfoEcApTwF9TbHxKMLOZ/+3EZvsvg4SPR42L+ElTP0U5CGH4kETHM77Ec5RrFAfxJ
	q8oOvxIECIcx5y2IwWKTShLOiriFSHQu//9ep6nor1iUCnTHmWwq0MG2DBAEHMznuKf8q5qPrREVn
	VJ0TlIFtMAXkr8eZnzlQof6mSwgk6vsUknv4GUrtmgaR47b6GhvgS10vjQbbpggW8+arL0D/XsbO/
	WcCtbhWzj9Kjyk4D0kWMfPSXbTNu3QN7dgu7zo+yNA/QLnoFvk+X5sj2BwdD2uACFhgMUoqiqDBh8
	++HHVMqOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSVjB-0006jk-5r; Wed, 14 Oct 2020 01:37:17 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSVj7-0006ij-Td
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 01:37:15 +0000
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 53F903CFC23933453BDA;
 Wed, 14 Oct 2020 09:37:09 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 09:37:09 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 14
 Oct 2020 09:37:08 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
 <20201014010813.GA775684@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a1221820-55db-e550-0a9c-684ab96608e3@huawei.com>
Date: Wed, 14 Oct 2020 09:37:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201014010813.GA775684@T590>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_213714_197749_4B75B642 
X-CRM114-Status: GOOD (  22.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

rdma also need do this patch.
We do test this patch with nvme over roce a few days, now work well.

On 2020/10/14 9:08, Ming Lei wrote:
> On Tue, Oct 13, 2020 at 03:36:08PM -0700, Sagi Grimberg wrote:
>>
>>>>> This may just reduce the probability. The concurrency of timeout
>>>>> and teardown will cause the same request
>>>>> be treated repeatly, this is not we expected.
>>>>
>>>> That is right, not like SCSI, NVME doesn't apply atomic request
>>>> completion, so
>>>> request may be completed/freed from both timeout & nvme_cancel_request().
>>>>
>>>> .teardown_lock still may cover the race with Sagi's patch because
>>>> teardown
>>>> actually cancels requests in sync style.
>>> In extreme scenarios, the request may be already retry success(rq state
>>> change to inflight).
>>> Timeout processing may wrongly stop the queue and abort the request.
>>> teardown_lock serialize the process of timeout and teardown, but do not
>>> avoid the race.
>>> It might not be safe.
>>
>> Not sure I understand the scenario you are describing.
>>
>> what do you mean by "In extreme scenarios, the request may be already retry
>> success(rq state change to inflight)"?
>>
>> What will retry the request? only when the host will reconnect
>> the request will be retried.
>>
>> We can call nvme_sync_queues in the last part of the teardown, but
>> I still don't understand the race here.
> 
> Not like SCSI, NVME doesn't complete request atomically, so double
> completion/free can be done from both timeout & nvme_cancel_request()(via teardown).
> 
> Given request is completed remotely or asynchronously in the two code paths,
> the teardown_lock can't protect the case.
> 
> One solution is to apply the introduced blk_mq_complete_request_sync()
> in both two code paths.
> 
> Another candidate is to use nvme_sync_queues() before teardown, such as
> the following change:
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d6a3e1487354..dc3561ca0074 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1909,6 +1909,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	blk_mq_quiesce_queue(ctrl->admin_q);
>   	nvme_start_freeze(ctrl);
>   	nvme_stop_queues(ctrl);
> +	nvme_sync_queues(ctrl);
nvme_sync_queues now sync io queues and admin queues, so we may need like this:
nvme_sync_io_queues(struct nvme_ctrl *ctrl)
{
	down_read(&ctrl->namespaces_rwsem);
	list_for_each_entry(ns, &ctrl->namespaces, list)
		blk_sync_queue(ns->queue);
	up_read(&ctrl->namespaces_rwsem);
}
EXPORT_SYMBOL_GPL(nvme_sync_io_queues);

void nvme_sync_queues(struct nvme_ctrl *ctrl)
{
	struct nvme_ns *ns;

     nvme_sync_io_queues(ctrl);

	if (ctrl->admin_q)
		blk_sync_queue(ctrl->admin_q);
}
EXPORT_SYMBOL_GPL(nvme_sync_queues);
>   	nvme_tcp_stop_io_queues(ctrl);
>   	if (ctrl->tagset) {
>   		blk_mq_tagset_busy_iter(ctrl->tagset,
> @@ -2171,14 +2172,11 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
>   
> -	/* fence other contexts that may complete the command */
> -	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
>   	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
>   	if (!blk_mq_request_completed(rq)) {
>   		nvme_req(rq)->status = NVME_SC_HOST_ABORTED_CMD;
>   		blk_mq_complete_request(rq);
>   	}
> -	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
>   }
>   
>   static enum blk_eh_timer_return
> 
> 
> Thanks,
> Ming
> 
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
