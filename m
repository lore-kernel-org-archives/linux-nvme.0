From: hch@lst.de (hch@lst.de)
Date: Thu, 20 Apr 2017 07:11:12 +0200
Subject: [PATCH 02/23] block: remove the blk_execute_rq return value
In-Reply-To: <1492636063.2543.18.camel@sandisk.com>
References: <20170419192708.22098-1-hch@lst.de>
 <20170419192708.22098-3-hch@lst.de> <1492636063.2543.18.camel@sandisk.com>
Message-ID: <20170420051112.GA10822@lst.de>

On Wed, Apr 19, 2017@09:07:45PM +0000, Bart Van Assche wrote:
> > +	blk_execute_rq(or->request->q, NULL, or->request, 0);
> > +	error = or->request ? -EIO : 0;
> 
> Hello Christoph,
> 
> Did you perhaps intend or->request->errors instead of or->request?

Yes, thanks.
