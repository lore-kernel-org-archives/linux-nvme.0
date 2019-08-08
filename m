From: kbusch@kernel.org (Keith Busch)
Date: Thu, 8 Aug 2019 17:08:35 -0600
Subject: [PATCH] genirq/affinity: report extra vectors on uneven nodes
In-Reply-To: <1a6ab898b8800c3e660054f77ac81bfc3921d45a.camel@intel.com>
References: <20190807201051.32662-1-jonathan.derrick@intel.com>
 <alpine.DEB.2.21.1908080903360.2882@nanos.tec.linutronix.de>
 <20190808163224.GB27077@localhost.localdomain>
 <1a6ab898b8800c3e660054f77ac81bfc3921d45a.camel@intel.com>
Message-ID: <20190808230835.GB27570@localhost.localdomain>

On Thu, Aug 08, 2019@10:46:06PM +0000, Derrick, Jonathan wrote:
> On Thu, 2019-08-08@10:32 -0600, Keith Busch wrote:
> > 
> > I think the real problem is the spread's vecs_per_node doesn't account
> > which nodes contribute more CPUs than others. For example:
> > 
> >   Node 0 has 32 CPUs
> >   Node 1 has 8 CPUs
> >   Assign 32 vectors
> > 
> > The current algorithm assigns 16 vectors to node 0 because vecs_per_node
> > is calculated as 32 vectors / 2 nodes on the first iteration. The
> > subsequent iteration for node 1 gets 8 vectors because it has only 8
> > CPUs, leaving 8 vectors unassigned.
> > 
> > A more fair spread would give node 0 the remaining 8 vectors. This
> > optimization, however, is a bit more complex than the current algorithm,
> > which is probably why it wasn't done, so I think the warning should just
> > be removed.
> 
> It does get a bit complex for the rare scenario in this case
> Maybe just an informational warning rather than a stackdumping warning

I think the easiest way to ensure all vectors are assigned is iterate
the nodes in a sorted order from fewest CPUs to most. That should fix
the warning, though it may not have the best possible assignment ratio
(but better than what we're currently doing).

Unfortunately the kernel's sort() doesn't take a 'void *priv' for the
compare callback, so we wouldn't have all the information needed to weigh
each node, but maybe we can fix that if there's agreement to iterate
the nodes this way.
