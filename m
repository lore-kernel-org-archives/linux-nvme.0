From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Dec 2016 02:22:37 -0800
Subject: [PATCH] nvme: use __iowrite64_copy for SQs in the CMB
In-Reply-To: <CACtDJFcCJzhAvCK7gj6hkW9BSaCrZFa5bm6GsWwdMcy_NLDw_w@mail.gmail.com>
References: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
 <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>
 <20161121091411.GA10123@infradead.org>
 <aa517f417f04c082415dcb004ef77d94.squirrel@webmail.raithlin.com>
 <CACtDJFfFL2uha09razaLA+D1pwfj0mXdiRQ+UXTFND+GHo5Mwg@mail.gmail.com>
 <CACtDJFcCJzhAvCK7gj6hkW9BSaCrZFa5bm6GsWwdMcy_NLDw_w@mail.gmail.com>
Message-ID: <20161221102237.GA24532@infradead.org>

On Mon, Dec 19, 2016@02:18:30PM +0200, Saar Gross wrote:
> Hi again,
> 
> Any other comments?

I still can't see a good explanation on why we'd want/need the patch.
