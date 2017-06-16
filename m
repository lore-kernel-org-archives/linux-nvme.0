From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Jun 2017 12:26:17 +0200 (CEST)
Subject: [PATCH 5/8] genirq/affinity: update CPU affinity for CPU hotplug
 events
In-Reply-To: <20170603140403.27379-6-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-6-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706161223360.2254@nanos>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> +static void irq_affinity_online_irq(unsigned int irq, struct irq_desc *desc,
> +				    unsigned int cpu)
> +{
> +
> +	cpumask_and(mask, affinity, cpu_online_mask);
> +	cpumask_set_cpu(cpu, mask);
> +	if (irqd_has_set(data, IRQD_AFFINITY_SUSPENDED)) {
> +		irq_startup(desc, false);
> +		irqd_clear(data, IRQD_AFFINITY_SUSPENDED);
> +	} else {
> +		irq_affinity_set(irq, desc, mask);

I don't think this should be forced. In that case we really can use the
regular mechanism.

Thanks,

	tglx
