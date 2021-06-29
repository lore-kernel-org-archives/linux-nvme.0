Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2391FC11F67
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 15:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EF061DBF
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 15:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EF061DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9qY6yY72ESamekSRdGoYRH4RiGSfiw/0n+pz5vRyq0=; b=oJbgxX8y1/IKiGY6df0KQunhvS
	YbEOWYqLyGm5Ypc3x+POwPu8inatopC6a6LXw9jSoh4ZEdwveXEPO7ao0EqCnNJHl+wJLZm3/FTQC
	MB/Mdvb7wV6woCYjkMKHAkgUFyQo7wcS3IY92EaOSWTcuqJcuuMdrazLYMpcYG//OYv0lcVsEouzE
	n+2KxzgaQiGcrT/Zv/ysAitM+s//2xzrwXfNPjxYUFdbsZ0+7igH2BuTXxs+oJuuP9YgnaJMXKq0t
	n26td88Bz9bV/UAnS4yAmz1rp1sjUI3OCd0p+tOdt7xa6NBauKIVYmLmSP6CqRMI5JjL4bsSytwjW
	29TmQHmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyG6d-00BXJw-HR; Tue, 29 Jun 2021 15:56:59 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyG6a-00BXIK-8q
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 15:56:58 +0000
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GDpdx5DbPz6H7PS;
 Tue, 29 Jun 2021 23:43:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 17:56:46 +0200
Received: from [10.47.83.88] (10.47.83.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 29 Jun
 2021 16:56:45 +0100
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, "Christoph
 Hellwig" <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, "Wen
 Xiong" <wenxiong@us.ibm.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c31aa259-d3a8-8c70-efce-b7af02bfd609@huawei.com>
Date: Tue, 29 Jun 2021 16:49:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210629074951.1981284-2-ming.lei@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.47.83.88]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_085656_641325_6EB7D574 
X-CRM114-Status: GOOD (  26.33  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 29/06/2021 08:49, Ming Lei wrote:
> hctx is deactivated when all CPU in hctx->cpumask become offline by
> draining all requests originated from this hctx and moving new
> allocation to active hctx. This way is for avoiding inflight IO when
> the managed irq is shutdown.
> 
> Some drivers(nvme fc, rdma, tcp, loop) doesn't use managed irq, so
> they needn't to deactivate hctx. Also, they are the only user of
> blk_mq_alloc_request_hctx() which is used for connecting io queue.
> And their requirement is that the connect request can be submitted
> via one specified hctx on which all CPU in its hctx->cpumask may have
> become offline.
> 
> Address the requirement for nvme fc/rdma/loop, so the reported kernel
> panic on the following line in blk_mq_alloc_request_hctx() can be fixed.
> 
> 	data.ctx = __blk_mq_get_ctx(q, cpu)
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Wen Xiong <wenxiong@us.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c         | 6 +++++-
>   include/linux/blk-mq.h | 1 +
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index df5dc3b756f5..74632f50d969 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -494,7 +494,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	data.hctx = q->queue_hw_ctx[hctx_idx];
>   	if (!blk_mq_hw_queue_mapped(data.hctx))
>   		goto out_queue_exit;
> -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +	cpu = cpumask_first(data.hctx->cpumask);
>   	data.ctx = __blk_mq_get_ctx(q, cpu);
>   
>   	if (!q->elevator)
> @@ -2570,6 +2570,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
>   		return 0;
>   
> +	/* Controller doesn't use managed IRQ, no need to deactivate hctx */
> +	if (hctx->flags & BLK_MQ_F_NOT_USE_MANAGED_IRQ)
> +		return 0;
Is there anything to be gained in registering the CPU hotplug handler 
for the hctx in this case at all?

> +
>   	/*
>   	 * Prevent new request from being allocated on the current hctx.
>   	 *
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 21140132a30d..600c5dd1a069 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -403,6 +403,7 @@ enum {
>   	 */
>   	BLK_MQ_F_STACKING	= 1 << 2,
>   	BLK_MQ_F_TAG_HCTX_SHARED = 1 << 3,
> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ = 1 << 4,

Many block drivers don't use managed interrupts - to be proper, why not 
set this everywhere (which doesn't use managed interrupts)? I know why, 
but it's odd.

As an alternative, if the default queue mapping was used (in 
blk_mq_map_queues()), then that's the same thing as 
BLK_MQ_F_NOT_USE_MANAGED_IRQ in reality, right? If so, could we 
alternatively check for that somehow?

Thanks,
John

>   	BLK_MQ_F_BLOCKING	= 1 << 5,
>   	BLK_MQ_F_NO_SCHED	= 1 << 6,
>   	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
