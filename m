From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Nov 2015 09:13:57 +0100
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <20151109201232.GC5386@localhost.localdomain>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-10-git-send-email-hch@lst.de>
 <20151109185731.GB5386@localhost.localdomain> <20151109192518.GA10681@lst.de>
 <20151109201232.GC5386@localhost.localdomain>
Message-ID: <20151110081357.GA21708@lst.de>

On Mon, Nov 09, 2015@08:12:33PM +0000, Keith Busch wrote:
> > Haha, so we at least can root cause this now.  Can you point me
> > to the caller that cares?  I'd really like to get rid of the special
> > case of passing a negative errno here, so I'd like to figure out how
> > we could pass this information on instead.
> 
> The "set_queue_count()" was the function that cared, but looks like
> patch 8/12 makes this think a timeout is an aborted status.

I'm still a bit confused on the semantics you want/need.  If the 
Set Features for set_queue_count times out we'll call the reset handler,
which because we are inside the probe handler will remove the device.
How do we care about the return value in that case?

Can you write down a few sentences on why/how we care?  I'll volunteer
to put them into the driver in comment form once we have all this sorted
out so that anyone touching the driver in the future won't be as confused.
