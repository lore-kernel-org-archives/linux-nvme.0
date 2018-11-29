From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Nov 2018 13:19:14 -0700
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181129191310.9795-2-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
Message-ID: <20181129201914.GB9377@localhost.localdomain>

On Thu, Nov 29, 2018@08:12:58PM +0100, Christoph Hellwig wrote:
> +enum hctx_type {
> +	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
> +	HCTX_TYPE_READ,		/* just for READ I/O */
> +	HCTX_TYPE_POLL,		/* polled I/O of any kind */
> +
> +	HCTX_MAX_TYPES,
>  };

Well, there goes my plan to use this with Weighted-Round-Robin NVMe IO
queues!

I'm not that sad about it, though.

Reviewed-by: Keith Busch <keith.busch at intel.com>
