From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jan 2015 17:21:21 +0000 (UTC)
Subject: [PATCH v2] NVMe: avoid kmalloc/kfree for smaller IO
In-Reply-To: <20150122190758.GA28666@kernel.dk>
References: <20150122190758.GA28666@kernel.dk>
Message-ID: <alpine.LNX.2.00.1501291714300.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Jens Axboe wrote:
> Currently we allocate an nvme_iod for each IO, which holds the
> sg list, prps, and other IO related info. Set a threshold of
> 2 pages and/or 8KB of data, below which we can just embed this
> in the per-command pdu in blk-mq. For any IO at or below
> NVME_INT_PAGES and NVME_INT_BYTES, we save a kmalloc and kfree.
>
> For higher IOPS, this saves up to 1% of CPU time.

Looks good to me, tests well on my machines. I had to make one minor
modification to the diff for it to apply to your latest tree, but it's
trivial and you'll see it (just below nvme_set_info()).

Reviewed-by: Keith Busch <keith.busch at intel.com>

> Signed-off-by: Jens Axboe <axboe at fb.com>
