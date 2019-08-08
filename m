From: kbusch@kernel.org (Keith Busch)
Date: Thu, 8 Aug 2019 09:17:40 -0600
Subject: [PATCH] genirq/affinity: create affinity mask for single vector
In-Reply-To: <20190805011906.5020-1-ming.lei@redhat.com>
References: <20190805011906.5020-1-ming.lei@redhat.com>
Message-ID: <20190808151740.GA27077@localhost.localdomain>

On Mon, Aug 05, 2019@09:19:06AM +0800, Ming Lei wrote:
> Since commit c66d4bd110a1f8 ("genirq/affinity: Add new callback for
> (re)calculating interrupt sets"), irq_create_affinity_masks() returns
> NULL in case of single vector. This change has caused regression on some
> drivers, such as lpfc.
> 
> The problem is that single vector may be triggered in some generic cases:
> 1) kdump kernel 2) irq vectors resource is close to exhaustion.
> 
> If we don't create affinity mask for single vector, almost every caller
> has to handle the special case.
> 
> So still create affinity mask for single vector, since irq_create_affinity_masks()
> is capable of handling that.

Hi Ming,

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
 
> ---
>  kernel/irq/affinity.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4352b08ae48d..6fef48033f96 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -251,11 +251,9 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  	 * Determine the number of vectors which need interrupt affinities
>  	 * assigned. If the pre/post request exhausts the available vectors
>  	 * then nothing to do here except for invoking the calc_sets()
> -	 * callback so the device driver can adjust to the situation. If there
> -	 * is only a single vector, then managing the queue is pointless as
> -	 * well.
> +	 * callback so the device driver can adjust to the situation.
>  	 */
> -	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
> +	if (nvecs > affd->pre_vectors + affd->post_vectors)
>  		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>  	else
>  		affvecs = 0;
> -- 
