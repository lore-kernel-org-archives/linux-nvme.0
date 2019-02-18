From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 18 Feb 2019 08:25:49 +0100 (CET)
Subject: [patch v6 7/7] genirq/affinity: Add support for non-managed
 affinity sets
In-Reply-To: <20190218024922.GA27779@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.869750763@linutronix.de> <20190217134522.GH7296@ming.t460p>
 <alpine.DEB.2.21.1902172010060.1683@nanos.tec.linutronix.de>
 <20190218024922.GA27779@ming.t460p>
Message-ID: <alpine.DEB.2.21.1902180824070.1683@nanos.tec.linutronix.de>

Ming,

On Mon, 18 Feb 2019, Ming Lei wrote:
> On Sun, Feb 17, 2019@08:17:05PM +0100, Thomas Gleixner wrote:
> > I don't see how that would break blk-mq. The unmanaged set is not used by
> > the blk-mq stuff, that's some driver internal voodoo. So blk-mq still gets
> > a perfectly spread and managed interrupt set for the queues.
> 
> >From the discussion above, the use case is for megaraid_sas. And one of the
> two interrupt sets(managed and non-managed) will be chosen according to
> workloads runtime.
> 
> Each interrupt set actually defines one blk-mq queue mapping, and the
> queue mapping needs to respect the rule I mentioned now. However,
> non-managed affinity can be changed to any way anytime by user-space.
> 
> Recently HPSA tried to add one module parameter to use non-managed
> IRQ[1].
> 
> Also NVMe RDMA uses non-managed interrupts, and at least one CPU hotplug
> issue is never fixed yet[2]. 
> 
> [1] https://marc.info/?t=154387665200001&r=1&w=2
> [2] https://www.spinics.net/lists/linux-block/msg24140.html

Interesting. I misread the description which megasas folks provided
then. I'll drop that patch and get the other lot merged. Thanks for your
work and help with that!

Thanks,

	tglx
