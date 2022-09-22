Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECB3C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 09:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBTVlbOfBC+xuW4o0ZbVu0NOcIC5/4WM8n0ybJ5/s64=; b=qBpk8nFFlhD5TuPwlvC9BeZGW1
	2ax3fQIfp44DfWbc8TXyOkftL4hdpQsIB/zU1d6eqZDCHE19HxgPwFro6x1SSOn3lcC/N8f/N7Ah5
	YV9ViYeLD1EOCLtr/6XJnLoGgbQqhjgf+/hvgAX/mmvJKIHAxRmMRy0zEHbQHyoj50ZefJXeMjzsC
	SEqjDX4u+dJ1q5MBuufjLmOfEpagM/ghVCpXVp2+P2iKBwgg5Rkg50tBx2OyYsI0F6wq7nsdBPtrE
	5Yf+ZSxbandYqiwG6XWjOe4Da6zfx8lB6SpIWFDw+N3QuCCr0pVgA2rf7lcZ+e2Podpej7ECx6bER
	RKkJFeUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obI4Q-00EKJO-Q2; Thu, 22 Sep 2022 09:00:34 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHrc-00EGCx-Rj
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:47:22 +0000
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MY80x0x80z6HJ5M;
	Thu, 22 Sep 2022 16:42:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:47:11 +0200
Received: from [10.195.244.8] (10.195.244.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 09:47:11 +0100
Message-ID: <19568225-56a1-f545-b8de-a219b7f843b7@huawei.com>
Date: Thu, 22 Sep 2022 09:47:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
	<linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <20220920021724.1841850-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.8]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_014721_140649_AD832A3F 
X-CRM114-Status: GOOD (  21.45  )
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

On 20/09/2022 03:17, Ming Lei wrote:
> For avoiding to trigger io timeout when one hctx becomes inactive, we
> drain IOs when all CPUs of one hctx are offline. However, driver's
> timeout handler may require cpus_read_lock, such as nvme-pci,
> pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
> and irq_build_affinity_masks() needs cpus_read_lock().
> 
> Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
> is held, so deadlock is caused.
> 
> Fixes the issue by breaking the wait loop if enough long time elapses,
> and these in-flight not drained IO still can be handled by timeout
> handler.

I don't think that that this is a good idea - that is because often 
drivers cannot safely handle scenario of timeout of an IO which has 
actually completed. NVMe timeout handler may poll for completion, but 
SCSI does not.

Indeed, if we were going to allow the timeout handler handle these 
in-flight IO then there is no point in having this hotplug handler in 
the first place.

> 
> Cc: linux-nvme@lists.infradead.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..4585985b8537 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3301,6 +3301,7 @@ static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
>   	return true;
>   }
>   
> +#define BLK_MQ_MAX_OFFLINE_WAIT_MSECS 3000

That's so low compared to default SCSI sd timeout.

>   static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   {
>   	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> @@ -3326,8 +3327,13 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   	 * frozen and there are no requests.
>   	 */
>   	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
> -		while (blk_mq_hctx_has_requests(hctx))
> +		unsigned int wait_ms = 0;
> +
> +		while (blk_mq_hctx_has_requests(hctx) && wait_ms <
> +				BLK_MQ_MAX_OFFLINE_WAIT_MSECS) {
>   			msleep(5);
> +			wait_ms += 5;
> +		}
>   		percpu_ref_put(&hctx->queue->q_usage_counter);
>   	}
>   

Thanks,
John

