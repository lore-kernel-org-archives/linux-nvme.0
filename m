From: joe@perches.com (Joe Perches)
Date: Sat, 10 Dec 2016 03:27:50 -0800
Subject: [patch] nvme-fabrics: correct some printk information
In-Reply-To: <20161210090618.GA11680@elgon.mountain>
References: <20161210090618.GA11680@elgon.mountain>
Message-ID: <1481369270.5946.51.camel@perches.com>

On Sat, 2016-12-10@12:06 +0300, Dan Carpenter wrote:
> We really don't care where "ctrl" is on the stack since we're just
> returning soon what we want is the actual ctrl pointer itself.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
[]
> @@ -2402,7 +2402,7 @@ enum blk_eh_timer_return
>  
>  	dev_info(ctrl->ctrl.device,
>  		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
> -		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
> +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, ctrl);

Found by script or inspection?

If by script, it seems unlikely there's only 1 instance
where an address of an automatic pointer type is used
incorrectly.
