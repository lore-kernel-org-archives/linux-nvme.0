From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Nov 2015 16:47:50 +0000
Subject: [PATCH 04/47] block: provide a new BLK_EH_QUIESCED timeout
 return value
In-Reply-To: <x49wpt71hm9.fsf@segfault.boston.devel.redhat.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-5-git-send-email-hch@lst.de>
 <x49mvu32zrw.fsf@segfault.boston.devel.redhat.com>
 <20151124154019.GB5939@lst.de>
 <x491tbf2y6v.fsf@segfault.boston.devel.redhat.com>
 <20151124155609.GA6251@lst.de>
 <x49wpt71hm9.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20151124164750.GB5193@localhost.localdomain>

On Tue, Nov 24, 2015@11:34:22AM -0500, Jeff Moyer wrote:
> CPU 0 executes the following:
> 
> blk_rq_check_expired():
>         if (!blk_mark_rq_complete(rq))  // this succeeds, so we call blk_rq_timed_out
>                 blk_rq_timed_out(rq);
> blk_rq_timed_out():
>         if (q->rq_timed_out_fn)
>                 ret = q->rq_timed_out_fn(req);
>         switch (ret) {  // QUIESCED is returned
> ...
>         case BLK_EH_QUIESCED:
>                 set_bit(REQ_ATOM_QUIESCED, &req->atomic_flags);
>                 break;
> 
> CPU 1 takes an interrupt for the completion of the same request:
> 
> blk_complete_request():
>         if (!blk_mark_rq_complete(req) ||  // this fails, as it's already marked complete
>             test_and_clear_bit(REQ_ATOM_QUIESCED, &req->atomic_flags))  // this succeeds
>                 __blk_complete_request(req); // so we complete the request
> 
> Later, after the adapter reset is finished, you mentioned that all
> requests will be completed.  My question is: will this result in a
> double completion for this particular request?

The reset action clears the queue's busy tags only after the adapter
is disabled. At that point, no interrupts can happen and h/w will never
complete more active requests. If an interrupt completes the request
while the reset is in progress, the request tag won't be "busy" when
the final clean-up occurs.
