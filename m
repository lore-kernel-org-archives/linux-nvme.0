From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Nov 2015 16:13:02 +0000
Subject: [PATCH] NVMe: Split shutdown work
In-Reply-To: <20151124153107.GA4326@infradead.org>
References: <1448302665-9703-1-git-send-email-keith.busch@intel.com>
 <20151124073448.GA17979@infradead.org>
 <20151124151406.GA3936@localhost.localdomain>
 <20151124153107.GA4326@infradead.org>
Message-ID: <20151124161302.GA5193@localhost.localdomain>

On Tue, Nov 24, 2015@07:31:07AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 24, 2015@03:14:06PM +0000, Keith Busch wrote:
> > Security locked drives may reject "set feature". Some of my drives in
> > manufacturing mode also fail it.
> 
> Is there any wording in the spec that allows this?  What number of
> I/O queues will show up on these drives?   Allowing to ignore this
> failure is defintively black magic and needs long comments explaining
> the why and how, or it will get broken accidentally again and again.

Heh, my reasoning is focused a bit too narrowly. :)

Instead of examining a specific command's failure modes, can we agree
there is a difference in how we should handle a controller that responds
to initialization with failure status vs one that doesn't respond
at all? I don't want to rat hole commentary for an exceedingly rare
scenario, but it helps tremendously to have this distinction if it
happens.

> We need serialization not just of shutdown calls, but also of shutdown
> vs reset.  Thinking about it aren't we doing the shutdown from the
> pci_driver ->removal callback with my current branch?

There's actually lots of entry points to shutdown: system suspend,
shutdown, PCI-e Function Level Reset, NVMe Controller Level Reset, NVMe
Subsystem Reset Occurred/Controller Failure Status, and PCI removal. PCI
removal can happen from PCI-e hotplug event, driver requested, or user
requested.

I've never seen these events occur simultaneously in practice. There's
no handling for it, but we can fix it utilizing the new device flags.
