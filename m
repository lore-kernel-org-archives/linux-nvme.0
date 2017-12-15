From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 14 Dec 2017 22:52:11 -0500
Subject: [PATCH] NVMe: Format fix when going from 4k sector size to 512
 bytes
In-Reply-To: <20171214204936.17793-1-jeff.lien@wdc.com> (Jeff Lien's message
 of "Thu, 14 Dec 2017 14:49:36 -0600")
References: <20171214204936.17793-1-jeff.lien@wdc.com>
Message-ID: <yq1fu8cmyvo.fsf@oracle.com>


Jeff,

> +	blk_queue_logical_block_size(disk->queue, bs);
> +	blk_queue_physical_block_size(ns->queue, bs);

A bit messy that you mix ns->queue and disk->queue.

> +    	blk_limits_io_min(&ns->queue->limits, bs);

blk_queue_io_min(foo->queue, bs);

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
