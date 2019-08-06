From: marcos.souza.org@gmail.com (Marcos Paulo de Souza)
Date: Tue, 6 Aug 2019 07:24:56 -0300
Subject: [PATCH] block: Remove request_queue argument from
 blk_execute_rq_nowait
In-Reply-To: <20190806051911.GA13409@lst.de>
References: <20190806011754.7722-1-marcos.souza.org@gmail.com>
 <20190806051911.GA13409@lst.de>
Message-ID: <20190806102456.GA29914@continental>

On Tue, Aug 06, 2019@07:19:11AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 05, 2019@10:17:51PM -0300, Marcos Paulo de Souza wrote:
> > +void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
> > +			int at_head, rq_end_io_fn *done)
> 
> We store a ->rq_disk in struct request, so we should also not need
> that.  And at_head should either become a bool, or be replaced with
> a flags argument, ints used boolean are usually not a good idea.

Makes sense.

> 
> > @@ -81,7 +80,7 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
> 
> And all the same argument changes that apply to blk_execute_rq_nowait
> apply to blk_execute_rq as well.

Thanks for the suggestions, I will send a v2 soon.
