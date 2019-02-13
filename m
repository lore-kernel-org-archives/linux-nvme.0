From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 13 Feb 2019 09:07:24 -0600
Subject: [PATCH V3 2/5] genirq/affinity: store irq set vectors in 'struct
 irq_affinity'
In-Reply-To: <20190213105041.13537-3-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-3-ming.lei@redhat.com>
Message-ID: <20190213150723.GC96272@google.com>

On Wed, Feb 13, 2019@06:50:38PM +0800, Ming Lei wrote:
> Currently the array of irq set vectors is provided by driver.
> 
> irq_create_affinity_masks() can be simplied a bit by treating the
> non-irq-set case as single irq set.

s/simplied a bit/simplified/

> So move this array into 'struct irq_affinity', and pre-define the max
> set number as 4, which should be enough for normal cases.

s/irq/IRQ/
You have a real mixture of capitalization across the changelogs.

> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  drivers/nvme/host/pci.c   |  5 ++---
>  include/linux/interrupt.h |  6 ++++--
>  kernel/irq/affinity.c     | 18 +++++++++++-------
>  3 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 022ea1ee63f8..0086bdf80ea1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2081,12 +2081,11 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
>  static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> -	int irq_sets[2];
>  	struct irq_affinity affd = {
>  		.pre_vectors = 1,
> -		.nr_sets = ARRAY_SIZE(irq_sets),
> -		.sets = irq_sets,
> +		.nr_sets = 2,
>  	};
> +	int *irq_sets = affd.set_vectors;
>  	int result = 0;
>  	unsigned int irq_queues, this_p_queues;
>  
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 1ed1014c9684..a20150627a32 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -259,6 +259,8 @@ struct irq_affinity_notify {
>  	void (*release)(struct kref *ref);
>  };
>  
> +#define	IRQ_MAX_SETS  4

This is a pretty generic name.  Maybe it should include a hint that it's
related to affinity?

>  /**
>   * struct irq_affinity - Description for automatic irq affinity assignements
>   * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
> @@ -266,13 +268,13 @@ struct irq_affinity_notify {
>   * @post_vectors:	Don't apply affinity to @post_vectors at end of
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
> - * @sets:		Number of affinitized sets
> + * @set_vectors:	Number of affinitized sets
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
>  	int	nr_sets;
> -	int	*sets;
> +	int	set_vectors[IRQ_MAX_SETS];
>  };
>  
>  /**
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 9200d3b26f7d..b868b9d3df7f 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -244,7 +244,7 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	int curvec, usedvecs;
>  	struct irq_affinity_desc *masks = NULL;
> -	int i, nr_sets;
> +	int i;
>  
>  	/*
>  	 * If there aren't any vectors left after applying the pre/post
> @@ -253,6 +253,9 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	if (nvecs == affd->pre_vectors + affd->post_vectors)
>  		return NULL;
>  
> +	if (affd->nr_sets > IRQ_MAX_SETS)
> +		return NULL;
> +
>  	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
>  	if (!masks)
>  		return NULL;
> @@ -264,12 +267,13 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
>  	 * Spread on present CPUs starting from affd->pre_vectors. If we
>  	 * have multiple sets, build each sets affinity mask separately.
>  	 */
> -	nr_sets = affd->nr_sets;
> -	if (!nr_sets)
> -		nr_sets = 1;
> +	if (!affd->nr_sets) {
> +		affd->nr_sets = 1;
> +		affd->set_vectors[0] = affvecs;
> +	}
>  
> -	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
> -		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
> +	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> +		int this_vecs = affd->set_vectors[i];
>  		int ret;
>  
>  		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
> @@ -316,7 +320,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
>  		int i;
>  
>  		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
> -			set_vecs += affd->sets[i];
> +			set_vecs += affd->set_vectors[i];
>  	} else {
>  		get_online_cpus();
>  		set_vecs = cpumask_weight(cpu_possible_mask);
> -- 
> 2.9.5
> 
