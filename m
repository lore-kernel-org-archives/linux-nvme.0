From: mlin@kernel.org (Ming Lin)
Date: Wed, 21 Oct 2015 08:01:19 -0700
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard,write_same}
In-Reply-To: <x49io60wdap.fsf@segfault.boston.devel.redhat.com>
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151021072126.GA7671@infradead.org>
 <x49io60wdap.fsf@segfault.boston.devel.redhat.com>
Message-ID: <1445439679.3126.5.camel@hasee>

On Wed, 2015-10-21@09:39 -0400, Jeff Moyer wrote:
> Christoph Hellwig <hch at infradead.org> writes:
> 
> > Jens, Ming:
> >
> > are you fine with the one liner change to get back to the old I/O
> > pattern?  While it looks like the cards fault I'd like to avoid this
> > annoying regression.
> 
> I'm not Jens or Ming, but your patch looks fine to me, though you'll
> want to remove the MAX_BIO_SECTORS definition since it's now unused.
> It's not clear to me why the limit was lowered in the first place.

UINT_MAX >> 9 is not power of 2 and it causes dm-thinp discard fails.

At the lengthy discussion:
[PATCH v5 01/11] block: make generic_make_request handle arbitrarily sized bios
We agreed to cap discard to 2G as an interim solution for 4.3 until the
dm-thinp discard code is rewritten.

Hi Mike,

Will the dm-thinp discard rewritten ready for 4.4?

Thanks,
Ming

> 
> You can add my Reviewed-by: Jeff Moyer <jmoyer at redhat.com> if you resend
> the patch.
> 
> -Jeff
