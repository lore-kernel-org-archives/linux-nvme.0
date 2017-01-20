From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Jan 2017 11:30:30 +0100
Subject: [PATCH v2 2/2] nvme: Enable autonomous power state transitions
In-Reply-To: <9b150934a9d756f69ca241199af512925a4050ec.1484855622.git.luto@kernel.org>
References: <cover.1484855622.git.luto@kernel.org>
 <9b150934a9d756f69ca241199af512925a4050ec.1484855622.git.luto@kernel.org>
Message-ID: <20170120103030.GB23149@lst.de>


> +static void nvme_set_latency_tolerance(struct device *dev, s32 val)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +
> +	u64 latency;
> +
> +	if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT ||
> +	    val == PM_QOS_LATENCY_ANY)
> +		latency = U64_MAX;
> +	else
> +		latency = val;

In addition to the latency vs val mixup pointed out earlier -
can you use a switch statement here to make the code a little
more obvious?

> +	if (ctrl->ps_max_latency_us != val) {
> +		ctrl->ps_max_latency_us = val;
> +		nvme_configure_apst(ctrl);
> +	}
> +}
> +

>  	ctrl->identified = true;

The ->identified field seems to never be checked anywhere.


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7103bce4ba4f..1c3e170da6de 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1791,6 +1791,8 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>  
> +	nvme_configure_apst(&dev->ctrl);
> +
>  	/*
>  	 * A controller that can not execute IO typically requires user
>  	 * intervention to correct. For such degraded controllers, the driver
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 557f29b1f1bb..a64b5db96fd8 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1629,6 +1629,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
>  
>  	nvme_start_keep_alive(&ctrl->ctrl);
>  
> +	nvme_configure_apst(&ctrl->ctrl);
> +

Is there a specific reason for the exact placement of these calls here
and not at inside nvme_init_identify?  Having all the code called
from an existing core function would make things a lot easier in the
future.  And if that's not possible we'll probably need comments
on why it's placed like it is.
