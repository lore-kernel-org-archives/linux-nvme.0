From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Jun 2017 10:22:00 +0200
Subject: [PATCH v4 for-4.13 2/6] mlx5: move affinity hints assignments
 to generic code
In-Reply-To: <1496814868-22070-3-git-send-email-sagi@grimberg.me>
References: <1496814868-22070-1-git-send-email-sagi@grimberg.me>
 <1496814868-22070-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170607082200.GB24774@lst.de>

On Wed, Jun 07, 2017@08:54:24AM +0300, Sagi Grimberg wrote:
> generic api takes care of spreading affinity similar to
> what mlx5 open coded (and even handles better asymmetric
> configurations). Ask the generic API to spread affinity
> for us, and feed him pre_vectors that do not participate
> in affinity settings (which is an improvement to what we
> had before).
> 
> The affinity assignments should match what mlx5 tried to
> do earlier but now we do not set affinity to async, cmd
> and pages dedicated vectors.
> 
> Also, remove mlx5e_get_cpu routine as we have generic helpers
> to get cpumask and node given a irq vector, so use them
> directly.
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Acked-by: Leon Romanovsky <leonro at mellanox.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 12 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/main.c    | 83 ++---------------------
>  include/linux/mlx5/driver.h                       |  1 -
>  3 files changed, 10 insertions(+), 86 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 2a3c59e55dcf..ebfda1eae6b4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1565,11 +1565,6 @@ static void mlx5e_close_cq(struct mlx5e_cq *cq)
>  	mlx5e_free_cq(cq);
>  }
>  
> -static int mlx5e_get_cpu(struct mlx5e_priv *priv, int ix)
> -{
> -	return cpumask_first(priv->mdev->priv.irq_info[ix].mask);
> -}
> -
>  static int mlx5e_open_tx_cqs(struct mlx5e_channel *c,
>  			     struct mlx5e_params *params,
>  			     struct mlx5e_channel_param *cparam)
> @@ -1718,11 +1713,11 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>  {
>  	struct mlx5e_cq_moder icocq_moder = {0, 0};
>  	struct net_device *netdev = priv->netdev;
> -	int cpu = mlx5e_get_cpu(priv, ix);
>  	struct mlx5e_channel *c;
>  	int err;
>  
> -	c = kzalloc_node(sizeof(*c), GFP_KERNEL, cpu_to_node(cpu));
> +	c = kzalloc_node(sizeof(*c), GFP_KERNEL,
> +		pci_irq_get_node(priv->mdev->pdev, MLX5_EQ_VEC_COMP_BASE + ix));
>  	if (!c)
>  		return -ENOMEM;
>  
> @@ -1730,7 +1725,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
>  	c->mdev     = priv->mdev;
>  	c->tstamp   = &priv->tstamp;
>  	c->ix       = ix;
> -	c->cpu      = cpu;
> +	c->cpu      = cpumask_first(pci_irq_get_affinity(priv->mdev->pdev,
> +			MLX5_EQ_VEC_COMP_BASE + ix));

->cpu is only used to call cpu_to_node on it.  So remove it and switch
the users to

	pci_irq_get_node(priv->mdev->pdev)

instead.
