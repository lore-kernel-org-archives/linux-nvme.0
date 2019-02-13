From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 13 Feb 2019 21:58:56 +0100 (CET)
Subject: [PATCH V3 3/5] genirq/affinity: add new callback for caculating
 set vectors
In-Reply-To: <20190213151149.GD96272@google.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-4-ming.lei@redhat.com>
 <20190213151149.GD96272@google.com>
Message-ID: <alpine.DEB.2.21.1902132157060.1659@nanos.tec.linutronix.de>

On Wed, 13 Feb 2019, Bjorn Helgaas wrote:
> > Add a new callback of .calc_sets into 'struct irq_affinity' so that
> > driver can caculate set vectors after IRQ vector is allocated and
> > before spread IRQ vectors. Add 'priv' so that driver may retrieve
> > its private data via the 'struct irq_affinity'.
> 
> s/caculate/calculate/
> 
> I *think* "set vectors" here has something to do with an affinity
> cpumask?  "Set vectors" doesn't seem like quite the right terminology.

See previous mail. Let's stay with 'interrupt sets' and get rid of the
vector naming completely.

Thanks,

	tglx
