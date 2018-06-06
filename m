From: Sriram.Popuri@netapp.com (Popuri, Sriram)
Date: Wed, 6 Jun 2018 19:02:16 +0000
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180530121241.GA1850@lst.de>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de>
Message-ID: <BN7PR06MB4033AEEF34ABC70C71175B6992650@BN7PR06MB4033.namprd06.prod.outlook.com>

Looks like __nvme_find_path is pretty basic one.
Let's say if there are 2 NVME_ANA_OPTIMIZED paths. However it looks like the first found path is chosen. That means having more than one NVME_ANA_OPTIMIZED paths doesn't help much. Any plans to round robin?

> -	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
> +	if (!ns)
> +		ns = __nvme_find_path(head, NVME_ANA_INACCESSIBLE);

Also if there are multiple NVME_ANA_INACCESSIBLE paths and only a few(or one) is changing ANA state from INACCESSIBLE to OPTIMIZED and if that happens to be the last entry in your list, then trying above doesn't really help.

Regards,
~Sriram

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Christoph Hellwig
Sent: Wednesday, May 30, 2018 5:43 PM
To: Hannes Reinecke <hare at suse.de>
Cc: Keith Busch <keith.busch at intel.com>; Hannes Reinecke <hare at suse.com>; Christoph Hellwig <hch at lst.de>; linux-nvme at lists.infradead.org; Sagi Grimberg <sagi at grimberg.me>
Subject: Re: [PATCH] nvme: avoid hang on inaccessible paths

> -	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
> +	if (!ns)
> +		ns = __nvme_find_path(head, NVME_ANA_INACCESSIBLE);

This at least needs to keep a comment on why we are aiming for an inaccessible path.

> @@ -165,10 +166,14 @@ static blk_qc_t nvme_ns_head_make_request(struct 
> request_queue *q,
>  
>  	srcu_idx = srcu_read_lock(&head->srcu);
>  	ns = nvme_find_path(head);
> -	if (likely(ns)) {
> +	if (likely(ns && nvme_ns_ana_state(ns) != NVME_ANA_INACCESSIBLE)) {
>  		bio->bi_disk = ns->disk;
>  		bio->bi_opf |= REQ_NVME_MPATH;
>  		ret = direct_make_request(bio);

We should actually sometimes try to issue I/O on an inaccessible path.
Please take a look at Section 8.18.3.3 in the ANA TP.  Similar handling would also apply to change states, which we'd also need to cover here and above.


> +	} else if (ns) {
> +		bio->bi_status = BLK_STS_TRANSPORT;
> +		bio_set_flag(bio, BIO_QUIET);
> +		bio_endio(bio);
>  	} else if (!list_empty_careful(&head->list)) {
>  		dev_warn_ratelimited(dev, "no path available - requeuing I/O\n");

But a case where we only have inaccessible / change states isn't really different from the no path available, requeing case.

Now it might make sense to have a (configurable) timeout to give up in all those case, and if my vague memory serves me right you actually volunteered to implement that a while ago.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
