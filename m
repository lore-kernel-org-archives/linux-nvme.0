From: wolfgang@rohdewald.de (Wolfgang Rohdewald)
Date: Tue, 25 Jun 2019 14:11:04 +0200
Subject: [nvme] Invalid SGL for payload:91648 nents:3
In-Reply-To: <20190625095013.GA1353@lst.de>
References: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>
 <20190625091704.GA30606@ming.t460p>
 <CAOSXXT5PgPJqouD0G7qJjar5tmy-9z+wWdFMqpD2K1=5vQZ+HA@mail.gmail.com>
 <20190625094532.GA11214@ming.t460p> <20190625095013.GA1353@lst.de>
Message-ID: <336692273232ee2441e30e7e2a1c542201854010.camel@rohdewald.de>

On Di, 2019-06-25@11:50 +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019@05:45:35PM +0800, Ming Lei wrote:
> > On Tue, Jun 25, 2019@06:38:58PM +0900, Keith Busch wrote:
> > > The first two sg elements should have been merged to one and would have
> > > avoided the error. The bug is kernel, nothing to do with the device.
> > 
> > The default max segment size is 64k, so the first two can't be merged.
> > 
> > And the 1st sg should have been dispatched as single request.
> 
> Well, that is exactly what I fixed with my patches that went into
> 5.2.  Looks like we need to backport those as well.
> 
> Wolfgang, can you try the latest 5.2-rc git tree?

5.2.0-rc6 works fine.

Do you still want me to apply nvme_dump_rq() to 5.1 for finding the root cause?

-- 
mit freundlichen Gr?ssen

Wolfgang Rohdewald
