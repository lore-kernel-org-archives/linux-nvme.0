From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 12 Apr 2016 12:00:53 -0700
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <20160405213904.GD12625@localhost.localdomain>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
 <20160405123523.GA19495@infradead.org>
 <20160405175437.GC12625@localhost.localdomain>
 <20160405213904.GD12625@localhost.localdomain>
Message-ID: <20160412190053.GB32482@infradead.org>

On Tue, Apr 05, 2016@09:39:04PM +0000, Keith Busch wrote:
> On Tue, Apr 05, 2016@05:54:37PM +0000, Keith Busch wrote:
> > On Tue, Apr 05, 2016@05:35:23AM -0700, Christoph Hellwig wrote:
> > > So how do any other PCIe device work given that almost no driver does
> > > unconditionaly polling?
> > 
> > I honestly don't have a good answer to that, and I agree with you
> > that this shouldn't be necessary ... but this is a harmless way to not
> > frustrate people who purchase these devices.
> > 
> > I suspect other PCI device drivers either at least try to never use the
> > legacy IRQ, or they've never been tested in platforms that break them.
> 
> Before I resend with the requested code comments, I'd like to hear your
> opinion on an alternate solution (patch below).
> 
> Currently the driver uses legacy IRQ if available only until we know how
> many queues it can create. The legacy IRQ use is tripping up some h/w,
> but I've not heard such issues with MSI/MSI-x.
> 
> Would you prefer going straight to MSI-x? The driver does that when
> there is no INTx, but we wouldn't need to poll from the watchdog timer
> if we make MSI-x the default behavior,

Can you resend this to Jens for 4.6 with a proper signoff?
