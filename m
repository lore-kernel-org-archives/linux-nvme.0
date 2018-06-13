From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 13:47:56 +0200
Subject: Read request exceeding max_hw_sectors_kb
In-Reply-To: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>
References: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>
Message-ID: <20180613114756.GA27631@lst.de>

On Wed, Jun 13, 2018@04:11:56PM +0530, Jitendra Bhivare wrote:
> So something like resolves the issue:
> static void nvme_set_chunk_size(struct nvme_ns *ns)
> {
> 	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
> 
> 	chunk_size = rounddown_pow_of_two(chunk_size);
> 	chunk_size = min(ns->ctrl->max_hw_sectors, chunk_size);
> 	blk_queue_chunk_sectors(ns->queue,
> rounddown_pow_of_two(chunk_size));
> }
> 
> Please do let me know if this is the right approach or SPDK should set
> noiob appropriately.

I think the answer is both:  The kernel code should be more robust
in handling bogus noiob sizes, so please submit a patch per your above
analysis.  spdk should be fixed to not expose a bogus noiob size as well.
