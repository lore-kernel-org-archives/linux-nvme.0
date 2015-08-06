From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 6 Aug 2015 20:36:58 +0300
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <1438716733-566-1-git-send-email-keith.busch@intel.com>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
Message-ID: <55C39B3A.5030201@dev.mellanox.co.il>


> +/*
> + * Check if adding a bio_vec after bprv with offset would create a gap in
> + * the SG list. Most drivers don't care about this, but some do.
> + */
> +static inline bool bvec_gap_to_prev(struct request_queue *q,
> +				struct bio_vec *bprv, unsigned int offset)
> +{
> +	if (!queue_virt_boundary(q))
> +		return false;
> +	return offset ||
> +		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));

I'm wandering if it deserves an unlikely() statement given it really
depends on the application workload...

Thoughts?
