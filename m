From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 17:26:49 +0000 (UTC)
Subject: [PATCH] NVMe: avoid kmalloc/kfree for smaller IO
In-Reply-To: <20150122043805.GA12546@kernel.dk>
References: <20150122043805.GA12546@kernel.dk>
Message-ID: <alpine.LNX.2.00.1501221702170.15481@localhost.lm.intel.com>

On Wed, 21 Jan 2015, Jens Axboe wrote:
> Currently we allocate an nvme_iod for each IO, which holds the
> sg list, prps, and other IO related info. Set a threshold of
> 2 pages and/or 8KB of data, below which we can just embed this
> in the per-command pdu in blk-mq. For any IO at or below
> NVME_INT_PAGES and NVME_INT_BYTES, we save a kmalloc and kfree.
>
> For higher IOPS, this saves up to 1% of CPU time.
>
> Signed-off-by: Jens Axboe <axboe at fb.com>
>
> ----

> +/*
> + * Max size of iod being embedded in the request payload
> + */
> +#define NVME_INT_PAGES		2
> +#define NVME_INT_BYTES		(NVME_INT_PAGES * PAGE_CACHE_SIZE)

I think the above needs to use what the device thinks a page size, right? If
there's a mismatched host-device page size, nvme_setup_prps could end up
accessing a non-existent prp list.

   #define NVME_INT_BYTES(dev) (NVME_INT_PAGES * dev->page_size)

Otherwise, looks good!
