From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 17 Feb 2019 20:17:05 +0100 (CET)
Subject: [patch v6 7/7] genirq/affinity: Add support for non-managed
 affinity sets
In-Reply-To: <20190217134522.GH7296@ming.t460p>
References: <20190216171306.403545970@linutronix.de>
 <20190216172228.869750763@linutronix.de> <20190217134522.GH7296@ming.t460p>
Message-ID: <alpine.DEB.2.21.1902172010060.1683@nanos.tec.linutronix.de>

On Sun, 17 Feb 2019, Ming Lei wrote:
> On Sat, Feb 16, 2019@06:13:13PM +0100, Thomas Gleixner wrote:
> > Some drivers need an extra set of interrupts which should not be marked
> > managed, but should get initial interrupt spreading.
> 
> Could you share the drivers and their use case?

You were Cc'ed on that old discussion:

 https://lkml.kernel.org/r/300d6fef733ca76ced581f8c6304bac6 at mail.gmail.com

> > For both interrupt sets the interrupts are properly spread out, but the
> > second set is not marked managed.
> 
> Given drivers only care the managed vs non-managed interrupt numbers,
> just wondering why this case can't be covered by .pre_vectors &
> .post_vectors?

Well, yes, but post/pre are not subject to spreading and I really don't
want to go there.

> Also this kind of usage may break blk-mq easily, in which the following
> rule needs to be respected:
> 
> 1) all CPUs are required to spread among each interrupt set
> 
> 2) no any CPU is shared between two IRQs in same set.

I don't see how that would break blk-mq. The unmanaged set is not used by
the blk-mq stuff, that's some driver internal voodoo. So blk-mq still gets
a perfectly spread and managed interrupt set for the queues.

> >  	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> > -		unsigned int this_vecs = affd->set_size[i];
> > +		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;
> 
> The above check is inverted.

Doh. Stupid me.

Thanks,

	tglx
