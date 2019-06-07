From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jun 2019 18:42:02 +0200
Subject: [PATCH 2/2] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <20190606212854.122478-3-bvanassche@acm.org>
References: <20190606212854.122478-1-bvanassche@acm.org>
 <20190606212854.122478-3-bvanassche@acm.org>
Message-ID: <20190607164202.GA7307@lst.de>

On Thu, Jun 06, 2019@02:28:54PM -0700, Bart Van Assche wrote:
> +	phys_bs = bs;
> +	io_opt = bs;
> +	if (id->nsfeat & (1 << 4)) {
> +		/* NPWG = Namespace Preferred Write Granularity */
> +		phys_bs *= 1 + le16_to_cpu(id->npwg);
> +		/* NOWS = Namespace Optimal Write Size */
> +		io_opt *= 1 + le16_to_cpu(id->nows);
> +	}
>  	blk_queue_logical_block_size(disk->queue, bs);
> -	blk_queue_physical_block_size(disk->queue, bs);
> -	blk_queue_io_min(disk->queue, bs);
> +	blk_queue_physical_block_size(disk->queue, phys_bs);

Unfortunatly it is not that simple.  Filesystems expect the physical
block size to be an atomic writable unit.  So this value will have
to be limited by AWUPF/NAWUPF values.
