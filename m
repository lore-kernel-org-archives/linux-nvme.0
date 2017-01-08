From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 02:13:28 -0800
Subject: [PATCH] nvme: use __iowrite64_copy for SQs in the CMB
In-Reply-To: <CACtDJFcKB9r+Fzoo7+ewwEUR_qyt+mRxKU+JYyYXSmX6=mw5pA@mail.gmail.com>
References: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
 <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>
 <20161121091411.GA10123@infradead.org>
 <aa517f417f04c082415dcb004ef77d94.squirrel@webmail.raithlin.com>
 <CACtDJFfFL2uha09razaLA+D1pwfj0mXdiRQ+UXTFND+GHo5Mwg@mail.gmail.com>
 <CACtDJFcCJzhAvCK7gj6hkW9BSaCrZFa5bm6GsWwdMcy_NLDw_w@mail.gmail.com>
 <20161221102237.GA24532@infradead.org>
 <CACtDJFcKB9r+Fzoo7+ewwEUR_qyt+mRxKU+JYyYXSmX6=mw5pA@mail.gmail.com>
Message-ID: <20170108101328.GF25268@infradead.org>

On Wed, Jan 04, 2017@09:22:34AM +0200, Saar Gross wrote:
> As already mentioned: the current implementation uses memcpy() which
> is generic in nature, whereas the new implementation uses explicit
> 64-bit writes when possible.
> What else are you looking for?

Any explanation of why this would benefit the driver in practive.
You've now explained the mechanics of your change in detail, but still
haven't shown in numbers or bugs fixed.

Note that we currently don't use 64-bit MMIO writes in the NVMe driver
at all, as we work around buggy Apple controllers.  This would be the
first one, and while I'm not against it at all, I'd rather have a good
reason to make the change instead of just having a drive-by patch in
the tree.
