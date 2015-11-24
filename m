From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Nov 2015 16:56:09 +0100
Subject: [PATCH 04/47] block: provide a new BLK_EH_QUIESCED timeout
 return value
In-Reply-To: <x491tbf2y6v.fsf@segfault.boston.devel.redhat.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-5-git-send-email-hch@lst.de>
 <x49mvu32zrw.fsf@segfault.boston.devel.redhat.com>
 <20151124154019.GB5939@lst.de>
 <x491tbf2y6v.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20151124155609.GA6251@lst.de>

On Tue, Nov 24, 2015@10:51:04AM -0500, Jeff Moyer wrote:
> >> 
> >> blk_complete_request:
> >> A  if (!blk_mark_rq_complete(rq) ||
> >> B      test_and_cleart_bit(REQ_ATOM_QUIESCED, &req->atomic_flags)) {
> >> C        __blk_mq_complete_request(rq);
> >> 
> >> could run alongside of:
> >> 
> >> blk_rq_check_expired:
> >> 1 if (!blk_mark_rq_complete(rq))
> >> 2   blk_rq_timed_out(rq);
> >> 
> >> So, if 1 comes before A, we have two cases to consider:
> >> 
> >> i.  the expiration path does not yet set REQ_ATOM_QUIESCED before the
> >>     completion code runs, and so the completion code does nothing.
> >
> > The command has timed out and sets REQ_ATOM_COMPLETED first,
> > the the actual completion comes in and does indeed nothing.  We now
> > set REQ_ATOM_QUIESCED and kick off a controller reset, which will
> > ultimatively complete all commands using blk_mq_complete_request.
> > Now REQ_ATOM_QUIESCED is set on the command that caused the timeout,
> > so it will be completed as well.
> >
> >> ii. the expiration path *does* SET REQ_ATOM_QUIESCED.  In this instance,
> >>     will we get yet another completion for the request when the command
> >>     is ultimately retired by the adapter reset?
> >
> > The command has timed out and sets REQ_ATOM_COMPLETED first, then
> > REQ_ATOM_QUIESCED as well.  Now the actual completion comes in and does
> > nothing because REQ_ATOM_COMPLETED was set.  We will then kick off the
> 
> See B above.  REQ_ATOM_COMPLETE is set, so the first half of that
> statement is false, but then test_and_clear_bit(REQ_ATOM_QUIESCED...)
> returns true, so we call __blk_complete_request.  So the question is,
> will we get a double completion for that request after the reset is
> performed?

We always set REQ_ATOM_COMPLETE before calling into ->timeout and thus
even having a chance to REQ_ATOM_QUIESCED.  Maybe we're talking past
each other, so if it feels like I'm off track try to explain the
race in a bit more detail.
