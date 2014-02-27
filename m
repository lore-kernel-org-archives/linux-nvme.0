From: kmo@daterainc.com (Kent Overstreet)
Date: Thu, 27 Feb 2014 13:27:15 -0800
Subject: [PATCH 1/9] block: Make generic_make_request handle arbitrary
 sized bios
In-Reply-To: <20140227172254.GI5744@linux.intel.com>
References: <1393457997-17618-1-git-send-email-kmo@daterainc.com>
 <1393457997-17618-2-git-send-email-kmo@daterainc.com>
 <20140227172254.GI5744@linux.intel.com>
Message-ID: <20140227212715.GA2834@kmo-pixel>

On Thu, Feb 27, 2014@12:22:54PM -0500, Matthew Wilcox wrote:
> On Wed, Feb 26, 2014@03:39:49PM -0800, Kent Overstreet wrote:
> > We do this by adding calls to blk_queue_split() to the various
> > make_request functions that need it - a few can already handle arbitrary
> > size bios. Note that we add the call _after_ any call to blk_queue_bounce();
> > this means that blk_queue_split() and blk_recalc_rq_segments() don't need to
> > be concerned with bouncing affecting segment merging.
> 
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index 51824d1f23..e4376b9613 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -737,6 +737,8 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
> >  	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> >  	int result = -EBUSY;
> >  
> > +	blk_queue_split(q, &bio, q->bio_split);
> > +
> >  	if (!nvmeq) {
> >  		put_nvmeq(NULL);
> >  		bio_endio(bio, -EIO);
> 
> I'd suggest that we do:
> 
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> +	struct nvme_queue *nvmeq;
>  	int result = -EBUSY;
> 
> +	blk_queue_split(q, &bio, q->bio_split);
> +
> +	nvmeq = get_nvmeq(ns->dev);
>  	if (!nvmeq) {
> 
> so that we're running the blk_queue_split() code outside the get_cpu()
> call.

Whoops, that's definitely a bug.

> Now, the NVMe driver has its own rules about when BIOs have to be split.
> Right now, that's way down inside the nvme_map_bio() call when we're
> walking the bio to compose the scatterlist.  Should we instead have an
> nvme_bio_split() routine that is called instead of blk_queue_split(),
> and we can simplify nvme_map_bio() since it'll know that it's working
> with bios that don't have to be split.
> 
> In fact, I think it would have little NVMe-specific in it at that point,
> so we could name __blk_bios_map_sg() better, export it to drivers and
> call it from nvme_map_bio(), which I think would make everybody happier.

Yes, definitely - and by doing it there we shoudn't even have to split
the bios, we can just process them incrementally. I can write a patch
for it later if you want to test it.
