From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 Nov 2015 05:02:06 -0800
Subject: [PATCH] nvme: prepare support for Apple NVMe controller
In-Reply-To: <20151029151056.GA2580@localhost.localdomain>
References: <bd1f730603ee00205657774a362aab10@localhost>
 <20151029151056.GA2580@localhost.localdomain>
Message-ID: <20151103130206.GA19495@infradead.org>

On Thu, Oct 29, 2015@09:10:56AM -0600, Jon Derrick wrote:
> > +#define readq lo_hi_readq
> > +#define writeq lo_hi_writeq
> > +
> 
> Good job figuring that one out. But this should be a quirk:
> a) It will sacrifice some io cycles on other devices
> b) It may get lost at some point in the name of performance
> 
> Christoph recently added a quirks mechanism where I think it would fit

We never access 64 bit registers in the fast path.  I'd be fine to
apply the patch from Stephan as-is as long as we document in detail why
we are doing this.  Stephan, can you respin the patch with a comment
and also with the PCI ID for the Apple controller added to the ID table?
