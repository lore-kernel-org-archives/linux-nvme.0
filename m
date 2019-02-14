From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 13:59:26 +0100 (CET)
Subject: [PATCH V4 3/4] nvme-pci: Simplify interrupt allocation
In-Reply-To: <20190214122347.17372-4-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
 <20190214122347.17372-4-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141358130.1561@nanos.tec.linutronix.de>

On Thu, 14 Feb 2019, Ming Lei wrote:
> +static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +
> +	nvme_calc_io_queues(dev, nvecs);
> +
> +	affd->set_size[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
> +	affd->set_size[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
> +	affd->nr_sets = 2;

That's not really correct.

> -		nvme_calc_io_queues(dev, irq_queues);
> -		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
> -		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
> -		if (!irq_sets[1])
> -			affd.nr_sets = 1;

-----------------------^^^^^^^^^^^^^^^^^^  				     

That happens when the number of interrupts becomes too small to have split
queues. I'll fix that up.

Thanks,

	tglx
