From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 10 Feb 2019 19:49:12 +0100 (CET)
Subject: [PATCH 4/5] nvme-pci: simplify nvme_setup_irqs() via
 .setup_affinity callback
In-Reply-To: <20190125095347.17950-5-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
 <20190125095347.17950-5-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902101815260.8784@nanos.tec.linutronix.de>

On Fri, 25 Jan 2019, Ming Lei wrote:
> +static int nvme_setup_affinity(const struct irq_affinity *affd,
> +			       struct irq_affinity_desc *masks,
> +			       unsigned int nmasks)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +	int affvecs = nmasks - affd->pre_vectors - affd->post_vectors;
> +	int curvec, usedvecs;
> +	int i;
> +
> +	nvme_calc_io_queues(dev, nmasks);

So this is the only NVME specific information. Everything else can be done
in generic code. So what you really want is:

	struct affd {
		...
+		calc_sets(struct affd *, unsigned int nvecs);
		...
	}

And sets want to be actually inside of the affinity descriptor structure:

        unsigned int num_sets;
	unsigned int set_vectors[MAX_SETS];

We surely can define a sensible maximum of sets for now. If that ever turns
out to be insufficient, then struct affd might become to large for the
stack, but for now, using e.g. 8, there is no need to do so.

So then the logic in the generic code becomes exactly the same as what you
added to nvme_setup_affinity():

	if (affd->calc_sets) {
		affd->calc_sets(affd, nvecs);
	} else if (!affd->num_sets) {
		affd->num_sets = 1;
		affd->set_vectors[0] = affvecs;
	}

	for (i = 0; i < affd->num_sets; i++) {
	    ....
	}

See?

Thanks,

	tglx
