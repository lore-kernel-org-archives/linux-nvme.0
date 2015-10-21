From: jmoyer@redhat.com (Jeff Moyer)
Date: Wed, 21 Oct 2015 09:39:58 -0400
Subject: [PATCH v6 05/11] block: remove split code in
 blkdev_issue_{discard, write_same}
In-Reply-To: <20151021072126.GA7671@infradead.org> (Christoph Hellwig's
 message of "Wed, 21 Oct 2015 00:21:26 -0700")
References: <1439363241-31772-1-git-send-email-mlin@kernel.org>
 <1439363241-31772-6-git-send-email-mlin@kernel.org>
 <20151013115011.GA6546@infradead.org>
 <CAF1ivSbsH7JsduHE+a2d+BEbZL6Fo7uJWS2NCTTMNTSAUMt0UA@mail.gmail.com>
 <20151021072126.GA7671@infradead.org>
Message-ID: <x49io60wdap.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at infradead.org> writes:

> Jens, Ming:
>
> are you fine with the one liner change to get back to the old I/O
> pattern?  While it looks like the cards fault I'd like to avoid this
> annoying regression.

I'm not Jens or Ming, but your patch looks fine to me, though you'll
want to remove the MAX_BIO_SECTORS definition since it's now unused.
It's not clear to me why the limit was lowered in the first place.

You can add my Reviewed-by: Jeff Moyer <jmoyer at redhat.com> if you resend
the patch.

-Jeff
