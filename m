From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 11 Feb 2019 11:58:11 +0800
Subject: [PATCH 4/5] nvme-pci: simplify nvme_setup_irqs() via
 .setup_affinity callback
In-Reply-To: <alpine.DEB.2.21.1902101731370.8784@nanos.tec.linutronix.de>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-5-ming.lei@redhat.com>
 <alpine.DEB.2.21.1902101731370.8784@nanos.tec.linutronix.de>
Message-ID: <20190211035810.GB8638@ming.t460p>

On Sun, Feb 10, 2019@05:39:20PM +0100, Thomas Gleixner wrote:
> On Fri, 25 Jan 2019, Ming Lei wrote:
> 
> > Use the callback of .setup_affinity() to re-caculate number
> > of queues, and build irqs affinity with help of irq_build_affinity().
> > 
> > Then nvme_setup_irqs() gets simplified a lot.
> 
> I'm pretty sure you can achieve the same by reworking the core code without
> that callback.

Could you share the idea a bit? As I mentioned, the re-distribution
needs driver's knowledge.

>  
> > +	/* Fill out vectors at the beginning that don't need affinity */
> > +	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
> > +		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);
> 
> cpu_possible_mask is wrong.  Why are you deliberately trying to make this
> special? There is absolutely no reason to do so.

It is just for avoiding to export 'irq_default_affinity'.

> 
> These interrupts are not managed and therefore the initial affinity has to
> be irq_default_affinity. Setting them to cpu_possible_mask can and probably
> will evade a well thought out default affinity mask, which was set to
> isolate a set of cores from general purpose interrupts.
> 
> This is exactly the thing which happens with driver special stuff and which
> needs to be avoided. There is nothing special about this NVME setup and
> yes, I can see why the current core code is a bit tedious to work with, but
> that does not justify that extra driver magic by any means.

OK, thanks for your explanation.

Thanks,
Ming
