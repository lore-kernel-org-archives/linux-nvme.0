From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 02:28:03 -0800
Subject: [PATCH 5/5] nvmet: add support for the Write Zeroes command
In-Reply-To: <6591bf30-6f66-c4e6-e304-9b580489a9b9@grimberg.me>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-6-git-send-email-chaitanya.kulkarni@hgst.com>
 <6591bf30-6f66-c4e6-e304-9b580489a9b9@grimberg.me>
Message-ID: <20161117102803.GA8295@infradead.org>

On Wed, Nov 16, 2016@06:47:22PM +0200, Sagi Grimberg wrote:
> > +	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
> > +				GFP_KERNEL, &bio, false))
> > +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> > +
> > +	if (bio) {
> > +		bio->bi_private = req;
> > +		bio->bi_end_io = nvmet_bio_done;
> > +		if (status) {
> 
> if (status != NVME_SC_SUCCESS) can this happen?
> can we end up with a bio if __blkdev_issue_zeroout
> failed?

This can't happen, it's copy and paste from deallocate which operates on a
range, and where it could happen.

> > +			bio->bi_error = -EIO;
> > +			bio_endio(bio);
> 
> Something looks odd here, how does the status propagate in
> this case?

We'd only need the -EIO - but as said this can't actually happen and
we can just remove it.
