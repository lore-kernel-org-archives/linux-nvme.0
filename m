From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 28 Jun 2016 09:20:18 -0500
Subject: [PATCH] nvme-rdma: Always signal fabrics private commands
In-Reply-To: <20160628084105.GA13533@lst.de>
References: <1466698104-32521-1-git-send-email-sagi@grimberg.me>
 <20160624070740.GB4252@infradead.org> <577005C3.4000802@grimberg.me>
 <20160628084105.GA13533@lst.de>
Message-ID: <005201d1d148$32c33740$9849a5c0$@opengridcomputing.com>

> On Sun, Jun 26, 2016@07:41:39PM +0300, Sagi Grimberg wrote:
> > Our error path is freeing the tagset before we free the queue (draining
> > the qp) so we get to a use-after-free condition (->done() is a freed
> > tag memory).
> >
> > Note that we must allocate the qp before we allocate the tagset because
> > we need the device when init_request callouts come. So we allocated
> > before, we free after. An alternative fix was to free the queue before
> > the tagset even though we allocated it before (as Steve suggested).
> 
> Would draining, but not freeing the qp before freeing the tagset work?
> That seems like the most sensible option here.

disconnecting and draining, I think.
