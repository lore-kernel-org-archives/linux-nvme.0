From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 11:47:46 +0200
Subject: [PATCH v5 for-4.13 3/7] mlx5: move affinity hints assignments
 to generic code
In-Reply-To: <1497533594-11579-4-git-send-email-sagi@grimberg.me>
References: <1497533594-11579-1-git-send-email-sagi@grimberg.me>
 <1497533594-11579-4-git-send-email-sagi@grimberg.me>
Message-ID: <20170616094746.GB12547@lst.de>

>  
> +static int mlx5e_get_node(struct mlx5e_priv *priv, int ix)
> +{
> +	return pci_irq_get_node(priv->mdev->pdev, MLX5_EQ_VEC_COMP_BASE + ix);
> +}

This helper seems very useful indeed..

>  	rq->mpwqe.info = kzalloc_node(wq_sz * sizeof(*rq->mpwqe.info),
> -				      GFP_KERNEL, cpu_to_node(c->cpu));
> +					GFP_KERNEL, node);

Why the reindenting?

>  	/* We allocate more than mtt_sz as we will align the pointer */
> -	rq->mpwqe.mtt_no_align = kzalloc_node(mtt_alloc * wq_sz, GFP_KERNEL,
> -					cpu_to_node(c->cpu));
> +	rq->mpwqe.mtt_no_align = kzalloc_node(mtt_alloc * wq_sz,
> +					GFP_KERNEL, node);

Or the moving of GFP_KERNEL to the next line here?
