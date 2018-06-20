From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 20 Jun 2018 12:06:33 +0300
Subject: [PATCH 1/7] nvme-rdma: fix possible double free condition when
 failing to create a controller
In-Reply-To: <20180619123415.25077-2-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-2-sagi@grimberg.me>
Message-ID: <0af01f6d-75f3-3a8c-bcca-abd6a8da3920@mellanox.com>



On 6/19/2018 3:34 PM, Sagi Grimberg wrote:
> Failures after nvme_init_ctrl will defer resource cleanups to .free_ctrl
> when the reference is released, hence we should not free the controller queues
> for these failures.

see below.

> 
> Fix that by moving controller queues allocation before controller initialization
> and correctly freeing them for failures before initialization and skip them
> for failures after initialization.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index c9424da0d23e..99d213ea95da 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1932,11 +1932,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   		goto out_free_ctrl;
>   	}
>   
> -	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
> -				0 /* no quirks, we're perfect! */);
> -	if (ret)
> -		goto out_free_ctrl;
> -
>   	INIT_DELAYED_WORK(&ctrl->reconnect_work,
>   			nvme_rdma_reconnect_ctrl_work);
>   	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
> @@ -1950,14 +1945,19 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
>   				GFP_KERNEL);
>   	if (!ctrl->queues)
> -		goto out_uninit_ctrl;
> +		goto out_free_ctrl;
> +
> +	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_rdma_ctrl_ops,
> +				0 /* no quirks, we're perfect! */);
> +	if (ret)
> +		goto out_kfree_queues;
>   
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
>   	WARN_ON_ONCE(!changed);
>   
>   	ret = nvme_rdma_configure_admin_queue(ctrl, true);
>   	if (ret)
> -		goto out_kfree_queues;
> +		goto out_uninit_ctrl;
>   
>   	/* sanity check icdoff */
>   	if (ctrl->ctrl.icdoff) {
> @@ -2014,14 +2014,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   
>   out_remove_admin_queue:
>   	nvme_rdma_destroy_admin_queue(ctrl, true);
> -out_kfree_queues:
> -	kfree(ctrl->queues);
>   out_uninit_ctrl:
>   	nvme_uninit_ctrl(&ctrl->ctrl);
>   	nvme_put_ctrl(&ctrl->ctrl);
>   	if (ret > 0)
>   		ret = -EIO;
>   	return ERR_PTR(ret);

can you explain this error flow ? we'll never free the queues since the 
list &ctrl->list is empty. I guess a fix to nvme_rdma_free_ctrl is 
needed in this case.
Also, when ret will be > 0 ?


> +out_kfree_queues:
> +	kfree(ctrl->queues);
>   out_free_ctrl:
>   	kfree(ctrl);
>   	return ERR_PTR(ret);
> 
