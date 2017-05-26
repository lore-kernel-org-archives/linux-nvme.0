From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 May 2017 08:50:20 +0200
Subject: [PATCH 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <1495743219-1085-2-git-send-email-maxg@mellanox.com>
References: <1495743219-1085-1-git-send-email-maxg@mellanox.com>
 <1495743219-1085-2-git-send-email-maxg@mellanox.com>
Message-ID: <20170526065020.GA19681@lst.de>

On Thu, May 25, 2017@11:13:39PM +0300, Max Gurtovoy wrote:
> Cache the needed umr_fence and set the wqe ctrl segmennt
> accordingly.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> Acked-by: Leon Romanovsky <leon at kernel.org>
> ---
>  drivers/infiniband/hw/mlx5/main.c    |   14 ++++++++++++++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |    1 +
>  drivers/infiniband/hw/mlx5/qp.c      |   15 +++++++--------
>  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index d45772d..83d1f9b 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -2979,6 +2979,18 @@ static int create_umr_res(struct mlx5_ib_dev *dev)
>  	return ret;
>  }
>  
> +static u8 mlx5_get_umr_fence(u8 umr_fence_cap)
> +{
> +	switch (umr_fence_cap) {
> +	case MLX5_CAP_UMR_FENCE_STRONG:
> +		return MLX5_FENCE_MODE_STRONG_ORDERING;
> +	case MLX5_CAP_UMR_FENCE_SMALL:
> +		return MLX5_FENCE_MODE_INITIATOR_SMALL;
> +	default:
> +		return MLX5_FENCE_MODE_NONE;

Of course I don't really understand your firmware interface, but
shouldn't strong ordering be the default, and only certain fw
cap bits would relax it?
