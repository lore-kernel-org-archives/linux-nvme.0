From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 13 Feb 2019 09:16:43 -0600
Subject: [PATCH V3 5/5] genirq/affinity: Document .calc_sets as required
 in case of multiple sets
In-Reply-To: <20190213105041.13537-6-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-6-ming.lei@redhat.com>
Message-ID: <20190213151642.GF96272@google.com>

On Wed, Feb 13, 2019@06:50:41PM +0800, Ming Lei wrote:
> Now NVMe has implemented the .calc_sets callback for caculating each
> set's vectors.

s/caculating/calculating/

> For other cases of multiple IRQ sets, pre-caculating each set's vectors
> before allocating IRQ vectors can't work because the whole vectors
> number is unknow at that time.

s/unknow/unknown/
Maybe spell check could be helpful?

> So document .calc_sets as required explicitly for multiple sets.
> 
> Acked-by: Bjorn Helgaas <bhelgaas at google.com>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  drivers/pci/msi.c         | 16 ++++++++++------
>  include/linux/interrupt.h |  3 ++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 96978459e2a0..199d708b4099 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1036,10 +1036,12 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  		return -ERANGE;
>  
>  	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * vectors. The caller needs to handle that.
> +	 * If the caller requests multiple sets of IRQs where each set
> +	 * requires different affinity, it must also supply a ->calc_sets()
> +	 * callback to compute vectors for each set after whole vectors are
> +	 * allocated.

"compute vectors for each set after whole vectors are allocated"
doesn't read smoothly.  The caller is requesting "multiple sets of
IRQs".  So each set contains several IRQ vectors.  IIUC, the vectors
calc_sets() are computing are something other than IRQ vectors.

>  	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> +	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(dev->msi_enabled))
> @@ -1094,10 +1096,12 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  		return -ERANGE;
>  
>  	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * supported vectors. The caller needs to handle that.
> +	 * If the caller requests multiple sets of IRQs where each set
> +	 * requires different affinity, it must also supply a ->calc_sets()
> +	 * callback to compute vectors for each set after whole vectors are
> +	 * allocated.
>  	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> +	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
>  		return -EINVAL;
>  
>  	if (WARN_ON_ONCE(dev->msix_enabled))
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 7a27f6ba1f2f..a053f7fb0ff1 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -269,7 +269,8 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
>   * @set_vectors:	Number of affinitized sets
> - * @calc_sets:		Callback for caculating set vectors
> + * @calc_sets:		Callback for caculating set vectors, required for
> + * 			multiple irq sets.
>   * @priv:		Private data of @calc_sets
>   */
>  struct irq_affinity {
> -- 
> 2.9.5
> 
