From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 Aug 2018 17:10:14 +0300
Subject: [PATCH 1/4] nvme-rdma: use reconnect_work for initial connect
In-Reply-To: <20180821134329.69577-2-hare@suse.de>
References: <20180821134329.69577-1-hare@suse.de>
 <20180821134329.69577-2-hare@suse.de>
Message-ID: <f2d53def-3394-eaf3-c75c-d30f708454de@mellanox.com>



On 8/21/2018 4:43 PM, Hannes Reinecke wrote:
> The 'reconnect_work' function does exactly the same than we do
> for the initial connect, so we can as well schedule the workqueue
> item here and wait for it to complete.

If we do this we should rename it to connect_work.

> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   drivers/nvme/host/rdma.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index dc042017c293..0906acbb800e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1990,19 +1990,25 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
>   	WARN_ON_ONCE(!changed);
>   
> -	ret = nvme_rdma_setup_ctrl(ctrl, true);

we call nvme_rdma_setup_ctrl with "new == true" here and with "new == 
false" in the reconnect work.
so how does this work ?

> -	if (ret)
> -		goto out_uninit_ctrl;
> -
> -	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
> -		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
> -
>   	nvme_get_ctrl(&ctrl->ctrl);
>   
>   	mutex_lock(&nvme_rdma_ctrl_mutex);
>   	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
>   	mutex_unlock(&nvme_rdma_ctrl_mutex);
>   
> +	if (!queue_delayed_work(nvme_wq, &ctrl->reconnect_work, 0)) {
> +		nvme_put_ctrl(&ctrl->ctrl);
> +		dev_err(ctrl->ctrl.device,
> +			"failed to schedule initial connect\n");
> +		goto out_uninit_ctrl;
> +	}
> +
> +	flush_delayed_work(&ctrl->reconnect_work);
> +
> +	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISpcs\n",
> +		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
> +
> +
>   	return &ctrl->ctrl;
>   
>   out_uninit_ctrl:
> 

what is the benefit here ?
We have more lines of code now :)
