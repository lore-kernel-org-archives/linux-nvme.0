From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Nov 2015 20:40:36 +0100
Subject: [PATCH 04/47] block: provide a new BLK_EH_QUIESCED timeout
 return value
In-Reply-To: <x49h9kb1d23.fsf@segfault.boston.devel.redhat.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-5-git-send-email-hch@lst.de>
 <x49mvu32zrw.fsf@segfault.boston.devel.redhat.com>
 <20151124154019.GB5939@lst.de>
 <x491tbf2y6v.fsf@segfault.boston.devel.redhat.com>
 <20151124155609.GA6251@lst.de>
 <x49wpt71hm9.fsf@segfault.boston.devel.redhat.com>
 <20151124175619.GA13224@infradead.org>
 <x49h9kb1d23.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20151124194036.GA12518@lst.de>

On Tue, Nov 24, 2015@01:12:52PM -0500, Jeff Moyer wrote:
> >> blk_complete_request():
> >>         if (!blk_mark_rq_complete(req) ||  // this fails, as it's already marked complete
> >>             test_and_clear_bit(REQ_ATOM_QUIESCED, &req->atomic_flags))  // this succeeds
> >
> > and clears the flag, so we'd need a race betweem this call to
> > blk_mq_complete request and the later completion of all outstanding
> > commands from reset.  For NVMe we ensure this by not taking completions
> 
> But we're completing the request, so the request will actually be freed.
> Any references to this request are bogus at this point, no?

For blk-mq it won't be freed.  For the non blk-mq case the tag
to request lookup will have to handle that case, but that path isn't
exercised by nvme.
