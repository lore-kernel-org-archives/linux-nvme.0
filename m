From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Jun 2017 12:29:59 +0200 (CEST)
Subject: [PATCH 5/8] genirq/affinity: update CPU affinity for CPU hotplug
 events
In-Reply-To: <20170603140403.27379-6-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-6-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706161226210.2254@nanos>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> +static void irq_affinity_online_irq(unsigned int irq, struct irq_desc *desc,
> +				    unsigned int cpu)
> +{
> +	const struct cpumask *affinity;
> +	struct irq_data *data;
> +	struct irq_chip *chip;
> +	unsigned long flags;
> +	cpumask_var_t mask;
> +
> +	if (!desc)
> +		return;
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> +		return;

That's silly. Why want you to do that for each irq descriptor? That's
outright silly. Either you allocated it in irq_affinity_[on|off]line_cpu()
once or just make it a static cpumask. Lemme fix that up.

Thanks,

	tglx
