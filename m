From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Mon, 14 May 2018 23:09:20 +0000
Subject: Cannot Connect NVMeoF At Certain NR_IO_Queues Values
In-Reply-To: <743c4b33-2bf8-7c76-95af-62043c2aaeeb@mellanox.com>
References: <DE927C68B458BE418D582EC97927A9287FF26F91@ORSMSX113.amr.corp.intel.com>
 <743c4b33-2bf8-7c76-95af-62043c2aaeeb@mellanox.com>
Message-ID: <DE927C68B458BE418D582EC97927A9287FF27624@ORSMSX113.amr.corp.intel.com>

> IMO this issue was fixed in mlx5_core function mlx5_get_vector_affinity.
> It was a long discussion regarding this fix and it will be fixed again in 4.17. After
> the final fix, it should go to stable kernel as well.

Thanks Max.  So current 4.17-rc5 has a fix now?  Or fix is not in yet?

> Meanwhile I can suggest a fast workaround for you if needed (or other
> solutions as well):
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c index
> 0f840ec..dd92cb9 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2236,7 +2236,7 @@ static int nvme_rdma_map_queues(struct
> blk_mq_tag_set *set)
>          .init_hctx      = nvme_rdma_init_hctx,
>          .poll           = nvme_rdma_poll,
>          .timeout        = nvme_rdma_timeout,
> -       .map_queues     = nvme_rdma_map_queues,
>   };

Thanks, I'll give this a shot.
