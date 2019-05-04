From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 4 May 2019 23:20:54 +0900
Subject: [PATCHv3 2/2] nvme: validate cntlid during controller
 initialisation
In-Reply-To: <20190503133736.111201-3-hare@suse.de>
References: <20190503133736.111201-1-hare@suse.de>
 <20190503133736.111201-3-hare@suse.de>
Message-ID: <1624cd68-f64e-d255-2f6e-5c1436699778@gmail.com>

Hi Hannes,

I think this patch looks good. but I have a simple query here.

On 5/3/19 10:37 PM, Hannes Reinecke wrote:
> @@ -2434,10 +2452,20 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	}
>   
>   	mutex_lock(&subsys->lock);
> -	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> +	if (!nvme_duplicate_cntlid(subsys, ctrl))
> +		list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
> +	else {
> +		dev_err(ctrl->device,
> +			"Duplicate cntlid %u, rejecting\n",
> +			ctrl->cntlid);
> +		ctrl->subsys = NULL;
> +		sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
> +		nvme_put_subsystem(subsys);

Does it(nvme_put_subsystem()) really need to be here?  I think explicit
"put" for the subsystem is always good, but right above this code, we
can see the comment when sysfs link has been failed:

if (sysfs_create_link(&subsys->dev.kobj, &ctrl->device->kobj,
                 dev_name(ctrl->device))) {
         dev_err(ctrl->device,
                 "failed to create sysfs link from subsystem.\n");
         /* the transport driver will eventually put the subsystem */
         return -EINVAL;
}

I'm not pretty sure where the exactly the comment says, but I can see
the nvme_destroy_subsystem() would be invoked from the transport
drivers (e.g. pci, rdma, etc)

In case of nvme-pci, nvme_remove_dead_ctrl() will do the "put".  For
nvme-rdma, nvme_rdma_create_ctrl() will do the "put".

Did you do just explicit "put" for the subsystem OR does it really need
to be here with any other reason?

I'm just asking why there is a difference between code above it and this
patch.  If you don't mind, please let me know if I'm wrong here. :)

Thanks,

> +		ret = -EINVAL;
> +	}
>   	mutex_unlock(&subsys->lock);
>   
> -	return 0;
> +	return ret;
>   
>   out_unlock:
>   	mutex_unlock(&nvme_subsystems_lock);
> 
