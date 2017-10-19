From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 15:15:35 +0200
Subject: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
In-Reply-To: <1d2fe3fa-564f-c056-bbc5-b80282bee912@suse.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-7-hch@lst.de>
 <1d2fe3fa-564f-c056-bbc5-b80282bee912@suse.de>
Message-ID: <20171019131535.GB20645@lst.de>

On Thu, Oct 19, 2017@02:45:03PM +0200, Hannes Reinecke wrote:
> > No way in hell this would get through.  Preemptive NAK right here.
> >
> > That whole idea is just amazingly stupid, and no one has even
> > explained a reason for it.
> 
> I wonder what has changed ...

The nvme-controller devices aren't accessible to anyone outside the
nvme driver itself, so they aren't just hidden, as far as the rest
of the kernel is concerned they don't exist.  They just allow reusing
block layer code in the nvme driver instead of reimplementing it.
