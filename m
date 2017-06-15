From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 14:27:17 +0200
Subject: [RESEND-nvme-4.13] nvme: Implement NS Optimal IO Boundary from
 1.3 Spec
In-Reply-To: <20170614163753.5215-1-scott.bauer@intel.com>
References: <20170614163753.5215-1-scott.bauer@intel.com>
Message-ID: <20170615122717.GA23459@lst.de>

Hi Scott,

can you resend this against the nvme-4.13 tree, it clashes badly
with some of the other changes.

Also a few comments:

>  	blk_queue_logical_block_size(ns->queue, bs);
> +	if (ns->noiob) {
> +		/* Convert from controller logical blocks to 512 sectors. */
> +		iob = (((unsigned int)ns->noiob) << ns->lba_shift) >> 9;
> +		iob = rounddown_pow_of_two(iob);
> +		blk_queue_chunk_sectors(ns->queue, iob);
> +	}

What about moving this into a little helper:

static void nvme_set_chunk_size(struct nvme_ns *ns)
{
	unsigned int chunk_size = (((u32)ns->noiob) << ns->lba_shift) >> 9;

	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
}
