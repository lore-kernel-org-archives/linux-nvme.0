From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 14:12:41 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180530111637.22223-1-hare@suse.de>
References: <20180530111637.22223-1-hare@suse.de>
Message-ID: <20180530121241.GA1850@lst.de>

> -	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
> +	if (!ns)
> +		ns = __nvme_find_path(head, NVME_ANA_INACCESSIBLE);

This at least needs to keep a comment on why we are aiming for an
inaccessible path.

> @@ -165,10 +166,14 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
>  
>  	srcu_idx = srcu_read_lock(&head->srcu);
>  	ns = nvme_find_path(head);
> -	if (likely(ns)) {
> +	if (likely(ns && nvme_ns_ana_state(ns) != NVME_ANA_INACCESSIBLE)) {
>  		bio->bi_disk = ns->disk;
>  		bio->bi_opf |= REQ_NVME_MPATH;
>  		ret = direct_make_request(bio);

We should actually sometimes try to issue I/O on an inaccessible path.
Please take a look at Section 8.18.3.3 in the ANA TP.  Similar handling
would also apply to change states, which we'd also need to cover here
and above.


> +	} else if (ns) {
> +		bio->bi_status = BLK_STS_TRANSPORT;
> +		bio_set_flag(bio, BIO_QUIET);
> +		bio_endio(bio);
>  	} else if (!list_empty_careful(&head->list)) {
>  		dev_warn_ratelimited(dev, "no path available - requeuing I/O\n");

But a case where we only have inaccessible / change states isn't
really different from the no path available, requeing case.

Now it might make sense to have a (configurable) timeout to give
up in all those case, and if my vague memory serves me right you
actually volunteered to implement that a while ago.
