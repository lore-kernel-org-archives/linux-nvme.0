From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 6 May 2016 11:35:10 -0500
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160506162823.GB7999@lst.de>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160506160408.GB15666@localhost> <20160506162823.GB7999@lst.de>
Message-ID: <20160506163510.GA20754@localhost>

On Fri, May 06, 2016@06:28:23PM +0200, Christoph Hellwig wrote:
> On Fri, May 06, 2016@11:04:08AM -0500, Bjorn Helgaas wrote:
> > I like this a lot.  One relatively minor comment below.
> 
> Do you want this addressed?  The problem is that I probably will also
> need something like this flags argument for introducing the irq spreading
> as we can't simply do it for all callers directly.  If you take
> the patch as-is I'd be happy to do another pass later to remove it
> and look into different no-MSI quirking once we're done with the
> MSI-X spreading work.

I don't know what sort of clues you'll need for IRQ spreading, but
that sounds like a good reason for the argument.  So if you will need
the flags argument for something else, then I think it's OK as-is.  

Bjorn
