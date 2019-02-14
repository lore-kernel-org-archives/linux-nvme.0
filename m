From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 15:04:24 +0100 (CET)
Subject: [PATCH V4 1/4] genirq/affinity: store interrupt sets size in
 'struct irq_affinity'
In-Reply-To: <20190214122347.17372-2-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
 <20190214122347.17372-2-ming.lei@redhat.com>
Message-ID: <alpine.DEB.2.21.1902141502320.1561@nanos.tec.linutronix.de>

On Thu, 14 Feb 2019, Ming Lei wrote:
>  /**
>   * struct irq_affinity - Description for automatic irq affinity assignements
>   * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
> @@ -266,13 +268,13 @@ struct irq_affinity_notify {
>   * @post_vectors:	Don't apply affinity to @post_vectors at end of
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
> - * @sets:		Number of affinitized sets
> + * @set_size:		Number of affinitized sets

Both nr_sets and set_size comments are wrong ...

>  	nr_sets = affd->nr_sets;
> -	if (!nr_sets)
> +	if (!nr_sets) {
>  		nr_sets = 1;
> +		set_size[0] = affvecs;
> +	} else {
> +		memcpy(set_size, affd->set_size,
> +				IRQ_AFFINITY_MAX_SETS * sizeof(int));

Uuurgh. No. This needs to be nr_sets * sizeof(int) otherwise you copy
beyond the size of the source. nr_sets is already verified to be less than
IRQ_AFFINITY_MAX_SETS.

Fixed it up.

Thanks,

	tglx
