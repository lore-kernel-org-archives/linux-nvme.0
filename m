From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 5 Feb 2018 10:16:22 -0700
Subject: [PATCH] mlx5: fix mlx5_get_vector_affinity to start from
 completion vector 0
In-Reply-To: <20180205142452.7630-1-sagi@grimberg.me>
References: <20180205142452.7630-1-sagi@grimberg.me>
Message-ID: <397fbb71-2a0f-4293-1aee-b9127350fb33@deltatee.com>

Thanks Sagi,

I can confirm this fixes our issue.

Nice Catch!

Logan

On 05/02/18 07:24 AM, Sagi Grimberg wrote:
> The consumers of this routine expects the affinity map of of vector
> index relative to the first completion vector. The upper layers are
> not aware of internal/private completion vectors that mlx5 allocates
> for its own usage.
> 
> Hence, return the affinity map of vector index relative to the first
> completion vector.
> 
> Fixes: 05e0cc84e00c ("net/mlx5: Fix get vector affinity helper function")
> Reported-by: Logan Gunthorpe <logang at deltatee.com>
> Tested-by: Max Gurtovoy <maxg at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Cc: <stable at vger.kernel.org> # v4.15
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   include/linux/mlx5/driver.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index a0610427e168..b82c4ae92411 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -1238,7 +1238,7 @@ mlx5_get_vector_affinity(struct mlx5_core_dev *dev, int vector)
>   	int eqn;
>   	int err;
>   
> -	err = mlx5_vector2eqn(dev, vector, &eqn, &irq);
> +	err = mlx5_vector2eqn(dev, MLX5_EQ_VEC_COMP_BASE + vector, &eqn, &irq);
>   	if (err)
>   		return NULL;
>   
> 
