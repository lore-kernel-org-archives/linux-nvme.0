From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Tue, 13 Aug 2019 19:31:39 +0000
Subject: [PATCH V3 1/3] genirq/affinity: Enhance warning check
In-Reply-To: <20190813081447.1396-2-ming.lei@redhat.com>
References: <20190813081447.1396-1-ming.lei@redhat.com>
 <20190813081447.1396-2-ming.lei@redhat.com>
Message-ID: <ac920ba3996d0feedc924045b54724ba5482e427.camel@intel.com>

Hi Ming,

On Tue, 2019-08-13@16:14 +0800, Ming Lei wrote:
> The two-stage spread is done on same irq vectors, and we just need that
> either one stage covers all vector, not two stage work together to cover
> all vectors.
> 
> So enhance the warning check to make sure all vectors are spread.
> 
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: linux-nvme at lists.infradead.org,
> Cc: Jon Derrick <jonathan.derrick at intel.com>
> Cc: Jens Axboe <axboe at kernel.dk>
> Fixes: 6da4b3ab9a6 ("genirq/affinity: Add support for allocating interrupt sets")
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  kernel/irq/affinity.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 6fef48033f96..265b3076f16b 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -215,8 +215,7 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
>  					       npresmsk, nmsk, masks);
>  	put_online_cpus();
>  
> -	if (nr_present < numvecs)
> -		WARN_ON(nr_present + nr_others < numvecs);
> +	WARN_ON(max(nr_present, nr_others) < numvecs);

I think the patch description assumes the first condition
"The two-stage spread is done on same irq vectors"

    /*
     * Spread on non present CPUs starting from the next vector to be
     * handled. If the spreading of present CPUs already exhausted the
     * vector space, assign the non present CPUs to the already spread
     * out vectors.
     */
    if (nr_present >= numvecs)
            curvec = firstvec;

But doesn't following condition imply nr_others spread is potentionally
different vector set?

    else
            curvec = firstvec + nr_present;

>  
>  	free_node_to_cpumask(node_to_cpumask);
>  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3278 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190813/cd319cc3/attachment.bin>
