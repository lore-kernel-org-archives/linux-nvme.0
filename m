From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 14:22:14 +0300
Subject: [PATCH v2 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <9562e253-bc15-4ea1-3880-0430fd540410@mellanox.com>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
 <1495957991-19223-2-git-send-email-maxg@mellanox.com>
 <700d9410-56e7-d70f-9de4-87e4e37bca28@grimberg.me>
 <9562e253-bc15-4ea1-3880-0430fd540410@mellanox.com>
Message-ID: <bcd8ef4b-60f9-34e4-a020-0d34407da61e@grimberg.me>

> they are declared in patch 1/2:
>
> +enum {
> +    MLX5_CAP_UMR_FENCE_STRONG    = 0x0,
> +    MLX5_CAP_UMR_FENCE_SMALL    = 0x1,
> +    MLX5_CAP_UMR_FENCE_NONE        = 0x2,
> +};
> +

Missed that, thanks.

What's FENCE_NONE anyway? no umr fence needed at all?
