From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Feb 2019 08:49:23 -0700
Subject: [PATCH V2 3/4] nvme-pci: avoid irq allocation retrying via
 .calc_sets
In-Reply-To: <20190212130439.14501-4-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
 <20190212130439.14501-4-ming.lei@redhat.com>
Message-ID: <20190212154922.GA6176@localhost.localdomain>

On Tue, Feb 12, 2019@05:04:38AM -0800, Ming Lei wrote:
> Currently pre-caculate each set vectors, and this way requires same
> 'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
> then nvme_setup_irqs() has to retry in case of allocation failure.
> 
> This usage & interface is a bit awkward because the retry should have
> been avoided by providing one reasonable 'min_vecs'.
> 
> Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
> can calculate each set's vector after IRQ vectors is allocated and
> before spread IRQ, then NVMe's retry in case of irq allocation failure
> can be removed.
> 
> Signed-off-by: Ming Lei <ming.lei at redhat.com>

Thanks, Ming, this whole series looks like a great improvement for
drivers using irq sets.

Minor nit below. Otherwise you may add my review for the whole series
if you spin a v3 for the other minor comments.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> +static void nvme_calc_irq_sets(struct irq_affinity *affd, int nvecs)
> +{
> +	struct nvme_dev *dev = affd->priv;
> +
> +	nvme_calc_io_queues(dev, nvecs);
> +
> +	affd->set_vectors[HCTX_TYPE_DEFAULT] = dev->io_queues[HCTX_TYPE_DEFAULT];
> +	affd->set_vectors[HCTX_TYPE_READ] = dev->io_queues[HCTX_TYPE_READ];
> +	affd->nr_sets = HCTX_TYPE_POLL;
> +}

The value of HCTX_TYPE_POLL happens to be 2, but that seems more of a
coincidence right now. Can we hard code 2 just in case the value changes?
