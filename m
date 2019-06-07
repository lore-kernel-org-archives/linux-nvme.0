From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 07 Jun 2019 11:19:47 -0400
Subject: [PATCH 2/2] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <20190606212854.122478-3-bvanassche@acm.org> (Bart Van Assche's
 message of "Thu, 6 Jun 2019 14:28:54 -0700")
References: <20190606212854.122478-1-bvanassche@acm.org>
 <20190606212854.122478-3-bvanassche@acm.org>
Message-ID: <yq1ef45jucs.fsf@oracle.com>


Bart,

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
> +	blk_queue_io_min(disk->queue, phys_bs);
> +	blk_queue_io_opt(disk->queue, io_opt);
>  
>  	if (ns->ms && !ns->ext &&
>  	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))

Also fine. Nice to get these wired up!

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
