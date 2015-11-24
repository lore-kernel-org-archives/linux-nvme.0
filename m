From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 Nov 2015 09:56:19 -0800
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
Message-ID: <20151124175619.GA13224@infradead.org>

On Tue, Nov 24, 2015@11:34:22AM -0500, Jeff Moyer wrote:
> CPU 1 takes an interrupt for the completion of the same request:
> 
> blk_complete_request():
>         if (!blk_mark_rq_complete(req) ||  // this fails, as it's already marked complete
>             test_and_clear_bit(REQ_ATOM_QUIESCED, &req->atomic_flags))  // this succeeds

and clears the flag, so we'd need a race betweem this call to
blk_mq_complete request and the later completion of all outstanding
commands from reset.  For NVMe we ensure this by not taking completions
onc we start reset, but we probably need to document this better.  I
will ensure all this is properly documented in the next version!
