From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 15:43:41 +0300
Subject: [PATCH v2 4/5] nvme_fc: add aen abort to teardown
In-Reply-To: <20170411183512.9043-5-jsmart2021@gmail.com>
References: <20170411183512.9043-1-jsmart2021@gmail.com>
 <20170411183512.9043-5-jsmart2021@gmail.com>
Message-ID: <e497c0b2-a4c3-57bc-56b4-c8188b28fefe@grimberg.me>


>  /*
> @@ -2406,12 +2493,12 @@ __nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>
>  	ret = nvme_fc_init_aen_ops(ctrl);
>  	if (ret)
> -		goto out_exit_aen_ops;
> +		goto out_stop_keep_alive;
>
>  	if (ctrl->queue_count > 1) {
>  		ret = nvme_fc_create_io_queues(ctrl);
>  		if (ret)
> -			goto out_exit_aen_ops;
> +			goto out_stop_keep_alive;
>  	}
>
>  	spin_lock_irqsave(&ctrl->lock, flags);
> @@ -2438,8 +2525,8 @@ __nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>
>  	return &ctrl->ctrl;
>
> -out_exit_aen_ops:
> -	nvme_fc_exit_aen_ops(ctrl);
> +out_stop_keep_alive:
> +	nvme_stop_keep_alive(&ctrl->ctrl);
>  out_remove_admin_queue:
>  	/* send a Disconnect(association) LS to fc-nvme target */
>  	nvme_fc_xmt_disconnect_assoc(ctrl);
>

Not directly related to what this patch does,

otherwise,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
