From: kbusch@kernel.org (Keith Busch)
Date: Mon, 6 May 2019 08:53:27 -0600
Subject: [PATCH] nvme-loop: Fix race between completions and shutdown
In-Reply-To: <20190506145203.2851-1-minwoo.im.dev@gmail.com>
References: <20190506145203.2851-1-minwoo.im.dev@gmail.com>
Message-ID: <20190506145327.GA2164@localhost.localdomain>

On Mon, May 06, 2019@11:52:03PM +0900, Minwoo Im wrote:
>  static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>  {
>  	if (ctrl->ctrl.queue_count > 1) {
> +		nvme_start_freeze(&ctrl->ctrl);
> +		nvme_wait_freeze(&ctrl->ctrl);
> +
>  		nvme_stop_queues(&ctrl->ctrl);
>  		blk_mq_tagset_busy_iter(&ctrl->tag_set,
>  					nvme_cancel_request, &ctrl->ctrl);
>  		nvme_loop_destroy_io_queues(ctrl);
> +
> +		nvme_unfreeze(&ctrl->ctrl);
>  	}

nvme_stop_queues() and blk_mq_tagset_busy_iter() really don't make sense
to call on frozen queues.
