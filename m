From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 19:34:54 +0300
Subject: [PATCHv4 3/4] nvme: Introduce frozen controller state
In-Reply-To: <20180713205609.19701-4-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
 <20180713205609.19701-4-keith.busch@intel.com>
Message-ID: <59b9c74b-91f1-7d1b-f20a-5a64dd66a17e@grimberg.me>


> +	if (ctrl->state == NVME_CTRL_FROZEN) {
> +		nvme_wait_freeze(ctrl);
> +		blk_mq_update_nr_hw_queues(ctrl->tagset, ctrl->queue_count - 1);
> +		nvme_unfreeze(ctrl);
> +		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
> +			return;
> +	}
> +

Having the transport drivers setup a state to indicate nvme-core to
handle it and change it again looks convoluted to me...

>   	if (ctrl->queue_count > 1) {
>   		nvme_queue_scan(ctrl);
>   		nvme_enable_aen(ctrl);
>   		queue_work(nvme_wq, &ctrl->async_event_work);
> -		nvme_start_queues(ctrl);
>   	}
>   }
>   
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	nvme_start_queues(ctrl);

You start the queues here?
