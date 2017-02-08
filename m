From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Feb 2017 12:57:10 +0100
Subject: [PATCH 3/4] block: optionally merge discontiguous discard bios
 into a single request
In-Reply-To: <CACVXFVOZfrLGb59q=V_O2xijM6t9uUq8Foj5qWZ5sAQpRSWngA@mail.gmail.com>
References: <20170207164658.32449-1-hch@lst.de>
 <20170207164658.32449-4-hch@lst.de>
 <CACVXFVOZfrLGb59q=V_O2xijM6t9uUq8Foj5qWZ5sAQpRSWngA@mail.gmail.com>
Message-ID: <20170208115710.GB11342@lst.de>

On Wed, Feb 08, 2017@06:54:24PM +0800, Ming Lei wrote:
> > +               struct bio *bio)
> > +{
> > +       unsigned short segments = blk_rq_nr_discard_segments(req);
> > +
> > +       if (segments >= queue_max_discard_segments(q))
> > +               goto no_merge;
> > +       if (blk_rq_sectors(req) + bio_sectors(bio) >
> > +           blk_rq_get_max_sectors(req, blk_rq_pos(req)))
> > +               goto no_merge;
> > +
> > +       req->biotail->bi_next = bio;
> > +       req->biotail = bio;
> > +       req->__data_len += bio->bi_iter.bi_size;
> 
> typeof(__data_len) is unsigned, and should be easy to overflow
> for discard rq's merge.

We respect the max_discard_sectors setting which is unsigned as well
above in blk_rq_get_max_sectors(), so we can't actually overflow here.

And please remove the fullquote after your two line comment, thanks!
