From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 14:11:06 +0200
Subject: [PATCH 9/9] nvmet: make ANATT configurable
In-Reply-To: <20180604122102.4bfcd154@pentland.suse.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-10-hch@lst.de>
 <20180604122102.4bfcd154@pentland.suse.de>
Message-ID: <20180604121106.GA29545@lst.de>

On Mon, Jun 04, 2018@12:21:02PM +0200, Hannes Reinecke wrote:
> _Actually_ I would like to retract this patch.
> 
> I've been working on implementing ANA TT on the target, and found this
> particular implementation unworkable.
> 
> The problem is that with the current implementation the ANA state is
> pretty much tied to the _port_, which might be shared across several
> subsystems. Consequently any state change might affect namespaces
> on several subsystems, too.
> 
> But if the anatt value is tied to the subsystem we'd need to have
> different timers/workqueue items per port and subsystem/namespace, which
> doesn't really scale. Plus we're not giving anything away by making the
> anatt per port, not per subsys.

Well.  In the end the ANATT is a property of whatever cluster manager
is used to manage the backend connections.  Neither subsystem nor port
really map to that perfectly.  In fact we probably just want to set
it globally.
