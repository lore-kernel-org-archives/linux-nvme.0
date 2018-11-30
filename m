From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Nov 2018 07:40:20 -0700
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181130080013.GB18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <20181129201914.GB9377@localhost.localdomain>
 <20181130080013.GB18936@lst.de>
Message-ID: <20181130144020.GH9377@localhost.localdomain>

On Fri, Nov 30, 2018@12:00:13AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018@01:19:14PM -0700, Keith Busch wrote:
> > On Thu, Nov 29, 2018@08:12:58PM +0100, Christoph Hellwig wrote:
> > > +enum hctx_type {
> > > +	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
> > > +	HCTX_TYPE_READ,		/* just for READ I/O */
> > > +	HCTX_TYPE_POLL,		/* polled I/O of any kind */
> > > +
> > > +	HCTX_MAX_TYPES,
> > >  };
> > 
> > Well, there goes my plan to use this with Weighted-Round-Robin NVMe IO
> > queues!
> 
> Wo between what do you even want to round robin?  If it is between
> reads and writes that's easy.  If we want priority reads or writes
> (separate from polling) that's also still fairly easily.

I was considering the IOPRIO_PRIO_CLASS. There are four of them, which
may roughly correspond to the four NVMe IO queues weights. Maybe even
through HIPRI flagged IOs with the RT class.

 
> Btw, one thing I wanted to try once I get hold of the right hardware
> is to mark the poll queues as priority queues and see if that makes
> any differents in poll IOPS/latency.

I doubt it will make much difference in IOPS, but should improve latency
on hipri IOs at the expense of normal IO since hipri will be fetched
ahead during command arbitrarion.
