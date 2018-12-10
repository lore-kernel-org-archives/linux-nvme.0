From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Dec 2018 12:12:42 -0800
Subject: [PATCH 03/12] nvmet: add error-log definitions
In-Reply-To: <20181210055011.3146-4-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
 <20181210055011.3146-4-chaitanya.kulkarni@wdc.com>
Message-ID: <b900a403-cda7-c150-630a-13ebf9c06ac2@grimberg.me>


> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dafee1af4829..5a19f64de891 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -202,6 +202,10 @@ struct nvmet_ctrl {
>   
>   	struct device		*p2p_client;
>   	struct radix_tree_root	p2p_ns_map;
> +
> +	spinlock_t		error_lock;
> +	u64			counter;
> +	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
>   };

NVMET_ERROR_LOG_SLOTS is undefined AFAICT.
