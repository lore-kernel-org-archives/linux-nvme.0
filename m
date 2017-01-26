From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 26 Jan 2017 18:30:47 +0200
Subject: [PATCH] nvme: make nvmf_register_transport require a create_ctrl
 callback
In-Reply-To: <20170126152228.15330-1-jthumshirn@suse.de>
References: <20170126152228.15330-1-jthumshirn@suse.de>
Message-ID: <2cc9ed5f-c9af-fd9d-2c90-04541ceebab6@grimberg.me>


>  static void __exit nvme_fc_exit_module(void)
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 557f29b..80f3695 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2063,8 +2063,7 @@ static int __init nvme_rdma_init_module(void)
>  		return ret;
>  	}
>
> -	nvmf_register_transport(&nvme_rdma_transport);
> -	return 0;
> +	return = nvmf_register_transport(&nvme_rdma_transport);

??
