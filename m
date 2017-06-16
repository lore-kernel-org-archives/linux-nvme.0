From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Jun 2017 12:23:17 +0200 (CEST)
Subject: [PATCH 3/8] genirq/affinity: factor out a irq_affinity_set helper
In-Reply-To: <20170603140403.27379-4-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-4-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1706161221250.2254@nanos>

On Sat, 3 Jun 2017, Christoph Hellwig wrote:
> +
> +bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)

This should be named irq_affinity_force() because it circumvents the 'move
in irq context' mechanism. I'll do that myself. No need to resend.

Thanks,

	tglx
