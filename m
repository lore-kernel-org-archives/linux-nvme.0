From: axboe@fb.com (Jens Axboe)
Date: Thu, 11 Dec 2014 13:58:10 -0700
Subject: [PATCH] NVMe: fix retry/error logic in nvme_queue_rq()
In-Reply-To: <alpine.LNX.2.00.1412112040520.4026@localhost.lm.intel.com>
References: <20141211203359.GA14132@kernel.dk>
 <alpine.LNX.2.00.1412112040520.4026@localhost.lm.intel.com>
Message-ID: <548A0562.6070902@fb.com>

On 12/11/2014 01:54 PM, Keith Busch wrote:
> The real reason for reusing the nvme_iod was we needed some structure
> to exist for the life of the command to track total time so we don't
> retry indefinitely. Keeping the dma mapping was just a bonus.

Before blk-mq, you could have cases where ->make_request_fn() was
entered and you'd have to defer due to being out of commands, for
instance. That's no longer the case. Right now it should only happen if
we run into resource constraints, on the IOMMU or memory side. Now we
are definitely better off freeing everything. Besides, we didn't retain
the full state, so the retry was buggy.

> Total time is tracked with "req->start_time" now, so nothing wrong with
> removing the iod reuse.
> 
> Acked-by: Keith Busch <keith.busch at intel.com>

Thanks!

-- 
Jens Axboe
