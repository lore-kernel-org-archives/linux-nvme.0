From: hch@lst.de (Christoph Hellwig)
Date: Sun, 8 May 2016 11:05:58 +0200
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160506163510.GA20754@localhost>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160506160408.GB15666@localhost> <20160506162823.GB7999@lst.de>
 <20160506163510.GA20754@localhost>
Message-ID: <20160508090558.GA11677@lst.de>

On Fri, May 06, 2016@11:35:10AM -0500, Bjorn Helgaas wrote:
> I don't know what sort of clues you'll need for IRQ spreading, but
> that sounds like a good reason for the argument.  So if you will need
> the flags argument for something else, then I think it's OK as-is.  

The basic idea is that we want to spread the MSI(-X) vectors around
properly right when allocating them.  See the series around this
patch when I last posted it.  For for now various drivers use different
ways of spreading them, so we'll need to make it opt-in in the beginning.

In the long run we'll hopefully have everyone converted to the common
algorithm and can get rid of the flag, but that might take a while.
