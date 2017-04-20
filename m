From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:27:59 +0300
Subject: [PATCH v2 3/4] nvme: enable SG gaps support
In-Reply-To: <1492098977-5231-4-git-send-email-maxg@mellanox.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492098977-5231-4-git-send-email-maxg@mellanox.com>
Message-ID: <2bd673ee-8455-32b7-1bad-34fa9eebb076@grimberg.me>


>  	if (ctrl->quirks & NVME_QUIRK_STRIPE_SIZE)
>  		blk_queue_chunk_sectors(q, ctrl->max_hw_sectors);
> -	blk_queue_virt_boundary(q, ctrl->page_size - 1);
> +
> +	if (!ctrl->sg_gaps_support)
> +		blk_queue_virt_boundary(q, ctrl->page_size - 1);
> +

I think it would be better if the ctrl will hold a virt_boundary
provided by the fabric driver? Then we would always
blk_queue_virt_boundary but with capable devices the fabric driver
can set it to 0. This will also allow for dword aligned sgls to
fit in pretty easily.
