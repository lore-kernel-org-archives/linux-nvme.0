From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Dec 2014 20:54:42 +0000 (UTC)
Subject: [PATCH] NVMe: fix retry/error logic in nvme_queue_rq()
In-Reply-To: <20141211203359.GA14132@kernel.dk>
References: <20141211203359.GA14132@kernel.dk>
Message-ID: <alpine.LNX.2.00.1412112040520.4026@localhost.lm.intel.com>

The real reason for reusing the nvme_iod was we needed some structure
to exist for the life of the command to track total time so we don't
retry indefinitely. Keeping the dma mapping was just a bonus.

Total time is tracked with "req->start_time" now, so nothing wrong with
removing the iod reuse.

Acked-by: Keith Busch <keith.busch at intel.com>

On Thu, 11 Dec 2014, Jens Axboe wrote:
> Hi,
>
> The logic around retrying and erroring IO in nvme_queue_rq() is broken
> in a few ways:
>
> - If we fail allocating dma memory for a discard, we return retry. We
>  have the 'iod' stored in ->special, but we free the 'iod'.
>
> - For a normal request, if we fail dma mapping of setting up prps, we
>  have the same iod situation. Additionally, we haven't set the callback
>  for the request yet, so we also potentially leak IOMMU resources.
>
> Get rid of the ->special 'iod' store. The retry is uncommon enough that
> it's not worth optimizing for or holding on to resources to attempt to
> speed it up. Additionally, it's usually best practice to free any
> request related resources when doing retries.
>
> Signed-off-by: Jens Axboe <axboe at fb.com>
