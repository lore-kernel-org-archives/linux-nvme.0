Return-Path: <SRS0=uUcO=BE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F01C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2020 08:52:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003AE206D8
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Jul 2020 08:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tLwIbe2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003AE206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=riUOWHWBqhzRm0vrbvT5vEZIH+ROiML8e61vm2V7Xwo=; b=tLwIbe2UtsesBVtaG8ze7dFLS
	4/tYT9V9DBFfBzNQPAOAivsnRcAQBbWTuQUKfdIGvgMUV6bBF9Uw+HpqV5j4UQZDu4naSZLwPOt5A
	Fi9CHgKLrXUTSFx7ND5Vin3hDhZfQ3xZvAlEGYEyOqX9iN07O0iZrGkQVkb85XcyaB2vOqPY59Q8s
	DE0dbQDxx1JbYhl22Do/ja1hBy5tmsGXKHc/NxGxwbT1yCkQEtRy4ZuyWA7vuRxmLLseHjrMafpuv
	3KvpSr6xy+nQDVD8x3ERcQEjc9r2p7uKH2f6/sr8DPyUXleMUnsKGdGajLaHb/TKtepzYgSQD/r5S
	5r3UOd9eQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzFuT-0002WE-8G; Sat, 25 Jul 2020 08:52:01 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzFuQ-0002VX-Rs
 for linux-nvme@lists.infradead.org; Sat, 25 Jul 2020 08:51:59 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C7B8825C979E2C0E634D;
 Sat, 25 Jul 2020 16:51:54 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0;
 Sat, 25 Jul 2020 16:51:52 +0800
Subject: Re: [PATCH rfc v2 3/4] nvme-core: reduce io failover time
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200724230604.34625-1-sagi@grimberg.me>
 <20200724230604.34625-4-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <2442ebd7-12ff-3a8b-902f-2dd5d000ce02@huawei.com>
Date: Sat, 25 Jul 2020 16:51:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200724230604.34625-4-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200725_045159_166047_E8D10288 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2020/7/25 7:06, Sagi Grimberg wrote:
> From: Chao Leng <lengchao@huawei.com>
>
> We test nvme over roce fail over with multipath when 1000 namespaces
> configured, io pause more than 10 seconds. The reason: nvme_stop_queues
> will quiesce all queues for each namespace when io timeout cause path
> error. Quiesce queue wait all ongoing dispatches finished through
> synchronize_rcu, need more than 10 milliseconds for each wait,
> thus io pause more than 10 seconds.
>
> To reduce io pause time, nvme_stop_queues use
> blk_mq_quiesce_queue_nowait to quiesce the queue, nvme_stop_queues wait
> all ongoing dispatches completed after all queues has been quiesced.
>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2ae8caa4e25f..e3fae68f7de6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4548,8 +4548,13 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		blk_mq_quiesce_queue(ns->queue);
> +		blk_mq_quiesce_queue_nowait(ns->queue);
>   	up_read(&ctrl->namespaces_rwsem);
> +	/*
> +	 * BLK_MQ_F_BLOCKING drivers should never call us
> +	 */
> +	WARN_ON_ONCE(ctrl->tagset.flags & BLK_MQ_F_BLOCKING);

There is a little compile bug, ctrl->tagset is a pointer. it should:

WARN_ON_ONCE(ctrl->tagset->flags & BLK_MQ_F_BLOCKING);


> +	synchronize_rcu();
>   }
>   EXPORT_SYMBOL_GPL(nvme_stop_queues);
>   

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
