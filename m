From: hch@lst.de (Christoph Hellwig)
Date: Tue, 23 May 2017 11:35:55 +0200
Subject: [PATCH 2/7] genirq/affinity: assign vectors to all present CPUs
In-Reply-To: <alpine.DEB.2.20.1705212028280.3023@nanos>
References: <20170519085756.29742-1-hch@lst.de>
 <20170519085756.29742-3-hch@lst.de>
 <alpine.DEB.2.20.1705212028280.3023@nanos>
Message-ID: <20170523093555.GA23632@lst.de>

On Sun, May 21, 2017@08:31:47PM +0200, Thomas Gleixner wrote:
> On Fri, 19 May 2017, Christoph Hellwig wrote:
> > -	/* Stabilize the cpumasks */
> > -	get_online_cpus();
> 
> How is that protected against physical CPU hotplug? Physical CPU hotplug
> manipulates the present mask.

It does indeed seem to.  Documentation/core-api/cpu_hotplug.rst claims
there are no locking rules for manipulations of cpu_present_mask,
maybe it needs and update to mention get/put_online_cpus() ?

Or maybe I should just switch to possible_cpu mask here like a lot of
code seems to do to avoid the hot plug issues, but that might be a bit
of a waste.
