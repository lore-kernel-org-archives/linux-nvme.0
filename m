From: hch@lst.de (Christoph Hellwig)
Date: Thu, 2 Mar 2017 01:14:59 +0100
Subject: [PATCH 2/3] blk-mq: Provide freeze queue timeout
In-Reply-To: <1488396132-11369-3-git-send-email-keith.busch@intel.com>
References: <1488396132-11369-1-git-send-email-keith.busch@intel.com>
 <1488396132-11369-3-git-send-email-keith.busch@intel.com>
Message-ID: <20170302001459.GA23070@lst.de>

> +int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
> +				     unsigned long timeout)
> +{
> +	return wait_event_timeout(q->mq_freeze_wq,
> +					percpu_ref_is_zero(&q->q_usage_counter),
> +					timeout);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);

Can you just add the timeout argument to blk_mq_freeze_queue_wait?
Existing callers can pass 0, which is interpreted as no timeout by
the low-level wait code.
