From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 11:41:38 -0400
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170829145559.GA32760@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
 <20170829145417.GA4428@localhost.localdomain>
 <20170829145559.GA32760@lst.de>
Message-ID: <20170829154138.GB4428@localhost.localdomain>

On Tue, Aug 29, 2017@04:55:59PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 29, 2017@10:54:17AM -0400, Keith Busch wrote:
> > It also looks like new submissions will get a new path only from the
> > fact that the original/primary is being reset. The controller reset
> > itself seems a bit heavy-handed. Can we just set head->current_path to
> > the next active controller in the list?
> 
> For ANA we'll have to do that anyway, but if we got a failure
> that clearly indicates a path failure what benefit is there in not
> resetting the controller?  But yeah, maybe we can just switch the
> path for non-ANA controllers and wait for timeouts to do their work.

Okay, sounds reasonable.

Speaking of timeouts, nvme_req_needs_retry will fail the command
immediately rather than try the alternate path if it was cancelled due
to timeout handling. Should we create a new construct for a command's
total time separate from recovery timeout so we may try an alternate
paths?
