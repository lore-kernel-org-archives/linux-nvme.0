From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Jun 2017 13:08:03 +0200 (CEST)
Subject: [PATCH 3/8] genirq/affinity: factor out a irq_affinity_set helper
In-Reply-To: <20170603140403.27379-4-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706161306070.2254@nanos>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> +bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)
> +{
> +	struct irq_data *data = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(data);
> +	bool ret = false;
> +
> +	if (!irq_can_move_pcntxt(data) && chip->irq_mask)
> +		chip->irq_mask(data);
> +
> +	if (chip->irq_set_affinity) {
> +		if (chip->irq_set_affinity(data, mask, true) == -ENOSPC)
> +			pr_crit("IRQ %d set affinity failed because there are no available vectors.  The device assigned to this IRQ is unstable.\n", irq);
> +		ret = true;
> +	}
> +
> +	/*
> +	 * We unmask if the irq was not marked masked by the core code.
> +	 * That respects the lazy irq disable behaviour.
> +	 */
> +	if (!irq_can_move_pcntxt(data) &&
> +	    !irqd_irq_masked(data) && chip->irq_unmask)
> +		chip->irq_unmask(data);

There is another issue with this. Nothing updates the affinity mask in
irq_desc, when we just invoke the chip callback. Let me have a look.

Thanks,

	tglx
