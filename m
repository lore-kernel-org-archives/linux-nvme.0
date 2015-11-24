From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 Nov 2015 09:58:03 -0800
Subject: [PATCH] NVMe: Split shutdown work
In-Reply-To: <20151124161302.GA5193@localhost.localdomain>
References: <1448302665-9703-1-git-send-email-keith.busch@intel.com>
 <20151124073448.GA17979@infradead.org>
 <20151124151406.GA3936@localhost.localdomain>
 <20151124153107.GA4326@infradead.org>
 <20151124161302.GA5193@localhost.localdomain>
Message-ID: <20151124175803.GB13224@infradead.org>

On Tue, Nov 24, 2015@04:13:02PM +0000, Keith Busch wrote:
> Heh, my reasoning is focused a bit too narrowly. :)
> 
> Instead of examining a specific command's failure modes, can we agree
> there is a difference in how we should handle a controller that responds
> to initialization with failure status vs one that doesn't respond
> at all? I don't want to rat hole commentary for an exceedingly rare
> scenario, but it helps tremendously to have this distinction if it
> happens.

If we ignore a return value that shouldn't fail per spec we will need
a comment either way.  But yes, handling an error return vs timeout
differently makes sense independent of that.

> 
> > We need serialization not just of shutdown calls, but also of shutdown
> > vs reset.  Thinking about it aren't we doing the shutdown from the
> > pci_driver ->removal callback with my current branch?
> 
> There's actually lots of entry points to shutdown: system suspend,
> shutdown, PCI-e Function Level Reset, NVMe Controller Level Reset, NVMe
> Subsystem Reset Occurred/Controller Failure Status, and PCI removal. PCI
> removal can happen from PCI-e hotplug event, driver requested, or user
> requested.
> 
> I've never seen these events occur simultaneously in practice. There's
> no handling for it, but we can fix it utilizing the new device flags.

Ok.
