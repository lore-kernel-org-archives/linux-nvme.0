From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Apr 2017 08:32:13 +0200
Subject: [PATCH rfc 2/6] mlx5: move affinity hints assignments to
 generic code
In-Reply-To: <1491140492-25703-3-git-send-email-sagi@grimberg.me>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170404063213.GB8978@lst.de>

> @@ -1375,7 +1375,8 @@ static void mlx5e_close_cq(struct mlx5e_cq *cq)
>  
>  static int mlx5e_get_cpu(struct mlx5e_priv *priv, int ix)
>  {
> -	return cpumask_first(priv->mdev->priv.irq_info[ix].mask);
> +	return cpumask_first(pci_irq_get_affinity(priv->mdev->pdev,
> +			MLX5_EQ_VEC_COMP_BASE + ix));

This looks ok for now, but if we look at the callers we'd probably
want to make direct use of pci_irq_get_node and pci_irq_get_affinity for
the uses directly in mlx5e_open_channel as well as the stored away
->cpu field.  But maybe that should be left for another patch after
this one.

> +	struct irq_affinity irqdesc = { .pre_vectors = MLX5_EQ_VEC_COMP_BASE, };

I usually move assignments inside structures onto a separate line to make
it more readable, e.g.

	struct irq_affinity irqdesc = {
		.pre_vectors = MLX5_EQ_VEC_COMP_BASE,
	};

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
