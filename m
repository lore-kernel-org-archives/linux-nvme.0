From: snitzer@redhat.com (Mike Snitzer)
Date: Wed, 21 Oct 2015 11:33:51 -0400
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}
In-Reply-To: <1445439679.3126.5.camel@hasee>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151021072126.GA7671@infradead.org>
 <x49io60wdap.fsf@segfault.boston.devel.redhat.com>
 <1445439679.3126.5.camel@hasee>
Message-ID: <20151021153351.GA4984@redhat.com>

On Wed, Oct 21 2015 at 11:01am -0400,
Ming Lin <mlin@kernel.org> wrote:

> On Wed, 2015-10-21@09:39 -0400, Jeff Moyer wrote:
> > Christoph Hellwig <hch at infradead.org> writes:
> > 
> > > Jens, Ming:
> > >
> > > are you fine with the one liner change to get back to the old I/O
> > > pattern?  While it looks like the cards fault I'd like to avoid this
> > > annoying regression.
> > 
> > I'm not Jens or Ming, but your patch looks fine to me, though you'll
> > want to remove the MAX_BIO_SECTORS definition since it's now unused.
> > It's not clear to me why the limit was lowered in the first place.
> 
> UINT_MAX >> 9 is not power of 2 and it causes dm-thinp discard fails.
> 
> At the lengthy discussion:
> [PATCH v5 01/11] block: make generic_make_request handle arbitrarily sized bios
> We agreed to cap discard to 2G as an interim solution for 4.3 until the
> dm-thinp discard code is rewritten.

But did Jens ever commit that change to cap at 2G?  I don't recall
seeing it.

> Hi Mike,
> 
> Will the dm-thinp discard rewritten ready for 4.4?

No.  I'm not clear what needs changing in dm-thinp.  I'll have to
revisit the thread to refresh my memory.

BTW, DM thinp can easily handle discards that aren't a power-of-2 so
long as the requested discard is a factor of the thinp blocksize.
