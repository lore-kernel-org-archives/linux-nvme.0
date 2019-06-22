From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 22 Jun 2019 09:38:41 +0900
Subject: [PATCH] nvme-fc: clean up error messages
In-Reply-To: <20190621211944.28604-1-emilne@redhat.com>
References: <20190621211944.28604-1-emilne@redhat.com>
Message-ID: <20190622003841.GC3139@minwooim-desktop>

Hello, Ewan.

On 19-06-21 17:19:44, Ewan D. Milne wrote:
> Some of the error messages are inconsistent, and one of them is wrong
> (i.e. "queue_size 128 > ctrl maxcmd 32, reducing to queue_size").
> Make them more clear and distinguishable for log analysis.
> 
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>

> ---
> @@ -1259,7 +1259,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>  	if (fcret) {
>  		ret = -EBADF;
>  		dev_err(ctrl->dev,
> -			"q %d connect failed: %s\n",
> +			"queue %d connect admin queue failed: %s\n",
>  			queue->qnum, validation_errors[fcret]);
>  	} else {
>  		ctrl->association_id =
> @@ -1358,7 +1358,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>  	if (fcret) {
>  		ret = -EBADF;
>  		dev_err(ctrl->dev,
> -			"q %d connect failed: %s\n",
> +			"queue %d connect failed: %s\n",
>  			queue->qnum, validation_errors[fcret]);

Hmm..  It looks like the first one and the second ond are not pretty
consistent because the second one does not have any queue property like
I/O queue even the first shows "admin queue" itself.

>  	} else {
>  		queue->connection_id =
> @@ -1371,7 +1371,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>  out_no_memory:
>  	if (ret)
>  		dev_err(ctrl->dev,
> -			"queue %d connect command failed (%d).\n",
> +			"queue %d connect failed (%d).\n",
>  			queue->qnum, ret);
>  	return ret;
>  }
> @@ -2678,16 +2678,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>  		/* warn if maxcmd is lower than queue_size */
>  		dev_warn(ctrl->ctrl.device,
>  			"queue_size %zu > ctrl maxcmd %u, reducing "
> -			"to queue_size\n",
> -			opts->queue_size, ctrl->ctrl.maxcmd);
> +			"queue_size to %u\n",
> +			opts->queue_size, ctrl->ctrl.maxcmd, ctrl->ctrl.maxcmd);
>  		opts->queue_size = ctrl->ctrl.maxcmd;
>  	}
>  
>  	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
>  		/* warn if sqsize is lower than queue_size */
>  		dev_warn(ctrl->ctrl.device,
> -			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> -			opts->queue_size, ctrl->ctrl.sqsize + 1);
> +			"queue_size %zu > ctrl sqsize %u, reducing "
> +			"queue_size to %u\n",
> +			opts->queue_size, ctrl->ctrl.sqsize + 1,
> +			ctrl->ctrl.sqsize + 1);

This part looks good to me, though.

Thanks,
