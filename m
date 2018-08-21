From: james.smart@broadcom.com (James Smart)
Date: Tue, 21 Aug 2018 14:01:51 -0700
Subject: [PATCH 2/4] nvme: implement 'async_connect' cli option
In-Reply-To: <20180821134329.69577-3-hare@suse.de>
References: <20180821134329.69577-1-hare@suse.de>
 <20180821134329.69577-3-hare@suse.de>
Message-ID: <7bdfe5fb-388a-2544-f140-ed6d9b264bfb@broadcom.com>



On 8/21/2018 6:43 AM, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 611e70cae754..90b4d8df275b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3081,7 +3081,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   		goto fail_ctrl;
>   	}
>   
> -	flush_delayed_work(&ctrl->connect_work);
> +	if (!opts->async_connect)
> +		flush_delayed_work(&ctrl->connect_work);
>   
>   	dev_info(ctrl->ctrl.device,
>   		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0906acbb800e..82917dba9452 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2003,7 +2003,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   		goto out_uninit_ctrl;
>   	}
>   
> -	flush_delayed_work(&ctrl->reconnect_work);
> +	if (!opts->async_connect)
> +		flush_delayed_work(&ctrl->reconnect_work);
>   
>   	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
>   		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);

I would prefer that the check and flush occur in the common 
nvmf_create_ctrl() routine.? However, I know this means the core layer 
has to become aware of the work element which complicates things.? If 
you're willing to figure that out....

if not...
Reviewed-by:? James Smart? <james.smart at broadcom.com>

-- james
