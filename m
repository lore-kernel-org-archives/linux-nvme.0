Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77378C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Jd95jnfIFi3jDinna8ZnPEfwvk94yj/FLwvMLSUxwE=; b=fkqL1pRi15i0PSQCPVQjTnqtWC
	K54qwwQj3aGu7GaWaRfSgqL8TYN/+phGJwrHnrNxw/AidNsWlATB0iOiFaLgqCHZ8I2oYgRW1W1wN
	Nta7mRt9AMaATYn5BTtpwBV66nThXyfMM9tDbBvNztp8C0tN0vgMF6YtHs738hilrlDzANuyvqk0V
	eXQh5Uw5I+ZftWTBcuqn6g0lrM2zdNXMw3DIDC0b2+E7SgH4twI6fIZ78XV5x1GvOSZoLDV96DcvY
	30kXdQsvefcOFy8z2eHk7Uhqnxvthsl7q6ShM7yvCDcwynrVWa+jN8nQkxQP1t1EGOralXUUo3Fmx
	vadrDcww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYxp-000000091zP-0x64;
	Wed, 19 Aug 2026 05:35:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYxm-000000091yx-2hei
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:35:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5052968C7B; Wed, 19 Aug 2026 07:35:41 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:35:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jun1.zeng@intel.com, Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
Message-ID: <20260819053541.GC32364@lst.de>
References: <20260818033846.53790-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818033846.53790-1-changfengnan@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_223547_005598_91AFA18E 
X-CRM114-Status: GOOD (  26.43  )
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

On Tue, Aug 18, 2026 at 11:38:46AM +0800, Fengnan Chang wrote:
> +#define NVME_ADAPTIVE_POLL_PERIOD_NS	(10U * NSEC_PER_USEC)
> +#define NVME_ADAPTIVE_EPISODE_CQES	8192U
> +#define NVME_ADAPTIVE_REEVAL_CQES	(64U * NVME_ADAPTIVE_EPISODE_CQES)
> +#define NVME_ADAPTIVE_POLL_RETRIES	2U

It would be good to describe these paramters and how we picked the
constants here.

> +struct nvme_adaptive_poll {
> +	struct hrtimer timer;		/* fires the next poll drain */
> +	struct irq_poll iopoll;		/* softirq context for the drain */
> +	struct nvme_queue *nvmeq;
> +	u64 start_ns;			/* when the current sample/episode started */
> +	u32 retry_completions;		/* completions until retry or IRQ rebaseline */
> +	u32 interval_ns;		/* sampled average gap between completions */
> +	u32 completions;		/* completions seen so far this sample/episode */
> +	int irq;
> +	u8 poll_failures;		/* consecutive rejected polling trials */

Lots of overly long lines.  Just move the comments above the fields.

> -	 /* only used for poll queues: */
> +	struct nvme_adaptive_poll *adaptive;
> +	/* Used for both poll queues and adaptive interrupt polling. */

s/both //

> +static inline unsigned int nvme_poll_cq(struct nvme_queue *nvmeq,
> +					struct io_comp_batch *iob)

Two-tab indents please.  Also for various other spots later on.

>  {
> -	bool found = false;
> +	unsigned int found = 0;
>  
>  	while (nvme_cqe_pending(nvmeq)) {
> -		found = true;
>  		/*
>  		 * load-load control dependency between phase and the rest of
>  		 * the cqe requires a full read memory barrier
> @@ -1620,6 +1649,7 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
>  		dma_rmb();
>  		nvme_handle_cqe(nvmeq, iob, nvmeq->cq_head);
>  		nvme_update_cq_head(nvmeq);
> +		found++;
>  	}
>  
>  	if (found)
> @@ -1627,17 +1657,22 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
>  	return found;
>  }

And maybe split this into a prep patch?

> +/* Keep the normal completion loop branch-free. */

That is a rather terse comment.  I also don't really see what is
branch free here.

> +static enum hrtimer_restart nvme_adaptive_poll_timer(struct hrtimer *timer)
> +{
> +	struct nvme_adaptive_poll *adaptive = container_of(timer,
> +					struct nvme_adaptive_poll, timer);

container_of statements tend to read a lot nicer like:
(same for the next one)

	struct nvme_adaptive_poll *adaptive =
		container_of(timer, struct nvme_adaptive_poll, timer);


> +
> +static irqreturn_t nvme_irq(int irq, void *data);

Please add the new interrupt handlers below nvme_irq to remove the need
for this forward declaration.

> +	unsigned int completions;
> +	unsigned long flags;
> +	DEFINE_IO_COMP_BATCH(iob);
> +
> +	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
> +	if (unlikely(test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))) {
> +		spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
> +		return IRQ_HANDLED;
> +	}
> +	completions = nvme_poll_cq(nvmeq, &iob);
> +	if (completions)
> +		nvme_adaptive_sample(nvmeq, completions);
> +	spin_unlock_irqrestore(&nvmeq->cq_poll_lock, flags);
> +	if (!completions)
> +		return test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
> +					  &nvmeq->flags) ? IRQ_HANDLED : IRQ_NONE;
> +	if (!rq_list_empty(&iob.req_list))
> +		nvme_pci_complete_batch(&iob);
> +	return IRQ_HANDLED;

This reads a bit weird, I'd reflow the end to:

	if (completions) {
		if (!rq_list_empty(&iob.req_list))
			nvme_pci_complete_batch(&iob);
	} else {
		if (!test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ,
				&nvmeq->flags))
			return IRQ_NONE;
	}
	return IRQ_HANDLED;



> +}
> +
> +static irqreturn_t nvme_irq_adaptive(int irq, void *data)
> +{
> +	struct nvme_queue *nvmeq = data;
> +	irqreturn_t ret;
> +
> +	if (!test_bit(NVMEQ_ADAPTIVE_ENABLED, &nvmeq->flags)) {
> +		ret = nvme_irq(irq, data);
> +		if (ret == IRQ_NONE &&
> +		    test_and_clear_bit(NVMEQ_ADAPTIVE_STALE_IRQ, &nvmeq->flags))
> +			return IRQ_HANDLED;
> +		return ret;
> +	}
> +	return nvme_irq_adaptive_enabled(irq, data);
> +}
> +
> +static irqreturn_t nvme_irq(int irq, void *data)
> +{
> +	struct nvme_queue *nvmeq = data;
> +	DEFINE_IO_COMP_BATCH(iob);
> +
> +	if (nvme_poll_cq(nvmeq, &iob)) {
> +		if (!rq_list_empty(&iob.req_list))
> +			nvme_pci_complete_batch(&iob);
> +		return IRQ_HANDLED;
> +	}
> +	return IRQ_NONE;

A lot of this irq handler code is repetitive.  Could there be a way
to share the code to remove the duplication?


