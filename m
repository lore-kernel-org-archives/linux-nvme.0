From: hare@suse.de (Hannes Reinecke)
Date: Wed, 30 May 2018 14:30:20 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180530121241.GA1850@lst.de>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de>
Message-ID: <20180530143020.50a299b8@pentland.suse.de>

On Wed, 30 May 2018 14:12:41 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > -	/* XXX: try an inaccessible path as last resort per
> > 8.18.3.3 */
> > +	if (!ns)
> > +		ns = __nvme_find_path(head,
> > NVME_ANA_INACCESSIBLE);  
> 
> This at least needs to keep a comment on why we are aiming for an
> inaccessible path.
> 
Ok.

> > @@ -165,10 +166,14 @@ static blk_qc_t
> > nvme_ns_head_make_request(struct request_queue *q, 
> >  	srcu_idx = srcu_read_lock(&head->srcu);
> >  	ns = nvme_find_path(head);
> > -	if (likely(ns)) {
> > +	if (likely(ns && nvme_ns_ana_state(ns) !=
> > NVME_ANA_INACCESSIBLE)) { bio->bi_disk = ns->disk;
> >  		bio->bi_opf |= REQ_NVME_MPATH;
> >  		ret = direct_make_request(bio);  
> 
> We should actually sometimes try to issue I/O on an inaccessible path.
> Please take a look at Section 8.18.3.3 in the ANA TP.  Similar
> handling would also apply to change states, which we'd also need to
> cover here and above.
> 
That specific handling hasn't been implemented with this patch, as it
would induce issues on the host side.
But see below.

> 
> > +	} else if (ns) {
> > +		bio->bi_status = BLK_STS_TRANSPORT;
> > +		bio_set_flag(bio, BIO_QUIET);
> > +		bio_endio(bio);
> >  	} else if (!list_empty_careful(&head->list)) {
> >  		dev_warn_ratelimited(dev, "no path available -
> > requeuing I/O\n");  
> 
> But a case where we only have inaccessible / change states isn't
> really different from the no path available, requeing case.
> 
It is for the initial connect.

> Now it might make sense to have a (configurable) timeout to give
> up in all those case, and if my vague memory serves me right you
> actually volunteered to implement that a while ago.
> 
The problem is that this particular code path is triggered for the
revalidate_disk() case; when opting for requeue (as the original code
did) the system will hang during revalidate_disk(), via

[ 1463.219509]  schedule+0x4f/0xd0
[ 1463.220712]  io_schedule+0x1c/0x50
[ 1463.221415]  do_read_cache_page+0x603/0x8a0
[ 1463.232007]  read_dev_sector+0x5b/0x160
[ 1463.232858]  read_lba+0x1b5/0x340
[ 1463.237400]  efi_partition+0x234/0xce0
[ 1463.254255]  check_partition+0x1ab/0x310
[ 1463.255090]  rescan_partitions+0x136/0x4b0
[ 1463.258420]  __blkdev_get+0x535/0x840
[ 1463.261793]  blkdev_get+0x1ff/0x4c0
[ 1463.267360]  __device_add_disk+0x73c/0x7a0
[ 1463.272179]  nvme_mpath_add_disk+0x9a/0xe0
[ 1463.273042]  nvme_alloc_ns+0x6e3/0xdb0

As this blocks the nvmf_dev_mutex we don't have any chance to connect
the other, optimized path.

I had been thinking of implementing that particular handling from the
ANA spec, but that would mean we're adding an ANA TT delay for each
inaccessible path, which with the current defaults would mean booting
is delayed by 10 seconds per inaccessible path.
That simply doesn't scale, so I opted for aborting the I/O straigh away.
(Which, incidentally, is also how we handle things on the dm-multipath
side).

One possible alternative would be to make revalidate_disk non-blocking
by adding another GENHD flag to avoid reading partitions, as this would
require more plumbing I didn't attempt it so far.

Cheers,

Hannes
