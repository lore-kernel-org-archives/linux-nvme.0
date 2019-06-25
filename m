From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Jun 2019 11:50:13 +0200
Subject: [nvme] Invalid SGL for payload:91648 nents:3
In-Reply-To: <20190625094532.GA11214@ming.t460p>
References: <92778741dff3723fc94cd75df3043adc9c8bf21a.camel@rohdewald.de>
 <20190625091704.GA30606@ming.t460p>
 <CAOSXXT5PgPJqouD0G7qJjar5tmy-9z+wWdFMqpD2K1=5vQZ+HA@mail.gmail.com>
 <20190625094532.GA11214@ming.t460p>
Message-ID: <20190625095013.GA1353@lst.de>

On Tue, Jun 25, 2019@05:45:35PM +0800, Ming Lei wrote:
> On Tue, Jun 25, 2019@06:38:58PM +0900, Keith Busch wrote:
> > The first two sg elements should have been merged to one and would have
> > avoided the error. The bug is kernel, nothing to do with the device.
> 
> The default max segment size is 64k, so the first two can't be merged.
> 
> And the 1st sg should have been dispatched as single request.

Well, that is exactly what I fixed with my patches that went into
5.2.  Looks like we need to backport those as well.

Wolfgang, can you try the latest 5.2-rc git tree?
