From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Dec 2016 16:40:30 -0800
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <20161210090618.GA11680@elgon.mountain>
References: <20161210090618.GA11680@elgon.mountain>
Message-ID: <c73d9cb3-89f4-54d3-50b3-90b6b2f3df23@broadcom.com>

Dan,

Mind if I solve this a different way ?  I really don't know why knowing 
the ptr value is even meaningful

-- james


On 12/10/2016 1:06 AM, Dan Carpenter wrote:
> We really don't care where "ctrl" is on the stack since we're just
> returning soon what we want is the actual ctrl pointer itself.
>
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 771e2e761872..e6395ed2f562 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2402,7 +2402,7 @@ enum blk_eh_timer_return
>   
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
> -		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
> +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, ctrl);
>   
>   	kref_get(&ctrl->ctrl.kref);
>   
