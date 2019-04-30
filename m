From: kbusch@kernel.org (Keith Busch)
Date: Tue, 30 Apr 2019 10:33:50 -0600
Subject: [PATCHv2] nvme-multipath: split bios with the ns_head bio_set
 before submitting
In-Reply-To: <20190430162745.39204-1-hare@suse.de>
References: <20190430162745.39204-1-hare@suse.de>
Message-ID: <20190430163350.GA25542@localhost.localdomain>

On Tue, Apr 30, 2019@06:27:45PM +0200, Hannes Reinecke wrote:
> +	/*
> +	 * The namespace might be going away and the bio might
> +	 * be moved to a different queue via blk_steal_bios(),
> +	 * so we need to use the bio_split pool from the original
> +	 * queue to allocate the bvecs from.
> +	 */
> +	blk_queue_split(q, *bio);
                           ^^^^

Shouldn't that be '&bio'?
