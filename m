From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Feb 2019 14:37:57 +0100 (CET)
Subject: [PATCH V2 2/4] genirq/affinity: add new callback for caculating
 set vectors
In-Reply-To: <20190212130439.14501-3-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
 <20190212130439.14501-3-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902121435330.3710@nanos.tec.linutronix.de>

On Tue, 12 Feb 2019, Ming Lei wrote:

> Currently pre-caculated set vectors are provided by driver for
> allocating & spread vectors. This way only works when drivers passes
> same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
> also requires driver to retry the allocating & spread.
> 
> As Bjorn and Keith mentioned, the current usage & interface for irq sets
> is a bit awkward because the retrying should have been avoided by providing
> one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
> 'max_vecs', number of the allocated vectors is unknown before calling
> pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
> pre-caculated.
> 
> Add a new callback of .calc_sets into 'struct irq_affinity' so that
> driver can caculate set vectors after IRQ vector is allocated and
> before spread IRQ vectors. Add 'priv' so that driver may retrieve
> its private data via the 'struct irq_affinity'.

Nice changelog!

>  	 * Spread on present CPUs starting from affd->pre_vectors. If we
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
> -	nr_sets = affd->nr_sets;
> -	if (!nr_sets) {
> +	if (affd->calc_sets) {
> +		affd->calc_sets(affd, nvecs);
> +		nr_sets = affd->nr_sets;
> +	} else if (!affd->nr_sets) {
>  		nr_sets = 1;
>  		affd->set_vectors[0] = affvecs;
> -	}
> +	} else
> +		nr_sets = affd->nr_sets;

Lacks curly brackets.

Aside of that it might make sense to get rid of the local variable, but
that should be done in patch 1 if at all. No strong opinion though.

Thanks,

	tglx
