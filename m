From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Feb 2019 14:35:29 +0100 (CET)
Subject: [PATCH V2 1/4] genirq/affinity: store irq set vectors in 'struct
 irq_affinity'
In-Reply-To: <20190212130439.14501-2-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
 <20190212130439.14501-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902121434280.3710@nanos.tec.linutronix.de>

On Tue, 12 Feb 2019, Ming Lei wrote:

> Currently the array of irq set vectors is provided by driver.
> 
> irq_create_affinity_masks() can be simplied a bit by treating the
> non-irq-set case as single irq set.
> 
> So move this array into 'struct irq_affinity', and pre-define the max
> set number as 4, which should be enough for normal cases.

You really want to add some sanity check which makes sure, that nr_sets is
<= IRQ_MAX_SETS.

Thanks,

	tglx
