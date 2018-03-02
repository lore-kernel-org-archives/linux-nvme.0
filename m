From: hch@lst.de (Christoph Hellwig)
Date: Sat, 3 Mar 2018 00:07:38 +0100
Subject: [PATCH 2/5] genirq/affinity: move actual irq vector spread
 into one helper
In-Reply-To: <20180206121742.29336-3-ming.lei@redhat.com>
References: <20180206121742.29336-1-ming.lei@redhat.com>
 <20180206121742.29336-3-ming.lei@redhat.com>
Message-ID: <20180302230738.GB31468@lst.de>

On Tue, Feb 06, 2018@08:17:39PM +0800, Ming Lei wrote:
> No functional change, just prepare for converting to 2-stage
> irq vector spread.
> 
> Cc: Thomas Gleixner <tglx at linutronix.de>
> Cc: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  kernel/irq/affinity.c | 99 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 56 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4b1c4763212d..6af3f6727f63 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -79,7 +79,7 @@ static void build_node_to_cpumask(cpumask_var_t *masks)
>  		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
>  }
>  
> -static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
> +static int get_nodes_in_cpumask(const cpumask_var_t *node_to_cpumask,
>  				const struct cpumask *mask, nodemask_t *nodemsk)

Maybe you can split all your constifications into a separate prep patch?

> +int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,
> +			     const cpumask_var_t *node_to_cpumask,
> +			     const struct cpumask *cpu_mask,
> +			     struct cpumask *nmsk,
> +			     struct cpumask *masks)

static?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
