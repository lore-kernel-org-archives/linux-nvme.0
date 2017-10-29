From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 29 Oct 2017 19:09:24 +0200
Subject: [PATCH 1/2] IB/mlx5: posting klm/mtt list inline in the send
 queue for reg_wr
In-Reply-To: <1509295101-14081-2-git-send-email-idanb@mellanox.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-2-git-send-email-idanb@mellanox.com>
Message-ID: <a97dd33b-1185-b2db-6df2-a636be963c71@grimberg.me>


> As most kernel RDMA ULPs, NVMe over Fabrics in its secure
> "register_always" mode registers and invalidates user buffer
> upon each IO.

Again, lets drop the secured mode language.

> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index acb79d3..b25b93d 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -53,6 +53,7 @@ enum {
>   
>   enum {
>   	MLX5_IB_SQ_STRIDE	= 6,
> +	MLX5_IB_SQ_UMR_INLINE_THRESHOLD = 64,
>   };

Is this a device capability? Is it true for all mlx5 devices?
can we get it from the FW instead?

Otherwise, looks good to me,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
