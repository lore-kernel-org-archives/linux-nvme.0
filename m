From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 12:31:29 +0300
Subject: [PATCH 4/5] nvmet: use atomic allocations when allocating fc
 requests
In-Reply-To: <20180515074043.22843-5-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-5-jthumshirn@suse.de>
Message-ID: <3c91cf45-aa85-e1a5-6d25-5654131626dd@grimberg.me>


> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 34712def81b1..d2209c60f95f 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -509,7 +509,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
>   	if (!rport->targetport)
>   		return -ECONNREFUSED;
>   
> -	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_KERNEL);
> +	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_ATOMIC);

Question, why isn't tfcp_req embedded in fcpreq? don't they have
the same lifetime?

>   	if (!tfcp_req)
>   		return -ENOMEM;
>   
> 
