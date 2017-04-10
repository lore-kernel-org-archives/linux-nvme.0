From: hch@lst.de (hch@lst.de)
Date: Mon, 10 Apr 2017 17:31:34 +0200
Subject: [PATCH v2] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1491838033.4199.3.camel@sandisk.com>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
 <20170410151657.GA15173@lst.de> <1491838033.4199.3.camel@sandisk.com>
Message-ID: <20170410153134.GB15446@lst.de>

On Mon, Apr 10, 2017@03:27:14PM +0000, Bart Van Assche wrote:
> > I would love if we could do this at the ib_qp level.
> 
> Hello Christoph,
> 
> Please keep in mind that some but not all RDMA drivers need a construct like
> this.

Sure, I don't want to force anyone to use it.  But I'd like to have
a generic helper that everyone can use instead of reinventing the wheel.
E.g. at least iser will need the same fix, and many drivers would
benefit from not always signalling completions even if they don't have
the ability yet.
