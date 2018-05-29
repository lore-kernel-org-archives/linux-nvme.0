From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 15:38:54 +0200
Subject: [PATCH 08/10] nvmet: Set nanagrpid correctly
In-Reply-To: <20180529150414.44a1cb7e@pentland.suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-9-hare@suse.de> <20180529125151.GH7376@lst.de>
 <20180529150414.44a1cb7e@pentland.suse.de>
Message-ID: <20180529133854.GA8916@lst.de>

On Tue, May 29, 2018@03:04:14PM +0200, Hannes Reinecke wrote:
> Yes, but it also doesn't _forbid_ us to set it to the value which is
> currently active.

It doesn't.  The maximum naming however forbids you to ever add
one that is higher than the current max one if you did that,
severly limiting the amount of dynamic changes.

> 
> Plus we already have dynamic fields in the identify output; the
> 'mnan' field is specifically for the number of allocated namespaces.
> And I can easily create new namespaces while a controller is attached.

mnan is static as well.
