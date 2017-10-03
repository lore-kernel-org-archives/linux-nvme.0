From: hch@lst.de (Christoph Hellwig)
Date: Tue, 3 Oct 2017 13:53:55 +0200
Subject: [PATCH 6/6] nvme: ignore retries for multipath devices
In-Reply-To: <9d603720-2f86-ab3c-6ba3-9d57afb3568e@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-7-git-send-email-hare@suse.de>
 <20171002162254.GA11497@lst.de>
 <9d603720-2f86-ab3c-6ba3-9d57afb3568e@suse.de>
Message-ID: <20171003115355.GB24650@lst.de>

On Tue, Oct 03, 2017@12:02:38PM +0200, Hannes Reinecke wrote:
> >>  	if (nvme_req(req)->status & NVME_SC_DNR)
> >>  		return false;
> >> -	if (nvme_req(req)->retries >= nvme_max_retries)
> >> +	if (nvme_req(req)->retries >= nvme_max_retries &&
> >> +	    !(req->cmd_flags & REQ_NVME_MPATH))
> >>  		return false;
> >>  	return true;
> > 
> > All failover logic is inside a nvme_req_needs_retry() conditional,
> > so this change looks completely broken - it basically disables
> > failover.
> > 
> Not in our tests.
> Without this patch we'd been seeing I/O errors during failover; with
> this patch I/O continues on the failover path.

http://git.infradead.org/users/hch/block.git/blob/refs/heads/nvme-mpath:/drivers/nvme/host/core.c#l208

210	if (unlikely(nvme_req(req)->status && nvme_req_needs_retry(req))) {
211		if (nvme_req_needs_failover(req)) {
212			nvme_failover_req(req);
213			return;
214		 }

The only call to nvme_failover_req is guarded by nvme_req_needs_retry,
and you change needs_retry to return true for MPATH requests that
exceed the number of retries.  I just don't see how we'd hit the
max_retries count, as each retry before should have already taken
nvme_req_needs_failover before.  What error code do you see this
with?  What kinds of device/setup?
