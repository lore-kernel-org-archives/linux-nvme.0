From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Aug 2016 14:02:46 -0700
Subject: [PATCH] add u64 number parser
In-Reply-To: <09649a75-e9a1-11d7-37e2-48f4e93a3b2e@broadcom.com>
References: <5792b919.0C1gyf+dF4XKu6Zj%james.smart@broadcom.com>
 <5e325cbb-a140-8f26-7402-5dc1a2cd07ea@sandisk.com>
 <09649a75-e9a1-11d7-37e2-48f4e93a3b2e@broadcom.com>
Message-ID: <20160811210246.GC18013@infradead.org>

On Sat, Jul 23, 2016@08:52:18AM -0700, James Smart wrote:
> 
> On 7/22/2016 6:32 PM, Bart Van Assche wrote:
> > On 07/22/16 17:23, James Smart wrote:
> > > +    buf = kmalloc(len + 1, GFP_KERNEL);
> > > +    if (!buf)
> > > +        return -ENOMEM;
> > > +    memcpy(buf, s->from, len);
> > > +    buf[len] = '\0';
> > 
> > Hello James,
> > 
> > Have you considered to combine the above kmalloc() and memcpy() calls
> > into a single kasprintf(GFP_KERNEL, "%.*s", len, s->from) call?
> > 
> > Bart.
> > 
> 
> No, I followed the example of existing parse functions in the file.

The kasprintf would indeed be nicer, but I'm fine with keeping the
existing style for this patch.  Bonus points for sending a follow on
to convert all of them over.

Reviewed-by: Christoph Hellwig <hch at lst.de>
