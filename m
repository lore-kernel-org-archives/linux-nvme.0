From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Oct 2016 05:52:57 -0700
Subject: [PATCH 3/7 v2] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <20161018233223.GA2202@localhost.localdomain>
References: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
 <20161012085834.GD12972@infradead.org>
 <1f0b3b42-241a-65db-f842-08a1c378b559@broadcom.com>
 <20161018194939.GA2048@localhost.localdomain>
 <adbdd838-6bf9-ef8d-0008-507d507adb8a@broadcom.com>
 <20161018233223.GA2202@localhost.localdomain>
Message-ID: <20161019125257.GA25922@infradead.org>

On Tue, Oct 18, 2016@05:32:24PM -0600, Jon Derrick wrote:
> > What is the rule for when it should be a macro vs an inline ?   It makes
> > sense to me to be an inline if you want to strongly check the type of an
> > argument, but something simple like this, it's not so clear.  If I didn't
> > have the "cpu_to_be32" part, I'd abandon the inline and the macro and code
> > it directly.
> In this case they will both provide the same error checking, due to
> cpu_to_be32 returning type __be32. The only difference is that one adds
> a macro and the other adds a function, and if we ever need to add some
> caveats to the logic it will be simpler with the function. That and the
> coding style dictates that all things being equal, we should still
> prefer inline. Those are my only rationales in this case.

I generally prefer to avoid macros that make grepping hard.  But
I don't want to bikeshed too much over this this - I'd prefer Jon's
variant, but I'm not going to NAK the series over this helper.
