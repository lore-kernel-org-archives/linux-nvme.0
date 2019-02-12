From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 12 Feb 2019 14:42:04 +0100 (CET)
Subject: [PATCH V2 0/4] genirq/affinity: add .calc_sets for improving
 IRQ allocation & spread
In-Reply-To: <20190212130439.14501-1-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902121438310.3710@nanos.tec.linutronix.de>

On Tue, 12 Feb 2019, Ming Lei wrote:

> Hi,
> 
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
> 
> 
> V2:
> 	- add .calc_sets instead of .setup_affinity() which is easy to
> 	be abused by drivers

This looks really well done. If you can address the minor nitpicks, then
this is good to go, unless someone has objections.

Thanks,

	tglx
