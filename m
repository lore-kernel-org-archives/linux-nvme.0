From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 13:39:12 -0700
Subject: [PATCH 4/5] nvmet: use atomic allocations when allocating fc
 requests
In-Reply-To: <20180515074043.22843-5-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-5-jthumshirn@suse.de>
Message-ID: <d9dfaf4b-62ba-de74-61b0-a5ca5705582b@broadcom.com>



On 5/15/2018 12:40 AM, Johannes Thumshirn wrote:
> fcloop_fcp_req() runs with the hctx_lock (a rcu_read_lock() locked
> section) held, so memory allocations done in this context have to be
> atomic.
...
>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>   drivers/nvme/target/fcloop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
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
>   	if (!tfcp_req)
>   		return -ENOMEM;
>   

Reviewed-by:?? James Smart? <james.smart at broadcom.com>
