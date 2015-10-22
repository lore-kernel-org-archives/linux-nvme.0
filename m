From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 20:17:17 +0200
Subject: [PATCH 4/9] nvme: do not restart the request timeout if we're
 resetting the controller
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CD26DD0@fmsmsx104.amr.corp.intel.com>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-5-git-send-email-hch@lst.de>
 <20151022162702.GD21840@localhost.localdomain>
 <20151022163053.GA21116@lst.de>
 <B58D82457FDA0744A320A2FC5AC253B93CD26DD0@fmsmsx104.amr.corp.intel.com>
Message-ID: <20151022181717.GA22554@lst.de>

On Thu, Oct 22, 2015@05:15:18PM +0000, Busch, Keith wrote:
> But the request is available for reuse after completion. Can we
> can rely on REQ_ATOM_COMPETE when the req is allocated for a new command?

We can't.  What I intended to rely on is a controller reset killing all
I/O queue state, but we still have a small race window between the return from
->timeout and the actual controller reset.  I'll have to figure out a way
to mitigate that.
