Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FC3C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YLuOQFaU/X5mcThHdBV3qzCk8saMxlSNsMnTwHAUe1E=; b=kima8xmYsOo14GcMqgykHFE+yh
	iRQfsbwTHPrd0r2ybKzApWj43AlMgDtNbYzrtX3GrZLeyfiemhfPNOApq8uj2zGgXKbSuBc0Ru5B0
	+jcPQtIg98o3+OtzhooRsmA9J4pMSh9V1FDnjsJu0/hTZKcRFesw3E0ODyoOFrrc8QjW3GwZ3LCdF
	h0DMmz3rFtQ7LXQ/kKYAaAVOyya5U3WsqUJ/X1ISn+b60Ql5uGNzOLJqVbWaSbHFgIjygLWdSh8xN
	HZKYRne1Z2AqjxLf4zTyyt4RWu7cXjKmXHkKWWZGAdsDmPdOBKQHY4wA9psWvHuFyoG6gMVOUM57D
	ROVnT+IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFeG-00DY1d-2w; Thu, 22 Sep 2022 06:25:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obFeD-00DY0Q-B9
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 06:25:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EC5F68BEB; Thu, 22 Sep 2022 08:25:17 +0200 (CEST)
Date: Thu, 22 Sep 2022 08:25:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, homas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Message-ID: <20220922062517.GB27946@lst.de>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920021724.1841850-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_232521_548448_A99060E0 
X-CRM114-Status: GOOD (  31.28  )
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

On Tue, Sep 20, 2022 at 10:17:24AM +0800, Ming Lei wrote:
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

I'm not sure that this actually is a good idea on its own, and it kinda
defeats the cpu hotplug processing.

So if I understand your log above correctly the problem is that
we have commands that would time out, and we exacalate to a
controller reset that is racing with the CPU unplug, or if not can
you explain the scenario a little more?

> Cc: linux-nvme@lists.infradead.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..4585985b8537 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3301,6 +3301,7 @@ static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
>  	return true;
>  }
>  
> +#define BLK_MQ_MAX_OFFLINE_WAIT_MSECS 3000
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> @@ -3326,8 +3327,13 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	 * frozen and there are no requests.
>  	 */
>  	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
> -		while (blk_mq_hctx_has_requests(hctx))
> +		unsigned int wait_ms = 0;
> +
> +		while (blk_mq_hctx_has_requests(hctx) && wait_ms <
> +				BLK_MQ_MAX_OFFLINE_WAIT_MSECS) {
>  			msleep(5);
> +			wait_ms += 5;
> +		}
>  		percpu_ref_put(&hctx->queue->q_usage_counter);
>  	}
>  
> -- 
> 2.31.1
---end quoted text---

