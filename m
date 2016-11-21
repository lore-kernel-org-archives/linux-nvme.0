From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 21 Nov 2016 01:14:11 -0800
Subject: [PATCH] nvme: use __iowrite64_copy for SQs in the CMB
In-Reply-To: <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>
References: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
 <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>
Message-ID: <20161121091411.GA10123@infradead.org>

On Mon, Nov 21, 2016@10:54:40AM +0200, Saar Gross wrote:
> Hi everyone,
> 
> Any comments on this patch? I didn't receive any so far.

Please explain why we would want to apply the patch, e.g. without
it some devices may be broken, or that on a particular device you
get much better performance (including numbers and an explanation of the
setup).
