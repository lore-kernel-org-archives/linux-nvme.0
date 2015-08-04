From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 4 Aug 2015 04:28:17 -0700
Subject: [PATCHv3] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <1438372071-24898-1-git-send-email-keith.busch@intel.com>
References: <1438372071-24898-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150804112817.GA8395@infradead.org>

> -		if (q->queue_flags & (1 << QUEUE_FLAG_SG_GAPS) &&
> -		    bvec_gap_to_prev(prev, offset))
> +		if (queue_virt_boundary(q) && bvec_gap_to_prev(prev, offset,
> +							queue_virt_boundary(q)))

Nipick:  This would look nicer as:

		if (queue_virt_boundary(q) &&
		     bvec_gap_to_prev(prev, offset, queue_virt_boundary(q)))

But why don't we hide all this beind a better implementation of
bvec_gap_to_prev:

> +static inline bool bvec_gap_to_prev(struct bio_vec *bprv, unsigned int offset, unsigned long mask)
>  {
> -	return offset || ((bprv->bv_offset + bprv->bv_len) & (PAGE_SIZE - 1));
> +	return offset || ((bprv->bv_offset + bprv->bv_len) & mask);
>  }

static inline bool bvec_gap_to_prev(struct request_queue *q,
		struct bio_vec *bprv, unsigned int offset)
{
	if (!queue_virt_boundary(q))
		return false;
	return offset ||
		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q);
}
