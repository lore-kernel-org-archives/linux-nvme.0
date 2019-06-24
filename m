From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 24 Jun 2019 17:42:39 +0200 (CEST)
Subject: [PATCH v3 4/5] genirq/affinity: allow driver's discontigous
 affinity set
In-Reply-To: <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1ead341c6d603cf138aed62e31091f257cb19981.1561385989.git.zhangweiping@didiglobal.com>
Message-ID: <alpine.DEB.2.21.1906241740320.32342@nanos.tec.linutronix.de>

On Mon, 24 Jun 2019, Weiping Zhang wrote:

> The driver may implement multiple affinity set, and some of
> are empty, for this case we just skip them.

Why? What's the point of creating empty sets? Just because is not a real
good justification.

Leaving the patch for Ming.

Thanks,

	tglx

> Signed-off-by: Weiping Zhang <zhangweiping at didiglobal.com>
> ---
>  kernel/irq/affinity.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f18cd5aa33e8..6d964fe0fbd8 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -295,6 +295,10 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  		unsigned int this_vecs = affd->set_size[i];
>  		int ret;
>  
> +		/* skip empty affinity set */
> +		if (this_vecs == 0)
> +			continue;
> +
>  		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
>  					       curvec, masks);
>  		if (ret) {
> -- 
> 2.14.1
> 
> 
