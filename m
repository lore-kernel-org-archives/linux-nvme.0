From: hch@lst.de (hch@lst.de)
Date: Wed, 19 Apr 2017 08:13:23 +0200
Subject: block: remove the blk_execute_rq return value
In-Reply-To: <1492554253.2689.15.camel@sandisk.com>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
 <20170418155229.5977-2-hch@bombadil.infradead.org>
 <1492554253.2689.15.camel@sandisk.com>
Message-ID: <20170419061323.GA6257@lst.de>

On Tue, Apr 18, 2017@10:24:15PM +0000, Bart Van Assche wrote:
> On Tue, 2017-04-18@08:52 -0700, Christoph Hellwig wrote:
> > diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
> > index b05e151c9b38..82c6d02193ae 100644
> > --- a/drivers/block/paride/pd.c
> > +++ b/drivers/block/paride/pd.c
> > @@ -747,7 +747,8 @@ static int pd_special_command(struct pd_unit *disk,
> >  
> >  	rq->special = func;
> >  
> > -	err = blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
> > +	blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
> > +	err = req->errors ? -EIO : 0;
> >  
> >  	blk_put_request(rq);
> >  	return err;
> 
> Hello Christoph,
> 
> Sorry that I hadn't noticed this before but shouldn't "req" be changed into
> "rq"? Otherwise this patch looks fine to me. If this comment gets addressed
> you can add:

It should.  But it seems this no one caught this because the check gets
removed later in the series by "pd: remove bogus check for req->errors",
so I should just move that patch earlier in the series.
