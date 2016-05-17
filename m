From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 11:30:03 -0400
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <20160517152359.GC14260@localhost.localdomain>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
 <1463295520.5272.4.camel@kernel.org>
 <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
 <20160517150511.GB14260@localhost.localdomain>
 <20160517152359.GC14260@localhost.localdomain>
Message-ID: <20160517153003.GA18529@localhost.localdomain>

On Tue, May 17, 2016@11:23:59AM -0400, Keith Busch wrote:
>  out:
> +	if (ret == BLK_MQ_RQ_QUEUE_BUSY) {
> +		spin_lock_irq(ns->queue->queue_lock);
> +		if (!blk_queue_stopped(req->q))


Err ... rather, the above line should be:

+		if (blk_queue_stopped(req->q))


> +			blk_mq_stop_hw_queues(ns->queue);
> +		spin_unlock_irq(ns->queue->queue_lock);
> +	}
>  	nvme_free_iod(dev, req);
>  	return ret;
>  }
