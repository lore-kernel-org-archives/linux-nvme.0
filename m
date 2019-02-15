From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 Feb 2019 10:54:32 +0100 (CET)
Subject: [patch V5 4/8] nvme-pci: Simplify interrupt allocation
In-Reply-To: <alpine.DEB.2.21.1902151051470.1646@nanos.tec.linutronix.de>
References: <20190214204755.819014197@linutronix.de>
 <20190214211759.699390983@linutronix.de> <868syhs8tn.wl-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1902151051470.1646@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1902151053520.1646@nanos.tec.linutronix.de>

On Fri, 15 Feb 2019, Thomas Gleixner wrote:
> On Fri, 15 Feb 2019, Marc Zyngier wrote:
> > > +	 */
> > > +	if (nrirqs == 1)
> > > +		nr_read_queues = 0;
> > > +	else if (write_queues >= nrirqs)
> > > +		nr_read_queues = nrirqs - 1;
> > 
> > ... while this seem to ensure that we carve out one write queue out of
> > the irq set. It looks like a departure from the original code, which
> > would set nr_read_queues to 1 in that particular case.
> 
> Bah. right you are.

That needs to be:

     nr_read_queues = 1;

obviously.

/me blushes.
