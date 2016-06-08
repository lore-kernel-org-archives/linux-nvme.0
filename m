From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Jun 2016 16:10:19 +0200
Subject: [PATCH 01/11] Revert "blk-mq: add blk_mq_alloc_request_hctx"
In-Reply-To: <x49mvmv235d.fsf@segfault.boston.devel.redhat.com>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
 <1465389066-19119-2-git-send-email-hch@lst.de>
 <x49mvmv235d.fsf@segfault.boston.devel.redhat.com>
Message-ID: <20160608141019.GB1020@lst.de>

On Wed, Jun 08, 2016@09:58:38AM -0400, Jeff Moyer wrote:
> Christoph Hellwig <hch at lst.de> writes:
> 
> > Just for book keeping. The next patch brings it back with some changes.
> 
> That's a strange thing to do, and breaks bisectability.  Why not just
> update the function?

Because it's just an updated to a not yet applied series.  The idea is
that Jens could just take patch 2 if we get a positive review or two for
it.
